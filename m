Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78455C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F08222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196656;
	bh=taHRrWg463N4CcT0ZVY0mg81gGQl/3TpkBfJW4XrlFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KGSMtH9tizZM9cDphmQzDjTEb6+3hgj9veZLS1QivHmTtQ5RZoqj1zIIM/CXwQGEa
	 e1t2R0OkH66sQqhQ24v5Qb9USRQUlpaVnSfJcWRJ50WNPSL8ou3U8K7y0755FRfw57
	 iShvcbEX3KPLaaxoDG/nv0ZUd+G7vtEtpWNyzt70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfBOCKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731924AbfBOCKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8B821B68;
        Fri, 15 Feb 2019 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196650;
        bh=taHRrWg463N4CcT0ZVY0mg81gGQl/3TpkBfJW4XrlFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lFH/P+cw2ZtAx3SnBRe27qu+CsTYnetYRdxsu4TIQuuPMiEyat8LwOlvHEl5RKd7
         N2YaFVjlV7yf0Uvxx8C4bMe/H5m9zGa52KP3bMF8azXS2w8eonZ4aGBVLgFt2YPQ+W
         HXEIWTW60wNRXFqJIw1JsS8iM1PujkY5oxewMbPo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 64/77] drm/msm: avoid unused function warning
Date:   Thu, 14 Feb 2019 21:08:42 -0500
Message-Id: <20190215020855.176727-64-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a840f690d3c6f2f27425ca7e7bd2d635cdec07d7 ]

drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:368:13: error: 'dpu_plane_danger_signal_ctrl' defined but not used [-Werror=unused-function]

Fixes: 7b2e7adea732 ("drm/msm/dpu: Make dpu_plane_danger_signal_ctrl void")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index f549daf30fe6..1d155a7cb08c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -365,19 +365,6 @@ static void _dpu_plane_set_qos_ctrl(struct drm_plane *plane,
 			&pdpu->pipe_qos_cfg);
 }
 
-static void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
-{
-	struct dpu_plane *pdpu = to_dpu_plane(plane);
-	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
-
-	if (!pdpu->is_rt_pipe)
-		return;
-
-	pm_runtime_get_sync(&dpu_kms->pdev->dev);
-	_dpu_plane_set_qos_ctrl(plane, enable, DPU_PLANE_QOS_PANIC_CTRL);
-	pm_runtime_put_sync(&dpu_kms->pdev->dev);
-}
-
 /**
  * _dpu_plane_set_ot_limit - set OT limit for the given plane
  * @plane:		Pointer to drm plane
@@ -1271,6 +1258,19 @@ static void dpu_plane_reset(struct drm_plane *plane)
 }
 
 #ifdef CONFIG_DEBUG_FS
+static void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
+{
+	struct dpu_plane *pdpu = to_dpu_plane(plane);
+	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
+
+	if (!pdpu->is_rt_pipe)
+		return;
+
+	pm_runtime_get_sync(&dpu_kms->pdev->dev);
+	_dpu_plane_set_qos_ctrl(plane, enable, DPU_PLANE_QOS_PANIC_CTRL);
+	pm_runtime_put_sync(&dpu_kms->pdev->dev);
+}
+
 static ssize_t _dpu_plane_danger_read(struct file *file,
 			char __user *buff, size_t count, loff_t *ppos)
 {
-- 
2.19.1

