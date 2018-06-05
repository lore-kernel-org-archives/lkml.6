Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeFEGRl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:17:41 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37250 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFEGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:48 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 0/8] mailbox: ti-msgmgr: Add support for AM654 Secure Proxy
Date: Tue, 5 Jun 2018 01:16:21 -0500
Message-ID: <20180605061629.4759-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series enables support for Secure Proxy in newest addition in TI's SoC
portfolio - AM654 SoC.

The series is an RFC based off next-20180604 and will post formally once
v4.18-rc1 is available.

The DT and ARCH part of the series is based on https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2

The series (part 2 of 4) is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/next-20180604/k3-2-am6-sproxy

Full Boot log is available here: https://pastebin.ubuntu.com/p/vWCzMKtBCW/

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Nishanth Menon (8):
  mailbox: ti-msgmgr: Get rid of unused structure members
  mailbox: ti-msgmgr: Allocate Rx channel resources only on request
  mailbox: ti-msgmgr: Change message count mask to be descriptor based
  mailbox: ti-msgmgr: Move the memory region name to descriptor
  dt-bindings: mailbox: ti,message-manager: Add support for secure proxy
    threads
  mailbox: ti-msgmgr: Add support for Secure Proxy
  drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3
  arm64: dts: ti: k3-am6: Add Secure Proxy instance

 .../bindings/mailbox/ti,message-manager.txt        |  58 +++-
 arch/arm64/boot/dts/ti/k3-am6.dtsi                 |  11 +
 drivers/mailbox/Kconfig                            |   8 +-
 drivers/mailbox/ti-msgmgr.c                        | 353 +++++++++++++++++----
 4 files changed, 351 insertions(+), 79 deletions(-)

-- 
2.15.1
