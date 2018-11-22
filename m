Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E121C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604D52080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="oe9AT6rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604D52080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbeKVMcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44058 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403925AbeKVMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so5984408qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ku7VxA8FM86Lma6NsAxIOdj6TL4xUq0CE5op1FFIL2A=;
        b=oe9AT6rM4yAzR35iQBUdSrgauRUEMNnM+R2uphrp4/LW+8p0Yl8TKmjO4e1asyDkMF
         UtJYn4es/17JP5WZJsV+IZzGqN9uSuxjwmLiTBCl5yenhSBrMHffnv1GyZEd+cSuBLKt
         qA9hK0lM8aeJc3tIc+rXHeRzfaC2xj/3XGiaoLeRHLJs1lRbmgb4QqqLunSS77wFHzTn
         7Mu0gQqqssl1omCS+gK7C3d9LqBb5Ff98WzbJNp3gSprNXSdFhDzYILRCDrvxC+stlMs
         26NsWG734q0eSF2i9Sv3dn2opeSMHSEVaOUsyJm6sEeZSji9kr4l6EuDsAvKKBPQGlxw
         sczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ku7VxA8FM86Lma6NsAxIOdj6TL4xUq0CE5op1FFIL2A=;
        b=m07jwfPiGBua3jCYeQNHqGhDF40OZrNaznnwAAUZsLR2Kz9birz7CZ7CTZ1F/c8DQ+
         5xLEOTRtaGRHaCu178fWMu8Lk9zWGF+xRhmcTS6hpv6m/0YZISNbx0m+DNcz0dCS2Bhc
         iWZCrlm5zwTWqHj0CG1I5PiU9kfvAkObRoir2ido1N/+qzQuL8Fvekx6ti7sFbaxR4Rn
         MJKFoB6JfrPyek5x4+E57ZRMgLZBV4nTORgdBS77OcUE/TE8FHBgeURvZIF9seOX8MkN
         +G0/uJpgH7ESaQoiTuEnRa/bZXf3pzlzF/yPaHDM/k18bpT1HnUeMH41ivAnKewF2izN
         Oiew==
X-Gm-Message-State: AGRZ1gI7BjzrTtEMVo5qPcqF7DTnnFubMaYkU1RXaRZRVf8C66n57JIW
        jWUdFLrwZbqqPijh/5VYZHzg6A==
X-Google-Smtp-Source: AJdET5fUV0y/eTMvaufKDBHta4BbfCClRitejm8Jomr0fxjkYPrpG+jNd+LtSwVtTYRFNQmpsqtaoQ==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr8304561qtn.78.1542851731980;
        Wed, 21 Nov 2018 17:55:31 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:55:31 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/9] drm/msm: use contiguous vram for MSM_BO_SCANOUT when possible
Date:   Wed, 21 Nov 2018 20:52:30 -0500
Message-Id: <20181122015237.14534-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes it possible to have MMU for GPU but not display.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index d97f6ecb0531..6657453a3a58 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -914,7 +914,7 @@ static struct drm_gem_object *_msm_gem_new(struct drm_device *dev,
 
 	if (!iommu_present(&platform_bus_type))
 		use_vram = true;
-	else if ((flags & MSM_BO_STOLEN) && priv->vram.size)
+	else if ((flags & (MSM_BO_STOLEN | MSM_BO_SCANOUT)) && priv->vram.size)
 		use_vram = true;
 
 	printk("_msm_gem_new %u bytes use_vram=%u\n", size, use_vram);
-- 
2.17.1

