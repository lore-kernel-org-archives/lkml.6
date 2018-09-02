Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3EAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4746F2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Wyl7xMJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4746F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeIBGui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:50:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46655 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:50:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so12811887ljj.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 19:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mBeYwEV2SRGHBZy9jnreGn8jGfkQoey+Ea1hdmlqIOA=;
        b=Wyl7xMJGuwxkh+wMIVc9b8yCe2j5HmR4cjKcFp36gS8w4O/rKAPC3uJyGpK9+cktK8
         akmn6IxRaeR3U/oLJ9f4p8SGKcZDLQ3qHBCDQbcNvqegSJDsk7hnNOmlRQ16K5MFLFxO
         OBTHQtRramsq6rcq8aweEmDRNua5aCB7kWGjbMdduRTVgdABwDPn+fvWSrPW2kMti8lV
         rLnUMy/GEVzvy3bAJjAY6QcedXeVM96Bhq8H7mBSYknyZbacKBaOyjz0xU9TuS3JlAxR
         wlcNER/bdVQIV7tp8KzFeTl4Bm1+cipFdUpVzb3J6zJeKktMir/jtEiisG1mwJH1k5Um
         3B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mBeYwEV2SRGHBZy9jnreGn8jGfkQoey+Ea1hdmlqIOA=;
        b=n6FufsB2VeortTuYfBZbbY9OE5WyCS3BP+fPrE+sDce6egxmRJN39q7b8fdiBwerp6
         joGPoxMTDKIBsY6zopIZuko4F8iLFGBubY3nsr+16k/OEhItdvRirB/CoIYa/dwygmfQ
         YdlQgAV7ySeL7e08iLVfnAtYwlIl69TRCMXaIrN6W/Xuc1kXm6QAVvtvXgc4am1Ib9gs
         AO9aNvrOEQJVPVMgPuWwrhoC1vLSODYIRe+gFehfER8w332WhDj1kaI8v0xoAL7xi3wc
         TCyna9GkCtUk6FFnbNWji+SlgzTTZYe9HG/E1HCHDqyz+QsO7KTrU/M4vpAW+GyYktGt
         Ms2w==
X-Gm-Message-State: APzg51AsPG1o3Id609BIrKvbFEy94ONJZEpa6oGnluqIYzIMqZvvFnjJ
        hEIR3jt7CFmq2ChDjYOZZg2AeA==
X-Google-Smtp-Source: ANB0VdYGFsZPQ2E8BuecDyXqHkAF3/k/LxdIYYsD5VdIydjmTQEmqPU40SmXKd5y3HQ2yrAwtcsepA==
X-Received: by 2002:a2e:b007:: with SMTP id y7-v6mr13797664ljk.22.1535855793675;
        Sat, 01 Sep 2018 19:36:33 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id a18-v6sm2593747ljk.47.2018.09.01.19.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 19:36:31 -0700 (PDT)
Date:   Sat, 1 Sep 2018 19:36:03 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180902023603.2krvellhztpkoj67@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a72b44a871c218e2a0580e68affa1d3528c0587a:

  Merge tag 'omap-for-v4.19/fixes-v2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-09-01 18:22:19 -0700)

----------------------------------------------------------------
ARM: SoC fixes

First batch of fixes post-merge window:

 - A handful of devicetree changes for i.MX2{3,8} to change over to new
   panel bindings. The platforms were moved from legacy framebuffers
   to DRM and some development board panels hadn't yet been converted.
 - OMAP fixes related to ti-sysc driver conversion fallout, fixing some
   register offsets, no_console_suspend fixes, etc.
 - Droid4 changes to fix flaky eMMC probing and vibrator DTS mismerge.
 - Fixed 0755->0644 permissions on a newly added file.
 - Defconfig changes to make ARM Versatile more useful with QEMU
   (helps testing).
 - Enable defconfig options for new TI SoC platform that was merged this
   window (AM6).

----------------------------------------------------------------
Fabio Estevam (6):
      ARM: dts: imx28-evk: Move regulators outside simple-bus
      ARM: dts: imx28-evk: Convert to the new display bindings
      ARM: dts: imx23-evk: Move regulators outside simple-bus
      ARM: dts: imx23-evk: Convert to the new display bindings
      ARM: mxs_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G
      ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G

Keerthy (1):
      arm: dts: am4372: setup rtc as system-power-controller

Leonard Crestez (1):
      Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

Linus Walleij (1):
      ARM: defconfig: Update the ARM Versatile defconfig

Neeraj Dantu (1):
      ARM: dts: Fix file permission for am335x-osd3358-sm-red.dts

Nishanth Menon (1):
      arm64: defconfig: Enable TI's AM6 SoC platform

Olof Johansson (2):
      Merge tag 'imx-fixes-4.19' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.19/fixes-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix vibrations on Droid 4

Tony Lindgren (6):
      ARM: OMAP2+: Fix null hwmod for ti-sysc debug
      ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
      bus: ti-sysc: Fix module register ioremap for larger offsets
      bus: ti-sysc: Fix no_console_suspend handling
      Merge branch 'perm-fix' into omap-for-v4.19/fixes-v2
      ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

 arch/arm/boot/dts/am335x-osd3358-sm-red.dts |   0
 arch/arm/boot/dts/am4372.dtsi               |   1 +
 arch/arm/boot/dts/imx23-evk.dts             |  90 +++++++-------
 arch/arm/boot/dts/imx28-evk.dts             | 183 +++++++++++++---------------
 arch/arm/boot/dts/imx7d.dtsi                |  12 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts    |  20 +--
 arch/arm/configs/imx_v6_v7_defconfig        |   1 +
 arch/arm/configs/mxs_defconfig              |   1 +
 arch/arm/configs/versatile_defconfig        |  14 ++-
 arch/arm/mach-omap2/omap_hwmod.c            |  39 +++++-
 arch/arm64/configs/defconfig                |   3 +
 drivers/bus/ti-sysc.c                       |  37 +++---
 12 files changed, 213 insertions(+), 188 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
