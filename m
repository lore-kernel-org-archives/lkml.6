Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7A21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="At3kEbol";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CtSm1Ec4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeLRSyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:54:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:54:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 742BD6058E; Tue, 18 Dec 2018 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545159246;
        bh=SYepN5HlQz2x6xfgmINiiOr9CUb2ElNHXFcXVXIpe3c=;
        h=From:To:Cc:Subject:Date:From;
        b=At3kEboluPmk0kaNl3ehpL/HhEpI+9iBt2H9g2Ud4h/23wL5phvxfZ8BgLMq9Ofgd
         580eughzxUsNHqHYVxEV/mIQ4WaUUZ8vBK/fBNyAon3vSJPAyxRCR9/uD7AxaQjf11
         T9R2ozPapZ63Eew5P7vo1kjfodhh3MzXiPVTw5ug=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71D846058E;
        Tue, 18 Dec 2018 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545159244;
        bh=SYepN5HlQz2x6xfgmINiiOr9CUb2ElNHXFcXVXIpe3c=;
        h=From:To:Cc:Subject:Date:From;
        b=CtSm1Ec4tBoYmkqC9aMT/hPiICIMn1V3DaVn94jMT7jYCZmd3P5qjhCOdNd9uALKV
         Z7Zufvm4ywVL3XHiyHGxlCKXH5u2rmYNb0y4i2EUnqlBtUcSAxJKwWKoHidqrmbUGE
         xuErqe+6EENiM5MFrPjfexWeEwbvT+VaC8wLHgRU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71D846058E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: [v1] drm/msm/dpu: Remove unused enum and comment from dpu mdss
Date:   Wed, 19 Dec 2018 00:23:53 +0530
Message-Id: <1545159233-21580-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove enum dpu_iommu_domain from dpu mdss as its unused.

Remove unnecessary comment for variable which is already
removed.

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 68c54d2..1ab8d4a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -258,12 +258,6 @@ enum dpu_vbif {
 	VBIF_NRT = VBIF_1
 };
 
-enum dpu_iommu_domain {
-	DPU_IOMMU_DOMAIN_UNSECURE,
-	DPU_IOMMU_DOMAIN_SECURE,
-	DPU_IOMMU_DOMAIN_MAX
-};
-
 /**
  * DPU HW,Component order color map
  */
@@ -358,7 +352,6 @@ enum dpu_3d_blend_mode {
  * @alpha_enable: whether the format has an alpha channel
  * @num_planes: number of planes (including meta data planes)
  * @fetch_mode: linear, tiled, or ubwc hw fetch behavior
- * @is_yuv: is format a yuv variant
  * @flag: usage bit flags
  * @tile_width: format tile width
  * @tile_height: format tile height
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

