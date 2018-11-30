Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50A5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5021473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOxD11dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C5021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeLACKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:10:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37904 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:10:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so3314698qkg.5;
        Fri, 30 Nov 2018 07:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luJtdTOq5YyKAq6WN9mVXmmzV+2w+uytn39snmmCeq4=;
        b=rOxD11dJSwxdPrbPrDFwoz9kvqheZYnQQWo7Bk2ENG00kZEKEmKWVTGOupE9yXs4cR
         UH/kIQdYuG69763+aJ7wxcXgT3UC5XMg7w4zv0/3TJ/i2dhbLEGcetL85AI2OTa5DPU3
         0Sky8uvq1uTyJSbbjciIWJJYOUe6w6L8o5Q9nZ/bNKYPRi3d1/W0KXqbxloXaFnuK0at
         skMydhPCzK7laKkQ4Z0hjqElLzmHFw+lcbLZWQkANeO9ekFTxmA3PgGNq3La3KHWVgkF
         +1JpDA7gMCUaQqqONJrj6LfpH0nWLf4TjRHrs7tonoz8KcUxICvfp5EJFW8Yoo7bx72d
         px9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luJtdTOq5YyKAq6WN9mVXmmzV+2w+uytn39snmmCeq4=;
        b=fEr5lJ/lAAYELC2+go+scUnoSoD2rzFhWecSZLFNqEIMCZ3bhozM4DhBaZd4N7wtTr
         bqTaCS0qb1ZQQfIGF3ZXYHTEKmi1duAJbJecC3sq5Wn0HMfR6elwwtakoEGXfKWtD/yW
         7bH7rUXtcykRHHSopLrwWHo0eHhzSMAEl8YUBfEl9wdFcYLPFmeXqKab6Sy8FvBRcdo3
         3206014OlvHB7a9wR2tAU1kuR0H1NwIhX4/wTA0o7Xq8NH8lC3AbpvbTvMsqPzfUjHYy
         tbisXRCvHKl+09Dck18H06Yjmqvk7vlmMBzpDfM/9m5mnY0oQtaYq6Gu9b+u84ysdV0Z
         9pVA==
X-Gm-Message-State: AA+aEWZJil1cSFZT8oOpguNC8xnk7tsmzc2FQVgL3HGkRK6heF3fxEu/
        WfE1JdzECRlEeFXWKehXn8s=
X-Google-Smtp-Source: AFSGD/WSve9AcaU/LS2rxVkDSOPUuMmvKLpx1KtVOvrrSnPOlz1ZN/SSVjGB/+BVVe8ifvvAqnRLUg==
X-Received: by 2002:a37:2808:: with SMTP id o8mr5430825qkh.14.1543590067701;
        Fri, 30 Nov 2018 07:01:07 -0800 (PST)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id 46sm3629818qtv.22.2018.11.30.07.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:01:06 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/msm: add uapi to get/set debug name
Date:   Fri, 30 Nov 2018 10:00:41 -0500
Message-Id: <20181130150050.13762-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130150050.13762-1-robdclark@gmail.com>
References: <20181130150050.13762-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UAPI to get/set GEM objects' debug name.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 36 ++++++++++++++++++++++++++++++++++-
 include/uapi/drm/msm_drm.h    |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 913f5b3642b5..6ebbd5010722 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -23,6 +23,7 @@
 #include "msm_drv.h"
 #include "msm_debugfs.h"
 #include "msm_fence.h"
+#include "msm_gem.h"
 #include "msm_gpu.h"
 #include "msm_kms.h"
 
@@ -861,7 +862,8 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 {
 	struct drm_msm_gem_info *args = data;
 	struct drm_gem_object *obj;
-	int ret = 0;
+	struct msm_gem_object *msm_obj;
+	int i, ret = 0;
 
 	switch (args->info) {
 	case MSM_INFO_GET_OFFSET:
@@ -870,6 +872,9 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		if (args->len)
 			return -EINVAL;
 		break;
+	case MSM_INFO_SET_NAME:
+	case MSM_INFO_GET_NAME:
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -878,6 +883,8 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	if (!obj)
 		return -ENOENT;
 
+	msm_obj = to_msm_bo(obj);
+
 	switch (args->info) {
 	case MSM_INFO_GET_OFFSET:
 		args->value = msm_gem_mmap_offset(obj);
@@ -885,6 +892,33 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	case MSM_INFO_GET_IOVA:
 		ret = msm_ioctl_gem_info_iova(dev, obj, &args->value);
 		break;
+	case MSM_INFO_SET_NAME:
+		/* length check should leave room for terminating null: */
+		if (args->len >= sizeof(msm_obj->name)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = copy_from_user(msm_obj->name,
+			u64_to_user_ptr(args->value), args->len);
+		msm_obj->name[args->len] = '\0';
+		for (i = 0; i < args->len; i++) {
+			if (!isprint(msm_obj->name[i])) {
+				msm_obj->name[i] = '\0';
+				break;
+			}
+		}
+		break;
+	case MSM_INFO_GET_NAME:
+		if (args->value && (args->len < strlen(msm_obj->name))) {
+			ret = -EINVAL;
+			break;
+		}
+		args->len = strlen(msm_obj->name);
+		if (args->value) {
+			ret = copy_to_user(u64_to_user_ptr(args->value),
+					msm_obj->name, args->len);
+		}
+		break;
 	}
 
 	drm_gem_object_put_unlocked(obj);
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index bc1757848c7c..09f16fd7beda 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -114,6 +114,8 @@ struct drm_msm_gem_new {
  */
 #define MSM_INFO_GET_OFFSET	0x00   /* get mmap() offset, returned by value */
 #define MSM_INFO_GET_IOVA	0x01   /* get iova, returned by value */
+#define MSM_INFO_SET_NAME	0x02   /* set the debug name (by pointer) */
+#define MSM_INFO_GET_NAME	0x03   /* get debug name, returned by pointer */
 
 struct drm_msm_gem_info {
 	__u32 handle;         /* in */
-- 
2.19.2

