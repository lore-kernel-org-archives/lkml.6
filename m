Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE15C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF192147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxCvqmZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBGLRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:17:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46306 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfBGLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:17:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so11039912wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnEuMYZYNfZTiAaCyfHqZT4lfGHr0o+uMykks6XX9xA=;
        b=bxCvqmZYTN7U9/njoi8RrudRZSox1QAoMxC0MiTwAetGy1HxGFuJBjmjPC3xWmR+fc
         9+sHOkP/Bjto6EnjqgE/rHZK3cqT3z10RMM+U/P/xO9F/bIJAHi4QUcQGLtqo2H4TIEe
         h7ar0Rw/K1QRa2FLHih/aMF78EIaOeMqr+6yGbmSg2AjqWGTPUfNH2i7CaLSMz48OvIA
         YHntYDfqNBjUSYxocx6c6rluSxb5jiZGAsU2snxSWiRyu32SV2FBIlf1xK4LcPHWd4gJ
         3rYXc2Cahcz5orrUaQsftIl/2THWOhoIqUujhKkk4hRu2FbGJrozhG66O63AOk6MafrL
         1HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnEuMYZYNfZTiAaCyfHqZT4lfGHr0o+uMykks6XX9xA=;
        b=Dg9msyqACui7ZDx984iWUTPZqcdHPUOuicqIxWLURvaQcrZ7UjPnsGBieZentDk2FY
         YPmUIyXr3lf8Sups5w49AIUH0xTmKava7Qg5u++ct7H74IgrLzYpDLLV5ra0QhrDIHIr
         pHeNrbcOYZqOVC4eRgKTRT6gtEagsjptpo+7e1aEWmuaQYMSMCBouhb6c0aZm3itJg9g
         Ht+gtslmEfnVik3w9FoxEhGqwX3tpgK9Jka4RzfiWtt0n65Rs8qdUiBzvhhvbR2Hgl4o
         011zzBQLuVtN7QKe4BJUsnaMYcF86uFJtwUMacTyqd9iGuSmmc208JUc5Ia02lzRN8KK
         97oA==
X-Gm-Message-State: AHQUAubM5M647wzPLuf9LMO0iPZ88vwu20WFu944A/VjsTZGzWX3e7VV
        t5+p0/fB1UOdVwEholYvYY1ltQ==
X-Google-Smtp-Source: AHgI3IaWxxcYF6UIB2/LiUF7CxbuUic76NgWtAcyZhILDHylwdcEkWIqvblkWwoFC0HdeoylqGpRog==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr11726200wrg.237.1549538264038;
        Thu, 07 Feb 2019 03:17:44 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.42])
        by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 03:17:43 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh@kernel.org,
        bjorn.andersson@linaro.org
Cc:     swboyd@chromium.org, andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
Date:   Thu,  7 Feb 2019 12:17:33 +0100
Message-Id: <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Qualcomm's Synopsys 1.0.0 SuperSpeed phy
controller embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/phy/qcom,snps-usb-ssphy.txt      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
new file mode 100644
index 000000000000..354e6f9cef62
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
@@ -0,0 +1,79 @@
+Qualcomm Synopsys 1.0.0 SS phy controller
+===========================================
+
+Qualcomm 1.0.0 SS phy controller supports SuperSpeed USB connectivity on
+some Qualcomm platforms.
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,snps-usb-ssphy".
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
+		 three clock specifiers for reference, phy core and
+		 pipe clocks.
+
+- clock-names:
+    Value type: <string>
+    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
+		 property. Must contain "ref", "phy" and "pipe".
+
+- vdd-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VDD supply node.
+
+- vdda1p8-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 1.8V supply node.
+
+Optional properties:
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". Specifiers for COM and
+		 PHY resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		 property. Must contain "com" and "phy" if the property is
+		 specified.
+
+Required child nodes:
+
+- usb connector node as defined in bindings/connector/usb-connector.txt
+  containing the property vbus-supply.
+
+Example:
+
+usb3_phy: usb3-phy@78000 {
+	compatible = "qcom,snps-usb-ssphy";
+	reg = <0x78000 0x400>;
+	#phy-cells = <0>;
+	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+	clock-names = "ref", "phy", "pipe";
+	resets = <&gcc GCC_USB3_PHY_BCR>,
+		 <&gcc GCC_USB3PHY_PHY_BCR>;
+	reset-names = "com", "phy";
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	usb3_c_connector: usb3-c-connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		type = "micro";
+		vbus-supply = <&usb3_vbus_reg>;
+	};
+};
-- 
2.20.1

