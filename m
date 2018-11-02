Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A338EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD9820831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD9820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeKCEc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCEcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JNpZm078001;
        Fri, 2 Nov 2018 14:23:51 -0500
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JNpTh045127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:23:51 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:23:50 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:23:50 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfvW000522;
        Fri, 2 Nov 2018 14:23:48 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 2/6] dt-bindings: phy: phy-of-simple: Document new binding
Date:   Sat, 3 Nov 2018 00:56:12 +0530
Message-ID: <20181102192616.28291-3-faiz_abbas@ti.com>
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

Add documentation for the generic simple phy implementation.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/phy/phy-of-simple.txt | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-of-simple.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-of-simple.txt b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
new file mode 100644
index 000000000000..696f2763395c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
@@ -0,0 +1,29 @@
+Generic simple phy device tree binding
+--------------------------------------
+
+A good number of phy implementations merely read dts properties,
+enable clocks, regulators or do resets without having a dedicated register
+map. This binding implements a generic phy driver which can be used for
+such simple implementations and avoid boilerplate code duplication.
+
+Required Properties:
+-  compatible	: must be "simple-phy"
+-  phy-cells    : must be 0
+
+Optional Properties:
+-  bus-width	: generic bus-width. Must be positive.
+-  max-bitrate	: generic max-bitrate. Must be positive.
+-  pwr		: phandle to phy pwr regulator node.
+
+Example:
+
+The following example is a can transceiver implemented as a generic phy.
+It has a max-bitrate property and a pwr regulator.
+
+
+transceiver1: can-transceiver {
+	compatible = "simple-phy";
+	max-bitrate = <5000000>;
+	pwr-supply = <&transceiver1_fixed>;
+	#phy-cells = <0>;
+};
-- 
2.18.0

