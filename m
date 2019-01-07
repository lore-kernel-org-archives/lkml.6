Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7420AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4155D2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czl8uvc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfAGWvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:51:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55664 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfAGWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:51:40 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so3626154ith.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36E0YpcuxArMLpTNXVlBWwcRhGrfa+Ls3LkD2uNNl6k=;
        b=czl8uvc/mplYSvnlubSdM8TZW2m430opGUpW7MHRGdYl1JAQvEjaa7ZIJwyrduqvIR
         D8GJXVcw9T885YM84oM8t1AH1xBuOY3MGXsm0xe+mOPmeG+ta41TNcr05WE052bZOeql
         TZmdM0HvabVvee1UwEuINQR5XJWzXQymNmTs/LupWSzsKweFTSCASWYYj1G8A9w+EtEq
         2dP8lZEOl4XVnn1mTz9lD3bUK4S++lVQit3LyZkCD9jlsLynJwkCT/Mzh35Gk6dp2/a4
         z8KV0GOeSMlUHcYZLXNXZsqzeVspdyEdGUuCeu4A7TLzLyfojC2sR+eDUNUIs81kPsYj
         xvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36E0YpcuxArMLpTNXVlBWwcRhGrfa+Ls3LkD2uNNl6k=;
        b=E0tJWR0jgbamMr4SQYE++XxvnvluwRHHIOl+ikMUHnl42k9kRLTc8YbDJwFq/qTty6
         j2X2T0RDFSGtnS6XeOVEUEV4SyuqaW3vNC5d7GlTo4ga0Iy2hFF4Z9O4tJd3s9LoR0nT
         zzxdy8hHLWSOiCMu6z8rfc/PtdGjj5Foz0i8P76aZ053AoMDKS5WVwo3wXh5/kL62nLM
         GJQp646U070CSwk1gbDR7YRi2uYKfFToFktGC1Q9XL6WkioIp6g1Z+aAuXzPDn6QbPqy
         qjDLLZnYVa73NCXHxVHzNlpw7qsbKdKtG3cA1o8HEFy/zhMckRgyprrZ6MwjTtOgnU7k
         9Yzg==
X-Gm-Message-State: AJcUukcJtyOEWBPGxMcPyKTHOqNXsWZ/G+MgMFqM2cWCuKLoRPD3vbSD
        R6Ee/eiz61lBjquh/UA1FU1KJw==
X-Google-Smtp-Source: ALg8bN7M+Ryf0XPGhni4FJPDQyMZ+SFDLueYPxSMEGtbncyOq/kDkPP2u41r99Foo28OutNMdY96Jw==
X-Received: by 2002:a24:ba0b:: with SMTP id p11mr8443236itf.113.1546901499505;
        Mon, 07 Jan 2019 14:51:39 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id t10sm28512412ioi.4.2019.01.07.14.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:51:39 -0800 (PST)
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
Subject: [PATCH v6 1/2] drm/amd: validate user pitch alignment
Date:   Mon,  7 Jan 2019 15:51:14 -0700
Message-Id: <20190107225115.163992-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20181230010021.196990-1-yuzhao@google.com>
References: <20181230010021.196990-1-yuzhao@google.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 15ce7e681d67..de9f198d5371 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,16 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = mode_cmd->pitches[0] / cpp;
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
2.20.1.97.g81188d93c3-goog

