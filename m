Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A2vCH8XZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fjU1uVlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA1C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbeHAWVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:21:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbeHAWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:21:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F3CB60B15; Wed,  1 Aug 2018 20:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533155637;
        bh=aLZeTp6N7J45OWOIwIEW2ZLhcBoEwiP0cn+Srs879R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2vCH8XZAHMZlEIwkjWIkZa5/iiJm6zPYN3MNRXpLrpO6ZW0YslHRoXAGERI0QAzG
         zTBLbatr+wsbCk7qMu+8CAAUvIz+XTowcOyPdKPebiuOiQZaz4RCSCPsG2FZZ2vQJm
         0jlnbEvB8WxNN3Y8bSKiz1CJB6CNuwxPor950/h8=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16BCF606DD;
        Wed,  1 Aug 2018 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533155634;
        bh=aLZeTp6N7J45OWOIwIEW2ZLhcBoEwiP0cn+Srs879R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjU1uVlUs9KK7gXkLQN10frGODXMt3JUA3Nq+WjixTCOJqAgmVd+uLKjiqSZdVSG+
         LrELOAvxprmPUEqmZO9q7NOWCzt3tvvFfH1G1xT3QboU268ZZSDXSprgi/PAriRSO5
         K/F3TWz/smSrWzuuphw57mN+byj7up0/Tzj25D7M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16BCF606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v1 4/4] dt-bindigs: Update documentation of qcom,llcc
Date:   Wed,  1 Aug 2018 13:33:35 -0700
Message-Id: <1533155615-27929-5-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533155615-27929-1-git-send-email-vnkgutta@codeaurora.org>
References: <1533155615-27929-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reg-names and interrupts for LLCC documentation and the usage
examples. llcc broadcast base is added in addition to llcc base,
which is used for llcc broadcast writes.

Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
index 5e85749..b4b1c86 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -18,9 +18,22 @@ Properties:
 	Value Type: <prop-encoded-array>
 	Definition: Start address and the the size of the register region.
 
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
+
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

