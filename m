Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DFAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D72218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549048655;
	bh=f2oLzNDn2Cfvbgc3FgNMiKRTjjx2dAb6tJN6awhcr/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIP5w6PJiAtpgrqD43odJ+dOp/yKnORSl/IVSAGfUQPDlhywNjMTIAtYqKrRaXid9
	 X3nSokfYzOU+w07+SwcAa6jvu1pnoY11uPdkrYd1Kf75dpGS7hAlbIR7DTSx1frBZ0
	 0i++7cndTkqcBWL8RgrLPxFLifEEjkH2h4XiAjfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfBATRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfBATRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:17:31 -0500
Received: from localhost.localdomain (80-123-14-12.adsl.highway.telekom.at [80.123.14.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E38F218FF;
        Fri,  1 Feb 2019 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549048650;
        bh=f2oLzNDn2Cfvbgc3FgNMiKRTjjx2dAb6tJN6awhcr/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvxTa8or+KJj/AjfMIp+ig/t3j3gWmnFnf5ovOhhTg1SjfId/c5Zd7IazQjPcEKVp
         UbyI8IkBBKiAxWQoF13w8MBtrNRrVuorLJIwA1jBS8qp9AzqpKeV4shrO0o3RoFwjx
         ioZc6qxMEblEDolV9HK3boVMNpLxndq4aoGIohWM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] ARM: dts: samsung: exynos and s5pv210 for v5.1
Date:   Fri,  1 Feb 2019 20:17:20 +0100
Message-Id: <20190201191720.20464-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201191720.20464-1-krzk@kernel.org>
References: <20190201191720.20464-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.1

for you to fetch changes up to ec33745bccc8f336957c751f4153421cc9ef5a54:

  ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3 (2019-01-25 20:18:10 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.1

1. Extend support for Aries family of mobile devices (e.g. Samsung
   Galaxy S) based on S5Pv210 SoC: DRM Rotator, FIMD, PWM vibrator,
   power off, touchscreen, Broadcom BCM4329 Bluetooth and cpufreq.
2. Remove hardcoded bootargs on Galaxy S family (proper support in
   U-Boot).
3. Fix minor DTC warnings.
4. Fix Exynos4412 Odroid X2/U3 conflicting eMMC GPIO settings and regulator
   properties.
5. Fix the eMMC RTSN pin breaking proper reboot on X2.

----------------------------------------------------------------
Jonathan Bakker (1):
      ARM: dts: s5pv210: Add support for more devices present on Aries

Krzysztof Kozlowski (2):
      ARM: dts: s5pv210: Fix onenand's unit address format warning
      ARM: dts: s3c2416: Fix xti node's missing reg property warning

Marek Szyprowski (3):
      ARM: dts: exynos: Fix conflicting fixed-regulator GPIO flags and properties
      ARM: dts: exynos: Fix eMMC regulator properties on Odroid U3 boards
      ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3

Paweł Chmiel (5):
      ARM: dts: s5pv210: Add node for exynos-rotator
      ARM: dts: s5pv210: Use correct fimd variant
      ARM: dts: s5pv210: Remove hardcoded bootargs on Galaxy S and Fascinate 4G
      ARM: dts: s5pv210: Add reserved memory for MFC on Aries
      ARM: dts: s5pv210: Add DMC nodes

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 14 ++--
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |  2 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts          |  5 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi            | 90 +++++++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts       |  7 --
 arch/arm/boot/dts/s5pv210-galaxys.dts           |  7 --
 arch/arm/boot/dts/s5pv210.dtsi                  | 25 ++++++-
 8 files changed, 125 insertions(+), 27 deletions(-)
