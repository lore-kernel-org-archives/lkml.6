Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A81C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8865720837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544356179;
	bh=KXMCjPkFHLUQxUDv8jaVk1A7Z06zBBDxTTQsMCVSz4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O36F0fTFMWWLtG5UOWucgJj/TWsEyyEDvWVRFdZpfZSFyQKAgHDthmXEXqILdLPp1
	 AAxA5MMDzGMI7iwkHYabB/R2NRqIxUoRkT5pbjryjbzUELWizE/884W2Fjs8jyIONv
	 9KldwPD0g5PUapy5/olaiLcmo3YviSWh1bT/M3fI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8865720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLILt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeLILtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:49:25 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28F120867;
        Sun,  9 Dec 2018 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544356164;
        bh=KXMCjPkFHLUQxUDv8jaVk1A7Z06zBBDxTTQsMCVSz4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=finkDwW4JAkOSg3ZLPhLTgeqW5IkVV+g3G+uEcpvLX5XwAYKb+kbcQW4fjvdrwArG
         TUR8+GQOTJdd3fZfCIGXO+Kj4Q3ReETihvaexHRtnwT2jFfS1BX4HqDyiY9aso+q+h
         i2twkYy1x+6Wmyah1QKErqi760/r6jiVlEp7LRSY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] ARM: dts: exynos: Pull for v4.21
Date:   Sun,  9 Dec 2018 12:49:09 +0100
Message-Id: <20181209114911.25194-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21

for you to fetch changes up to 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:

  ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.21

1. Add missing properties and nodes for PMIC clocks in multiple DTS
   files.
2. Add UHS-I bus speed support to Odroid XU3/XU4/HC SD card and bump the
   maximum clock frequency to 200 MHz for SD and eMMC.
3. Update cooling maps to include all CPU devices in multiple DTS files.
4. Enable quirks for Exynos3250 DWC.
5. Add JPEG CODEC node to S5Pv210.
6. Add opp-suspend to devfreq OPPs on Exynos4 boards to fix resuming
   from suspend to RAM.
7. Remove eDP from Arndale board as it does not work and breaks also
   DSI.

----------------------------------------------------------------
Anand Moon (5):
      ARM: dts: exynos: Add UHS-I bus speed support to Odroid XU3/XU4/HC1
      ARM: dts: exynos: Fix LDO13 min values on Odroid XU3/XU4/HC1
      ARM: dts: exynos: Update maximum frequency for SD card to 200MHz on Odroid XU3/XU4/HC1
      ARM: dts: exynos: Update maximum frequency for eMMC to 200MHz on Odroid XU3/XU4
      ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU3/XU4/HC1

Andrzej Hajda (1):
      ARM: dts: exynos: remove display-port node from Arndale

Krzysztof Kozlowski (3):
      ARM: dts: exynos: Add compatible for s2mps11 clocks node on Exynos542x
      ARM: dts: exynos: Add compatible for s5m8767 clocks node on Itop Core
      ARM: dts: exynos: Clarify comment explaining purpose of Odroid XU3 DTSI

Lukasz Luba (1):
      ARM: dts: exynos: Add opp-suspend to DMC and leftbus devfreq OPPs on Exynos4

Marek Szyprowski (2):
      ARM: dts: exynos: Add missing clocks to RTC node for Arndale board
      ARM: dts: exynos: Use Samsung SoC specific compatible for DWC2 module

Paweł Chmiel (1):
      ARM: dts: s5pv210: Add s5p-jpeg codec node.

Viresh Kumar (1):
      ARM: dts: exynos: Add all CPUs in cooling maps

 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   6 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |   6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   6 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   4 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |   4 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |   9 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |   8 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  18 ++--
 arch/arm/boot/dts/exynos4412.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |  34 ++-----
 arch/arm/boot/dts/exynos5250.dtsi                  |   7 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   1 +
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   7 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  11 ++-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 106 ++++++++++++--------
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 109 +++++++++++++--------
 arch/arm/boot/dts/s5pv210.dtsi                     |   9 ++
 20 files changed, 221 insertions(+), 143 deletions(-)
