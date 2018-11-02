Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B2C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D7220831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W3GSQCd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D7220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeKCEca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54064 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeKCEc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JNvDx078018;
        Fri, 2 Nov 2018 14:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541186637;
        bh=7rqeRlMU/MryScBAG/F9EVyizjBgZJ6+Y03xj5k0G6g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W3GSQCd1EaNCmslfZ9lBuDRWEiySuQz/n8XAJNKkgLPyoV2w55tW6YNcKlMv6ySIh
         o3L0OIj+C4SN7BOdRUtOOps0s4jWdDJj2MS2WTEwcIlR2XGvf671jnw/lYx6vxXrNZ
         1YR3xKLBobbYaUJnsUMsDv9KS48taH0G6+gZ5V1I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JNvXh117580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:23:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:23:56 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:23:57 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfvY000522;
        Fri, 2 Nov 2018 14:23:54 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 4/6] dt-bindings: can: m_can: Document transceiver implementation as a phy
Date:   Sat, 3 Nov 2018 00:56:14 +0530
Message-ID: <20181102192616.28291-5-faiz_abbas@ti.com>
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

Some transceivers need a configuration step (for example, pulling
a standby line low) for them to start sending messages. Instead of a
parent child relationship, the transceiver can be implemented as a
phy with the configuration done in the phy driver. The bitrate
limitations can then be obtained by the driver using said phy
node.

Document the above implementation.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/net/can/m_can.txt     | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
index ed614383af9c..c11548e74278 100644
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ b/Documentation/devicetree/bindings/net/can/m_can.txt
@@ -42,12 +42,14 @@ Required properties:
 
 			  Please refer to 2.4.1 Message RAM Configuration in
 			  Bosch M_CAN user manual for details.
+Optional properties:
+- phy-names		: must be "can_transceiver". The transceiver
+			  typically limits the maximum bitrate of the
+			  system. The phy node is used to discover this
+			  limitation.
+- phys			: phandle to the transceiver implemented as a phy
+			  node.
 
-Optional Subnode:
-- can-transceiver	: Can-transceiver subnode describing maximum speed
-			  that can be used for CAN/CAN-FD modes. See
-			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
-			  for details.
 Example:
 SoC dtsi:
 m_can1: can@20e8000 {
@@ -64,12 +66,18 @@ m_can1: can@20e8000 {
 };
 
 Board dts:
+
 &m_can1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_m_can1>;
 	status = "enabled";
+	phy-names = "can_transceiver";
+	phys = <&transceiver1>;
+};
 
-	can-transceiver {
-		max-bitrate = <5000000>;
-	};
+transceiver1: can-transceiver {
+	compatible = "simple-phy";
+	max-bitrate = <5000000>;
+	pwr-supply = <&transceiver1_fixed>;
+	#phy-cells = <0>;
 };
-- 
2.18.0

