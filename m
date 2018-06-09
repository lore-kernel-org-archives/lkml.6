Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UqhgH6DDG1t2FwAAmS7hNA
	; Sat, 09 Jun 2018 12:10:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D1A85608B8; Sat,  9 Jun 2018 12:10:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4EF76605A5;
	Sat,  9 Jun 2018 12:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EF76605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeFIMKW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:10:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33756 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeFIMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:10:20 -0400
Received: by mail-vk0-f66.google.com with SMTP id 200-v6so9809182vkc.0;
        Sat, 09 Jun 2018 05:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3pxtCz9A/G4mAqyC31zcn9JFc25srpWX46jYbHy0p4=;
        b=OF2xl+gMJDyMhhU91t60jGz9y3JliAlaBLIpHiGsAaNW6XZKlvRa7wNMhiCtCnBQ7m
         97stgVGXb0sASByh5wynDWyeSVvNpjZ/hzr+IfZcgQDUhSe/s6CtnHdyspEzZc4iW69Q
         RAEjjBs7PYV7Mm5qkMbH8QArqCjF3jZuYMzFPlaZfr8VsKcRiRWutS99oAAusPr4mngu
         5hZDSEjzlOOikgsfsjTzsfliX7KYbWPyuseVPMs2sYUuU+otzSjize6jx0tNPGjoZ5Wm
         QA7SqbnhBYg9hhJxTrpQ1fKP7079TyniqCQJL2Pjx2RMEcN6WwFdAnR1t03O9D+/+Z5i
         YvIg==
X-Gm-Message-State: APt69E35fywBYSSXhcS1KFVNcFi5yjGx1L6kskO9rzHhWo5KivXAM5o5
        1KFmgftnHrGeP8zc0CqEJWN6vSBD6qIuD0Xll9Q=
X-Google-Smtp-Source: ADUXVKKs35ur0Zfyra/VUKgmGPbkKF2274MoO/PAcEtNcNf7I+NkgXTlZTvsBck4zrlJNXLZe1GntWZ8vAPp5BkxHCo=
X-Received: by 2002:a1f:e92:: with SMTP id 140-v6mr6219664vko.90.1528546219391;
 Sat, 09 Jun 2018 05:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com> <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
 <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
 <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAMuHMdUOqLhmb8kXOxriQ5mt_4rDQJbUqGsQiJBSkq5J5FWG7w@mail.gmail.com> <CAL_JsqK6Pb5ZbqAATpQNK-C=iVNA655H__5RERMmPTUOrX3Few@mail.gmail.com>
In-Reply-To: <CAL_JsqK6Pb5ZbqAATpQNK-C=iVNA655H__5RERMmPTUOrX3Few@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 9 Jun 2018 14:10:06 +0200
Message-ID: <CAMuHMdX2gsTJttum6_KPLcM7LTpSj3weHB7OwvBmuc4AjdfpuA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Rob Herring <robh+dt@kernel.org>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Doug Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jun 8, 2018 at 10:41 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Jun 8, 2018 at 2:47 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jun 8, 2018 at 8:50 AM, Michel Pollet
> > <michel.pollet@bp.renesas.com> wrote:
> >>> > + I add this to the cpu.txt, as a separate patch:
> >>> > # On other systems, the property can be either
> >>> >   32 bits or 64 bits, it is the driver's responsibility
> >>> >   to deal with either sizes.
> >>>
> >>> That is definitely not what we want to say. Use of 32-bit should be
> >>> considered out of spec. Yes, we have a few platforms in that category, but
> >>> they already handle that themselves. Would be nice to fix them, but at least
> >>> the STi platforms don't seem too active.
> >>>
> >>> IMO, we should delete whatever text we can here and at most just refer to
> >>> the spec.
> >>
> >> So actually I didn't use 32 bits by plain chance, I read the cpu.txt file which says
> >> that 64 bits systems use 64 bits property, concluded that in my case I ought to
> >> use 32 bits, then grepped around and found other systems using 32 bits, therefore
> >> I went forward and used it..
> >>
> >> Nothing said here that it should be 64 bits everywhere -- So the documentation
> >> needs fixing somehow. Right now it certainly led me wrong.
> >
> > Perhaps we should add to Documentation/devicetree/bindings/ the standard
> > bindings from ePAPR and successors, too?
>
> I hope you mean *reference* here, not duplicate the bindings here. We
> want to move in the other direction and move the common bindings out
> of the kernel and into the spec.

I did mean copy... I usually grep in Documentation/devicetree/bindings/,
and fall back to the spec only rarely, mostly because the spec usually
doesn't cover what I need.

I am aware of the ongoing work on updating the spec. I guess it's a
chicken-and-egg problem...

A list of standardized properties under Documentation/devicetree/bindings/,
referring to the spec may be a good interim solution. So at least it would show
it with git grep.

> The real solution here is validation which I'm working on. I had
> already converted cpus.txt. Here's an example of the results of the
> validation:
>
> arch/arm/boot/dts/stih410-b2120.dt.yaml:1962:7: cpu@0: 'enable-method'
> is a dependency of 'cpu-release-addr'
> arch/arm/boot/dts/stih410-b2120.dt.yaml:1965:26:
> cpu@0:cpu-release-addr: [155254948] is too short

Thanks, nice!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
