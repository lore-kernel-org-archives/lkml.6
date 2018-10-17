Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA03ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D626421523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k2bn/P3D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hH4c14AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D626421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJQVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:14:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJQVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:14:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47A8961324; Wed, 17 Oct 2018 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782345;
        bh=tyrC3RugWUjy7YFsnQINBY4rjSC8Oc8P0aIh7m1qcV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2bn/P3Dl1xB07ACgoQvlZte4NKhbNJIr41E+efPfxRZ6ahw/W5dSK5liJBzjL6hi
         MDOx34FfGngRZ6BDHa/73df2goVq1qppl9FjjfahhG9RehR7nF67RuCkxPT0NOHGlA
         NHc3PgXM6wBOoJqd4eivMiTcQfTxc6LrqibJtXWY=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8EE561313;
        Wed, 17 Oct 2018 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782343;
        bh=tyrC3RugWUjy7YFsnQINBY4rjSC8Oc8P0aIh7m1qcV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH4c14AYQtrMJ+r7Uk2nmelzKo4KzHD8Ju0KXpjtLTB7P3SpKi5EJhGTWQE0+kWwI
         DZx1BTU+aSWgv2pNFeFqId/fdJH8LnxR1M5QNrOCZjQDgByu+PLiYr3uGK2HMQWwb/
         5zjA96FtUuqm6CU8x1wU3OOGouKoftHlmi/phPnU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8EE561313
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v12 5/5] dt-bindings: media: Document bindings for venus firmware device
Date:   Wed, 17 Oct 2018 18:48:23 +0530
Message-Id: <1539782303-4091-6-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
References: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for firmware loader for video
hardware running on qualcomm chip.

Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/qcom,venus.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
index 00d0d1b..b602c4c 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus.txt
+++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
@@ -53,7 +53,8 @@
 
 * Subnodes
 The Venus video-codec node must contain two subnodes representing
-video-decoder and video-encoder.
+video-decoder and video-encoder, and one optional firmware subnode.
+Firmware subnode is needed when the platform does not have TrustZone.
 
 Every of video-encoder or video-decoder subnode should have:
 
@@ -79,6 +80,13 @@ Every of video-encoder or video-decoder subnode should have:
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
@@ -105,4 +113,8 @@ Every of video-encoder or video-decoder subnode should have:
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

