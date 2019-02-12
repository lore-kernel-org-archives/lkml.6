Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099E9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7421773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ezdbI0Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfBLMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:21:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56110 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbfBLMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:21:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1CCLqnm101394;
        Tue, 12 Feb 2019 06:21:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549974112;
        bh=hQcrJdKbsfwEGzYeAgFNCTXEdwgnwLpObbaZw7QqInA=;
        h=From:To:CC:Subject:Date;
        b=ezdbI0VnkRtx2lzbzXmyL4TD4xH1fk8rpdz8mS4XXfu0CV4LXPL1XNOTbO83t6rnd
         zZw0Hi/Re/J056y8UpMmxXXDa8DXpAyN8EaOANUSNCJN3FHgc5ONwPazvABXkrBmYd
         phqksB6QFBULbJgoi01pPSNLcl5X1JHk/2AIxBX8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1CCLqbb114319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 06:21:52 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 06:21:51 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 06:21:51 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1CCLnro015975;
        Tue, 12 Feb 2019 06:21:50 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65-mcu: Add ADC nodes
Date:   Tue, 12 Feb 2019 17:52:37 +0530
Message-ID: <20190212122237.10976-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI AM654 SoC has two ADC instances in the MCU domain. Add DT nodes for
the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
Tero,

Could you also pick up DT bindings here: https://patchwork.kernel.org/patch/10751429/
All the Acks are in place.

 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 30 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 12 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 593f718e8fb5..6f7d2b316ded 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -57,4 +57,34 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
+		reg = <0x0 0x40200000 0x0 0x1000>;
+		interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 0 2>;
+		assigned-clocks = <&k3_clks 0 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "adc_tsc_fck";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am654-adc", "ti,am3359-adc";
+		};
+	};
+
+	tscadc1: tscadc@40210000 {
+		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
+		reg = <0x0 0x40210000 0x0 0x1000>;
+		interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 1 2>;
+		assigned-clocks = <&k3_clks 1 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "adc_tsc_fck";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am654-adc", "ti,am3359-adc";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index e41fc3a5987b..fb6df5c8f85b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -163,3 +163,15 @@
 		#size-cells= <1>;
 	};
 };
+
+&tscadc0 {
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&tscadc1 {
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
-- 
2.20.1

