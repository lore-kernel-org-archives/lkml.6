Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FED520854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5dQ2aZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FED520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeIJIAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:00:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37731 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeIJIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:00:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so16597967ljk.4;
        Sun, 09 Sep 2018 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k5A1CyAJnS59bzGxDB7vhN7IXiU6VeBq2THGV/udhHc=;
        b=g5dQ2aZn/eacI2QuAkFCZCtHiW7tVznP541V2hoIjf2mAv0PGb3/K73aX0K94JEmrr
         FtHoiF5QpcHVJSLdZE+BGLNXhnvdFKGPljJrKfVV1UOJObNYKUulpTlfRboeddY2AYs/
         pWIP7rKvM6MU8sb7nNCoB0alFR3HM2+tStPgmfdon3otWvKhsrR2rkBlqDG5bX/HLkJl
         xI7iWFNPu4hIaEG+DsTi9C1l1O8jyOvM8+5vuQI0nzDc9zAsGXAJibDI7S9iOIabgElh
         HuDVSm+dMdNGB14zI5qlTs6K5p5bieZHTkDk8MT6yjImDQ6L1iA5Obb5Obk9AnbRPoPr
         DlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k5A1CyAJnS59bzGxDB7vhN7IXiU6VeBq2THGV/udhHc=;
        b=cXIdmJs0siGWOhk8R4jEbEE7GfwyH1Oq9S0pRvGxcuH+8MgmuElJnVMpmAbTgrXpkd
         9d8XW8fg1OnIQIlc71XAQaDW2g3/hWHpDhK9H0Gsn4okbX+v/9Q0zdyneGvtdyWx0XlN
         2fTy8Efr/i+Lfu/zk9ikKS+hLjQoho8fsoTzuYTDxKOpXWLe5Q2GyEdMqFjCL6cXJvKb
         IZckudGAUao57dmdHZg+4lP9+3W2vZkM5bUMSwupjN76EjahC6SkvGYMtxPq8xHvAhPI
         DrZ0Fl+vy2fOb1/Blh+DwO+dHoCLZM1zjZQmy0IxOepd3BH/+2ZhAGuhOYvMUKOL5lri
         uLgA==
X-Gm-Message-State: APzg51BObuOcnpdOUveJJj+XgjCn2a8g1zcpYz5F5tCHi+nPraYhcFDj
        XvKwq6b8HYJXQAkdtq+Pq0LxSZVw
X-Google-Smtp-Source: ANB0VdYo7VadoJXFo37fHG8U16N3Htrt8Uaf+PGlxITzWkLRReTZEf3Ut1gwnPVVWgAvT3W9y37C+g==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr10162424ljc.148.1536533705685;
        Sun, 09 Sep 2018 15:55:05 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2401574ljg.12.2018.09.09.15.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 15:55:04 -0700 (PDT)
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
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration
Date:   Mon, 10 Sep 2018 00:56:02 +0200
Message-Id: <20180909225605.16463-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717231448.14958-1-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a follow up of initial submission of a series consisted of 
6 changes, 3 of which have been already applied or reworkeed.


Janusz Krzysztofik (3):
      video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
      mtd: rawnand: ams-delta: use GPIO lookup table
      ARM: OMAP1: ams-delta: make board header file local to mach-omap1


I'm submitting the three patches in series because the last one depends
on the other two.

Tony, please set up an immutable tag for this series to be used by MTD
as there are more changes on Amstrad Delta NAND driver coming in.

Thanks,
Janusz


Changelog:
v3:
- rebased on top of v4.19-rc1
- added Acked-by: received from Miquel

v2:
[PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
	- already in mainline, commit 68e62a15a914
[PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
	- reworked and submitted as a series, already in linux-omap,
	  commit 68e62a15a914 ("ARM: OMAP1: ams-delta: drop GPIO lookup
	  table for serio device") followed by 9 more
[PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
	- already in mainline, commit d65777d1a2cd
[PATCH 4/6] fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
	- resubmitting as [PATCH v2 1/3 v2]
	v2: Remove problematic error code conversion no longer
	    needed if used on top of commit d08605a64e67 ("ARM: OMAP1:
	    ams-delta: move late devices back to init_machine")
	    and commit 8853daf3b4ac ("gpiolib: Defer on non-DT
	    find_chip_by_name() failure") already in linux-next
[PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
	- resubmitting as [PATCH v2 2/3 v4]
	v2: Fix handling of devm_gpiod_get_optional() return values -
	    thanks to Andy Shevchenko.
	v3: Remove problematic error code conversion no longer needed
	    if used on top of commit d08605a64e67 ("ARM: OMAP1:
	    ams-delta: move late devices back to init_machine") and
	    commit 8853daf3b4ac ("gpiolib: Defer on non-DT
	    find_chip_by_name() failure") already in linux-next - thanks
	    to Boris Brezillon
	v4: fix style issue - thanks to Boris Brezillon
[PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to
	mach-omap1
	- resending as [PATCH v2 3/3]

All dependencies mentioned in v2 changelog are satisfied in v4.19-rc1.


diffstat:
 arch/arm/mach-omap1/ams-delta-fiq-handler.S |    2 
 arch/arm/mach-omap1/ams-delta-fiq.c         |    3 
 arch/arm/mach-omap1/board-ams-delta.c       |    2 
 arch/arm/mach-omap1/board-ams-delta.h       |    2 
 drivers/mtd/nand/raw/ams-delta.c            |  126 ++++++++++++++--------------
 drivers/video/fbdev/omap/lcd_ams_delta.c    |   55 ++++--------
 6 files changed, 93 insertions(+), 97 deletions(-)

