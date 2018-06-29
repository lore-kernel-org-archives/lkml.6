Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A08BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0DB27BA5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0DB27BA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbeF2HsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:48:14 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42735 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933177AbeF2HsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:48:12 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so5218021uaj.9;
        Fri, 29 Jun 2018 00:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krLbWCIdM5jhuSyZDbaS3/9605IaCvaaa5YZcBIdXLI=;
        b=PTRzrD0d6yyWGxAVr0yDrlWb6XQhgJ2FjRFjcC1fYSLoImC8GiNjMAtO67PEiYeLOc
         6LFc0Wtf49MvdxtGkxVqdNdnivlqEFCWTedoHnbUvEr5/zUk3amibKBP5r2XndJsDtn3
         OWw0zA0nxrugBP2VBlIW0QQqBaMW61GjxR0e5yinBwYqnNqK/zXkYduVIkfqG++eTwQB
         Z/Sf/UI1DarOOjjwCGyifUjLHYzoXw7+aXcMaX4K6lgT1bnyLFOakD71RVG7VxBqm5qz
         PqjxBZVHeMl65ik3rt7jnl26H8ZgvtJYyHAcP5D2dDf14v8kwpyifI2cY8tf7kr1BLtd
         W70Q==
X-Gm-Message-State: APt69E1f3r5to3PMMMTtcALtmUpmL4T6fWw67ZoMa7Ud9L/oAByLJrES
        ckMksRkWPPIHeJk+upgorq4oSAWSWyy3AlUFoQY=
X-Google-Smtp-Source: AAOMgpd8Lhz9W+FhuTExulRbdBfNQky17yziNKZXpP0jqV++PT27+X5w+UXzQlHSes4RnsZZj4ha5AItM6R9fINUwFM=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr8645497uae.12.1530258492057;
 Fri, 29 Jun 2018 00:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180628134227.GA1719@arbeit> <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de> <20180628204516.GA29146@amd>
 <20180629064147.GA3219@arbeit> <20180629071724.GA10079@amd>
 <CAMuHMdXaPz3ckT1cPZed4e=iwk3nb75UBGC66hm+b+xRDNNnNg@mail.gmail.com> <20180629072912.GB10079@amd>
In-Reply-To: <20180629072912.GB10079@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Jun 2018 09:48:00 +0200
Message-ID: <CAMuHMdW1NX=BwJE0eauRLkRj1se4iRNGdxHXeajNQ-dKDhnPKw@mail.gmail.com>
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

Hi Pavel.

On Fri, Jun 29, 2018 at 9:29 AM Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2018-06-29 09:21:24, Geert Uytterhoeven wrote:
> > On Fri, Jun 29, 2018 at 9:17 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > > Yeah, well... I don't think decoding sentences in morse code is going
> > > > > to be much fun.
> > > > >
> > > > > And we don't really want encoder in kernel. Just do encoding in
> > > > > userspace, and use pattern trigger to display it.
> > > > >
> > > > > For many uses, morse code is "too geeky", and other patterns will be
> > > > > used.
> > > > >
> > > > > Like " X    " for error 1, " X X     " for error 2, " .xX .xX " for
> > > > > charging, " .xXx. " for everything okay...
> > > > >
> > > >
> > > > The hardware i'm using is not able to adjust brightness. It can just switch the
> > > > LED on or off. That's it.
> > > >
> > > > If anybody is interested i can submit a version 2 of the morse trigger with the
> > > > improvements suggested by Greg and Geert. Please let me know.
> > >
> > > I'd prefer more general pattern trigger.
> >
> > There are two parts here:
> >   1. The general pattern trigger (which is not yet upstream),
> >   2. A way to supply a string, convert it into morse code, and feed it to
> >      the LED subsystem.
> >
> > Given 1 is not yet upstream, I think Andreas solution is fine.
> > Once 1 is upstream, 2 can be modified to feed into 1, if available.
>
> There's no reason 2. should be in kernel ("mechanism, not policy").
>
> Given 1. is not really more complicated than the morse
> trigger... please just help with pattern trigger if you want this to
> happen.

Ah, you want to do the conversion to morse code in userspace?
Yes, that makes sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
