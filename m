Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeDKJsE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:48:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37863 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753014AbeDKJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:48:00 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/5] Introduce STMFX I2C GPIO expander
Date: Wed, 11 Apr 2018 11:47:00 +0200
Message-ID: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STMicroelectronics Multi-Function eXpander
(STMFX) GPIO expander, used on some STM32 discovery and evaluation boards.

STMFX is an STM32L152 based I2C slave controller, whose firmware embeds an
I/O expansion feature, offering 24 GPIOs.

STMFX pinctrl/GPIO driver provides a GPIO interface supporting inputs and
outputs, and a pinctrl interface supporting push-pull and open-drain
configuration.
STMFX GPIO expander can also be used as interrupt controller.

Previous series [1], based on MFD and GPIO frameworks, is abandoned and
completely reworked.

[1] https://lkml.org/lkml/2018/2/8/300

Amelie Delaunay (5):
  dt-bindings: pinctrl: document the STMFX pinctrl bindings
  pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
  ARM: dts: stm32: add STMFX pinctrl/gpio expander support on
    stm32746g-eval
  ARM: dts: stm32: add orange and blue leds on stm32746g-eval
  ARM: dts: stm32: add joystick support on stm32746g-eval

 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 118 +++
 arch/arm/boot/dts/stm32746g-eval.dts               |  66 ++
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 985 +++++++++++++++++++++
 5 files changed, 1183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c

-- 
2.7.4
