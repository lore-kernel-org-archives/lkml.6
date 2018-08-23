Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B4C04E86
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E032098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YgnfKgKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E032098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeHWIBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:01:05 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46306 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeHWIBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:01:05 -0400
Received: by mail-pf1-f177.google.com with SMTP id u24-v6so2021602pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZN+u7mC9EluaGdk8PcwKQWkPrPeLK3CEGSPJLLYhzQc=;
        b=YgnfKgKsx4CggBnVF9moP+CZM8iEh5v52cWit3YIXcYCC6OVSa86yiMGP7IvJqXPlN
         n7Vw1vb0C/J1XiRmVdBkF6Af+m/woKOjeIjOx0+RPW6MKDv3myCnJ8fQqeP7VHim7HkI
         BZOFuopfluwOqr+FjnBsy86JQ/pN4j/7Qs/CX9g1K2XTkaPVyqiQ1Y/ICRtpYPeIlKjT
         DxXP4s08GgpUGquAMZxK+eYfCvd8sA2rTm50hbNjRdefSTiL1EsQzErtD+ldK9PplNU+
         SVlbutKdRwGtJR3f3V/9KmMtUDsSruGWZa7ugmtPmgJRbfwAfcNIAApaVQYCta0SnADi
         WYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZN+u7mC9EluaGdk8PcwKQWkPrPeLK3CEGSPJLLYhzQc=;
        b=pVymlZBeoZyPZMWKoQF2INBeTKWMCp0QRkpv77f9AbmLw0qmEJlqTZT6Zd/v/3RBbG
         pSu4Ei2hIZ9IZBC3yDwRjtn2ViIV0TttD1N9SSgF4Bc2HY18f6iiar7yQUrfKIUFdB3l
         ybLL8RMCE7fk/pEJTCS04lWZhudhk6Mi3CbyBp3M73h0iVQ4KT2ihhgcDZK35u1PUCCT
         sdwcwLdF77KWh8KtFKggtki+zSt/hYkPj7YQMEMPAIBVMSSHlNWxyPuDYpAdk66lWsMf
         eR83/UsR0qJBsBDUVBvYlb01B4jKj1sX+5zFGpOSwS09TM1jjBcAH1MK/iW3g+YR2mhy
         zJwg==
X-Gm-Message-State: AOUpUlGpjU+9BNna6BbRpLhIdEn4RrvvOwUk7wyPiNp1x+6b9+bZ+ych
        zjDJjyo7whfdyGV3w5rl6a0PEQ==
X-Google-Smtp-Source: AA+uWPz5UFH/C4rs3DJ1WAfslSxLGVSC/HfzCfwc/Utk8lwgVwmkea69vtU6O1Zs7gX0v4erbDxwsw==
X-Received: by 2002:a65:614a:: with SMTP id o10-v6mr53706543pgv.387.1534998800242;
        Wed, 22 Aug 2018 21:33:20 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 70-v6sm4859947pfz.27.2018.08.22.21.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 21:33:17 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: SoC defconfig updates
Date:   Wed, 22 Aug 2018 21:32:56 -0700
Message-Id: <20180823043257.18582-4-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180823043257.18582-1-olof@lixom.net>
References: <20180823043257.18582-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep these separate since some files are shared and conflict-prone,
but there isn't really much to write about here.

Some of the churnier pieces is for the Aspeed platforms, which did an
overdue refresh of the defconfig, and enabled USB gadget and some
drivers from there. Most of the rest are minor additions here and there
to turn on drivers that are needed or useful on the various platforms.

----------------------------------------------------------------

The following changes since commit 4344bb3ec602d8b613a2f6c71f84eb631468a432:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 07d268f541dee9e58ded056fb6782942faa89a91:

  Merge tag 'v4.19-rockchip-defconfig64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into next/defconfig

----------------------------------------------------------------

Abhishek Sahu (2):
      ARM: qcom_defconfig: Enable QCOM NAND related configs
      arm64: defconfig: Enable CONFIG_MTD_NAND_QCOM for IPQ8074

Adam Ford (1):
      ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m

Amelie Delaunay (1):
      ARM: multi_v7_defconfig: enable STM32 RTC

Baruch Siach (2):
      ARM: mvebu_v7_defconfig: sync defconfig
      ARM: mvebu_v7_defconfig: enable SFP support

Benjamin Herrenschmidt (2):
      arm: configs: Add USB gadget to Aspeed G4 defconfig
      arm: configs: Add USB gadget to Aspeed G5 defconfig

David Lechner (2):
      ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS
      ARM: davinci_all_defconfig: Enable Bluetooth

Dien Pham (1):
      arm64: defconfig: Enable BD9571MWV regulator

Enric Balletbo i Serra (1):
      arm64: defconfig: Enable more peripherals for Samsung Chromebook Plus.

Florian Fainelli (2):
      Merge tag 'bcm2835-defconfig-next-2018-07-03' into defconfig/next
      Merge tag 'bcm2835-defconfig-64-next-2018-07-03' into defconfig-arm64/next

Geert Uytterhoeven (5):
      ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n
      ARM: shmobile: defconfig: Enable reset controller support
      ARM: shmobile: defconfig: Enable support for RZN1D-DB
      ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
      ARM: multi_v7_defconfig: Enable support for RZN1D-DB

Gregory CLEMENT (1):
      ARM: multi_v7_defconfig: Add Marvell NAND controller support

Hugues Fruchet (1):
      ARM: multi_v7_defconfig: enable STM32 DCMI media support

Joel Stanley (4):
      ARM: config: aspeed: Update defconfig
      ARM: config: multi_v5: Refresh configuration
      ARM: config: multi_v5: Enable ASPEED drivers
      ARM: config: aspeed: Enable new FSI drivers

Kishon Vijay Abraham I (1):
      ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP

Kunihiko Hayashi (1):
      ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors

Murali Karicheri (1):
      ARM: keystone: k2g: enable micrel and dp83867 phys

Olof Johansson (15):
      Merge tag 'keystone_config_for_4.19' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'arm-soc/for-4.19/defconfig' of https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'arm-soc/for-4.19/defconfig-arm64' of https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'davinci-for-v4.19/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'samsung-defconfig-4.19' of https://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'stm32-defconfig-for-v4.19-1' of git://git.kernel.org/.../atorgue/stm32 into next/defconfig
      Merge tag 'mvebu-defconfig-4.19-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'hisi-defconfig-for-4.19' of git://github.com/hisilicon/linux-hisi into next/defconfig
      Merge tag 'imx-defconfig-4.19' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'qcom-arm64-defconfig-for-4.19' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.19' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'renesas-arm-defconfig-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'aspeed-4.19-defconfig' of git://git.kernel.org/.../joel/aspeed into next/defconfig
      Merge tag 'v4.19-rockchip-defconfig64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/defconfig

Paweł Chmiel (3):
      ARM: s5pv210_defconfig: Run make savedefconfig
      ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
      ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro

Pierre-Yves MORDRET (1):
      ARM: multi_v7_defconfig: enable STM32 DMAv2, DMAMUX and MDMA

Ray Jui (1):
      arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

Robin Gong (1):
      ARM: imx_v6_v7_defconfig: add DMATEST support

Stefan Agner (2):
      ARM: mxs_defconfig: use MXSFB DRM driver
      ARM: imx_v6_v7_defconfig: use MXSFB DRM driver

Stefan Wahren (3):
      ARM: bcm2835_defconfig: Enable RPi voltage sensor
      ARM: multi_v7_defconfig: Enable RPi voltage sensor
      arm64: defconfig: Enable RPi voltage sensor

Zhou Wang (1):
      arm64: defconfig: enable HiSilicon PMU driver


 arch/arm/configs/aspeed_g4_defconfig   | 113 +++++++++++++++++++++++----
 arch/arm/configs/aspeed_g5_defconfig   | 117 +++++++++++++++++++++++-----
 arch/arm/configs/bcm2835_defconfig     |   2 +-
 arch/arm/configs/davinci_all_defconfig |  11 ++-
 arch/arm/configs/imx_v6_v7_defconfig   |   8 +-
 arch/arm/configs/keystone_defconfig    |   5 ++
 arch/arm/configs/multi_v5_defconfig    |  30 ++++---
 arch/arm/configs/multi_v7_defconfig    |  10 +++
 arch/arm/configs/mvebu_v7_defconfig    |  13 +---
 arch/arm/configs/mxs_defconfig         |   5 +-
 arch/arm/configs/qcom_defconfig        |   2 +
 arch/arm/configs/s5pv210_defconfig     |  49 +++++++++++-
 arch/arm/configs/shmobile_defconfig    |  17 +---
 arch/arm64/configs/defconfig           |  23 ++++++
 14 files changed, 324 insertions(+), 81 deletions(-)
