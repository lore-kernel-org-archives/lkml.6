Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeERCcM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:32:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38347 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeERCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:32:10 -0400
X-Google-Smtp-Source: AB8JxZrBNLRLE2ejyFCE3hPCWKaYwUnVQLb80WZO19ynL9Q865TT8/fArKshvz/vO3di3k5rWrTgpA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add gpio support for Action Semi S900 SoC
Date: Fri, 18 May 2018 08:00:51 +0530
Message-Id: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (5):
  dt-bindings: pinctrl: Add gpio bindings for Actions S900 SoC
  arm64: dts: actions: Add gpio properties to pinctrl node for S900
  arm64: dts: actions: Add gpio line names to Bubblegum-96 board
  pinctrl: actions: Add gpio support for Actions S900 SoC
  MAINTAINERS: Add Actions Semi S900 pinctrl entries

 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  13 ++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  | 175 +++++++++++++++++
 arch/arm64/boot/dts/actions/s900.dtsi              |   2 +
 drivers/pinctrl/actions/Kconfig                    |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c              | 206 +++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  20 ++
 drivers/pinctrl/actions/pinctrl-s900.c             |  29 ++-
 8 files changed, 447 insertions(+), 1 deletion(-)

-- 
2.14.1
