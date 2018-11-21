Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8485C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82392214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLNDY9Mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82392214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeKVFHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40452 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeKVFHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so6725633wmf.5;
        Wed, 21 Nov 2018 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6Su8zzVVrjceGqrw9zLmKG46wb+VaAzcmerV5DZ0ncs=;
        b=MLNDY9Mf9ssDIeJmOCATe1MXT0ufJEojNuZMaFxYVt6sNercPZj0ZIx7RHxagQZoQH
         ZO1WOMF2ocizo9egNQkcrUV1fxfQ1c+qo+4RC9zQ+hd9qtgiE8miMtVgzoLT9FxsnrHi
         AvJ9+daHnme2AI7UMjMikXJCMTXfAorfGm7Ydf1/S6tFOHlXvmFWEi9huVShKB2P1mK0
         TB1xmSRr0F2SVujvUqo35JaO+La7UqnfpnuVdFy89qJcJIffbPc+d6R/kGyi0wlEJ9/S
         4hpLdJQ327XoMrjK+EtKGrGj5ZdKRc77+PQXo2mhxd/pOKBPt3IGFMtMd78jsV4p3ukQ
         q9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Su8zzVVrjceGqrw9zLmKG46wb+VaAzcmerV5DZ0ncs=;
        b=YQB6dVvL3vU2WuXMJDxDVxCQAphyRulFVN17sHwRA/YIT4PR7ADqAl9VsCh31DvB4p
         F2+5529FuZl60XBvmUneRYyTvM+FPD/9SfjPstICP8fla3cf32cXbJqB6R2PbgNmoAH1
         n4VgkdUDgusktg2HYwcEJUqEYxo+wekliT2WTJWavombM6aNCq6GXO3cxVl4l/CIjx+b
         EBbKoJMR0PS1Dc/De3yYvDz7y/L1wFYrv4tgJMhRoEobWRGzEG/7E40WjVL+C8eIyPjc
         pO+YlSt/A6lLDGrS149rgAOeumjwVK/jjTgglpT6LWIqZRXYMHVv+p0JDyZMyj4y7QT5
         PGSA==
X-Gm-Message-State: AA+aEWZ4XP+BW3yLn0abWX4O3MWVOnLL5gQxsWTKbIADri7HVTU0eMpY
        YrpBB9Vooh5aLnnBr2Fy/wZPCFenmh0=
X-Google-Smtp-Source: AFSGD/WFERDsr6cp1cpRfWumzh62fzbhqjrxE08poEkGkTnLAcTRG/tNFNHas0XjkxutI4kg+hl+2g==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr6454572wmd.151.1542825099315;
        Wed, 21 Nov 2018 10:31:39 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:38 -0800 (PST)
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
Subject: [RFC PATCH v3 00/17] initial support for "suniv" Allwinner new ARM9 SoC
Date:   Wed, 21 Nov 2018 21:30:33 +0300
Message-Id: <cover.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of RFC patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comment from Maxime Ripard and fixed device tree
bindings to not include patterns. Also sram and watchdog compatibles
added for F1C100s.

irqchip code reworked to include a struct to differentiate chips.

Thanks!

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

Mesih Kilinc (17):
  ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner
    SoCs
  dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
  ARM: sunxi: add Allwinner ARMv5 SoCs
  dt-bindings: interrupt-controller: Add suniv interrupt-controller
  irqchip/sun4i: add support for suniv interrupt controller
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
  pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
  dt-bindings: clock: Add Allwinner suniv F1C100s CCU
  clk: sunxi-ng: add support for suniv F1C100s SoC
  dt-bindings: sram: Add Allwinner suniv F1C100s
  SoC: sunxi: Add support for Allwinner ARMv5 F1C100s sram
  dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
  watchdog: Add support for Allwinner ARMv5 F1C100s wdt
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
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 151 ++++++
 arch/arm/mach-sunxi/Kconfig                        |  39 +-
 arch/arm/mach-sunxi/sunxi.c                        |  10 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 536 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        | 104 ++--
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 417 ++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                     |   8 +
 drivers/watchdog/sunxi_wdt.c                       |   1 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  69 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  37 ++
 25 files changed, 1425 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4

