Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeBQUpI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:45:08 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37289 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeBQUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:45:06 -0500
X-Google-Smtp-Source: AH8x225ciUNuwJLm2Cs+k6SD+A6QwzbbAZOkdTiulypWSE8Lrgw2DTeSEzvgZpfhu4FaHeltSRGM6g==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/10] Add Actions Semi S900 pinctrl and gpio support
Date: Sun, 18 Feb 2018 02:14:23 +0530
Message-Id: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds pinctrl and gpio support for Actions Semi S900 SoC.
Pinctrl and gpio subsystems share the common set of register range but
implemented as individual drivers for making it less complex.

Pinmux functions are only accessible for pin groups while pinconf
parameters are available for both pin groups and individual pins.

gpio-line-names has been added for the Bubblegum-96 board matching the
96Boards CE specification v1.0.

Both pinctrl and gpio drivers are verified using the Bubblegum-96 board.

This patchset depends on the clock driver which is still under review:
https://lkml.org/lkml/2018/2/9/831

Thanks,
Mani

Manivannan Sadhasivam (10):
  dt-bindings: pinctrl: Add bindings for Actions S900 SoC
  arm64: dts: actions: Add pinctrl node for S900
  arm64: actions: Enable PINCTRL in platforms Kconfig
  pinctrl: actions: Add Actions S900 pinctrl driver
  dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
  arm64: dts: actions: Add S900 gpio nodes
  arm64: dts: actions: Add gpio line names to Bubblegum-96 board
  gpio: Add gpio driver for Actions OWL S900 SoC
  MAINTAINERS: Add reviewer for ACTIONS platforms
  MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries

 .../devicetree/bindings/gpio/actions,owl-gpio.txt  |   15 +
 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  171 ++
 MAINTAINERS                                        |    5 +
 arch/arm64/Kconfig.platforms                       |    1 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  175 ++
 arch/arm64/boot/dts/actions/s900.dtsi              |   13 +
 drivers/gpio/Kconfig                               |    8 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-owl.c                            |  258 ++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/actions/Kconfig                    |   12 +
 drivers/pinctrl/actions/Makefile                   |    2 +
 drivers/pinctrl/actions/pinctrl-owl.c              |  573 +++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  178 ++
 drivers/pinctrl/actions/pinctrl-s900.c             | 2536 ++++++++++++++++++++
 16 files changed, 3950 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 create mode 100644 drivers/gpio/gpio-owl.c
 create mode 100644 drivers/pinctrl/actions/Kconfig
 create mode 100644 drivers/pinctrl/actions/Makefile
 create mode 100644 drivers/pinctrl/actions/pinctrl-owl.c
 create mode 100644 drivers/pinctrl/actions/pinctrl-owl.h
 create mode 100644 drivers/pinctrl/actions/pinctrl-s900.c

-- 
2.14.1
