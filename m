Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75BBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49727B78
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A49727B78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeF2HVm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:21:42 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41494 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeF2HVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:21:37 -0400
Received: by mail-ua0-f196.google.com with SMTP id z12-v6so5064140uac.8;
        Fri, 29 Jun 2018 00:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlNi1y4I3b3aB1T+/vtvNlPZrbmtHp2cLP1TASIQv/Q=;
        b=FONgmMbJgfgsjaYlBTGuF5Ebqjq92d+xTUWwv2tZVg0+ejdgAIurAUpDBYMe10s3nn
         i3wXBp+MfE3m0oRgWSYM0LBVCkiKOaVH2/EVgWc/7jlTV1tqwcJ3M5vaALh1otuDd0Lc
         cN0IVoBwvZzKB0GqD/LsWWWT5r5cRLAWygWj0WFgZvxmeea8Amm/oYrTQJ+GLPIVHXyU
         Q2QsP4ys2V0rrHRZYPSHBgApy72DJKWmUthYsm2wsy7ht+yx41AQzdW8hnDUj0RrBMxL
         VKML0uElfWsF4oZi3d4q2WSrAO+8ZqIFk/ZnZZaSPV9WKDVUAiCLj4UH6vWaO6dfNyai
         /Ggw==
X-Gm-Message-State: APt69E3g0NZMavyGvjAtwjGQ8RXYy/TPdd6leNOk9ME5W6XkAIcpK/Dg
        g03wlzS4k/dqmhmuEkZQ+rVHtXlFR1uWWMVC5Y0=
X-Google-Smtp-Source: AAOMgpdYF/GwPPKZN1JgI49mVTdygcXZXKprey8w1tliS9UMejfhn7ROWwpy+TJZBLssi1mwuwoezp81TDNPYuI0ixc=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr9219264uas.26.1530256896040;
 Fri, 29 Jun 2018 00:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180628134227.GA1719@arbeit> <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de> <20180628204516.GA29146@amd>
 <20180629064147.GA3219@arbeit> <20180629071724.GA10079@amd>
In-Reply-To: <20180629071724.GA10079@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Jun 2018 09:21:24 +0200
Message-ID: <CAMuHMdXaPz3ckT1cPZed4e=iwk3nb75UBGC66hm+b+xRDNNnNg@mail.gmail.com>
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Willy Tarreau <w@1wt.eu>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, Jun 29, 2018 at 9:17 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > Yeah, well... I don't think decoding sentences in morse code is going
> > > to be much fun.
> > >
> > > And we don't really want encoder in kernel. Just do encoding in
> > > userspace, and use pattern trigger to display it.
> > >
> > > For many uses, morse code is "too geeky", and other patterns will be
> > > used.
> > >
> > > Like " X    " for error 1, " X X     " for error 2, " .xX .xX " for
> > > charging, " .xXx. " for everything okay...
> > >
> >
> > The hardware i'm using is not able to adjust brightness. It can just switch the
> > LED on or off. That's it.
> >
> > If anybody is interested i can submit a version 2 of the morse trigger with the
> > improvements suggested by Greg and Geert. Please let me know.
>
> I'd prefer more general pattern trigger.

There are two parts here:
  1. The general pattern trigger (which is not yet upstream),
  2. A way to supply a string, convert it into morse code, and feed it to
     the LED subsystem.

Given 1 is not yet upstream, I think Andreas solution is fine.
Once 1 is upstream, 2 can be modified to feed into 1, if available.

Do you agree?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
