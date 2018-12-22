Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBEBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26D121939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMGoMFXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392738AbeLVT1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:27:19 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45117 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbeLVT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:27:19 -0500
Received: by mail-io1-f65.google.com with SMTP id p7so3186520iog.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 11:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPTzuq2SmsgI0TyOi5Xd0ry0MyhbhpYqnj0R4kWWcY4=;
        b=XMGoMFXBzuAC3xHFEntnzfq+0EfIOsEXYpRjC/jq9S224OjEvboODJ1blNdYOYTu/d
         wzM+ifAHkL2ffPnzkynmLNvZdRcAnSfK/cVcN8xAH+s8A1ZyaB3MEn4+iH8eskhcOfE7
         ZXRaJN+75vYnoax5+G4tvx+mUHyFV23FpJiyZmdly4a6zIsBDfgzkMDdzZdsb+pU/GDt
         ZTyZKrLK7jBheCGsQN2gxT2MUMd+/Lf8J9VzUWp/wHRIE7oEL2xuV8M5zsc1nCoNL4w4
         xShl2qllUWKECwFF0aoxlgDWxE+ZMVuLT7UMmgZtEy1cvq3Sj+kRlqUFt9hot+Usz3rr
         ldig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPTzuq2SmsgI0TyOi5Xd0ry0MyhbhpYqnj0R4kWWcY4=;
        b=JX4QpB3AfldlHXaQCWov2qdd/lwk1rc1WduHN3ZobcmGAfQocBhRFyKxSpu4LdF6SX
         2B07Eg1QfUZSs2o/XCZ4mJvo+dx+YTqTOcby6m9kWP5yE9LdwEYS1IS7Xub7WAGjrpBl
         em4kLw/MZfJHewU/B1Qiel6FVVpHeJ/S2rFkpwUZUSzy0PBM2JmtTOszRo2AIvc4GhRc
         xFk5//vNVNbAYxo/NG3GIQcyVGl/7CwZN/ukasgnF5/oQMiSpOoqiwq0F1vv8bMq7W2H
         qo9YKzPwHyKXNY/ysbOhGkl2WYRrOmEQM2Aute95aPCpctare4FdQFyefPHptUHpnmhe
         3+HA==
X-Gm-Message-State: AJcUukefKL2a9Hq8nR9Zv8OyMZuZyIgwCnYzOf77r6tMKxMdSwysa65S
        Wn4UaRmV8XzYp80APtvt8xBCjw==
X-Google-Smtp-Source: ALg8bN4+6fnifNIvIshPWxwszkjief4rv+Dqp+bdyYC0TlNFe+FWm6uWiyi2cLD5nmHGOs/Jye4SRg==
X-Received: by 2002:a6b:1411:: with SMTP id 17mr5159065iou.252.1545506838135;
        Sat, 22 Dec 2018 11:27:18 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id y23sm10377045ita.1.2018.12.22.11.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 11:27:17 -0800 (PST)
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
Subject: [PATCH v3 1/2] drm/amd: validate user pitch alignment
Date:   Sat, 22 Dec 2018 12:27:11 -0700
Message-Id: <20181222192712.9420-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181221194739.25523-1-yuzhao@google.com>
References: <20181221194739.25523-1-yuzhao@google.com>
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

For GPU that does frame buffer compression, DMA writing out of bound
memory will cause memory corruption.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f9..883a4df2386d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,15 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = amdgpu_align_pitch(adev, mode_cmd->pitches[0], cpp, false);
+
+	if (mode_cmd->pitches[0] != pitch) {
+		DRM_DEBUG_KMS("Invalid pitch: expecting %d but got %d\n",
+			      pitch, mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-- 
2.20.1.415.g653613c723-goog

