Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C297C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382B20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmUVi7uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1382B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLACKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:10:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32997 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:10:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id o89so3324743qko.0;
        Fri, 30 Nov 2018 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIIynXA0FFPSVLn3lu7FimIsuF4uLklcho7eShOE9ec=;
        b=TmUVi7uoMHE9+7zm1nah476S3HFnI3K0xa5lzAn5l9s/42bf6aUXQ44r4UAvTM58YN
         UdEeMkeWy2rBNurRdeAiOXIWh3vTc8WAvSQ5cz37L3Oobktzv/W7CO7DKvoC0o+fTB7S
         WY9/w9SQ+MzczIoZQdzQ6v3ryiX/k/+ikKeoSWo6BeGzwpKOWAvIQM4IXXfcLzsH5lQF
         srXBIFdg69x4z1ztnSsvNYaqwA1NvLMyiQgyJ6uMIpNp9JJo0q+zChR2BNnhviKZpcpS
         gaMcVi12qsNiA1KzJdyzzYd3hmyfoZMiiLkDkUw4zgJj+eneGO6O7ZwokGemKnnGiChW
         QQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIIynXA0FFPSVLn3lu7FimIsuF4uLklcho7eShOE9ec=;
        b=nhKmJej1JFvwmtiEmh+N8t67D/5Q9gcmJa5HN0lUJ7LsT0WEUlfMgIgmHVC41wYLb7
         iNLK51r2WhuGjqS/juFfHQajixVRFGST14u3lw/CbpzvH8SmQx04uqgDCGNf0HiQoZJB
         8QfxWXg4ISur4W5Osoo/kE3Xp66nXm4wUqnmb15DryqwF0U9XWZPNO8uDU9VKPNyiMQ+
         I5BYzKsMz0y82T9cw9chXdSVGhasKDLMXMCGdxn/J3mqo0SwKcBG3bobCheEr7AeF9Fi
         Th8Sv4sXg+4rxgmo8+u0Xvsj5DStVYGhE86ueb5ncfPzwD+A23PoIsmVV5cWqORyd4V7
         /Mag==
X-Gm-Message-State: AA+aEWbysSzyC/Z4D9OouGaphxAJxQWko/TlWI9MLTlrMsD2XGGtIjEi
        HVynS3vJBgVc8u4HChmy6jo=
X-Google-Smtp-Source: AFSGD/VBclVMflf2PkhIstqjDgtpeWySWWZjjSUuJsaYqjszs6R9mPuxycA1WNmZR5V4Vo/iAaGdVw==
X-Received: by 2002:a37:8d81:: with SMTP id p123mr5425667qkd.241.1543590064496;
        Fri, 30 Nov 2018 07:01:04 -0800 (PST)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id k22sm2417808qtm.73.2018.11.30.07.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:01:03 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/msm: rework GEM_INFO ioctl
Date:   Fri, 30 Nov 2018 10:00:40 -0500
Message-Id: <20181130150050.13762-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130150050.13762-1-robdclark@gmail.com>
References: <20181130150050.13762-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prep work to add a way to get/set the GEM objects debug name.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 25 ++++++++++++++++---------
 include/uapi/drm/msm_drm.h    | 17 ++++++++++++-----
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9f823bf8d312..913f5b3642b5 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -863,21 +863,28 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	struct drm_gem_object *obj;
 	int ret = 0;
 
-	if (args->flags & ~MSM_INFO_FLAGS)
+	switch (args->info) {
+	case MSM_INFO_GET_OFFSET:
+	case MSM_INFO_GET_IOVA:
+		/* value returned as immediate, not pointer, so len==0: */
+		if (args->len)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	obj = drm_gem_object_lookup(file, args->handle);
 	if (!obj)
 		return -ENOENT;
 
-	if (args->flags & MSM_INFO_IOVA) {
-		uint64_t iova;
-
-		ret = msm_ioctl_gem_info_iova(dev, obj, &iova);
-		if (!ret)
-			args->offset = iova;
-	} else {
-		args->offset = msm_gem_mmap_offset(obj);
+	switch (args->info) {
+	case MSM_INFO_GET_OFFSET:
+		args->value = msm_gem_mmap_offset(obj);
+		break;
+	case MSM_INFO_GET_IOVA:
+		ret = msm_ioctl_gem_info_iova(dev, obj, &args->value);
+		break;
 	}
 
 	drm_gem_object_put_unlocked(obj);
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 3c3af92c4b3e..bc1757848c7c 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -105,14 +105,21 @@ struct drm_msm_gem_new {
 	__u32 handle;         /* out */
 };
 
-#define MSM_INFO_IOVA	0x01
-
-#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
+/* Get or set GEM buffer info.  The requested value can be passed
+ * directly in 'value', or for data larger than 64b 'value' is a
+ * pointer to userspace buffer, with 'len' specifying the number of
+ * bytes copied into that buffer.  For info returned by pointer,
+ * calling the GEM_INFO ioctl with null 'value' will return the
+ * required buffer size in 'len'
+ */
+#define MSM_INFO_GET_OFFSET	0x00   /* get mmap() offset, returned by value */
+#define MSM_INFO_GET_IOVA	0x01   /* get iova, returned by value */
 
 struct drm_msm_gem_info {
 	__u32 handle;         /* in */
-	__u32 flags;	      /* in - combination of MSM_INFO_* flags */
-	__u64 offset;         /* out, mmap() offset or iova */
+	__u32 info;           /* in - one of MSM_INFO_* */
+	__u64 value;          /* in or out */
+	__u32 len;            /* in or out */
 };
 
 #define MSM_PREP_READ        0x01
-- 
2.19.2

