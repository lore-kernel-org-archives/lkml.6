Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E74021916
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691180;
	bh=qjkEd0R7IuLFs4bm2TXYBEjhSS1ckwJx6qRYyOhQ+Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBR1C1oSN1iY48BABKp56mEHXobtsy9lyxNuLub/EnxoB5gCrBW5BoPvvbWMAgPAY
	 VoPAFO9zg0oyKu2Wc0WopfTKD7Ct1i25SZD4JBq02PRKcVaYJJnMquMRczReIhEN0G
	 YTLwk3ZvmVEXK7fbT0lHVywDIrGRvI4nlijFFzkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfA1P7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbfA1P7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5B921848;
        Mon, 28 Jan 2019 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691176;
        bh=qjkEd0R7IuLFs4bm2TXYBEjhSS1ckwJx6qRYyOhQ+Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bk34DOeEfC1231s6SfelU6slhAKCX/hvj1KCbH0KKBNSR5T8hM6XM6T2wz0zBDyDt
         fNCSK8LLwid0rhJqK2PytbAm/40k4X1lELskXy+igwLLKcRYxHZbEtU1yIoVi0bGJ4
         7t1IkFJRhvY9l8VF3VIxCMtRTLDA1OjvX8pO0UWs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 003/258] drm/vgem: Fix vgem_init to get drm device available.
Date:   Mon, 28 Jan 2019 10:55:09 -0500
Message-Id: <20190128155924.51521-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepak Sharma <deepak.sharma@amd.com>

[ Upstream commit d5c04dff24870ef07ce6453a3f4e1ffd9cf88d27 ]

Modify vgem_init to take platform dev as parent in drm_dev_init.
This will make drm device available at "/sys/devices/platform/vgem"
in x86 chromebook.

v2: rebase, address checkpatch typo and line over 80 characters

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181023163550.15211-1-emil.l.velikov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 0e5620f76ee0..6887db878b38 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -471,31 +471,31 @@ static int __init vgem_init(void)
 	if (!vgem_device)
 		return -ENOMEM;
 
-	ret = drm_dev_init(&vgem_device->drm, &vgem_driver, NULL);
-	if (ret)
-		goto out_free;
-
 	vgem_device->platform =
 		platform_device_register_simple("vgem", -1, NULL, 0);
 	if (IS_ERR(vgem_device->platform)) {
 		ret = PTR_ERR(vgem_device->platform);
-		goto out_fini;
+		goto out_free;
 	}
 
 	dma_coerce_mask_and_coherent(&vgem_device->platform->dev,
 				     DMA_BIT_MASK(64));
+	ret = drm_dev_init(&vgem_device->drm, &vgem_driver,
+			   &vgem_device->platform->dev);
+	if (ret)
+		goto out_unregister;
 
 	/* Final step: expose the device/driver to userspace */
 	ret  = drm_dev_register(&vgem_device->drm, 0);
 	if (ret)
-		goto out_unregister;
+		goto out_fini;
 
 	return 0;
 
-out_unregister:
-	platform_device_unregister(vgem_device->platform);
 out_fini:
 	drm_dev_fini(&vgem_device->drm);
+out_unregister:
+	platform_device_unregister(vgem_device->platform);
 out_free:
 	kfree(vgem_device);
 	return ret;
-- 
2.19.1

