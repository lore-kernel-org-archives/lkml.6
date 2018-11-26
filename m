Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F90FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D995120868
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HCjQnNnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D995120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKZLIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:08:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52648 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKZLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FXb5098850;
        Sun, 25 Nov 2018 18:15:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543191333;
        bh=ulvx31p1DRQxy6U1DhK/TBV9tfMB95PHkVQjJb2fCaQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HCjQnNnnfRv7mSrB3S7XzAf0fsP6W9xVQL0HvoVCZDL1aersUMy+Hcv2CbDL7AMnG
         jxpO86zJHIY0+QOIJ2HF9TAGM0VuJ4hCW4kJLMh96wz94I2s8RLmcsudRaguZmDKcG
         3SHBjXX2Yy+2igVOyw4BxVH8C/AXpwKNdClhS2IU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FXMC101826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:33 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FWgV005235;
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FWU04338;
        Sun, 25 Nov 2018 18:15:32 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 01/10] dt-bindings: phy: add cpsw port interface mode selection phy bindings
Date:   Sun, 25 Nov 2018 18:15:22 -0600
Message-ID: <20181126001531.12974-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPSW Port's Interface Mode Selection PHY (phy-gmii-sel) DT Bindings

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt

diff --git a/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
new file mode 100644
index 0000000..50ce9ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
@@ -0,0 +1,68 @@
+CPSW Port's Interface Mode Selection PHY Tree Bindings
+-----------------------------------------------
+
+TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports
+two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
+The interface mode is selected by configuring the MII mode selection register(s)
+(GMII_SEL) in the System Control Module chapter (SCM). GMII_SEL register(s) and
+bit fields placement in SCM are different between SoCs while fields meaning
+is the same.
+                                               +--------------+
+        +-------------------------------+      |SCM           |
+        |                     CPSW      |      |  +---------+ |
+        |        +--------------------------------+gmii_sel | |
+        |        |                      |      |  +---------+ |
+        |   +----v---+     +--------+   |      +--------------+
+        |   |Port 1..<--+-->GMII/MII<------->
+        |   |        |  |  |        |   |
+        |   +--------+  |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RMII   <------->
+        |               +-->        |   |
+        |               |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RGMII  <------->
+        |               +-->        |   |
+        |                  +--------+   |
+        +-------------------------------+
+
+CPSW Port's Interface Mode Selection PHY describes MII interface mode between
+CPSW Port and Ethernet PHY which depends on Eth PHY and board configuration.
+
+CPSW Port's Interface Mode Selection PHY device should defined as child device
+of SCM node (scm_conf) and can be attached to each CPSW port node using standard
+PHY bindings (See phy/phy-bindings.txt).
+
+Required properties:
+- compatible		: Should be "ti,am3352-phy-gmii-sel" for am335x platform
+			  "ti,dra7xx-phy-gmii-sel" for dra7xx/am57xx platform
+			  "ti,am43xx-phy-gmii-sel" for am43xx platform
+			  "ti,dm814-phy-gmii-sel" for dm814x platform
+- reg			: Address and length of the register set for the device
+- #phy-cells		: must be 2.
+			  cell 1 - CPSW port number (starting from 1)
+			  cell 2 - RMII refclk mode
+
+Examples:
+	phy_gmii_sel: phy-gmii-sel {
+		compatible = "ti,am3352-phy-gmii-sel";
+		reg = <0x650 0x4>;
+		#phy-cells = <2>;
+	};
+
+	mac: ethernet@4a100000 {
+		compatible = "ti,am335x-cpsw","ti,cpsw";
+		...
+
+		cpsw_emac0: slave@4a100200 {
+			...
+			phys = <&phy_gmii_sel 1 1>;
+		};
+
+		cpsw_emac1: slave@4a100300 {
+			...
+			phys = <&phy_gmii_sel 2 1>;
+		};
+	};
-- 
2.10.5

