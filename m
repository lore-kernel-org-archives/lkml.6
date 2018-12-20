Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35030C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07884218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EqLHNLvl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bh02hd/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbeLTRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:30:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbeLTRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:30:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6585F6090C; Thu, 20 Dec 2018 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327037;
        bh=s/vBiF/stLHSG1XGFLewCr5bYqm7HK5fSuvw7/3Fjs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqLHNLvlO3GyCbRJKffpGpq54U6jy3m3kUp9yCfrpYiY9fZNDBmZOEA5/tSZXGADF
         ycaQsWbp3gRMI1wpioD1GXL719cFX5lt9NC5n5Nf6qoJKJldjhVhuN640jRz6ulcuf
         ass4eUzkmJM/FK6Y9t9CXzRoz6PA1DHUTasgiBjY=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5CD860886;
        Thu, 20 Dec 2018 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327036;
        bh=s/vBiF/stLHSG1XGFLewCr5bYqm7HK5fSuvw7/3Fjs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh02hd/MG0MHsSnoii5ZSMacQ/xLMnWRD4qgvzm88HMoEuEYn3ZFhMPq2GhP3Pk3M
         qYYXIXKtmXGIFiLZXXLpddcyThPPt7N00nNzkJw2VGncLI1xniib0BqX2FjN1rBUqF
         be3xYXNiMjJvoCEjdJ7QM2Es7CXO9qoO0IxQN+P0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5CD860886
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/3] dt-bindings: drm/msm/a6xx: Document interconnect properties for GPU
Date:   Thu, 20 Dec 2018 10:30:25 -0700
Message-Id: <20181220173026.3857-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181220173026.3857-1-jcrouse@codeaurora.org>
References: <20181220173026.3857-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the interconnect and interconnect-names bindings
for the GPU node as detailed by bindings/interconnect/interconnect.txt.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 Documentation/devicetree/bindings/display/msm/gpu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index 9c89f4fdb8ca..5b04393dcb15 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -20,6 +20,8 @@ Required properties:
    - qcom,adreno-630.2
 - iommus: optional phandle to an adreno iommu instance
 - operating-points-v2: optional phandle to the OPP operating points
+- interconnect: optional phandle to a interconnect provider.  See
+  ../interconnect/interconnect.txt for details.
 - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
   control the power for the GPU. Applicable targets:
     - qcom,adreno-630.2
@@ -68,6 +70,8 @@ Example a6xx (with GMU):
 
 		operating-points-v2 = <&gpu_opp_table>;
 
+		interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
+
 		qcom,gmu = <&gmu>;
 	};
 };
-- 
2.18.0

