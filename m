Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pJ/qKq0b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QPpvcZKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeLMJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:05:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeLMJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:05:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F3B160908; Thu, 13 Dec 2018 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544691929;
        bh=6EHwfvUHeqg6v2iD8Y9ScNbvHXNVTuRyEv10SkLA/bs=;
        h=From:To:Cc:Subject:Date:From;
        b=pJ/qKq0bWWwbmZ3WVBscylX/4kudf7m3J7U7iK3ma45hU+1Q43y8/V/RU3FIZuC/o
         LwD2s4NxQVFxasWklTn3kNTKmM1KMF0i7M3nR2JEcq3r9mz8QKgUAzJ+BaX2vwZtAn
         ZLtTrAbyUIKQYHD57rg92ldsS7A8BHhnr3G7JBAM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87453608CD;
        Thu, 13 Dec 2018 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544691928;
        bh=6EHwfvUHeqg6v2iD8Y9ScNbvHXNVTuRyEv10SkLA/bs=;
        h=From:To:Cc:Subject:Date:From;
        b=QPpvcZKqm3RkTff+C7IhDNInq+c8vRNybQSHN89yU712WgmRbjUlE+0HjjhWhtUzq
         HSe8wpweIUKAxO2DoaNfFmBUyULTaVgny3zZ8Ta75IxppYtZkvc+QwsTRClFcpuiLd
         uq4Z5nG+o84ZKR/FyO0A/D5MW4fdRhJ1sfFf5c84=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87453608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v4 1/1] dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
Date:   Thu, 13 Dec 2018 14:35:07 +0530
Message-Id: <20181213090507.6269-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom's implementation of arm,mmu-500 works well with current
arm-smmu driver implementation. Adding a soc specific compatible
along with arm,mmu-500 makes the bindings future safe.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
---

Hi Joerg,
I am picking this out separately from the sdm845 smmu support
series [1], so that this can go through iommu tree.
The dt patch from the series [1] can be taken through arm-soc tree.

Hi Will,
As asked [2], here's the resend version of dt binding patch for sdm845.
Kindly ack this so that Joerg can pull this in.

Thanks
Vivek

[1] https://patchwork.kernel.org/cover/10636359/
[2] https://patchwork.kernel.org/patch/10636363/

 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index a6504b37cc21..3133f3ba7567 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -27,6 +27,10 @@ conditions.
                   "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
                   "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
 
+                  Qcom SoCs implementing "arm,mmu-500" must also include,
+                  as below, SoC-specific compatibles:
+                  "qcom,sdm845-smmu-500", "arm,mmu-500"
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

