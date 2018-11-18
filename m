Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB720869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpOhVpMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAB720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeKSAik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35381 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKSAij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so2812257wmt.0;
        Sun, 18 Nov 2018 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8PKNipPdK1WPnQfTDieqSkeAXjq5gGiSNMxRn2fCbn8=;
        b=LpOhVpMHPbd2vQg/c9vqMYxcWbBkeZ8hKaq/CYbLz3Ie248hDbGevDkCh23NMAykiN
         3vyMqbz092EV48FaBZDzJiwMkdIMlxefUtqBdKJO692HBE3QhaMMHquyjSUISV0W1nl/
         3gLCU0TMbs2y9LoozodN+oDI8oQKeEI2dEcXb9o80LN/MyTRZQxR/IRdS55LPUlpxmzf
         79qOa7XZj3sKv6ANn85pJnEscG7OwP4FIbW6P2PK7+ZDYc7tNlr+pcfdA0z0fueQtv33
         ycSNNWHsK7Quz8kU1G0iZSRxCmN0nioalTYsvE9WO3YnaYcSM/0tYWOs+GyGNk2c5jc9
         yjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8PKNipPdK1WPnQfTDieqSkeAXjq5gGiSNMxRn2fCbn8=;
        b=MSCpWoTMrcuHl5ryCi/O0JFrBOfN5nj6zLDo5u9QPwIXffeOjl2jWGrg7yP72+YmvJ
         124q1efFCwagXRleph/qdhfmJfkBW679wby67tjcZbVmus4YoYL4Uk7HkPd/uLz9Tusn
         eaEobxD+W3B1q1UsFXw/fCcPLl2hxxtf5cGKnUOBqJiBwBrfs7lqxHNKJkpW2C1RhNH3
         b0nkHSF3JfP0+TQKkFK4+bVEw9icNXJ5gwVuOHTf+WsnY3wAn/cb1G0KB9Hh5UFuKmIq
         9pDQUMZWOjBxryuRTXAUYafGiCKjpQQN7/zWOC3AyTUH54WqzP4wKQKtpo8Gnsa9D4KF
         wSBw==
X-Gm-Message-State: AGRZ1gJB4nv01QF6r5Jul3SNA8Q00H6GDNP93AWmuyfUgCU+6L9y0YP5
        3+r2WHC3klnDRG3EKiTytmsOj1qb83s=
X-Google-Smtp-Source: AFSGD/VMQ1uUpUFtVHH4WSiQFlUD24b9jFz/Hz6wGSukqhbF/w8pDdd5y4EvM03bfOzaN8I5Ylkn3w==
X-Received: by 2002:a1c:85c5:: with SMTP id h188-v6mr4175149wmd.59.1542550690710;
        Sun, 18 Nov 2018 06:18:10 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:10 -0800 (PST)
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
Subject: [RFC PATCH v2 00/14] initial support for "suniv" Allwinner new ARM9 SoC
Date:   Sun, 18 Nov 2018 17:16:59 +0300
Message-Id: <cover.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of RFC patchset for Allwinner ARMv5 F1C100s
SoC. Icenowy (author of the initial patchset) allowed me to continue.
For patch 1~3 which introduces first ARMv5 Allwinner SoC I looked 
freescale,imx configs and tried to organize patches better. 
Addressed comment from Maxime Ripard and added SoC name to
compatibles and filenames. 
Addressed comment from Rob Herring and added dt-bindings.

This is my first patch. Sorry for any inconvenience :-)

Original cover later:

This is the RFC initial patchset for the "new" Allwinner SUNIV ARM9 SoC.

The same die is packaged differently, come with different co-packaged
DRAM or shipped with different SDK; and then made many model names: F23,
F25, F1C100A, F1C100S, F1C200S, F1C500, F1C600, R6, etc. These SoCs all
share a common feature set and are packaged similarly (eLQFP128 for SoCs
without co-packaged DRAM, QFN88 for with DRAM). As their's no
functionality hidden on the QFN88 models (except DRAM interface not
exported), it's not clever to differentiate them. So I will use suniv as
common name of all these SoCs.

As it's the first not ARMv7+ Allwinner SoC to get supported, this
patchset firstly made CONFIG_ARCH_SUNXI a common config item, and let
selectable CONFIG_ARCH_SUNXI_V{5,7} to internally select it. This makes
reusing most work possible. This is PATCH 1~2.

The ARM9 has neither GIC nor arch_timer, like the sun4i/5i Cortex-A8
SoCs. So adapt the IRQ and timer driver used by sun4i/5i to support
suniv. This is PATCH 3~5.

Then it's the common way to support a new SoC -- pinctrl, CCU and
initial DT.

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

Mesih Kilinc (14):
  ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner
    SoCs
  dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
  ARM: sunxi: add Allwinner ARMv5 SoCs
  dt-bindings: interrupt-controller: Add suniv interrupt-controller
  irqchip/sun4i: add support for suniv interrupt controller
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  clocksource/drivers/sun4i: register as sched_clock on suniv
  dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
  pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
  dt-bindings: clock: Add Allwinner suniv F1C100s CCU
  clk: sunxi-ng: add support for suniv F1C100s SoC
  ARM: dts: suniv: add initial DTSI file for F1C100s
  ARM: suniv: f1c100s: add device tree for Lichee Pi Nano

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../interrupt-controller/allwinner,sun4i-ic.txt    |   5 +-
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../bindings/timer/allwinner,sun4i-timer.txt       |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 158 ++++++
 arch/arm/mach-sunxi/Kconfig                        |  39 +-
 arch/arm/mach-sunxi/Makefile                       |   3 +-
 arch/arm/mach-sunxi/sunxi_v5.c                     |  22 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 536 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        |  47 +-
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 417 ++++++++++++++++
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  69 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  37 ++
 22 files changed, 1401 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4

