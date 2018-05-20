Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeETRDw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:03:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49037 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752256AbeETRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:21 -0400
X-UUID: ed18c507af3d490dacf0b57257a9b215-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/7] add external interrupt support to MT7622 pinctrl
Date: Mon, 21 May 2018 01:01:46 +0800
Message-ID: <cover.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The series is to add external interrupt support to MT7622 pinctrl.

Before we can freely do that in pinctrl-mt7622.c with patch 3, a refactor
work has to be done with patch 2 to split EINT-related code from a
specific driver and then allows pintrl-mt7622.c to reuse it.

patch 1, 3, 7: add EINT support to MT7622 pinctrl.
patch 2, 6: make EINT-related become a generic way for all MediaTek
	    pinctrl.
patch 4, 5: eliminate unnecessary code in existent EINT-related ones after
	    refactor work was done.

Sean Wang (7):
  dt-bindings: pinctrl: add external interrupt support to MT7622 pinctrl
  pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl
    can fit
  pinctrl: mediatek: add EINT support to MT7622 SoC
  pinctrl: mediatek: use generic EINT register maps for each SoC
  pinctrl: mediatek: remove unused fields in struct mtk_eint_hw
  MAINTAINERS: update entry for PIN CONTROLLER - MEDIATEK
  arm64: dts: mt7622: add EINT support to pinctrl

 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |  10 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   8 +-
 drivers/pinctrl/mediatek/Kconfig                   |   6 +
 drivers/pinctrl/mediatek/Makefile                  |   1 +
 drivers/pinctrl/mediatek/mtk-eint.c                | 492 +++++++++++++++++
 drivers/pinctrl/mediatek/mtk-eint.h                | 106 ++++
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          | 143 +++++
 drivers/pinctrl/mediatek/pinctrl-mt8127.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      | 608 ++++-----------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |  13 +-
 16 files changed, 901 insertions(+), 614 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.c
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.h

-- 
2.7.4
