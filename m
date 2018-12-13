Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9DEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF7B20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675381;
	bh=zxE11cNHE7MWySKVZgsTnpMqoFlvP2LeGUHYTOW0DlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxoEZpWwc+tZbYfqNifGfCyM0iO3Ffrgmwf7pGckV0GhMmVQ7HPgrD4Jv830oXz15
	 vsREvDyj03549naooEoFx09JUzDSFLlfzR63VfAs7zkHt21NfD+UMh/jYZvceCi3pm
	 h+cHBdTLUIUg1uvpamN9SkIZQtM6MK+iGsvW4ClE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF7B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeLME3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbeLME3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610E220879;
        Thu, 13 Dec 2018 04:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675379;
        bh=zxE11cNHE7MWySKVZgsTnpMqoFlvP2LeGUHYTOW0DlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sq5FAVWNdt8JUQJNs8LTuYiSbhtzdWGOsOtqElvBCj4Gwn5tCNXH3nUTHVL/EUY0K
         0kH+u8hKLuOMnMMryFMM8VckTcLGVtjzvnepNwjb+pcp3eQfTIzW1PzJJPogonR+4+
         jfxwoqLvYOaehcCTzLFlGKnWbVvrgpwY43SXnAxE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 33/73] drm/msm: dpu: Don't set legacy plane->crtc pointer
Date:   Wed, 12 Dec 2018 23:27:58 -0500
Message-Id: <20181213042838.75160-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 081679c51ef2fd7b23cf9ddb7d775b17f75de18c ]

It causes a WARN in drm_atomic_get_plane_state(), and is not used by
atomic (or dpu).

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index cd02eae884cc..4752f08f0884 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -2122,7 +2122,6 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane)
 				NULL);
 
 	drm_crtc_helper_add(crtc, &dpu_crtc_helper_funcs);
-	plane->crtc = crtc;
 
 	/* save user friendly CRTC name for later */
 	snprintf(dpu_crtc->name, DPU_CRTC_NAME_SIZE, "crtc%u", crtc->base.id);
-- 
2.19.1

