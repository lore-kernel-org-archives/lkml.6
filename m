Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E77C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A05E20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f1tAUqNU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fSLEBkkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A05E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIEDuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:50:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIEDuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:50:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 225E2609D1; Tue,  4 Sep 2018 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536103381;
        bh=rtl7deW1Eq1K5D1poizL/X6Ilx6ChqdDpqrh8TsepFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1tAUqNUA2GPfH8lGGu7gHbf2SS1w1/2dwwYczvdHjDJdKPDsWMRPpkSMYVt4WvjV
         mFVojBN9aXRL2LLhZ5jzqnmDmbTXqVBEWGBKXU0u9WsdCL/AjR7yp3dzmYzhTnWqf4
         94Eh6kKHYAylJrt7Yn7Ft2AQdwRbxbssa6tGIVkE=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CB78608C1;
        Tue,  4 Sep 2018 23:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536103379;
        bh=rtl7deW1Eq1K5D1poizL/X6Ilx6ChqdDpqrh8TsepFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSLEBkkSmYtgQWfChKhInIFXhc4WKm2hgVjfx+UVkt0/hRCub/aqy4BH/80odCtU+
         Wc5+R53Qk6WSrzVdQ/5fC20nI23qRJHioNG+YBn7naRm02pQIQ+Xp3GH4LN3+k54dQ
         d4t4EbjF9K+3tgXmrWaRiSJ/sbWYMZ5EZEbhIB/E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CB78608C1
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
        swboyd@chromium.org, bjorn.andersson@linaro.org
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v4 4/4] dt-bindings: msm: Update documentation of qcom,llcc
Date:   Tue,  4 Sep 2018 16:22:25 -0700
Message-Id: <1536103345-1919-5-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
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
index 5e85749..2e007dc 100644
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
+        Definition: Register region names. Must be "llcc_base", "llcc_bcast_base".
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
+		reg-names = "llcc_base", "llcc_bcast_base";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

