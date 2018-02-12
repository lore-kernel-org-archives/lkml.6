Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934153AbeBLLbL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:31:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:64949 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934047AbeBLL3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:29:46 -0500
X-UUID: 43dc6e212d734bc89c00e4ae929f0b25-20180212
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 0/5] switch to MFD device for MediaTek audio subsystem
Date: Mon, 12 Feb 2018 19:28:46 +0800
Message-ID: <cover.1518424204.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series switches the clock driver to adapt the new MFD parent.
I still keep the previous version of the bindings (patch 4/5) for discussion.

Rob, let me know if there is any problem with this.

changes since v3:
 - Rebase to v4.16.
 - Modify clock driver for the sake of the backward compatibility.
 - Rewrite commit message of patch 4/5 to make it more specific.

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
 drivers/clk/mediatek/clk-mt2701-aud.c              | 179 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |   8 +-
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 8 files changed, 414 insertions(+), 205 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c

-- 
1.9.1
