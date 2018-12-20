Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F63C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7C82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE6BEwFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeLTBCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:02:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46905 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbeLTBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:02:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so9879pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x5i7/5XJL064OccNs2o8bb+FMlNTe/XBc/lkskb4qJo=;
        b=ZE6BEwFJNzKzy0QftiWinKLCCeAAwjbODMVzIBCaoR0sq1+cT5YzLPxTcVamZyxC3x
         sGe8Ao8A5lM9zg0bUXLxas8Wqb9BfTmLn3UZ4jXVp64k6X/EsoETdS81mKGJ5Mbv6hhX
         QwuMOmSjZum7XgIVABXw3teFjA39cnpszRUIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x5i7/5XJL064OccNs2o8bb+FMlNTe/XBc/lkskb4qJo=;
        b=dcPgBDqpmZ1+8OXtHJ3Es31wHp6jPoBakKzPZJM55pvfDXa5Gv6jj4DEMztYj3USNm
         ++Ou+4xKlOypVXDWeKsbTocEXGkWufsiu9TZl7oE92tou/s+RVel2RsR+HFJ0VRaoJsk
         HHxBCrJ5f9sHBYrDkLiVHH7eeLo1ArsZT1HPy9KgRgaFaZNoY6G2BRFpvumMpubgOQTG
         QAAwMxW+ICSXyv8ObgPrWh6iwZZICvszlo+RHgdhGlHq/JPUd/3TMzWWzW0eVItH8DBS
         ErwGuSib7uBVJOl8Su9JiWiJuMo+GgaQ6of0bjUg5bIUG99e+UpDX3i8n1q/x96bki3o
         iY3Q==
X-Gm-Message-State: AA+aEWYD64e/DxnFyuaszKpq8M+e7YnfXdUmt6I5eKxLnH5DdIdrYdZw
        KBO9BlmU2rk8n+aqWNJ3s8JTyg==
X-Google-Smtp-Source: AFSGD/WpvQFFNbj83n2PNngT90t09hB7EthY0uwD+TLzHT5xtLY17d5ga7DcMCnGsiEaclIEhrSn9A==
X-Received: by 2002:a63:4c04:: with SMTP id z4mr21706775pga.312.1545267756891;
        Wed, 19 Dec 2018 17:02:36 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id e16sm25334392pfn.46.2018.12.19.17.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 17:02:35 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed USB PHY binding
Date:   Thu, 20 Dec 2018 09:01:11 +0800
Message-Id: <20181220010112.16824-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181220010112.16824-1-shawn.guo@linaro.org>
References: <20181220010112.16824-1-shawn.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriharsha Allenki <sallenki@codeaurora.org>

It adds bindings for Synopsys 28nm femto phy controller that supports
LS/FS/HS usb connectivity on Qualcomm chipsets.

Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
new file mode 100644
index 000000000000..301987e716fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
@@ -0,0 +1,87 @@
+Qualcomm Synopsys 28nm Femto phy controller
+===========================================
+
+Synopsys 28nm femto phy controller supports LS/FS/HS usb connectivity on
+Qualcomm chipsets.
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,qcs404-usb-hsphy".
+
+- reg:
+    Value type: <prop-encoded-array>
+    Definition: USB PHY base address and length of the register map.
+
+- #phy-cells:
+    Value type: <u32>
+    Definition: Should be 0. See phy/phy-bindings.txt for details.
+
+- clocks:
+    Value type: <prop-encoded-array>
+    Definition: See clock-bindings.txt section "consumers". List of
+		three clock specifiers for reference, phy core and
+		sleep clocks.
+
+- clock-names:
+    Value type: <string>
+    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
+		property. Must contain "ref", "phy" and "sleep".
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". PHY reset specifiers
+		for phy core and POR resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		property. Must contain "phy" and "por".
+
+- vdd-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VDD supply node.
+
+- vdda1p8-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 1.8V supply node.
+
+- vdda3p3-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 3.3V supply node.
+
+- qcom,vdd-voltage-level:
+    Value type: <prop-array>
+    Definition: This is a list of three integer values <no min max> where
+		each value corresponding to voltage corner in uV.
+
+Optional child nodes:
+
+- The link to the USB connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt.
+
+Example:
+
+	phy@7a000 {
+		compatible = "qcom,qcs404-usb-hsphy";
+		reg = <0x7a000 0x200>;
+		#phy-cells = <0>;
+		clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+			 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+			 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+		clock-names = "ref", "phy", "sleep";
+		resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+			 <&gcc GCC_USB2A_PHY_BCR>;
+		reset-names = "phy", "por";
+		vdd-supply = <&vreg_l4_1p2>;
+		vdda1p8-supply = <&vreg_l5_1p8>;
+		vdda3p3-supply = <&vreg_l12_3p3>;
+		qcom,vdd-voltage-level = <0 1144000 1200000>;
+
+		port {
+			ep_usb_phy: endpoint {
+				remote-endpoint = <&ep_usb_con>;
+			};
+		};
+	};
-- 
2.18.0

