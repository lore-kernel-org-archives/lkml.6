Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7EAC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EFA2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KX6f+7Rq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KX6f+7Rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EFA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeJKRQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:16:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeJKRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:16:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8CEE60C8A; Thu, 11 Oct 2018 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539251385;
        bh=Qs7WWaBHahUgPCs4lu3CEuSrR+vGi3nxdpsz9rtgaiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KX6f+7RqWO+dLe79qN7fBuFy3ai0nh6S5gA41UzwfVxbNYH3Axjos25jyChzqhc19
         n+N8VcKqf8T+eNjSCQorV1/ZBfb5CIpB+wk2yVdY2m1wJKc6CCmSNnZunZKkWitzxf
         45K4zgHl9jpcPBTPVsKMItWSl2zdXLxNYFpKi7RE=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B1BE60C62;
        Thu, 11 Oct 2018 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539251385;
        bh=Qs7WWaBHahUgPCs4lu3CEuSrR+vGi3nxdpsz9rtgaiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KX6f+7RqWO+dLe79qN7fBuFy3ai0nh6S5gA41UzwfVxbNYH3Axjos25jyChzqhc19
         n+N8VcKqf8T+eNjSCQorV1/ZBfb5CIpB+wk2yVdY2m1wJKc6CCmSNnZunZKkWitzxf
         45K4zgHl9jpcPBTPVsKMItWSl2zdXLxNYFpKi7RE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B1BE60C62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, dianders@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
Date:   Thu, 11 Oct 2018 15:19:29 +0530
Message-Id: <20181011094930.17010-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom's implementation of arm,mmu-500 works well with current
arm-smmu driver implementation. Adding a soc specific compatible
along with arm,mmu-500 makes the bindings future safe.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

Changes since v3:
 - Refined language more to state things directly for the bindings
   description.

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

