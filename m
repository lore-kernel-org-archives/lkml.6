Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B988C2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B988C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeKUSo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:44:27 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36645 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:44:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so2732178vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZOcTZjPYZsnpOdOWnXFo0vtIXWLgf7MyMaLFbnoQPw=;
        b=gfVupAC6n3vOGP2es/Thd69hoEJxWzFcCvn24EfnXCuIgROKS/+eOBvAyN7h2LlCr2
         STKAtUzczIjHlXA9XRxM49IRgVvBXTE7UZ4fLOUtYWPfejixlFrrUN2ZV1D/sxT8X3GU
         FjlUNirhoYrnUIGNbmi+t7BZl4wqBO6kUA9DZII9S0ytGb7MwnyNewYNzK9D05KMVVvd
         45T3kTILKEkChDb9b4sfxw68aTuH9nQjLRGPhPYX68HblaoMeYw6lHM4GdB2bQKcUI7h
         QQNK59iZuANcbTBdOnTT7jcAwr2Uc95ESdePsQjvifIqCEDWUq7J20bqJHc1jXSqEaU9
         Y3XA==
X-Gm-Message-State: AGRZ1gLDSQkLM7gzh96qr9ykXkinaySkGot7bCOzxJYurUf1DB+6T0ME
        HHoVBW4N3CRRcFV3DGjMfImEVEFPjhCrMe8lkioG+A==
X-Google-Smtp-Source: AJdET5cgkz8XbeSq8MV+hP/ukkEdI/fA6fpfMoRSYw3Tce3SQgnlZi9p268CFHJYu5qsQ49/7yGZ/KaODrY6Kd2784E=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr2387135vsm.152.1542787856198;
 Wed, 21 Nov 2018 00:10:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
 <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com> <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Nov 2018 09:10:44 +0100
Message-ID: <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com>
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

On Wed, Nov 21, 2018 at 12:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On atari, the 68901 counts down to 0x01 and raises an interrupt. On mac,
> the 6522 counts down to 0xFFFF then raises an interrupt. No idea about
> amiga (Geert?) -- this has to be handled correctly to get a monotonic
> clocksource. I'll fix this in v3 (where the information is available).

The docs state that the CIA generates on interrupt on underflow, so I
guess that's the same behavior as the 6522 VIA.

Unfortunately the 24-bit ("TOD") counters in the two CIAs run from HSYNC
resp. VSYNC, which depends on the video mode, and thus can't be used
as a monotonic clock source.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
