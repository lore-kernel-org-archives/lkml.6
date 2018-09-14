Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4698FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545F920671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X3MiSXoc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lebCH/Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545F920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeINSkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:40:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeINSkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:40:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4AF4460B81; Fri, 14 Sep 2018 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536931543;
        bh=QKQCiSic8ozexkREWjUvff0daiF276h/ONDn9IUOFfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3MiSXocGCAisT2cbLlzZZwFzBg6B9TTy6JGEW7KsTREpZBCCFBWol6v6EWwfHjy5
         qltEHv/OV6pi0yoqOJFa4ZxutTfeFTmM1OLE5ZzJXyXWUweFg3T6DCwWXvSiU+Jcsy
         /KMwQl3ieLwH+JvBP6JwKX6tz7si1JLTHguaWlT0=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02C9D60998;
        Fri, 14 Sep 2018 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536931540;
        bh=QKQCiSic8ozexkREWjUvff0daiF276h/ONDn9IUOFfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lebCH/CafMBert18W4I3dexS3H0zdl4CM2i+j1Ar0MGA9DLM43UEsvTG76+8nLiH7
         dsIRbHCr5BjM4MUWP122cfGZxtIsGnOnFBpweSBpKzUsoNbidmSGa4MP9PJekFUDVL
         2IwpifLgAZP9OSdGHq+SrW46q1pHJwRVmYfTScsA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02C9D60998
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
Subject: [PATCH v7 5/5] dt-bindings: media: Document bindings for venus firmware device
Date:   Fri, 14 Sep 2018 18:54:37 +0530
Message-Id: <1536931477-13018-6-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536931477-13018-1-git-send-email-vgarodia@codeaurora.org>
References: <1536931477-13018-1-git-send-email-vgarodia@codeaurora.org>
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

