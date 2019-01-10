Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C96C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E67214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhccrWiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfAJOOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:14:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42113 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfAJOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:14:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so8375081lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G3EXLib4pk9BOkcP0QKT2IxPQGjWHTI4hPiULav+BkM=;
        b=BhccrWivKE51+P1IgXEKGy4lltmX6UeZllCsxqGBOFucWbiuSnnZdmSdoS+Ro5qNXa
         TUDylUCuW4kBOq6aXYdfLbPgojff9io6Ka2gCYidLpnYBeyWrB7AvR+EskFoksMKXtOK
         4T7UvDAfbb9ym4mm/2o1VvdSxbJGdlFZDlO1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G3EXLib4pk9BOkcP0QKT2IxPQGjWHTI4hPiULav+BkM=;
        b=ML9YKBEE0jWduThAb2NqcK6rAd9WvOh8b+ZobO1A8NwnJrX8dnillPL5dgoIdRKNHX
         2/bkH2cQlTK2ywXtY/xROr/j2yX9jph19I8NZel10nl74T6d7HFE3R5Exz5zUXwRlooy
         62eX7vkqdVJHY7fFvZAFPOoVZ1t8RZSCd64/jgyZm0Ip/tZivm+iNqGK4TbQMWAWUet4
         8o96NeAp3OXBhW6gKQ49u9EY/7s/LbsXadPh5cli4gbmvBtBk75TOlZo2xcta548/Q9O
         w6GcdmDpzaxb4zhcwXUl7F0CQ6nBqJplUiqs3emysBm9K61JNIlAhM6kORGsR5V6WhH7
         2AlQ==
X-Gm-Message-State: AJcUukek5eNoKiOQ242dPrS2WmXpDYzdfXZbq01EH6mN/PwtpgKdEWOm
        OG1mdmmYVbCHQBKsLrY8LFv8cw==
X-Google-Smtp-Source: ALg8bN5tUlcSjZzYH5lccOXXvV4wiY7jgHG9NHpMfizhy3JFE5fVYCS3vzZ3e5liMVDyUYckZz+jvw==
X-Received: by 2002:a19:c801:: with SMTP id y1mr5657180lff.53.1547129657871;
        Thu, 10 Jan 2019 06:14:17 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id l63sm14410367lfl.76.2019.01.10.06.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:14:17 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     robdclark@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drm/msm: avoid unused function warning
Date:   Thu, 10 Jan 2019 15:14:03 +0100
Message-Id: <20190110141403.20295-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:368:13: error: 'dpu_plane_danger_signal_ctrl' defined but not used [-Werror=unused-function]

Fixes: 7b2e7adea732 ("drm/msm/dpu: Make dpu_plane_danger_signal_ctrl void")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index fd75870eb17f..6aefcd6db46b 100644
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
@@ -1248,6 +1235,19 @@ static void dpu_plane_reset(struct drm_plane *plane)
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
2.19.2

