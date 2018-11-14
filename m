Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60877C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B1120868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="o/DgfAEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B1120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbeKOIcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41387 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389238AbeKOIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so28785311qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ku7VxA8FM86Lma6NsAxIOdj6TL4xUq0CE5op1FFIL2A=;
        b=o/DgfAEjE/kA84QId1mMA4V9JgV6pkEX/kd0AjGIOXihm8vEcDvaR8SqRBsGUrwnYl
         44Aj2nuWoJHekUsd1yvGPsOYvJF1tSx976bTCPld7ihVKgWGpN17eEUrjA0QUMpdOMO8
         Il3TVT8A/Z/0MNN1hkDo12/jvSymj+a7hlgwEbbXvg2aVBIGIkvL1mfFuCEyt1JejJOH
         UCH/+VFVEQ9acVg8bDxP6zKzfQh2l5e2JJJ8I0opCRnrWoExWaUZ/rpuKYypTlYabrBS
         hU0X9x5Cx0ie+LepoYyG7G1I7a6Af/Sx4WNOBQC8cIWfHpFSq09ZHbxqFlk96wEm7dPt
         R32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ku7VxA8FM86Lma6NsAxIOdj6TL4xUq0CE5op1FFIL2A=;
        b=MR/GfPGvYwgyKlBoMK5rHfitGnpAriffTFO56nEYSs8WVInxaQiaV/9Xz/SdCV+eVM
         yroxvWIJVjvuGkgMVuUMDIx6+xkl2y7gC6eaPbC5QYbKN99rXZaDgjh3rfXMgnBZyOil
         nXr8D0RZlWkBsOYLmIHAH1xDcUO0eOowGtcuyVhaooUyWABB77s1LmjhC/+5w5noyjb4
         OcSTAfgSlbBDxF4gQ+XauMut8TqMuJ0Z9nYtKXiTSWMnfj9GJxEhf56tULN6kzJcrCne
         TKAlhWxsMXxY8micNm1jBgSDifuvSWVzGkFy16AcJT3pJJhIf42hZpTFWWymgV8jRVLR
         Zq9w==
X-Gm-Message-State: AGRZ1gKkXEIKj9FykIRnh3TdhObg6uczLywpPVL9UHHEIPdlJ8Uhtixx
        e54pRny/aZZvSGK3Hh8VbMNfBg==
X-Google-Smtp-Source: AJdET5cDIMBh+0P2Ef6R3pYpaRq45vsTwRqsBsc5J/Tff14rT8XZnetqjqTHp7kf5dNd4SnaMjjIXg==
X-Received: by 2002:a0c:981b:: with SMTP id c27mr3949195qvd.184.1542234459427;
        Wed, 14 Nov 2018 14:27:39 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:27:38 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/9] drm/msm: use contiguous vram for MSM_BO_SCANOUT when possible
Date:   Wed, 14 Nov 2018 17:24:11 -0500
Message-Id: <20181114222418.15960-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
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

