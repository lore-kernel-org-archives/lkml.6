Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37EBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320B2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnKuEr99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfAGWvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:51:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39678 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfAGWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:51:41 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so3507048itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkKf9i6TdcB9R0RaIer+SvvdNV+GxmYU8yKh13/uJ4Q=;
        b=nnKuEr99zTNxggVtXQ5HDzZv5Zd3V0C1NvD5UACvZ40O/z7ZevRSsYcForgsqHLhee
         c7Z0ggU9Xb0JHwMtbBQmCivO4+a5CO8alUAUMbNWGMapop+OtF0aHx+kbCmWNO26ncbp
         uqgu+Qjw1pDlcRtlhJxblNaXRNHUEim/wUffFn6BOnNVChJrlZJr/RwSVH+CTt/Dv6ET
         pX3JNJke1lLqEHeGg+UykjhnjMh2g1Zo/Kkl7V1P4Wsmsg38qHSY+3V5Yxs7G2fgumt6
         iU9zOPcoyssc1+fOB6F1JpoXdoZcIrcSnwrsS4rgmeLlYwIdCzcGKNbv4GAxLFwcA/oF
         rCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkKf9i6TdcB9R0RaIer+SvvdNV+GxmYU8yKh13/uJ4Q=;
        b=jdnmduZekygNXOHJvVypdVm9gWVsIiOA8ZtJamSJpiTx5z6fwVIS6hdOVn8Ktbb4wN
         xfT7FVtzWiqQSngs+dwY4utpajk8V2QzfwlbA9tbsPh+4IZRMsDdk4NfCAVl/3jQ5ThQ
         YdZ2OiS3uFUWPcaeGvwVt+3toevawuWox6dCDnEmYgald2xLjE+eGlhM5LKB9mo5vJ3a
         SbvQqmn02J92dA1zQw+1mdRiS836PBJ6Nq3hVERvjRwepbh9TVFJsxbYbxzuM1GWV1ng
         kNNYuoM0d07CC5RglCCYma45ZLelFvSEI38bafQXA0UBbgEHXtC3wZEUzJ5KZLuguSvc
         QZTw==
X-Gm-Message-State: AA+aEWYXsGCc/5tStoqrETXUiZy90D/Gb4wUPr6eMzcNefSTtClyUvI5
        mvPMpm5J0wZIapnnjtLKSgQJkg==
X-Google-Smtp-Source: AFSGD/VT9u2MLhWDjGJlPg54ysZuFtypvE0iAwbw45jbOYxbpQbLxWIZHLVddkkDefN7q5HHU8bg/w==
X-Received: by 2002:a02:9f96:: with SMTP id a22mr44857755jam.7.1546901500763;
        Mon, 07 Jan 2019 14:51:40 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id t10sm28512412ioi.4.2019.01.07.14.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:51:40 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        stable@vger.kernel.org
Subject: [PATCH v6 2/2] drm/amd: validate user GEM object size
Date:   Mon,  7 Jan 2019 15:51:15 -0700
Message-Id: <20190107225115.163992-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190107225115.163992-1-yuzhao@google.com>
References: <20181230010021.196990-1-yuzhao@google.com>
 <20190107225115.163992-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating frame buffer, userspace may request to attach to a
previously allocated GEM object that is smaller than what GPU
requires. Validation must be done to prevent out-of-bound DMA,
otherwise it could be exploited to reveal sensitive data.

This fix is not done in a common code path because individual
driver might have different requirement.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index de9f198d5371..32b7648b7ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	int height;
 	struct amdgpu_device *adev = dev->dev_private;
 	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
 	int pitch = mode_cmd->pitches[0] / cpp;
@@ -551,6 +552,13 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	height = ALIGN(mode_cmd->height, 8);
+	if (obj->size < pitch * height) {
+		DRM_DEBUG_KMS("Invalid GEM size: expecting >= %d but got %zu\n",
+			      pitch * height, obj->size);
+		return ERR_PTR(-EINVAL);
+	}
+
 	amdgpu_fb = kzalloc(sizeof(*amdgpu_fb), GFP_KERNEL);
 	if (amdgpu_fb == NULL) {
 		drm_gem_object_put_unlocked(obj);
-- 
2.20.1.97.g81188d93c3-goog

