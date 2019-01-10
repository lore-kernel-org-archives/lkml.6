Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297AC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C8E2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rJG/mhqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfAJHbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:31:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45190 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfAJHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:31:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0A7V9t6055740;
        Thu, 10 Jan 2019 01:31:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547105469;
        bh=Pto7u8VyH65yuawcDIwQsHHQvfclzmSaSD4XFNE462M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rJG/mhqD5xVtUWMGzP6BdF1TjEBh+gs5jFzuuGVSVoQW0536WyO3kMqYQnY5vtVmp
         fNKk8Xs7feMckM9G5sENPAN6ds7CYeSy/knDrYIJJ01DwQDclSXy+cswWHnZt+D/qV
         uAyhkiBB/ASQhtWa9JkveOc8ikMAdXe2nTzKeSEc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0A7V9rs008468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 01:31:09 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 01:31:09 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 01:31:09 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0A7V38i020221;
        Thu, 10 Jan 2019 01:31:06 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
Date:   Thu, 10 Jan 2019 13:03:54 +0530
Message-ID: <20190110073355.3382-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190110073355.3382-1-faiz_abbas@ti.com>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Secure Digital Host Controller Interface (SDHCI)
present on TI's AM654 SOCs. It is compatible with eMMC5.1 Host
Specifications and SDHC Standard Specification 4.10.

Enable only upto HS200 speed mode.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 272cf8fc8d30..78e1bb56adee 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -191,4 +191,17 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	sdhci0: sdhci@4f80000 {
+		compatible = "ti,am654-sdhci-5.1";
+		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
+		power-domains = <&k3_pds 47>;
+		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
+		clock-names = "clk_ahb", "clk_xin";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+	};
 };
-- 
2.19.2

