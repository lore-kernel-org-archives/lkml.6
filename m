Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbeCELf4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:35:56 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59995 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933518AbeCELfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:35:54 -0500
X-UUID: b762b93e092845adb4f1c929054c6beb-20180305
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <hongkun.cao@mediatek.com>,
        <biao.huang@mediatek.com>, <yt.shen@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <erin.lo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 0/4] PINCTRL: Mediatek pinctrl driver for mt2712 
Date: Mon, 5 Mar 2018 19:35:41 +0800
Message-ID: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes four patches:
1.Add mt2712 pintcrl head file.
2.Add mt2712 pinctrl device node.
3.Add mt2712 pinctrl driver.
4.Support bias-disable of generic and special pins simultaneously.

Changes in patch v3:
1)Use SPDX identifiers for all new files.
2)Use right data for Copyright and Author.
3)Correct some spelling mistake.
4)Reusing original logic and change solution to support bias-disable of generic and special pins simultaneously.
5)Add some comments for the speical path of special pins bias-disable.

Changes in patch v2:
1)Separate patch4 for supporting bias-disable of generic and special pins.
2)GPIO16~17 direction setting is changed as generic pins in mt2712 E2,
  So remove GPIO16~17 special direction setting and remove apmixedsys node in pinctrl device node.
3)Add pinmux define in "mt2712-pinfunc.h" and "pinctrl-mtk-mt2712.h" for mt2712 E2 design.

Zhiyong Tao (4):
  arm64: dts: mt2712: add pintcrl file
  arm64: dts: mt2712: add pintcrl device node.
  pinctrl: add mt2712 pinctrl driver
  pintcrl: support bias-disable of generic and special pins
    simultaneously

 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 1123 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   18 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  632 ++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    6 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1967 +++++++++++++++++++++++++
 7 files changed, 3754 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h

--
2.6.4 
