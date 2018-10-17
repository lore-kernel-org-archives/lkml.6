Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5999ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9574E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCR5j+kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9574E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJRGm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:42:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45860 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRGm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:42:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id m8-v6so17606025qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=q2d2+eto/UT1viycFSpXhEOFe0u6zGB2ruedvOuZknY=;
        b=HCR5j+kMQvXCVk4NSvOvda/hW2fJaDzJeE4GNvYwrlcCtxHYsSBDqC62yADvkypyJQ
         52GrlqzNsQCwX4hVZq7PaUZkUKp8ZzPm/KL1qbL4d8LRSBAFR/yyVxNJmpe0idy0Qm3C
         AIMOtZWBqniohu2mfHBr0xWO4dxiM8FFDQ9+GqwKsZrPxCQp/Dfe1tQJhS5RKhLwPg2R
         6lKF8ZGLq+ReQ+w0RF1AUr6HzSpimB3hUejnPmvs7DnNtsV09vYejXXqBMtROwAA3Fvo
         ZTp4QJwAIyq1YxxAsy8olEjS+kX7ipNjyigt3ndWdADTybQJNg7EPywbhiV6gdizuu3M
         EMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=q2d2+eto/UT1viycFSpXhEOFe0u6zGB2ruedvOuZknY=;
        b=BUaeTNQCXAXpPQyeh3p+a/jMrae/wKRRwYWuEHe4SqjfuTbqAhrmeSwnGimqAQpPfG
         lRGHe+KisTVdnDG/2QmmJz7oLRgZ5eMmsN5ivWGyQFLeshcqWcCOLmc6OjEOyiM1NnD3
         YZDRcnW4Ng7G+Nq8Xf0n4U5MzZDcR0legzwDdCVgX8IL8FBFvjAVjbZ1thFeLmoNyhgZ
         IYzbfNWXcnMtYiuoAITcliCVnJSdgGi9M98zicM8E82EuUh9G56YI639cfnzFsntM2vM
         ncr6FVnbg4uGuRrYK537qs9G1Tpz1qIs8ghuf2m2PIlKVLA5vFx87gjWbnOKvTNbTm93
         bJyQ==
X-Gm-Message-State: ABuFfojFJYJkvJxlQqTMeIUHji0QLYy7U6fDDir98f1Wo07GRRo+Wag2
        DRH3wSENiuoKhyqu2sxWK6g=
X-Google-Smtp-Source: ACcGV62kFqiZiDhquOEXE6KJ0KrWXB9Pl2cmjC3TXyY3BlZEiPhPiCII7z490lMRHRBJIafGtY/3kA==
X-Received: by 2002:ae9:c21a:: with SMTP id j26-v6mr25846519qkg.52.1539816275880;
        Wed, 17 Oct 2018 15:44:35 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 128-v6sm10067075qko.7.2018.10.17.15.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 15:44:35 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:44:31 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: [FOR CI] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181017224431.hctq3crhxculykvu@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For historical reason, the function drm_wait_vblank_ioctl always return
-EINVAL if something gets wrong. This scenario limits the flexibility
for the userspace make detailed verification of the problem and take
some action. In particular, the validation of “if (!dev->irq_enabled)”
in the drm_wait_vblank_ioctl is responsible for checking if the driver
support vblank or not. If the driver does not support VBlank, the
function drm_wait_vblank_ioctl returns EINVAL which does not represent
the real issue; this patch changes this behavior by return EOPNOTSUPP.
Additionally, some operations are unsupported by this function, and
returns EINVAL; this patch also changes the return value to EOPNOTSUPP
in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
libdrm, which is used by many compositors; because of this, it is
important to check if this change breaks any compositor. In this sense,
the following projects were examined:

* Drm-hwcomposer
* Kwin
* Sway
* Wlroots
* Wayland-core
* Weston
* Xorg (67 different drivers)

For each repository the verification happened in three steps:

* Update the main branch
* Look for any occurrence "drmWaitVBlank" with the command:
  git grep -n "drmWaitVBlank"
* Look in the git history of the project with the command:
  git log -SdrmWaitVBlank

Finally, none of the above projects validate the use of EINVAL which
make safe, at least for these projects, to change the return values.

Change since V2:
 Daniel Vetter and Chris Wilson
 - Replace ENOTTY by EOPNOTSUPP
 - Return EINVAL if the parameters are wrong

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 98e091175921..80f5a3bb427e 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 	unsigned int flags, pipe, high_pipe;
 
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (vblwait->request.type &
 	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
-- 
2.19.1

