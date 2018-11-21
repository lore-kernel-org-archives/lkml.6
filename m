Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42201C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB55214DE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB55214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeKUS4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:56:36 -0500
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:53786 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728572AbeKUS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:56:36 -0500
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <jongk@linux-m68k.org>)
        id 1gPNmm-0000uh-5s
        for linux-kernel@vger.kernel.org; Wed, 21 Nov 2018 09:23:00 +0100
Received: from mail-lj1-f174.google.com ([209.85.208.174])
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jongk@linux-m68k.org>)
        id 1gPNmV-0000t1-MD
        for linux-kernel@vger.kernel.org; Wed, 21 Nov 2018 09:22:43 +0100
Received: by mail-lj1-f174.google.com with SMTP id s5-v6so4012766ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:22:43 -0800 (PST)
X-Gm-Message-State: AGRZ1gJPkaNANYmOIZrsdicoeTiATyTNxC2uDnp5tQUlDzdzo3DwsL4+
        n1nY1m1aTEjkW3lbgTHbgwDJm4rnX80IMaAe7+8=
X-Google-Smtp-Source: AJdET5dUqFJPYapDpVn0tN3DJ/Aa1n+E3CUuf5RJUq0hl3ubPIu7vUjeHtRrQmlZ7PHWmLin4zMTai2CLXs5EIH7Hx8=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr3227458lji.57.1542788563093;
 Wed, 21 Nov 2018 00:22:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
 <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com> <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
From:   Kars de Jong <jongk@linux-m68k.org>
Date:   Wed, 21 Nov 2018 09:22:31 +0100
X-Gmail-Original-Message-ID: <CACz-3riTnjM-mt4TBLWVXFWtMbTvVgcuqjqi1h_bzuZzu-DXmg@mail.gmail.com>
Message-ID: <CACz-3riTnjM-mt4TBLWVXFWtMbTvVgcuqjqi1h_bzuZzu-DXmg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
To:     fthain@telegraphics.com.au
Cc:     geert@linux-m68k.org, philb@gnu.org, schwab@linux-m68k.org,
        arnd@arndb.de, schivers@csc.com.au, tglx@linutronix.de,
        daniel.lezcano@linaro.org, schmitzmic@gmail.com,
        john.stultz@linaro.org, linus.walleij@linaro.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.208.174
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=G66o7Os5 c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=JHtHm7312UAA:10 a=8981fWPbAAAA:8 a=8uBZengZ5fZy5sdr5uEA:9 a=QEXdDO2ut3YA:10 a=o72u2rHnfW5qNJ_4I8LD:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op wo 21 nov. 2018 om 00:13 schreef Finn Thain <fthain@telegraphics.com.au>:
>
> On Tue, 20 Nov 2018, Kars de Jong wrote:
>
> > Op ma 19 nov. 2018 om 02:10 schreef Finn Thain <fthain@telegraphics.com.au>:
> > >
> > > hp300_gettimeoffset() never checks the timer interrupt flag and will
> > > fail to notice when the timer counter gets reloaded. That means the
> > > clock could jump backwards.
> > >
> > > Remove this code and leave this platform on the 'jiffies' clocksource.
> > > Note that this amounts to a regression in clock precision. However,
> > > adopting the 'jiffies' clocksource does resolve the monotonicity issue.
> > >
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > > ---
> > > hp300_gettimeoffset() cannot be used in a clocksource conversion
> > > unless it can be made monotonic. I can't fix this without knowing the
> > > details of the timer implementation, such as the relationship between
> > > the timer count and the interrupt flag.
> >
> > I don't really like this regression...
> >
>
> Me neither...
>
> I'll see if I can write a conversion patch based on the information you've
> provided. Can you test it?

I can try... It's been a while since I booted the machine to Linux
though (NFS support only).
MAME is also starting to support it, but not quite there yet :-)

> > According to NetBSD sources, there are 3 timers in the chip (originally
> > an MC6840 PTM).
>
> Thanks for the tip. I will examine the datasheet for the 6840.
>
> I'll also take another look at the NetBSD code.
>
> > Timer 1 is used as the system timer, timer 3 runs at the same rate and
> > is unused on Linux (on NetBSD it is used as the statistics/profiling
> > timer), and timer 3 is connected to timer 2 so you can make a 32-bit
> > timer out of the two timers together (also unused on Linux).
> >
> > Timers 1 counts down at 25 MHz.
>
> You mean, 250 kHz, right? The code in mainline programs the timer for 2500
> cycles, hoping to get 10 ms. That is, 250 cycles per ms.

Eh, yes, that makes a lot more sense.

> > The interrupt flag is set when the counter reaches 0 after which it is
> > automatically reloaded and starts counting down again.
> >
>
> Thanks.
>
> On atari, the 68901 counts down to 0x01 and raises an interrupt. On mac,
> the 6522 counts down to 0xFFFF then raises an interrupt. No idea about
> amiga (Geert?) -- this has to be handled correctly to get a monotonic
> clocksource. I'll fix this in v3 (where the information is available).

Cool!

Kars.
