Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E11C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218CB21721
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KcWYBRKm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ns918tVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218CB21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeHNNO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:14:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbeHNNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:14:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1478760214; Tue, 14 Aug 2018 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534242476;
        bh=b/a1xnKDp+AWb8vR0vxHi/h4wvuTk+uPwsEIlIPatVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcWYBRKm7a3lsKGVYe6JlXUPmwTt5zrQLLNJDSS1/1RCEmXXyABUCfC6CMXYYpEO8
         3iiRwfHvCDpYqrlfqdC2oMDrt36j9r5n74cL1qO/AXU++DSohkuyf6/TMvw5Y2JJtz
         gV7sJYf7N4mBdt4/tuV3zim14BwMWZHKK5ude8xo=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C10C60214;
        Tue, 14 Aug 2018 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534242475;
        bh=b/a1xnKDp+AWb8vR0vxHi/h4wvuTk+uPwsEIlIPatVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ns918tVZwv4m6zGEHeKXb6hdcbwtu1fIx3Pqw0BWcoWYTc/+etWljq6BwcxhBMLxP
         +x49g3Xs7GJaxtRysV1de7W+99cShe4+Qrcut3F7V3t4ShD+DpydeI3ZiWoZu5AYfi
         klukrxMkF/PofteE+pAzCS2IQuilLvmAnG0uN/vM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C10C60214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     mark.rutland@arm.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 1/3] dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
Date:   Tue, 14 Aug 2018 15:57:38 +0530
Message-Id: <20180814102740.30222-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom's implementation of arm,mmu-500 works well with current
arm-smmu driver implementation. Adding a soc specific compatible
along with arm,mmu-500 makes the bindings future safe.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 7c71a6ed465a..7d73b2a259fc 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -18,6 +18,7 @@ conditions.
                         "arm,mmu-500"
                         "cavium,smmu-v2"
                         "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
+                        "qcom,<soc>-smmu-500", "arm,mmu-500"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -30,6 +31,10 @@ conditions.
                   An example string would be -
                   "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
 
+		  "qcom,<soc>-smmu-500" compatible string represents qcom's soc
+		  specific implementation of arm,mmu-500, and should be present
+		  along with "arm,mmu-500".
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

