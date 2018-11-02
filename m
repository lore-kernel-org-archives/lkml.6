Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3639FC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E00F20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E00F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeKCEcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54066 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeKCEca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JO08X078029;
        Fri, 2 Nov 2018 14:24:00 -0500
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JO0E4127883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:24:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:24:00 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:24:00 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfvZ000522;
        Fri, 2 Nov 2018 14:23:57 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 5/6] dt-bindings: can: can-transceiver: Remove legacy binding documentation
Date:   Sat, 3 Nov 2018 00:56:15 +0530
Message-ID: <20181102192616.28291-6-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the transceiver node being implemented as a phy, remove the legacy
dcoumentation. Don't remove the code implementing it to maintain dt
compatibility.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../bindings/net/can/can-transceiver.txt      | 24 -------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt

diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.txt b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
deleted file mode 100644
index 0011f53ff159..000000000000
--- a/Documentation/devicetree/bindings/net/can/can-transceiver.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Generic CAN transceiver Device Tree binding
-------------------------------
-
-CAN transceiver typically limits the max speed in standard CAN and CAN FD
-modes. Typically these limitations are static and the transceivers themselves
-provide no way to detect this limitation at runtime. For this situation,
-the "can-transceiver" node can be used.
-
-Required Properties:
- max-bitrate:	a positive non 0 value that determines the max
-		speed that CAN/CAN-FD can run. Any other value
-		will be ignored.
-
-Examples:
-
-Based on Texas Instrument's TCAN1042HGV CAN Transceiver
-
-m_can0 {
-	....
-	can-transceiver {
-		max-bitrate = <5000000>;
-	};
-	...
-};
-- 
2.18.0

