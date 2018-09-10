Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824BFC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A5720894
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lbafOHao";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A2x+G1Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A5720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeIKEnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:43:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeIKEnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:43:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6196D60B62; Mon, 10 Sep 2018 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536623236;
        bh=mk5/SkzvCw05op/4eL4O6Aolvs7yRuz2Hp0NBQpMBpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbafOHao+jUwwQeCZ/4moVNIHP0tUP1+uVVcw08GaO2o8TBRn9BjaHDg1HhWCtKy+
         +E6LoWOQlAT4du16u0lz23GGtFYczyCyQLjClXlQ/mjqFxMkGm4J2/vbTTDFHpz2FX
         ul+TDtx0FxjEzmkMpDyBeJf4haoWh5HvVzSIbp6M=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B0760AA2;
        Mon, 10 Sep 2018 23:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536623233;
        bh=mk5/SkzvCw05op/4eL4O6Aolvs7yRuz2Hp0NBQpMBpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2x+G1AaUdIUw1kdr/RiwQRS6VRPEbx0vgXuujYQUGRiovuRTdbp0nmg+DfM5EGjx
         0LZdrI7dfzaNHyMuiNOfP/iee9RiBOAl3mtsEVNg4caFP2cxM7kYFwlb8WY4Iiu6jQ
         YiaLlFPPgpx/bmVUknteCxyZU+vgbwOgI/TkGiBU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3B0760AA2
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
Subject: [PATCH v5 4/4] dt-bindings: msm: Update documentation of qcom,llcc
Date:   Mon, 10 Sep 2018 16:46:55 -0700
Message-Id: <1536623215-20018-5-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536623215-20018-1-git-send-email-vnkgutta@codeaurora.org>
References: <1536623215-20018-1-git-send-email-vnkgutta@codeaurora.org>
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

