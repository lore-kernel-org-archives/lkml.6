Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCVC7C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:59:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31217 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751667AbeCVC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:58:55 -0400
X-UUID: 4c3d69ae6d114c1ab5ba959f05104bc6-20180322
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
Subject: [PATCH v4 0/5] PINCTRL: Mediatek pinctrl driver for mt2712 
Date: Thu, 22 Mar 2018 10:58:38 +0800
Message-ID: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes five patches:
1.Add mt2712 pintcrl head file.
2.Add mt2712 pinctrl device node.
3.Add mt2712 pinctrl driver.
4.Support bias-disable of generic and special pins simultaneously.
5.fix check warnings.

Changes in patch v4:
1)fix check warnings for mt2712.
2)add fix check warnings patch for other ICs.

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


Zhiyong Tao (5):
  arm64: dts: mt2712: add pintcrl file
  arm64: dts: mt2712: add pintcrl device node.
  pinctrl: add mt2712 pinctrl driver
  pintcrl: support bias-disable of generic and special pins
    simultaneously
  pinctrl: fix check warnings.

 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 1123 ++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   18 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  634 +++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    8 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h |  840 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1757 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h |  123 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8127.h |  429 ++----
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h |  609 +++------
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h |  405 ++----
 12 files changed, 4348 insertions(+), 1606 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h

--
2.6.4
