Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeAaHmw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:42:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62891 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752909AbeAaHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:42:51 -0500
X-UUID: 635dfe6a135249a0b9e4494c18fbec8d-20180131
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 0/5] add MFD support for MediaTek audio subsystem
Date: Wed, 31 Jan 2018 15:42:40 +0800
Message-ID: <cover.1515639336.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 2nd version of the patch sets which modify clock driver to adapt
audio subsystem.  I still keeping 'simple-mfd' in the binding for discussion.
Rob, let me know if there is any problem with this.

changes since v2:
 - Drop useless changes in clk-mt7622-aud.c.
 - Revise binding text: 
	- Add more information about audio subsystem.
	- Separate clock node and AFE node.
 - Update license header.
changes since v1:
 - To avoid writing an MFD driver, we add "simple-mfd" in the audsys binding.
 - Move three top clocks to audio driver [1] as we remove mfd/mtk-audsys.c in v1.

Ryder Lee (5):
  clk: mediatek: update missing clock data for MT7622 audsys
  clk: mediatek: modify MT7622 audsys to adapt MFD device
  clk: mediatek: add audsys support for MT2701
  dt-bindings: clock: mediatek: update audsys documentation to adapt MFD
    device
  arm: dts: mediatek: add audio-subsystem node for both MT2701 and
    MT7623

 .../bindings/arm/mediatek/mediatek,audsys.txt      |  37 +++-
 arch/arm/boot/dts/mt2701.dtsi                      | 192 ++++++++++----------
 arch/arm/boot/dts/mt7623.dtsi                      | 193 ++++++++++-----------
 drivers/clk/mediatek/Kconfig                       |   6 +
 drivers/clk/mediatek/Makefile                      |   1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              | 175 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |   4 +-
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 8 files changed, 406 insertions(+), 205 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c

-- 
1.9.1
