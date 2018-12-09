Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767FDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5D020831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FzxVOKBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5D020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLIKVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 05:21:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56346 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 05:21:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB9ALY9q072732;
        Sun, 9 Dec 2018 04:21:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544350894;
        bh=U5x789AI3gPB1tD5QQJXPkPEU7/J4WYh30fY52yr3kI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FzxVOKBGqXjQrevA61qqrVqearFVu8qsZGZQA0OYINtzLmp/VJByhWWkj6WLOHUMK
         SYlB+6Uo3iX7CGFLngGkvlmJ+XTeyrx5RQJ+slaOvU7sswudL2xYntRmeUVRMz7bBK
         mDQCpTwb2z6tMJMCv4cghFJTfmAsrgjeTZa0eBDM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB9ALYvt043697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Dec 2018 04:21:34 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 9
 Dec 2018 04:21:34 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 9 Dec 2018 04:21:34 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB9ALQ8M007865;
        Sun, 9 Dec 2018 04:21:32 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am654: Enable main domain McSPI0
Date:   Sun, 9 Dec 2018 15:52:22 +0530
Message-ID: <20181209102222.7624-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209102222.7624-1-vigneshr@ti.com>
References: <20181209102222.7624-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable McSPI0 of main domain and add DT node for the SPI NOR flash
connected to CS0.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 49ec2c3f5ef1..e41fc3a5987b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -60,6 +60,15 @@
 			AM65X_IOPAD(0x0070, PIN_INPUT, 5) /* (R25) GPMC0_CSn2.I2C2_SDA */
 		>;
 	};
+
+	main_spi0_pins_default: main-spi0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01c4, PIN_INPUT, 0) /* (AH13) SPI0_CLK */
+			AM65X_IOPAD(0x01c8, PIN_INPUT, 0) /* (AE13) SPI0_D0 */
+			AM65X_IOPAD(0x01cc, PIN_INPUT, 0) /* (AD13) SPI0_D1 */
+			AM65X_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (AG13) SPI0_CS0 */
+		>;
+	};
 };
 
 &main_pmx1 {
@@ -136,3 +145,21 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ecap0_pins_default>;
 };
+
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins_default>;
+	#address-cells = <1>;
+	#size-cells= <0>;
+	ti,pindir-d0-out-d1-in = <1>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		spi-max-frequency = <48000000>;
+		#address-cells = <1>;
+		#size-cells= <1>;
+	};
+};
-- 
2.19.2

