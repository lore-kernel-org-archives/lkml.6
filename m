Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA5AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 01:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AB120866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 01:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpZGIIhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeL3BAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 20:00:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33294 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeL3BAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 20:00:36 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so19359505ioi.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 17:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYyHjZKks8NxW3IqSGX1v4DpLfWxsLc2mCd8rXyZl+o=;
        b=RpZGIIhjijfq9G/QPMLHlM+wJTn+uEAuHc7aNeXcTJPBY+oi87LAapJJcObVg1hbeS
         lcnqXoWJP4p6A1fzMeMIdQUCkrRk+5GRiIo94aD4c0b7yK+Md2M6IVIA89V0vzt4X3++
         +rgLZBg0ycGCg7ficRCSzbWSw8gt3FMGYe26X31f5Q0X4O4QQ7ILYC45SoL6RN/LSRKJ
         lennLxYbmBezHTIeA5WTFhSEFeOjIYnt4pOy+dRGmmaLKTWj/Urh3oqT38ov0Lfq5IOA
         IXhDYVrMRY8tF7GiJIAXe845UHdOdmhFE+P2DM5jdelOW/52VXSCX3+yOmHHiGnHjjri
         oKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYyHjZKks8NxW3IqSGX1v4DpLfWxsLc2mCd8rXyZl+o=;
        b=VxMFS3QJFak11hR0duHae7obihgajtKVWhD+Taq0ln8/fsHVZS7SPoUHUBLFzyWj8J
         Ps5B2fR+Sq19gSGUDGQnaFlvo3b5fld/TxKSD2KoRsjIojVaVjNshI/G6tK8+5B+OdAH
         ez0u+LlHYskA1RnxObKNeS9jEFWcvZGJDrLZfNZ3pk845F8OnDHFtwpgCbBho/4LaIjk
         4ZTdlLGaIfggTQGjg0pCJDqc4HkwkGO1wF0WbRAt8MCx/XcAVKW4NoaMwVCZyJSBO65t
         8lmrtPzU3AEJAtZhf1Fobeaf0Ll+yLloCgWgD+se5vWYu9lyY8je9r+2yo01Xzvm+Ggv
         FaHA==
X-Gm-Message-State: AJcUukdKPLIVRpo7rHNiW8PN26GjxSS9Xv2a6x3ZyWdHk0n7WXKZ76cE
        oDqAL+UZ74Vc6UPmu3CnwoEjCw==
X-Google-Smtp-Source: ALg8bN4JDJvP7yOSF6e5blZiDq4FN4In8SjuXWxfsdMwiM/Y6MCoECaupm6dyASraSf/vEeM6DGXuA==
X-Received: by 2002:a6b:dc18:: with SMTP id s24mr21580746ioc.139.1546131634874;
        Sat, 29 Dec 2018 17:00:34 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id o6sm5039048iom.74.2018.12.29.17.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 17:00:33 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 1/2] drm/amd: validate user pitch alignment
Date:   Sat, 29 Dec 2018 18:00:20 -0700
Message-Id: <20181230010021.196990-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181223215239.173339-2-yuzhao@google.com>
References: <20181223215239.173339-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace may request pitch alignment that is not supported by GPU.
Some requests 32, but GPU ignores it and uses default 64 when cpp is
4. If GEM object is allocated based on the smaller alignment, GPU
DMA will go out of bound.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 15ce7e681d67..16af80ccd0a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,22 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = mode_cmd->pitches[0] / cpp;
+
+	if (pitch < mode_cmd->width) {
+		DRM_DEBUG_KMS("Expecting pitch(%d)/cpp(%d) >= width(%d)\n",
+			      mode_cmd->pitches[0], cpp, mode_cmd->width);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pitch = amdgpu_align_pitch(adev, pitch, cpp, false);
+	if (mode_cmd->pitches[0] != pitch) {
+		DRM_DEBUG_KMS("Invalid pitch: expecting %d but got %d\n",
+			      pitch, mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-- 
2.20.1.415.g653613c723-goog

