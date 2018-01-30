Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeA3VSx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeA3VSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:18:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6727D21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg warning for syscon restart nodes
Date: Tue, 30 Jan 2018 22:18:15 +0100
Message-Id: <20180130211819.17139-1-krzk@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Changes since v1:
1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
   following Rob's advice.
2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
   on this.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  soc: samsung: pmu: Populate children syscon nodes
  ARM: dts: exynos: Remove duplicated inclusion of syscon restart nodes
    on Exynos5410
  ARM: dts: exynos: Fix missing missing reg warning for syscon restart
    nodes
  arm64: dts: exynos: Fix missing missing reg warning for syscon restart
    nodes

 .../devicetree/bindings/arm/samsung/pmu.txt        |  6 +++++
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       | 28 ++++++++++------------
 arch/arm/boot/dts/exynos3250.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  3 ++-
 arch/arm/boot/dts/exynos5.dtsi                     |  1 -
 arch/arm/boot/dts/exynos5250.dtsi                  |  1 +
 arch/arm/boot/dts/exynos5410.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 14 +++++------
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 12 +++++-----
 drivers/soc/samsung/exynos-pmu.c                   |  3 +++
 11 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.11.0
