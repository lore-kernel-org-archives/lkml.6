Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeFEG07 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:26:59 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16492 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeFEG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:26:56 -0400
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/3] firmware: Add K3 Support for TISCI driver
Date: Tue, 5 Jun 2018 01:26:37 -0500
Message-ID: <20180605062640.3356-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series enables TI System Control Interface(TISCI) support for
the newest addition in TI's SoC portfolio - AM654 SoC.

The series is an RFC based off next-20180604 and will post formally once
v4.18-rc1 is available.

The series (part 4 of 4) is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/next-20180604/k3-4-am6-tisci

Full Boot log is available here: https://pastebin.ubuntu.com/p/vWCzMKtBCW/

The Linux development follows closely the 66AK2G SoC model in aarch64 with a
few additions to handle the flexibility of firmware.

The architecture and dts support depends on part 1 of the series:
https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Nishanth Menon (3):
  Documentation: dt: keystone: ti-sci: Add optional host-id parameter
  firmware: ti_sci: Provide host-id as an optional dt parameter
  arm64: dts: ti: k3-am6: Add Device Management Security Controller
    support

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 +++
 arch/arm64/boot/dts/ti/k3-am6.dtsi                 | 32 ++++++++++++++++++++++
 drivers/firmware/ti_sci.c                          | 24 +++++++++++++---
 3 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.15.1
