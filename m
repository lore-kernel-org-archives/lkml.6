Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2581D20894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGj797NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2581D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeGYRg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbeGYRg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:36:29 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC0D20833;
        Wed, 25 Jul 2018 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532535846;
        bh=TWVTBV7ZcHnZr8NvCmWeQ6RF21wFwnYd7izZLMp27x0=;
        h=From:To:Cc:Subject:Date:From;
        b=sGj797NZZQAx9pCznGGHxlzlk2QZO8yCeukoJCTi2dm6uC21vL+TTqh26dK2givtD
         ubClUW4ciut9alaS5BkUYUavK25ZYn/1s+jBNy07Ht/BqkZ+EnCzySPyT+ozlD43SG
         BSB3Jagma0ErjnFW927z5QYSZSCdaUsT2fYOunn8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/3] drivers: samsung: Cleanup for v4.19
Date:   Wed, 25 Jul 2018 18:23:38 +0200
Message-Id: <20180725162340.7488-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rebased on v4.18-rc2, because at v4.18-rc1 the NFS root boot, which I use at my
testing setup (https://krzk.eu), was broken.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos5440-4.19

for you to fetch changes up to c708e462e90e04afb7634e1f27f60cd6869936db:

  usb: host: exynos: Remove support for Exynos5440 (2018-07-24 18:44:00 +0200)

----------------------------------------------------------------
Exynos5440 drivers removal

The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
server platforms but it did not make it to the market really.  There are
no development boards with it and probably there are no real products
neither.  The development for Exynos5440 ended in 2013 and since then
the platform is in maintenance mode.

Removing Exynos5440 makes our life slightly easier: less maintenance,
smaller code, reduced number of quirks, no need to preserve DTB
backward-compatibility.

The Device Tree sources and some of the drivers for Exynos5440 were
already removed.  This removes remaining drivers.

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      ata: ahci-platform: Remove support for Exynos5440
      cpufreq: exynos: Remove support for Exynos5440
      clk: samsung: Remove support for Exynos5440
      usb: host: exynos: Remove support for Exynos5440

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 -
 .../devicetree/bindings/clock/exynos5440-clock.txt |  28 --
 .../bindings/cpufreq/cpufreq-exynos5440.txt        |  28 --
 drivers/ata/ahci_platform.c                        |   1 -
 drivers/clk/samsung/Makefile                       |   1 -
 drivers/clk/samsung/clk-exynos5440.c               | 167 --------
 drivers/cpufreq/Kconfig.arm                        |  14 -
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/exynos5440-cpufreq.c               | 452 ---------------------
 drivers/usb/host/ehci-exynos.c                     |   7 -
 drivers/usb/host/ohci-exynos.c                     |   6 -
 include/dt-bindings/clock/exynos5440.h             |  44 --
 12 files changed, 750 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
 delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
 delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c
 delete mode 100644 include/dt-bindings/clock/exynos5440.h
