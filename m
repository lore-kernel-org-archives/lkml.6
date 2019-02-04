Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718E020815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LqVJrLdm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LqVJrLdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfBDQP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:15:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfBDQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:15:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A78160989; Mon,  4 Feb 2019 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296953;
        bh=vSlgeuTJ23KCkhROMEb+w831WwNffRz4kmTKqBSB3j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqVJrLdmMiqc58R8jggyoTNKZBeQwmskq+DDr0gLXBz79ur2eJDjCDi4kwBvjQ0Qz
         o7xz54Fm5svss6WJi2fLvOu3D2ZW+mXzCkS1+pzVy9gHwCnY+6hNpCQcZDffj0HX9K
         jsjCBQs02MJEzKtAN+JNT0oYRrdFV/4IstXic67c=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A9B360918;
        Mon,  4 Feb 2019 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296953;
        bh=vSlgeuTJ23KCkhROMEb+w831WwNffRz4kmTKqBSB3j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqVJrLdmMiqc58R8jggyoTNKZBeQwmskq+DDr0gLXBz79ur2eJDjCDi4kwBvjQ0Qz
         o7xz54Fm5svss6WJi2fLvOu3D2ZW+mXzCkS1+pzVy9gHwCnY+6hNpCQcZDffj0HX9K
         jsjCBQs02MJEzKtAN+JNT0oYRrdFV/4IstXic67c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A9B360918
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 2/6] dt-bindings: drm/msm/a6xx: Add GX power-domain for GMU bindings
Date:   Mon,  4 Feb 2019 09:15:40 -0700
Message-Id: <1549296944-17285-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMU should have two power domains defined: "cx" and "gx". "cx" is the
actual power domain for the device and "gx" will be attached at runtime
to manage reference counting on the GPU device in case of a GMU crash.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 Documentation/devicetree/bindings/display/msm/gmu.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
index 3439b38..90af5b0 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
@@ -24,7 +24,10 @@ Required properties:
    * "cxo"
    * "axi"
    * "mnoc"
-- power-domains: should be <&clock_gpucc GPU_CX_GDSC>
+- power-domains: should be:
+	<&clock_gpucc GPU_CX_GDSC>
+	<&clock_gpucc GPU_GX_GDSC>
+- power-domain-names: Matching names for the power domains
 - iommus: phandle to the adreno iommu
 - operating-points-v2: phandle to the OPP operating points
 
@@ -51,7 +54,10 @@ Example:
 			<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
 		clock-names = "gmu", "cxo", "axi", "memnoc";
 
-		power-domains = <&gpucc GPU_CX_GDSC>;
+		power-domains = <&gpucc GPU_CX_GDSC>,
+				<&gpucc GPU_GX_GDSC>;
+		power-domain-names = "cx", "gx";
+
 		iommus = <&adreno_smmu 5>;
 
 		operating-points-v2 = <&gmu_opp_table>;
-- 
2.7.4

