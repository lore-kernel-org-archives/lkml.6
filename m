Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeETFSp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 01:18:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35288 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeETFSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 01:18:43 -0400
X-Google-Smtp-Source: AB8JxZqSCMK1NMi7eqZVwl+WLJ2r5n2qYtIlwNE6jvo+qm1P/6OA2rcYzWNKecgu/21G3j+aBnH9mw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/5] Add gpio support for Action Semi S900 SoC
Date: Sun, 20 May 2018 10:47:31 +0530
Message-Id: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds gpio support for Actions Semi S900 SoC by extending
the pinctrl driver. There were previous patches submitted for adding a
standalone gpio driver based on gpiolib. But later on it has been realised
that the gpio functionality is closely tied with pinctrl subsystem for this
OWL family processors. So, having a separate gpio driver will make it hard
to add further functionalities in future. Hence, we decided to drop the
previous patches below adding a standalone gpio support:

dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
arm64: dts: actions: Add S900 gpio nodes
arm64: dts: actions: Add gpio line names to Bubblegum-96 board
gpio: Add gpio driver for Actions OWL S900 SoC
MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries

This patchset consits of incremental patches which will apply with the
previous pinctrl series: Add Actions Semi S900 pinctrl and gpio support,
excluding the dropped patches mentioned above.

Thanks,
Mani

Changes in v2:

* Removed gpiochip_add_pin_range() function and added gpio-ranges property
  in DT.
* Added Reviewed-by tag from Andy.

Manivannan Sadhasivam (5):
  dt-bindings: pinctrl: Add gpio bindings for Actions S900 SoC
  arm64: dts: actions: Add gpio properties to pinctrl node for S900
  arm64: dts: actions: Add gpio line names to Bubblegum-96 board
  pinctrl: actions: Add gpio support for Actions S900 SoC
  MAINTAINERS: Add Actions Semi S900 pinctrl entries

 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  16 ++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  | 175 ++++++++++++++++++
 arch/arm64/boot/dts/actions/s900.dtsi              |   3 +
 drivers/pinctrl/actions/Kconfig                    |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c              | 198 +++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  20 +++
 drivers/pinctrl/actions/pinctrl-s900.c             |  29 ++-
 8 files changed, 443 insertions(+), 1 deletion(-)

-- 
2.14.1
