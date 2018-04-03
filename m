Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeDCHQH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:16:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44099 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752991AbeDCHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:16:05 -0400
X-UUID: f9b22880a13a4092824583470fc38c09-20180403
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/7] add support for Bluetooth on MT7622 SoC
Date: Tue, 3 Apr 2018 15:15:50 +0800
Message-ID: <cover.1522736996.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TM-AS-Result: No-10.156600-8.000000-10
X-TMASE-MatchedRID: vLCRY9sB4eynIEz+LeVBUxWCVBr+Ay98T5++FIORChC48McbajxWsOrO
        SEJRBEaXAxc4cwJLvwnlEUN5eQRo4xOqqDV6Qdycl1zsjZ1/6ayE6lq+K7jth4aKwv8Fn/09Mq+
        en+OaNuuVbhRAPSasfZtT/sIk9yAYY/L30nD9T7iwr5ZZVOw5dUyQ5fRSh265NSweOixQAJJHdE
        c8dOyw1Vl+Hk3Iw2bEgDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/sjlfCqbK2HhV8rDL59PETnSiJ3
        mbMSg+F7wtS1smZ5LVE0XPkiVL1xg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.156600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

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

Sean Wang (7):
  dt-bindings: net: bluetooth: Add mediatek-bluetooth
  serdev: add dev_pm_domain_attach|detach()
  soc: mediatek: reuse read[l,x]_poll_timeout helpers
  soc: mediatek: reuse regmap_read_poll_timeout helpers
  soc: mediatek: add a fixed wait for SRAM stable
  Bluetooth: hci_mediatek: Add protocol support for MediaTek serial
    devices
  MAINTAINERS: add an entry for MediaTek Bluetooth driver

 .../devicetree/bindings/net/mediatek-bluetooth.txt |  35 ++
 MAINTAINERS                                        |   8 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_mediatek.c                   | 499 +++++++++++++++++++++
 drivers/bluetooth/hci_uart.h                       |   3 +-
 drivers/soc/mediatek/mtk-infracfg.c                |  45 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |  98 ++--
 drivers/tty/serdev/core.c                          |  14 +-
 9 files changed, 610 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_mediatek.c

-- 
2.7.4
