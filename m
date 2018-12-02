Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12643C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B120851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3SuOme7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12B120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeLBUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55645 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so3689216wmc.5;
        Sun, 02 Dec 2018 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HkUpJ5u4r54RHIDg1gzTLsj/w77aL+J50O3FnhmlJOw=;
        b=E3SuOme7u/a1WA6+Zoz7I5g2kxrWwXZSSOMcXtfXJwbW7e5Ek9lPzdS8BHfNJpV19u
         yzlf9XIPqq4WMCO4/k+J/E2Ut7Z27DT83QRjt8NRUfIWiDrwKNTWgXAn6wluT/nlMOYP
         Ut71ei8dYTXYYKJCuCI6++r6/nEms0UvUr7797l7cW8rgB973CDUV3zjwAl0Ffgy3zga
         qYKxs/QQ2329sjaQp9AK0SYK42w1zSWYFod2EriG82xvi7RyTgfTgKJU/GejQ2+qq4dV
         tmrAH9ZjWEs2z8CX9v5lkSqRAR6DBnTh3QhHI9yvQ7IywptDS2LOIF/daqK5gQ6+beP7
         SpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HkUpJ5u4r54RHIDg1gzTLsj/w77aL+J50O3FnhmlJOw=;
        b=r4j58GIx3/HVwQqajiQM1YJXm4H7sWZPzFefhSq3nuXAeUGWvumV00QtWK/uw30xb6
         JZk7brA9aueWjdpgOEyg8oZvCFMcVT6DNAd6k26apU3Z2co90/OE7t/5FrGLGoYzTezC
         9hbbId30yZh3tfaiOTVmeOewAW3rARTlTNeWqZbCI6WMokGTLukTaDBKplPdjYSo79RU
         pkq+1GZQYvbRxK7W33LApuonslTeND26gdcfURJcyOmMSFF2TjxA0mhJCSD0rBHRCz83
         r9KDxc1O08s/xfXQwmqfpE2LTCkIuLucpMTP0ar9pb3K9/Qj9tW2haA5T781rveqqwHq
         0o2A==
X-Gm-Message-State: AA+aEWbuSEyjQvB7KDEDApqyb64ntV7gHBh+RPcfhUTqhxbggHmIZd9s
        DxMXmOkXLaD4eOcjxXC4GCjlUmZPEsw=
X-Google-Smtp-Source: AFSGD/Vc+qGw9tdEbw5X7WMtvAB6XnjcHlyyYSAwEiJgrtbhmzhnL5/P5omnh1nE5cNflXNMosAAWg==
X-Received: by 2002:a1c:c148:: with SMTP id r69mr5870115wmf.147.1543782250442;
        Sun, 02 Dec 2018 12:24:10 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:09 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v6 00/17] initial support for "suniv" Allwinner new ARM9 SoC
Date:   Sun,  2 Dec 2018 23:23:34 +0300
Message-Id: <cover.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sixth version of patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comments from Stephen Boyd, added signatures.

Changes since v5:
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Fixed license identifier position

Changes since v4:
- Patch "dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl"
  - This patch applied for 4.21.
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - This patch applied for 4.21.
- Patch "dt-bindings: clock: Add Allwinner suniv F1C100s CCU"
  - Fixed license identifier position
  - Added DMA fields.
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Added DMA reset and clock support.
- Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
  - Remove dt-binding headers. 
  - Fix uart0 pin label.
- Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
  - Fix uart0 pin label.

Changes since v3:
- Patch "ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs"
  - Remove CONFIG_ARCH_SUNXI_Vx. Use ARCH_MULTI_Vx to differentiate SoC's
  - Change KConfig ARCH_SUNXI selection: 'select' to 'default'. 
- Patch "irqchip/sun4i: Add a struct to hold global variables"
  - Split irq_sun4i.c changes to 3 patch.
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - pinctrl-suniv-f1c100s: remove: disable_strict_mode = true
- Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
  - suniv-f1c100s.dtsi: remove unnecessary componenets.
  - Instead of patching drivers, add original compatible string with 
f1c100s compatibles.
  - Add Acked-by signatures.

Changes since v2:
- Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
  - Move SUN4I_TIMER option to ARCH_SUNXI
  - Added help text for MACH_SUNIV
- Patch "irqchip/sun4i: add support for suniv interrupt controller"
  - Defined sunxi_irq_chip_data struct and used it to differentiate
    registers between different chips.
- Patch " ARM: dts: suniv: add initial DTSI file for F1C100s"
  - Removed unnecessary fake clock.
  - Fixed compatible strings.

Changes since v1:
- Patch "ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7
  Allwinner SoCs"
  - Instead of using a common bool config use a common menuconfig. 
  - Use ARCH_MULTI_V7 to differentiate V7 SoCs.
  - Addressed comment from Julian Calaby
- Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
  - Use ARCH_MULTI_V5 to differentiate V5 SoCs.
  - removed "allwinner,suniv" board compatible string
  - Added dt-bindings
- Patch "irqchip/sun4i: add support for suniv interrupt controller"
  - Added dt-bindings
  - Changed "allwinner,suniv-ic" to "allwinner,suniv-f1c100s-ic"
- Patch "clocksource: sun4i: add a compatible for suniv"
  - Added dt-bindings
  - Changed "allwinner,suniv-timer" to "allwinner,suniv-f1c100s-timer"
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - Added dt-bindings
  - Renamed suniv-pinctrl to suniv-f1c100s-pinctrl
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Added dt-bindings
  - Renamed suniv-ccu to suniv-f1c100s-ccu
- Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
  - Addressed comment from Rask Ingemann Lambertsen

Thanks!

Mesih Kilinc (17):
  ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
  dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
  ARM: sunxi: add Allwinner ARMv5 SoCs
  dt-bindings: interrupt-controller: Add suniv interrupt-controller
  irqchip/sun4i: Add a struct to hold global variables
  irqchip/sun4i: Move IC specific register offsets to struct
  irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
  pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
  dt-bindings: clock: Add Allwinner suniv F1C100s CCU
  clk: sunxi-ng: add support for suniv F1C100s SoC
  dt-bindings: sram: Add Allwinner suniv F1C100s
  dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
  ARM: dts: suniv: add initial DTSI file for F1C100s
  ARM: suniv: f1c100s: add device tree for Lichee Pi Nano

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../interrupt-controller/allwinner,sun4i-ic.txt    |   4 +-
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../devicetree/bindings/sram/sunxi-sram.txt        |   4 +
 .../bindings/timer/allwinner,sun4i-timer.txt       |   4 +-
 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 147 ++++++
 arch/arm/mach-sunxi/Kconfig                        |  19 +-
 arch/arm/mach-sunxi/sunxi.c                        |  10 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 541 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        | 106 ++--
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 416 ++++++++++++++++
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  70 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  38 ++
 23 files changed, 1408 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4

