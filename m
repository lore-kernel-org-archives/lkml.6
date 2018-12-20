Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BE820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298439;
	bh=CfmdXNZE+4AW1n35ThWHPFHIIE815csQt4iPTbaj/CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nln04GxdwkTAuUTdv68VXBSYWaqdhIGnCvW+Nb5SYiIdKJfVUb99rTPLml6ZpksK1
	 oqcBfwAdJOJ6g83yUhh1NETVXtguyKqMydBqTa/2/W0cSB4pAKt+Uxf3rQBffE/zcb
	 nXi7GSi2YQtYhQwVGgsQzsnT/y71dtZduqZ0CVHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbeLTJd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732799AbeLTJ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF562177E;
        Thu, 20 Dec 2018 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298191;
        bh=CfmdXNZE+4AW1n35ThWHPFHIIE815csQt4iPTbaj/CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jyb0zW028t43tpiQb2ZpDyokdejy4VPSWk171wZ+cquzmjigBKvvglZGJ3BHb9+zg
         rVq82OFn2cFJKtXPehVXexXR79ItVDco+rgDLMTPN6GQm7/zLK5gzY4tWh16VbH7oG
         hC/7tUt6IPQiqbnuJoN1HkJi3n/MSOBtpa371TR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/67] drm/msm: dpu: Dont set legacy plane->crtc pointer
Date:   Thu, 20 Dec 2018 10:18:46 +0100
Message-Id: <20181220085904.894342094@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



