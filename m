Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1672214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfha/w01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1672214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbeIXXYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeIXXYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:24:51 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9385F20676;
        Mon, 24 Sep 2018 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537809699;
        bh=AU8m6xoiytlm+Nf6b2Skrs9pbL1H6AEerg3QyxbMFHc=;
        h=From:To:Cc:Subject:Date:From;
        b=tfha/w01Df0y7pFf7Asn6RDyWDh5LTOk2A++PvPqdkfwBKMEr5LfrOWRbfGcjHqYc
         f+QdBaHG7IRKlUbIgv3qbEBXcinWo+EzW7Oq22GiGIn9OKesbzQlcWCLXGFOlxqKvO
         YXWBzzqb9CpHuKHNevaL6G04CwXva8v6WriufEP8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: dts: exynos: DT for v4.20 (or 5.0) (revised)
Date:   Mon, 24 Sep 2018 19:21:33 +0200
Message-Id: <20180924172133.11786-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pull request without ABI-stability patch.

Best regards,
Krzysztof


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.20-2

for you to fetch changes up to ff1e37c6809daab75f7b2dea1efe69330e8eb65b:

  ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks (2018-09-24 18:55:16 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.20

1. Bring up DSI and HDMI on Exynos5250 Arndale.
2. Use the new way of setting external wakeup interrupts on S5Pv210.
3. Use proper cpufreq suspend OPP to fix suspend/wakeup from RAM on Snow
   Chromebook (Exynos5250).
4. Fully describe regualtors on Odroid XU3-family boards.
5. Fix sound in Snow-rev5 Chromebook.
6. Fix regulators configuration on Peach Pi/Pit Chromebooks (Exynos5420)
   which should be always on.
7. Fix pull control on PMIC interrupt lines on multiple boards which
   essentially fixes waking up by RTC.
8. Add PMIC interrupts on Exynos4210 UniversalC210 board.
9. Add external SD card support for Trats board (Exynos4210).
10. Correct audio subsystem parent clock on Peach Chromebooks.
11. Minor cleanups.

----------------------------------------------------------------
Andrzej Hajda (4):
      ARM: dts: exynos: Add DSI node on Exynos5250
      ARM: dts: exynos: Add DSI and panel nodes on Arndale
      ARM: dts: exynos: Use i2c-gpio for HDMI-DDC on Arndale
      ARM: dts: exynos: Fix HDMI-HPD line handling on Arndale

Krzysztof Kozlowski (6):
      ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup compatible
      ARM: dts: exynos: Add missing used PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Add unused PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Disable unused PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Add LDO28 regulator on Exynos5422 Odroid boards
      ARM: dts: exynos: Remove double SD card detect pin inversion

Marek Szyprowski (10):
      ARM: dts: exynos: Convert exynos5250.dtsi to opp-v2 bindings
      ARM: dts: exynos: Mark 1 GHz CPU OPP as suspend OPP on Exynos5250
      ARM: dts: exynos: Fix sound in Snow-rev5 Chromebook
      ARM: dts: exynos: Fix regulators configuration on Peach Pi/Pit Chromebooks
      ARM: dts: exynos: Disable pull control for MAX8997 interrupts on Origen
      ARM: dts: exynos: Add missing PMIC interrupts on UniversalC210 board
      ARM: dts: exynos: Disable pull control for S5M8767 PMIC
      ARM: dts: exynos: Disable pull control for PMIC IRQ line on Artik5 board
      ARM: dts: exynos: Add external SD card support for Trats board
      ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks

 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   7 +
 arch/arm/boot/dts/exynos4210-origen.dts            |   9 ++
 arch/arm/boot/dts/exynos4210-trats.dts             |  15 ++
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  11 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |   3 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   3 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           | 102 +++++++++++--
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |  11 ++
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |  11 ++
 arch/arm/boot/dts/exynos5250.dtsi                  | 152 ++++++++++++++------
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   5 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 157 +++++++++++++++++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   6 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   6 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   5 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   2 +-
 16 files changed, 433 insertions(+), 72 deletions(-)
