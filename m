Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6DA20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozmKSFvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6DA20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeK2Jjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:39:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51076 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeK2JhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so301998wmh.0;
        Wed, 28 Nov 2018 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W4Wi7swWBNgxc2OK1K68tHTCFCmIPvqaSqBPxwVVoF0=;
        b=ozmKSFvviuO6bCXbLt/IrPTYOperp0QDyoGBApkpeltiZiiKjUP7r0iQ8EQp/09BQV
         dXFH82hnvQd2J0pKScjZBNH1yeI9eSI8Fj0GVEJe9rdu+bYvc6HsGM4J7tOpqZRi6M4s
         VpOUatxGkpHe4e8tCKAvL6B7NTv2Qw7zk1F+B71HSjq/er4ft0bISwu65F+4yTc71EIr
         Od3O71d3slpuXXlPN006XmK8VdBqBhWEdB1wvGUkMZBbyLN8vPt4i4Q3yx+5WhGBKqbR
         i63707JDZDB6oSat0QCKzjrxd7146J8XQbT8H6cQ7olisfyWgPspTvfUYBf7KpSoln2Y
         KKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W4Wi7swWBNgxc2OK1K68tHTCFCmIPvqaSqBPxwVVoF0=;
        b=myj/Nek19nYGvtEmogjhsk/1HZiHlMXCooy6X5RtQAncwzOJbSw2QvN8DseJud69XI
         OJdTIH7PFDRQmYlsgcVuVgetkP6Gh/CxzvEYrsyfRqLfsnVJwlG/a0rp9dHqJWKc2SZn
         SnTLrHxfjM9Zm51oUFC14sdfMqZ6LJ7KVNqxuPT1OYWb6cTm0qKN4vivtcL7difnsACI
         GaujdwjZNVmwiZ2zXH6DLhxMN5kwtZBPcWSIOV6yA6gPEH2sSCt9OzY23VLDQMJbGZY5
         pMVndC5fegncmMurNDSIH56DDGuq63Hmh7AqxPDAa2s1TgBPsQ+aZB7OCwhKEg0eGHDD
         NY7Q==
X-Gm-Message-State: AA+aEWZXhs/mQ3M6O27ncFrldBKH74rTJw/7a+pUIxI7b3/Qyx0f0Sc6
        klDei28+gSZ6WZSHzFNaWd5JuaTkTRk=
X-Google-Smtp-Source: AFSGD/Xo2l8coJI3/3elUD+eZhwi+Me2yX3e2acv11avRxN4P6EgCQKuY5VGq37Q7S4WK78UAKbMEg==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr4461750wmu.152.1543444451189;
        Wed, 28 Nov 2018 14:34:11 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:10 -0800 (PST)
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
Subject: [PATCH v5 00/17] initial support for "suniv" Allwinner new ARM9 SoC
Date:   Thu, 29 Nov 2018 01:33:10 +0300
Message-Id: <cover.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifth version of patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comments from Maxime Ripard and Rob Herring, added signatures.

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

