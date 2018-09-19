Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01691214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXFRhmsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01691214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbeISXsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:48:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38397 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732428AbeISXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:48:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so5924988ljc.5;
        Wed, 19 Sep 2018 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+kw/mJfI1g5IzBxYn+xJC8Bz2nEa2IM1AiO5tlxWig=;
        b=VXFRhmsyY/5wGiz0e2K3F/CyV2XWYNwJ7PgRWVIMcMaj9ObCbVrd5lvYuh581/FR/j
         bnB0ptszkM/kKWLsY54Ew5ZtBtwo2WGKWiZ+X77CAs+E06L6Wjg0YXnHiWR4Ak/ju7XP
         lkTSddlZRYh0aHjVFe5o2yBEBiz2qtWScruuRVBqQhyFa3mru1622U6q8QvZHEeoIoNE
         NFGpuyjVr1bKj1wxDjxGXJM1h3a3qK5H8sTDoBvd3cjT3dYElW0EXEpC0j8jYDRbD/bS
         LfYLzKuKAGHBOat4b+/4XyavCsxjLC8obqKSry5oZamJjmAI+yLy8nW9kLiIv68Iwnqa
         N/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+kw/mJfI1g5IzBxYn+xJC8Bz2nEa2IM1AiO5tlxWig=;
        b=ERa3pM7bryizoti5Fl7u4mfVyI7dLue1LGVyALjTkwHgIUCQpapKw8ZEcNbo5I27gg
         6j+RzZCxzNclAldPTrKwh7jKQX+m+bFZeAgHTsLXmdDIKESfy1cNBHXy4ZCuPAqCQ/GG
         i466SGx55HsMoJVb8qEDopZ4Mg8kdCnI0AYhNn0I/4bJLA9w/TJtP3iEfVeemlMKfp2u
         4pi5f0TPyt+MbA+1eUGwZlYtHqNj5mQgWbaiEcRsXsggQ5cbFVmbtHy/K3uSXfKk9qds
         mstmREmfqTi2kty/jjLxHkCZZFr+M3HfaF6aPv/ah8HZez+h+SScam83y1+aqLJxqsIH
         yyyg==
X-Gm-Message-State: APzg51DyR9RD9nGJ0Fv5UU8aJXye7DW3TEq1g6k1GfYfycvBW/St6fXe
        Gbeq5rVidjfIsMtNkqGODBM=
X-Google-Smtp-Source: ANB0VdYTNDwfLm36wLkSaWd5s/riPjCEW1HCuU7mhRSh5Tv7p8HTUHw4qYdb4M+rP2mC6f1lj7DiBQ==
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr6415594ljj.13.1537380569668;
        Wed, 19 Sep 2018 11:09:29 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id i28-v6sm1195570lfc.87.2018.09.19.11.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:09:28 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration
Date:   Wed, 19 Sep 2018 20:10:54 +0200
Message-ID: <1794253.R1RrZXVNCJ@z50>
In-Reply-To: <20180909225605.16463-1-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com> <20180909225605.16463-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 10, 2018 12:56:02 AM CEST Janusz Krzysztofik wrote:
> 
> This is a follow up of initial submission of a series consisted of 
> 6 changes, 3 of which have been already applied or reworkeed.
> 
> 
> Janusz Krzysztofik (3):
>       video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
>       mtd: rawnand: ams-delta: use GPIO lookup table

Hi Tony,

Please ignore this patch. It may no longer be possible to merged it cleanly 
with nand/next tree. I'll exclude it from the series, rebase on top of nand/
next and submit via linux-mtd.

That shouldn't affect the two remaining patches of the series which should 
still apply and merge cleanly, but I can resend them renumbered if you wish.

Thanks,
Janusz

>       ARM: OMAP1: ams-delta: make board header file local to mach-omap1
> 
> 
> I'm submitting the three patches in series because the last one depends
> on the other two.
> 
> Tony, please set up an immutable tag for this series to be used by MTD
> as there are more changes on Amstrad Delta NAND driver coming in.
> 
> Thanks,
> Janusz
> 
> 
> Changelog:
> v3:
> - rebased on top of v4.19-rc1
> - added Acked-by: received from Miquel
> 
> v2:
> [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
> 	- already in mainline, commit 68e62a15a914
> [PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
> 	- reworked and submitted as a series, already in linux-omap,
> 	  commit 68e62a15a914 ("ARM: OMAP1: ams-delta: drop GPIO lookup
> 	  table for serio device") followed by 9 more
> [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
> 	- already in mainline, commit d65777d1a2cd
> [PATCH 4/6] fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
> 	- resubmitting as [PATCH v2 1/3 v2]
> 	v2: Remove problematic error code conversion no longer
> 	    needed if used on top of commit d08605a64e67 ("ARM: OMAP1:
> 	    ams-delta: move late devices back to init_machine")
> 	    and commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> 	    find_chip_by_name() failure") already in linux-next
> [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
> 	- resubmitting as [PATCH v2 2/3 v4]
> 	v2: Fix handling of devm_gpiod_get_optional() return values -
> 	    thanks to Andy Shevchenko.
> 	v3: Remove problematic error code conversion no longer needed
> 	    if used on top of commit d08605a64e67 ("ARM: OMAP1:
> 	    ams-delta: move late devices back to init_machine") and
> 	    commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> 	    find_chip_by_name() failure") already in linux-next - thanks
> 	    to Boris Brezillon
> 	v4: fix style issue - thanks to Boris Brezillon
> [PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to
> 	mach-omap1
> 	- resending as [PATCH v2 3/3]
> 
> All dependencies mentioned in v2 changelog are satisfied in v4.19-rc1.
> 
> 
> diffstat:
>  arch/arm/mach-omap1/ams-delta-fiq-handler.S |    2 
>  arch/arm/mach-omap1/ams-delta-fiq.c         |    3 
>  arch/arm/mach-omap1/board-ams-delta.c       |    2 
>  arch/arm/mach-omap1/board-ams-delta.h       |    2 
>  drivers/mtd/nand/raw/ams-delta.c            |  126 +++++++++++++
+--------------
>  drivers/video/fbdev/omap/lcd_ams_delta.c    |   55 ++++--------
>  6 files changed, 93 insertions(+), 97 deletions(-)
> 
> 




