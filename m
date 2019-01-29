Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F1EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3749A20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMLbavHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfA2LfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:35:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfA2LfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:35:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so17304069wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vJnKrcfM/+d9v4u5OjjWenwaWoG5s67rgvvgtB7HnPo=;
        b=AMLbavHhWoi6TWDvhbqvNZYHidPLMTf8rCfWS2eoDhSByogT6TK3QbVJEl8EQ61R8P
         bKeeHTnZYfvAEbqucIc9d3KdfeoHHcxGAY4vxSPDkkGO0CMcU08GcYKpBtu66mW/o7XD
         CjcWDxk3mgzmwFfhcTzoWckakzejfTuXOyo7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vJnKrcfM/+d9v4u5OjjWenwaWoG5s67rgvvgtB7HnPo=;
        b=JqxsFPF52URLiieQhJLQ7Z2hv3ZKdFSOkaxPBv2egR4juUMxJBPpUnFmh9NVvqv7m8
         H6BBmwIVob02OYzhMLEiWwahxD53Nhq64SW3277kwAdMu5HQe4wiLm7a6qghxBLYwYSh
         ERspdJCgKV/JorE4JE5wBaZjLCU2wraYDx9yPaQznvTcNqPnIsvdHo4yVSy7t0V7Fvw9
         9xXcPTO/hVP+RZvEtTpN5M95VGB8ZSwVE5t6I+IPshhvGxvyHUQMWBJ8g08G4Ry0QCU8
         ZHHpU8FRQLWbiaafHGP3cdejp59dHKsSk8l35dfosvR+S4apyTH8Ih5kKzAORTxXadpH
         f9yQ==
X-Gm-Message-State: AJcUukcHFY+x+RZ+GFZArfcnv4kkTSnNYlr+51JZVpxJ5sb2fQutdQJZ
        1Nsqsi9hRrlnN5rCWhCRUhxENA==
X-Google-Smtp-Source: ALg8bN5gPUfareuVF/+xOPS2D1Dc/OcgeVwYJG0RopNBAzp444G93viziKhe7kZlRodp5BFMnUKTrA==
X-Received: by 2002:a1c:b10a:: with SMTP id a10mr20438892wmf.148.1548761720574;
        Tue, 29 Jan 2019 03:35:20 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id i192sm1960129wmg.7.2019.01.29.03.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 03:35:20 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
        andy.gross@linaro.org, swboyd@chromium.org
Cc:     shawn.guo@linaro.org, vkoul@kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY bindings
Date:   Tue, 29 Jan 2019 12:35:14 +0100
Message-Id: <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
controller embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt

diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
new file mode 100644
index 0000000..8ef6e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
@@ -0,0 +1,73 @@
+Qualcomm Synopsys 1.0.0 SS phy controller
+===========================================
+
+Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
+chipsets
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,usb-ssphy".
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
+
+Optional child nodes:
+
+- vbus-supply:
+    Value type: <phandle>
+    Definition: phandle to the VBUS supply node.
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". PHY reset specifiers
+		 for phy core and COR resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		 property. Must contain "com" and "phy".
+
+Example:
+
+usb3_phy: phy@78000 {
+	compatible = "qcom,usb-ssphy";
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
+	vbus-supply = <&usb3_vbus_reg>;
+};
-- 
2.7.4

