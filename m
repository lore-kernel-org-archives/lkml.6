Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeFEGQ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:16:58 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:32095 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFEGQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:55 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 7/8] drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3
Date: Tue, 5 Jun 2018 01:16:28 -0500
Message-ID: <20180605061629.4759-8-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti-msgmr driver can support K3 platforms as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 725dce5ba62d..f87a857d21a5 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -99,12 +99,12 @@ config STI_MBOX
 
 config TI_MESSAGE_MANAGER
 	tristate "Texas Instruments Message Manager Driver"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || ARCH_K3
 	help
 	  An implementation of Message Manager slave driver for Keystone
-	  architecture SoCs from Texas Instruments. Message Manager is a
-	  communication entity found on few of Texas Instrument's keystone
-	  architecture SoCs. These may be used for communication between
+	  and K3 architecture SoCs from Texas Instruments. Message Manager
+	  is a communication entity found on few of Texas Instrument's keystone
+	  and K3 architecture SoCs. These may be used for communication between
 	  multiple processors within the SoC. Select this driver if your
 	  platform has support for the hardware block.
 
-- 
2.15.1
