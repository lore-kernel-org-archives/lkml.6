Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F42C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ADB20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lif51++p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ADB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeKYSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37938 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeKYSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so15318605wmd.3;
        Sat, 24 Nov 2018 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MNoQLhg5RnUk4Dygqb+CIUe5svaYsBLTOfmckQXyvpk=;
        b=Lif51++px1fPku4B0VCgfyVaIXkfVZjRFqWviDuwpOXHrNPkFkCGOy+pIRBYNPEE9O
         nKjUuWv4RB9tQv1RP1d4su8zeeDYfCuT3LzttGvkCOX83S5zgIlcCOYd+h+6UhbluRmZ
         7ossNuBGpl8D1R8o25nVjxNRXp7G6rabPFzo7M78sW72V+LSfGyr1WRLYFTKrsKCuVJW
         9py81uMOXWsc9iVGkK1HItxGdcv17c39JGHhJdHq9IBrcK8+dDE8GPcqxZTNY4reMdPp
         5hf6Oe+ZdGMebfpnZ6im43t6Gx4glUlv5WB2ghOXLycYZTqEM5DpBcOBdlWuA+By1yis
         nEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MNoQLhg5RnUk4Dygqb+CIUe5svaYsBLTOfmckQXyvpk=;
        b=jwVd9aniJWvDFikwSFeTE2KhUHsb/OGWwerPFajyttT7dP2kkeSed62JzKLXy2Xm4b
         GszMjRiAuhUBtfTDsNa6dt/tSDQdUx78bvJA9NbRJXBlQJnN56p+DKwUicQ2/brH7vFo
         z48XxOxlRzs6+dCKFnQmZMsZqIOWAAq97MsBp0ZTV1/xzfI2Tve4Oi3qE6OA+sMQItFd
         KIgQHVH/Lvek8kYQncrPBm19rC2u5t82rGh755p3GzH+SmzhUsyJn6xzprqQAfGjpEL7
         eRtyDWG5ib5d4uCiWtd+MrL22ftHZZyoj2rtjK8n5oBGurLkP9Je9zbhsVpvCNo0yoR3
         zKDg==
X-Gm-Message-State: AA+aEWYde1IL4XbKEFnwLk4cG/flk84CSdCR6ErBpjZVl573lITPZFcD
        bNI00RzTgdwIthWc5r4dutMAtNGz/Jo=
X-Google-Smtp-Source: AFSGD/UcItO0ZLHoex87LLeY2fqEVU35A6gEoEoAcoh/LYVTYsC3qM2AJsV3G/nSkj2NPbBs0/Zjmw==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr11800560wmg.75.1543131823542;
        Sat, 24 Nov 2018 23:43:43 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:42 -0800 (PST)
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
Subject: [RFC PATCH v4 00/17] initial support for "suniv" Allwinner new ARM9 SoC
Date:   Sun, 25 Nov 2018 10:43:02 +0300
Message-Id: <cover.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth version of RFC patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comments from Maxime Ripard, added Acked-by signatures.

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
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 536 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        | 106 ++--
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 416 ++++++++++++++++
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  69 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  37 ++
 23 files changed, 1401 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4

