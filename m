Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeEOIwm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:52:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752545AbeEOIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:52:37 -0400
X-UUID: 9cd52d29377442d8a8f52eaacb40a67d-20180515
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 0/7] add support for Bluetooth on MT7622 SoC
Date: Tue, 15 May 2018 16:52:15 +0800
Message-ID: <cover.1526374087.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v2 and changes since v1
 - Dropped patches already being applied
 - Rewirte the whole driver using btuart [1], and add slight extension
   of btuart to fit into btmtkuart driver. Beware that [1] is also pulled
   into one part of the series for avoiding any breakage when the patchset
   is being compiled.

[1] btuart 
	https://www.spinics.net/lists/linux-bluetooth/msg74918.html

v1:

Hi,

This patchset introduces built-in Bluetooth support on MT7622 SoC.
And, it should be simple to make an extension to support other
MediaTek SoCs with adjusting a few of changes on the initialization
sequence of the device.

Before the main driver is being introduced, a few of things about
power-domain management should be re-worked for serdev core and MediaTek
SCPSYS to allow the Bluetooth to properly power up.

Patch 2: add a generic way attaching power domain to serdev
Patch 3 and 4: add cleanups with reuse APIs from Linux core
Patch 5: fix a limitation about power enablement Bluetooth depends on
Patch 1, 6 and 7: the major part of adding Bluetooth support to MT7622
	
	Sean

Marcel Holtmann (1):
  Bluetooth: Add new serdev based driver for UART attached controllers

Sean Wang (6):
  dt-bindings: net: bluetooth: Add mediatek-bluetooth
  serdev: add dev_pm_domain_attach|detach()
  Bluetooth: Add new quirk for non-persistent setup settings
  Bluetooth: Extend btuart driver for join more vendor devices
  Bluetooth: mediatek: Add protocol support for MediaTek serial devices
  MAINTAINERS: add an entry for MediaTek Bluetooth driver

 .../devicetree/bindings/net/mediatek-bluetooth.txt |  35 ++
 MAINTAINERS                                        |   8 +
 drivers/bluetooth/Kconfig                          |  23 +
 drivers/bluetooth/Makefile                         |   3 +
 drivers/bluetooth/btmtkuart.c                      | 383 +++++++++++++++
 drivers/bluetooth/btmtkuart.h                      | 119 +++++
 drivers/bluetooth/btuart.c                         | 527 +++++++++++++++++++++
 drivers/bluetooth/btuart.h                         |  30 ++
 drivers/tty/serdev/core.c                          |  14 +-
 include/net/bluetooth/hci.h                        |   9 +
 net/bluetooth/hci_core.c                           |   3 +-
 11 files changed, 1152 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 create mode 100644 drivers/bluetooth/btmtkuart.c
 create mode 100644 drivers/bluetooth/btmtkuart.h
 create mode 100644 drivers/bluetooth/btuart.c
 create mode 100644 drivers/bluetooth/btuart.h

-- 
2.7.4
