Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE10C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE88F20841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMwFTLzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE88F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeG1PCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:02:35 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35717 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeG1PCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:02:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so3509883plq.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4suSwIq81lCIKz+SBiyuRi6a+w/Rxe0DLRPHTiRBOgk=;
        b=nMwFTLzrrPqQsKbagFpb0GeNrMzQSE7baWKMI0P6T5k7qGOyXCyWZxB9kkhux05C74
         go4oI8PWxP5UG8BfhOUNmdc4gLd61wge4x8bBJBT4DD8TDXe+n0M2l/11dItzfyfJ6y9
         8KLykaynTz6bLS6tl+UVxSguYOnehgfm7iO7bD8ThAkZeCjLiqAe29lLE5YgjGcy9nv4
         XM+tJWayx1sB4jdZ/YSkdvNFEVeMULVAlDHtSDCPlNSLlAVddS3sXgb1do9TUwPvjgVv
         7gcX+EqZhGiHELtVACVgBkECh/r25Q1b6CsUNGgVi6ftECc5lI1ILQgczV90oo151jjA
         MyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4suSwIq81lCIKz+SBiyuRi6a+w/Rxe0DLRPHTiRBOgk=;
        b=qLlDe8L9X6hOby/HYUAmAgQ7iF/kuFM5hIkvoh6Au9R2rcKjKA1VH3HICAYc31e1Ca
         FVir/4XoDjwNnwhg7DBo3UZLthy2UoTxUR+1t4yLPPZ3JWzMvVLsLg5GfwtgvKuYWoZb
         cHFTI9CgXvbiYX2wFha++i59c242obZgPhtkAhyLZC7ueBGAYjfBFid1U7H1skrC4BfO
         WZG1zqazmg+TWjHjSGQRr5GfIz8NiUjLHo5G7KaATSvMBdhBTOxCQyUBZYIH9wJXhYVK
         8pVwWpzvfXBzisXHn2FUBBLlOiM2lfUo5kZ1dfSgU0HkkJ42kqXyJlBPYIAPFGXyN/d1
         /yLQ==
X-Gm-Message-State: AOUpUlFfnoCVYNpx0WgsZUDFV19jOBOc+g0PHOD1KdvLVEZru+bMzp1f
        ANKKRJ04kvG/jTW10zI8Mgnt7i/m
X-Google-Smtp-Source: AAOMgpf8OgXNMuHzzjWEliqxUDXF/NMRZ0sD9Xyc2oKdQon7H6jQtbgH/Q/n0Kepk8+FmXZmzX9cDQ==
X-Received: by 2002:a17:902:9348:: with SMTP id g8-v6mr9706991plp.302.1532784960740;
        Sat, 28 Jul 2018 06:36:00 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.16])
        by smtp.gmail.com with ESMTPSA id w81-v6sm14405755pfk.92.2018.07.28.06.35.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Jul 2018 06:35:59 -0700 (PDT)
Date:   Sat, 28 Jul 2018 19:08:45 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        matthias.bgg@gmail.com, ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180728133845.GA15261@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert drm_atomic_helper_suspend/resume() to use
drm_mode_config_helper_suspend/resume().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a2ca90f..1fcda2de 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -520,29 +520,24 @@ static int mtk_drm_sys_suspend(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm = private->drm;
+	int ret;
 
-	drm_kms_helper_poll_disable(drm);
-
-	private->suspend_state = drm_atomic_helper_suspend(drm);
-	if (IS_ERR(private->suspend_state)) {
-		drm_kms_helper_poll_enable(drm);
-		return PTR_ERR(private->suspend_state);
-	}
-
+	ret = drm_mode_config_helper_suspend(drm);
 	DRM_DEBUG_DRIVER("mtk_drm_sys_suspend\n");
-	return 0;
+
+	return ret;
 }
 
 static int mtk_drm_sys_resume(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm = private->drm;
+	int ret;
 
-	drm_atomic_helper_resume(drm, private->suspend_state);
-	drm_kms_helper_poll_enable(drm);
-
+	ret = drm_mode_config_helper_resume(drm);
 	DRM_DEBUG_DRIVER("mtk_drm_sys_resume\n");
-	return 0;
+
+	return ret;
 }
 #endif
 
-- 
1.9.1

