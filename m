Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B181C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F193A208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ew9cjO1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F193A208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbeFLACN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:02:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34702 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeFLACL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:02:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so11094018pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ft87hMCLeP/6pvTpBBm+/QcPyjGDb1Eec3Lw3Lyv/Yg=;
        b=ew9cjO1xrwkQMNxlfn1kSD3xWiAeq4LlzIWV57IORgwTxnSUlOtO9MonzbQN+fxtkN
         XBk94HEU0HQegJuUQmKTN1F4ZKjV00uN/1u57fQXp0LupgS609a5/f93klrC2//Fl4yy
         dJT7JPovToywtC2rW65CsEVhmHq5daCCiFojVZ3OKthTKA+9MH9PwhMgEcK+Z83fYO/8
         9qXCgo08GIE5MXfTF22RUTp5lvKCQJXJjyaG6dSQEr89U97kzuh7ybX3pqsMRsogd/Yt
         dmHeZUJzorZxTyLVq1NCvMJXFMA5mY/of3Vmrc2VS2ZlvNrcSdU6M+/vpQPcaDWlyz2C
         mf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ft87hMCLeP/6pvTpBBm+/QcPyjGDb1Eec3Lw3Lyv/Yg=;
        b=sUjRcok3gQN/Z4Dp08ElB0EVLD5VvRT76d3pZ2keL4sju1061Y829COEG8aUo82wsK
         ZowPP+q7i2hqueVWdsowwmjx++KEbVoqbfpzqQHA0wnLVuXvhRBE132GMgQwm1JkvalH
         wvyu+5kxdGt06M9u8mqFK+WdYs5cZfNxEwiXxA932XVSLE39e1BNnZovTXCugY1b4v91
         hNJzXKue1ZekPqJkAAqJj2LhrEjU5n5dqoOGSDjPaziJdiCD1w5YBq8YbhkGVgHFvHTM
         uubLyWyWE9ldiZQ6jdh/r1w/g3n13BsAI+EpmIC2no0z0wdjbintdBmc8famAA/lHHKX
         82zQ==
X-Gm-Message-State: APt69E1RPUx1Vb6tiyom+J6xFC+qB155lSJY+DCUJlr2/vRlOVk5b8yK
        iZ5SgKkoiXyO64HKsTl+UtE6grsa
X-Google-Smtp-Source: ADUXVKIgml2MSwncI0RfIwhcEjD9nw9VX19uQo6Or2R6w6J9vmka5YNFmnk4h0Kag9H4xc0kVA0wYw==
X-Received: by 2002:a63:5fcb:: with SMTP id t194-v6mr1064553pgb.176.1528761730949;
        Mon, 11 Jun 2018 17:02:10 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c27-v6sm82016623pfl.63.2018.06.11.17.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:02:09 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM: SoC updates
Date:   Mon, 11 Jun 2018 17:01:38 -0700
Message-Id: <20180612000142.28883-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the pull requests for arm-soc for this merge window, broken up
into 4 different pull requests. In addition to this, I will follow up
with a small branch that normalizes some of the defconfigs at the end
of the merge window, since they have become quite shuffled with time.

There are a handful of conflicts in the first two branches, described
in the emails. Unfortunately this release some driver maintainers
picked up the devicetree fragments when they were sent with the same
patch series as the driver updates, we normally avoid that and merge DT
only through arm-soc, but this time it slipped through. I'm considering
adding monitoring scripts for it in linux-next to catch it early since
it's often a source for conflicts on active platforms.


About the contributions this release:

826 patches from 170 authors, 29778 lines added and 11701 deleted.

Dirstat this release is similar to most other releases, with the vast
majority of changes in the devicetree files. For non-DT contributions
cleanups of OMAP platforms and new development on Qualcomm and Nvidia
memory controllers cover most of it, but also some ARM SCMI, Allwinner,
Hisilicon and misc other platform improvements are there.

  51.1% arch/arm/boot/dts/
   3.8% arch/arm/mach-omap2/
   3.0% arch/arm/
   7.0% arch/arm64/boot/dts/mediatek/
   3.2% arch/arm64/boot/dts/qcom/
   8.5% arch/arm64/boot/dts/renesas/
   6.6% arch/arm64/boot/dts/
   3.2% drivers/memory/
   3.6% drivers/soc/qcom/
   5.2% drivers/

Excluding DT:
  17.2% arch/arm/mach-omap2/
  13.9% arch/arm/
   7.0% drivers/bus/
   5.8% drivers/firmware/arm_scmi/
  10.3% drivers/memory/tegra/
  16.5% drivers/soc/qcom/
   9.0% drivers/soc/
   6.4% drivers/
   8.1% include/linux/


New SoCs introduced in this release:

  - Amlogic:
   + Meson 8M2 SoC, a.k.a. S812. A quad Cortex-A9 SoC used in some set
     top boxes and other products.

  - Mediatek:
   + MT7623A, which is a flavor of the MT7623 family with other on-chip
     ethernet options.

 - Qualcomm:
   + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
     (Cortex-A75/A55 derivative) SoC that's one of the current high-end
     mobile SoCs.

     It's great to see mainline support for it. So far, you
     can't do much with it, since a lot of peripherals are not yet in the
     DTs but driver support for USB, GPU and other pieces are starting to
     trickle in. This might end up being a well-supported SoC upstream if
     the momentum keeps up.

 - Renesas:
   + R8A77990, a.k.a R-Car E3, a new automotive entertainment-targeted
     SoC. Currently only one Cortex-A53 CPU is enabled, we are eagerly
     awaiting more. So far, basic drivers such as serial, gpios, PMU and
     ethernet are enabled.
   + R8A77470, a.k.a. RZ/G1C, a new dual Cortex-A7 SoC with PowerVR
     GPU. Same here, basic set of drivers such as serial, gpios and ethernet
     enabled, and SMP support is also forthcoming.

 - STMicroelectronics:
   + STM32F469, very similar tih STM32F429 but with display support

Enhancements to SoCs/platforms (DTS contents, some driver portions might
not be in yet):

 - Allwinner sun8i (h3/a33/a83t) SMP, DVFS tweaks, misc
 - Amlogic Meson: I2C, UFS, TDM, GPIO external interrupts, MMC resets
 - Hisilicon hi3660: Thermal cooling, CPU frequency scaling, mailbox interfaces
 - Marvell Berlin2CD: SMP support, thermal sensors
 - Mediatek MT7623: Highspeed DMA, audio support
 - Qualcomm IPQ8074 PCIe support, MSM8996 UFS support
 - Renesas: Watchdog and PMU support across many platforms
 - Rockchip RK3399: USB3 OTG support
 - Samsung Exynos: Audio-over-HDMI on Odroid X/X2/U3
 - STMicro STM32: Lots of peripherals added to STM32MP175C
 - Uniphier: Ethernet support


New boards:

Allwinner A20: Olimex A20-SOM-EVB-eMMC variant
Allwinner H2+: Libre Computer ALL-H3-CC (h2+ version)
Allwinner A33: Nintendo NES/SuperNES Classic Edition
Aspeed: S2600WF, Inventec Lanyang BMC, Portwell Neptune
Berlin2CD: Valve Steam Link
Broadcom BCM5301X: Luxul XAP-1610 and XWR-3150 V1
Broadcom: Raspberry Pi 3 B+
Mediatek MT7623N and MT7623A  reference boards
Meson 8M2: Tronsmart MXIII Plus
NXP i.MX: Engicam i.CoreM6, DHCOM iMX6 SOM, BTicino i.MX6DL Mamoj
Qualcomm MSM8974: Sony Xperia Z1 Compact support
Qualcomm SDM845 MTP development board
Renesas: Ebisu R8A77990 board
Renesas RZ/G1C: iwg23s: iWave G235-SDB
TI am335x: Pocketbeagle support
