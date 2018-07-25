Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AABC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CD620833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dvd/tMkd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eZq0UYQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CD620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeGYS6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:58:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbeGYS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:58:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C820C60B7F; Wed, 25 Jul 2018 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532540744;
        bh=aLZeTp6N7J45OWOIwIEW2ZLhcBoEwiP0cn+Srs879R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dvd/tMkd9WXndxdylygWgknT4Xz3OL1HKYd57XIUcM0wLRE25tkSwZyI2NsTNMS3f
         Rcko30/lmrPRmfPWTr04JhaW2qGYxWK55VnGBYatrM1lrv6Z/zzeyyE+b/gG4Nn+oU
         ItapxP3Z6JRD+Or1PD6bGtfN9BMXjopZ6Vv0mlqs=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A38F60BDE;
        Wed, 25 Jul 2018 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532540742;
        bh=aLZeTp6N7J45OWOIwIEW2ZLhcBoEwiP0cn+Srs879R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZq0UYQQTibnKiDBRQ7t7G7JC4LrdiGptlvm8D+9BRkfAm+VWY51DS4L6nYvUvLH7
         up7F2x4BROarKwIWIqUuUZrISalNnkXWylU6eY3ckspR4CM4zKJxjeqC8aoEObymRU
         IjcEBCxwrc4saL8sE6fGHfvyFhMyB1ggXcMDDQyA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A38F60BDE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     evgreen@chromium.org, robh@kernel.org, bp@alien8.de,
        mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        rishabhb@codeaurora.org
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v0 4/4] dt-bindigs: Update documentation of qcom,llcc
Date:   Wed, 25 Jul 2018 10:44:57 -0700
Message-Id: <1532540697-26630-5-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
References: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
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

