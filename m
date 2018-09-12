Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF26C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742412087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P3t8s8oK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dkFvgtXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742412087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeILXMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:12:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeILXMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:12:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7DBFC60B19; Wed, 12 Sep 2018 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536775617;
        bh=mk5/SkzvCw05op/4eL4O6Aolvs7yRuz2Hp0NBQpMBpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3t8s8oKlpzlPhriN3Oh6/F+xhmlYc4OrftjoE+OphvoG2gTR3n5/TmwkluqvTqZx
         AFA3qrIe4hF4+dGvJrUjM0+09Rnu6X4Xw+iu2zg0dmDHN7aPAF8tc2BJG1FjQ1IHd9
         je42pGXzHTw0dON8Akyct5KxfkLY4rHLgj0BF9X0=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6377609FD;
        Wed, 12 Sep 2018 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536775612;
        bh=mk5/SkzvCw05op/4eL4O6Aolvs7yRuz2Hp0NBQpMBpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkFvgtXN//M8Lm4NTlbwsTT2Vdu99HgITBswqvHzyhnRZTL7YnM94SxlwkEa0H25d
         2jZGdQkwaOsFyXL3sCBNY56muyK4ENu1JSFOd4z0XlCx0OcYDCJeF/GU1jR++ei0T0
         a82i4lnvJPRMsOC0DoP3Jvz6NW6Rh0l7d/FFXd7c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6377609FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v6 4/4] dt-bindings: msm: Update documentation of qcom,llcc
Date:   Wed, 12 Sep 2018 11:06:35 -0700
Message-Id: <1536775595-11192-5-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536775595-11192-1-git-send-email-vnkgutta@codeaurora.org>
References: <1536775595-11192-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reg-names and interrupts for LLCC documentation and the usage
examples. llcc broadcast base is added in addition to llcc base,
which is used for llcc broadcast writes.

Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/msm/qcom,llcc.txt         | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
index 5e85749..eaee06b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -16,11 +16,26 @@ Properties:
 - reg:
 	Usage: required
 	Value Type: <prop-encoded-array>
-	Definition: Start address and the the size of the register region.
+	Definition: The first element specifies the llcc base start address and
+		    the size of the register region. The second element specifies
+		    the llcc broadcast base address and size of the register region.
+
+- reg-names:
+        Usage: required
+        Value Type: <stringlist>
+        Definition: Register region names. Must be "llcc_base", "llcc_broadcast_base".
+
+- interrupts:
+	Usage: required
+	Definition: The interrupt is associated with the llcc edac device.
+			It's used for llcc cache single and double bit error detection
+			and reporting.
 
 Example:
 
 	cache-controller@1100000 {
 		compatible = "qcom,sdm845-llcc";
-		reg = <0x1100000 0x250000>;
+		reg = <0x1100000 0x200000>, <0x1300000 0x50000> ;
+		reg-names = "llcc_base", "llcc_broadcast_base";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

