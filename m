Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B512C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BF520821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMz499Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfAIHUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:20:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39675 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:20:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so6522426wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=EFRzN3RmtL19hzC8H91jMcdWOUHVgudbfi8b7VFWUug=;
        b=HMz499GziYozWQHK+nWsRrf3fM8lUxQkuz9EHoHvQYjSmgt4Bn41GJuid6k73OlDTf
         +hB5X0TyhaRbrX0euv1r9ZSbJiC8Z34nypj4j6EwjkogSPg6JfhlqUBNwVpqOlbQjxVQ
         +Tdlt5U44K4GcQYhlVjpP3RBt0X7bUqgVZLYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=EFRzN3RmtL19hzC8H91jMcdWOUHVgudbfi8b7VFWUug=;
        b=L4KcAbtaOg7wokVmOPr8Oypeaxlp+MzF+/jGWWlIHKrlOTzp1x7x/88aJavnMbhG5O
         dIPyu3u+MZs6B3Hb9jtf0Lj2onz+kZNtMBZqrOBrzls4NnCI4vGYaBl8157acz49+cNV
         vcjAING8a+nGIpmHul6JvTCcUBxdfoqopz+Tn2Oy1TpALYqYlp/CF3X70oeRYBQsy9f4
         cNPWf7PBKbb1wpIwt2vhCywEWODgnZvSYnDLK6XqerWVqF7u3jPRxsIO0cKguz0+fBeJ
         HGbSScYzIc2HPtfRtfYoHpVH3M0adpy5MOgBbaNnUDMiGx9ZPJvmPThECkBeX0mVAXth
         F1Hw==
X-Gm-Message-State: AJcUukdHJ/p81DYnnLP0M5tvqyqjZvm1gbVFkiVrFI1xVYFpLQE5n9tv
        E1fQo2WaOPgjxSGGAOCEAPsvHw==
X-Google-Smtp-Source: ALg8bN5ErtXRqV/wc/QD+C2PUtwMaSiYvjsKfWOe2jEftm0fGK+cxDsXOPZorkpQLtVV/pYoN2XK6A==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr3705386wrs.86.1547018419954;
        Tue, 08 Jan 2019 23:20:19 -0800 (PST)
Received: from dell ([2.27.35.240])
        by smtp.gmail.com with ESMTPSA id j24sm64211372wrd.86.2019.01.08.23.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:20:18 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:20:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.1
Message-ID: <20190109072018.GB27286@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Please accept my apologies for the lateness.

Christmas holidays, yada yada yada! :)

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-4.21

for you to fetch changes up to 3f2d347e851ef4464dea49504cde85e5eef67b2d:

  mfd: exynos-lpass: Enable UART module support (2019-01-03 08:32:42 +0000)

----------------------------------------------------------------
 - New Device Support
   - Add support for Power Supply to AXP813
   - Add support for GPIO, ADC, AC and Battery Power Supply to AXP803
   - Add support for UART to Exynos LPASS

 - Fix-ups
   - Use supplied MACROS; ti_am335x_tscadc
   - Trivial spelling/whitespace/alignment; tmio, axp20x, rave-sp
   - Regmap changes; bd9571mwv, wm5110-tables
   - Kconfig dependencies; MFD_AT91_USART
   - Supply shared data for child-devices; madera-core
   - Use new of_node_name_eq() API call; max77620, stmpe
   - Use managed resources (devm_*); tps65218
   - Comment descriptions; ingenic-tcu
   - Coding style; madera-core

 - Bug Fixes
   - Fix section mismatches; twl-core, db8500-prcmu
   - Correct error path related issues; mt6397-core, ab8500-core, mc13xxx-core
   - IRQ related fixes; tps6586x
   - Ensure proper initialisation sequence; qcom_rpm
   - Repair potential memory leak; cros_ec_dev

----------------------------------------------------------------
Beomho Seo (1):
      mfd: exynos-lpass: Enable UART module support

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Chen-Yu Tsai (1):
      mfd: axp20x: Re-align MFD cell entries

Cheng-Yi Chiang (1):
      mfd: cros_ec: Add commands to control codec

Dan Carpenter (1):
      mfd: ab8500-core: Return zero in get_register_interruptible()

Dien Pham (1):
      mfd: bd9571mwv: Add volatile register to make DVFS work

Enric Balletbo i Serra (1):
      mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove

Geert Uytterhoeven (1):
      mfd: tmio: Typo s/use use/use/

Jean Delvare (1):
      mfd: at91-usart: Add platform dependency

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend

Jonathan Marek (1):
      mfd: qcom_rpm: write fw_version to CTRL_REG

Kangjie Lu (1):
      mfd: mc13xxx: Fix a missing check of a register-read failure

Keerthy (1):
      mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe()

Nathan Chancellor (2):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations

Nicolas Boichat (1):
      mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Oskari Lemmela (2):
      mfd: axp20x: Add AC power supply cell for AXP813
      mfd: axp20x: Add supported cells for AXP803

Paul Cercueil (1):
      mfd: ingenic-tcu: Fix bit field description in header

Richard Fitzgerald (2):
      mfd: madera: Add shared data for accessory detection
      mfd: madera: Remove spurious semicolon in while loop

Rob Herring (1):
      mfd: Use of_node_name_eq() for node name comparisons

Vignesh R (2):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
      iio: adc: ti_am335x_tscadc: Improve accuracy of measurement

Yangtao Li (1):
      mfd: rave-sp: Fix typo in rave_sp_checksum comment

 drivers/iio/adc/ti_am335x_adc.c      |   5 +-
 drivers/mfd/Kconfig                  |   1 +
 drivers/mfd/ab8500-core.c            |   2 +-
 drivers/mfd/axp20x.c                 | 126 +++++++++++++++++++----------------
 drivers/mfd/bd9571mwv.c              |   1 +
 drivers/mfd/cros_ec_dev.c            |   1 +
 drivers/mfd/db8500-prcmu.c           |   4 +-
 drivers/mfd/exynos-lpass.c           |   4 +-
 drivers/mfd/madera-core.c            |   5 +-
 drivers/mfd/max77620.c               |   2 +-
 drivers/mfd/mc13xxx-core.c           |   4 +-
 drivers/mfd/mt6397-core.c            |   3 +-
 drivers/mfd/qcom_rpm.c               |   4 ++
 drivers/mfd/rave-sp.c                |   2 +-
 drivers/mfd/stmpe.c                  |  12 ++--
 drivers/mfd/ti_am335x_tscadc.c       |   5 +-
 drivers/mfd/tps65218.c               |  24 +------
 drivers/mfd/tps6586x.c               |  24 +++++++
 drivers/mfd/twl-core.c               |   4 +-
 drivers/mfd/wm5110-tables.c          |   2 +
 include/linux/mfd/cros_ec_commands.h |  94 ++++++++++++++++++++++++++
 include/linux/mfd/ingenic-tcu.h      |   2 +-
 include/linux/mfd/madera/core.h      |   7 ++
 include/linux/mfd/ti_am335x_tscadc.h |   4 ++
 include/linux/mfd/tmio.h             |   2 +-
 25 files changed, 244 insertions(+), 100 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
