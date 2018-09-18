Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C0CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CB821471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T2BnHYcy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HcEOzB4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CB821471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbeISDeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:34:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISDet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:34:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4390B60C7E; Tue, 18 Sep 2018 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537308011;
        bh=QKQCiSic8ozexkREWjUvff0daiF276h/ONDn9IUOFfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2BnHYcyv4H6/UjVgIAs1j5odP/N9CSRzka021QHoHySUVldm9OHcxY1vsBX4oqqR
         fT2CA3CrCNFz7OrZBUgwkvPk1bWUQPiAUgwkJMMdc9nOKm8/QcURSOerzNt0VPOWiY
         cOQKS6RqX/5J3dci44kI8JK7soPifzWZKgy4cJyI=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E6FE60CA2;
        Tue, 18 Sep 2018 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537308007;
        bh=QKQCiSic8ozexkREWjUvff0daiF276h/ONDn9IUOFfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcEOzB4M+ly1GjAA1YoZ8NfHg7YxSqlLlXZtBcuX4dzrMyGKcX4JSVSANYI6/ObCT
         DRrPr/F2BR+ykg5RfKfThERgRs1+71aTAoqOfDR5XC13kcmi6XeJ98ZKRgSYouHTzx
         F0J+7D5NnGTtka/k0cAnE77gkQTi3k2PwcWfog5A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E6FE60CA2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v8 5/5] dt-bindings: media: Document bindings for venus firmware device
Date:   Wed, 19 Sep 2018 03:29:13 +0530
Message-Id: <1537307954-9729-6-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537307954-9729-1-git-send-email-vgarodia@codeaurora.org>
References: <1537307954-9729-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for firmware loader for video
hardware running on qualcomm chip.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 Documentation/devicetree/bindings/media/qcom,venus.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
index 00d0d1b..7e04586 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus.txt
+++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
@@ -53,7 +53,7 @@
 
 * Subnodes
 The Venus video-codec node must contain two subnodes representing
-video-decoder and video-encoder.
+video-decoder and video-encoder, and one optional firmware subnode.
 
 Every of video-encoder or video-decoder subnode should have:
 
@@ -79,6 +79,13 @@ Every of video-encoder or video-decoder subnode should have:
 		    power domain which is responsible for collapsing
 		    and restoring power to the subcore.
 
+The firmware subnode must have:
+
+- iommus:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: A list of phandle and IOMMU specifier pairs.
+
 * An Example
 	video-codec@1d00000 {
 		compatible = "qcom,msm8916-venus";
@@ -105,4 +112,8 @@ Every of video-encoder or video-decoder subnode should have:
 			clock-names = "core";
 			power-domains = <&mmcc VENUS_CORE1_GDSC>;
 		};
+
+		video-firmware {
+			iommus = <&apps_iommu 0x10b2 0x0>;
+		};
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

