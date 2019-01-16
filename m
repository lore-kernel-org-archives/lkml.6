Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9748C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CCA20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dt/3fixN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DIaQICx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAPVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:10:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfAPVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:10:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B00160591; Wed, 16 Jan 2019 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547673000;
        bh=KiHM9uw7DhRYRVfHXxa4m4FsbQuRsV5HedJAQnGvnrU=;
        h=From:To:Cc:Subject:Date:From;
        b=Dt/3fixNK967UKYrl0/ofpEKu5ttYwFjuTQ3DE6U0dYI5MBE3f9MYjQ+J8F24V/xI
         npTWRkRidEbh4teVFyFF4SI0ec7eScdyvZnE5cgEHEE0NZU3twa6lgQ10MxpeRBiRm
         L8FsyAerksKU19v9hQJuJjIDAFM9H1jjsiI55CBw=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B99D60591;
        Wed, 16 Jan 2019 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547672998;
        bh=KiHM9uw7DhRYRVfHXxa4m4FsbQuRsV5HedJAQnGvnrU=;
        h=From:To:Cc:Subject:Date:From;
        b=DIaQICx0OCLcPzPTrOy84kY7ka7YuoH9IevwJB8+yMInvfU4T8EJp+NtXgPdGmOy/
         qMtqSy7hDo7hIcV9koOZnKCmwxUMBJcG7BZHzc3JS2fD4e64/7gdp4FCfDlOvZ0Qnv
         n/eaVtCwAbQLZWWjQu7HiZIkqz8z71wZOu9NMJ88=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B99D60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] dt-bindings: drm/msm/a6xx: Document GMU bindings
Date:   Wed, 16 Jan 2019 14:09:51 -0700
Message-Id: <1547672991-3204-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 24937c540917 ("dt-bindings: drm/msm/a6xx: Document GMU and update
GPU bindings") mistakenly omitted the GMU bindings as seen in [1].
Return them to their rightful place.

[1] https://patchwork.freedesktop.org/patch/268679/

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

 .../devicetree/bindings/display/msm/gmu.txt        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
new file mode 100644
index 0000000..3439b38
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
@@ -0,0 +1,59 @@
+Qualcomm adreno/snapdragon GMU (Graphics management unit)
+
+The GMU is a programmable power controller for the GPU. the CPU controls the
+GMU which in turn handles power controls for the GPU.
+
+Required properties:
+- compatible: "qcom,adreno-gmu-XYZ.W", "qcom,adreno-gmu"
+    for example: "qcom,adreno-gmu-630.2", "qcom,adreno-gmu"
+  Note that you need to list the less specific "qcom,adreno-gmu"
+  for generic matches and the more specific identifier to identify
+  the specific device.
+- reg: Physical base address and length of the GMU registers.
+- reg-names: Matching names for the register regions
+  * "gmu"
+  * "gmu_pdc"
+  * "gmu_pdc_seg"
+- interrupts: The interrupt signals from the GMU.
+- interrupt-names: Matching names for the interrupts
+  * "hfi"
+  * "gmu"
+- clocks: phandles to the device clocks
+- clock-names: Matching names for the clocks
+   * "gmu"
+   * "cxo"
+   * "axi"
+   * "mnoc"
+- power-domains: should be <&clock_gpucc GPU_CX_GDSC>
+- iommus: phandle to the adreno iommu
+- operating-points-v2: phandle to the OPP operating points
+
+Example:
+
+/ {
+	...
+
+	gmu: gmu@506a000 {
+		compatible="qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
+
+		reg = <0x506a000 0x30000>,
+			<0xb280000 0x10000>,
+			<0xb480000 0x10000>;
+		reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hfi", "gmu";
+
+		clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+			<&gpucc GPU_CC_CXO_CLK>,
+			<&gcc GCC_DDRSS_GPU_AXI_CLK>,
+			<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+		clock-names = "gmu", "cxo", "axi", "memnoc";
+
+		power-domains = <&gpucc GPU_CX_GDSC>;
+		iommus = <&adreno_smmu 5>;
+
+		operating-points-v2 = <&gmu_opp_table>;
+	};
+};
-- 
2.7.4

