Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFAAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691021568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2jtdvdOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691021568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391027AbeIUXfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390180AbeIUXfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:35:24 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7DF21557;
        Fri, 21 Sep 2018 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537551928;
        bh=fuWOjHbcXejNLebTGPi2/vNODWx8FmWU3ZDzAKYcxd8=;
        h=From:To:Cc:Subject:Date:From;
        b=2jtdvdOyS7F5+AUIlVfYjrTL/YAzj8Qtwn9qKYoA6Uf1CPK5zwcEJKYbWsWDPJ8HL
         80Io3J60jRVDGwl201P6IuqwAjnVa+1njISnAENm7zO5npXy6rfV1b4cdAlG0H/XPc
         1p89mpjrhll20kYK6pDcCmOsYTwoMymraMz+b3Xo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] ARM: dts: exynos: DT for v4.20 (or 5.0)
Date:   Fri, 21 Sep 2018 19:45:19 +0200
Message-Id: <20180921174520.9126-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nothing special, description in tag.

Best regards,
Krzysztof


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.20

for you to fetch changes up to 7c92b9a8e0fc5eae460a33b7420af5cf60bd7b21:

  ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks (2018-09-17 18:03:10 +0200)

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
12. Explicitly mark Samsung Exynos SoC as unstable. When introduced, the
    DT bindings were minimal and incomplete. Since then some significant
    (not fully compatible) changes have been already merged and
    workarounds have been added while working on drivers. Marking certain
    bindings as unstable will point users attention to always use DTB
    compiled from current kernel sources - which anyway happens now. In
    case of fear of incompatible ABI changes, any out of tree Device
    Tree sources should either be upstreamed or should be changed in the
    same way as in-kernel DTS are modified.

----------------------------------------------------------------
Andrzej Hajda (4):
      ARM: dts: exynos: Add DSI node on Exynos5250
      ARM: dts: exynos: Add DSI and panel nodes on Arndale
      ARM: dts: exynos: Use i2c-gpio for HDMI-DDC on Arndale
      ARM: dts: exynos: Fix HDMI-HPD line handling on Arndale

Krzysztof Kozlowski (7):
      ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup compatible
      ARM: dts: exynos: Add missing used PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Add unused PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Disable unused PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Add LDO28 regulator on Exynos5422 Odroid boards
      ARM: dts: exynos: Remove double SD card detect pin inversion
      dt-bindings: arm: Explicitly mark Samsung Exynos SoC as unstable

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

 .../devicetree/bindings/arm/samsung/exynos.txt     |  26 ++++
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
 17 files changed, 459 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos.txt
