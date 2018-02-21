Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966091AbeBUQCX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:02:23 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33896 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeBUQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:02:21 -0500
X-Google-Smtp-Source: AH8x224xR8DEEc5V0TZvZU9QfbRGSEWHaW5HLoLobeOBkqSmmPXO2MUcmAPAERfVZv3tm/Y4BLF+Vw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/10] Add Actions Semi S900 pinctrl and gpio support
Date: Wed, 21 Feb 2018 21:30:34 +0530
Message-Id: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
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

There is also S500 pinctrl and gpio driver developed by Andreas Farber
independently to this patchset.
https://github.com/afaerber/linux/commits/bg96-next

If this patchseries seems to be good enough to add base OWL pinctrl and
gpio support. Then, we may decide on adding S500 support on top of this later
by reusing the pinctrl definitions from Andreas.

Thanks,
Mani

Changes in v2:

* Implemented each GPIO bank as its own gpio-controller
* Added gpio-ranges property
* Modified pin group to follow pad names instead of register names
* Incorporated review comments from Andy
* Incorporated review comments from Andreas
* Fixed the MODULE_LICENSE with respect to SPDX tag
* Added Reviewed by tag from Rob for pinctrl binding

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

 .../devicetree/bindings/gpio/actions,owl-gpio.txt  |   76 +
 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  178 ++
 MAINTAINERS                                        |    5 +
 arch/arm64/Kconfig.platforms                       |    1 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  201 ++
 arch/arm64/boot/dts/actions/s900.dtsi              |   54 +
 drivers/gpio/Kconfig                               |    8 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-owl.c                            |  219 ++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/actions/Kconfig                    |   12 +
 drivers/pinctrl/actions/Makefile                   |    2 +
 drivers/pinctrl/actions/pinctrl-owl.c              |  571 +++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  178 ++
 drivers/pinctrl/actions/pinctrl-s900.c             | 2505 ++++++++++++++++++++
 16 files changed, 4013 insertions(+)
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
