Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA3FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354352146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354352146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeKUT3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:29:17 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43704 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeKUT3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:29:16 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so2777363vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHSeRCPm/Q1a14fKwEg2Q9aGrmsElIml1S5CCfKoJrE=;
        b=iijHn1pXjT7QXoqnrXKbX5SnIvEzArl/Hdq0keRHM310MA6R7BPS0d77v5qSegN18P
         XER0e2avWUcH4NKcnCQGgnC/xeMQH05xApptdYrmpiVuxblYMXLnSLO3RuyD7Ho6YNAB
         9PME4Tko2zgsq780XRp8lsgEMDu33QnVSiA9Hjr2RoVx+vH8VyoHR+5U9eU/r5MJkMH2
         U+oPamde/ogot7wxqLHRuwpHxfEzeN6eidq85ULfcJqrFmcHwYSDWRq3ehR4iUw8HXYC
         VRRCANN9jlWnH9Qkr2gtgoXuMBXYZoxoMDAhHwJVUCU8CbE5yxqREinBwBk8o1CxJFMt
         o6+w==
X-Gm-Message-State: AA+aEWazm9LTSO/JZSEtI73pSPnz24TeTZUQCWi/LLRQAUaUouAKQDdd
        H8fYPA0eJ4GYXjYUZE0Ts3JDjZZRFQZ8PWK6MfA=
X-Google-Smtp-Source: AJdET5fwUSxNj3AQKMUMOxMyoUeLof8bgULSitS4nvKy10iYaD/8CYDQuHkO2p7wxLLQ8zFgtI6+y3YRfX0QuM6z9XM=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2190741vsj.11.1542790537098;
 Wed, 21 Nov 2018 00:55:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
 <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
 <alpine.LNX.2.21.1811202034350.258@nippy.intranet> <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com>
 <alpine.LNX.2.21.1811211917270.275@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1811211917270.275@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Nov 2018 09:55:24 +0100
Message-ID: <CAMuHMdVexpeYVSBMXFwu5cYt3d=w9U48m_fNTuK5awhBNnsW_A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Wed, Nov 21, 2018 at 9:41 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 21 Nov 2018, Geert Uytterhoeven wrote:
> > On Wed, Nov 21, 2018 at 12:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > On atari, the 68901 counts down to 0x01 and raises an interrupt. On
> > > mac, the 6522 counts down to 0xFFFF then raises an interrupt. No idea
> > > about amiga (Geert?) -- this has to be handled correctly to get a
> > > monotonic clocksource. I'll fix this in v3 (where the information is
> > > available).
> >
> > The docs state that the CIA generates on interrupt on underflow, so I
> > guess that's the same behavior as the 6522 VIA.
>
> Difficult to say. The sequence varies from one implementation to another.
> Let's ignore the MSB and LSB and pretend it's one register:
>
> MC68901: N, N-1, N-2, ..., 2, 1, N, N-1, N-2, ...
> MC6840:  N, N-1, N-2, ..., 2, 1, 0, N, N-1, N-2, ...
> SY6522:  N, N-1, N-2, ..., 2, 1, 0, 0xFFFF, N, N-1, N-2, ...
>
> Now the question is, when the timer asserts its interrupt, and the count
> register is fetched immediately, what value does it have?
>
> For the MC68901, you get 1. For the SY6522, you get 0xFFFF. For MC6840, as
> far as I can tell, you'd get 0.

I assume 0xFFFF. The 8520 CIA is almost identical to the 6526 CIA, as used in
the C64, which is a direct descendant of the 6522 VIA.

> > Unfortunately the 24-bit ("TOD") counters in the two CIAs run from HSYNC
> > resp. VSYNC, which depends on the video mode, and thus can't be used as
> > a monotonic clock source.
>
> Is that because of video mode changes? Could the clocksource be
> unregistered before the mode change and then re-registered at a different
> frequency afterwards?

On older Amigas (most plain 68000, unless expanded), video modes are fixed.
Some have a jumper to select the power supply tick instead of the VSYNC
signal, which is more accurate, but still runs at a low 50 or 60 Hz.
On anything more modern (A3000 and up), video modes are programmable.
In addition, blanking the screen according to VESA will disable sync signals,
thus stopping the clock, I assume.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
