Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbeCEOuC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:50:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932106AbeCEOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:49:53 -0500
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 1/8] dt-bindings: scsi: hisi_sas: add an property of signal attenuation
Date: Mon, 5 Mar 2018 22:48:43 +0800
Message-ID: <1520261330-204596-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520261330-204596-1-git-send-email-john.garry@huawei.com>
References: <1520261330-204596-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

For some new boards with hip07 chipset we are required to
set PHY config registers differently. The hw property which
determines how to set these registers is in the PHY signal
attenuation readings.

This patch add an devicetree property, "hisilicon,signal-attenuation",
which is used to describe the signal attenuation of an board.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 Documentation/devicetree/bindings/scsi/hisilicon-sas.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
index df3bef7..8c6659e 100644
--- a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
+++ b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
@@ -53,6 +53,13 @@ Main node required properties:
 Optional main node properties:
  - hip06-sas-v2-quirk-amt : when set, indicates that the v2 controller has the
 			    "am-max-transmissions" limitation.
+ - hisilicon,signal-attenuation : array of 3 32-bit values, containing de-emphasis,
+		preshoot, and boost attenuation readings for the board. They
+		are used to describe the signal attenuation of the board. These
+		values' range is 7600 to 12400, and used to represent -24dB to
+		24dB.
+		The formula is "y = (x-10000)/10000". For example, 10478
+		means 4.78dB.
 
 Example:
 	sas0: sas@c1000000 {
-- 
1.9.1
