Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37918C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC16204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoyjaCk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC16204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJPAvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:51:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32912 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPAvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:51:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so22319473qte.0;
        Mon, 15 Oct 2018 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Aj3xniyMbaNesfeXCWFdtvlG8L63AvByL+zrSbdGlTU=;
        b=JoyjaCk7hyN9Oy7O/cuC6ZPMBfZpGHERa9h5Y3WGxEATMo3w665A5aeN8sy5ChHSU7
         dK0czBH3F1RkirZZspP/5m52KWd2c8KdNuWAV2L40xteaoLOMpKNCy15ULCDCmgcX4rX
         8D3fwNnbDv5TWl6VLxmym/ddNb4MjXQ05EPv+HMhsibELw/GdjQfezyCMovr7tVkh78f
         g9N0HeY2cFkO76mgw+/wEKvUQ2o0MB5oXFOj7pr/Pl/OzV0z2koWngULDwoSUdft4rco
         +tHrtDodDDMREhFUGjXyLJJDIxVVAdl8YKCyEEtF/kUzM3+43X7PRDLwoUlPdKHM3DRp
         jl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Aj3xniyMbaNesfeXCWFdtvlG8L63AvByL+zrSbdGlTU=;
        b=DYNq/usE4UUf2qMWwdfWTj5jhqrC9WaaRdpqiYIgwajw+lsQE3ta0G86h9QamWPelG
         Kj/P3UD6oaEkgZJgqx3ZpIMN+T9zqJbLi8NvmiOuyl0RtFfEwYRqFlae/ZKnyH8Itt4u
         8NCRQwjzlw5Gd+OLlQlt19J6QUDvTDs0uJRSlJ1hl6oHxUE30zR1xKKvwPj8dClMAcPE
         X8PPvLOXZQ7UrgbYAPU0lgB2Ip+4w/jYmsncYO82XvAAhd4WhaAaISpSKsGq7eH4qpAk
         qkyhHzHIC3W8cfAyaIKG4ekGY4s+PigGSNSXJRKAjRnhcUxKq6rTnkMr/zMnPmR98Ssf
         r8Nw==
X-Gm-Message-State: ABuFfojV1GEhgdoVkodEJwnBjC/NVumoC40N2/vLNGph3w1io0ABWYI/
        ccc2L9KUPSdhVp/Y7RuuK3w=
X-Google-Smtp-Source: ACcGV62ywlolgVpQs6dotBl+SAmJHbwzwRIvqwwtModOCbrF1jgXznIK0zLnY6NebNavCZtgGHZzwQ==
X-Received: by 2002:aed:26e4:: with SMTP id q91-v6mr16568373qtd.280.1539623133207;
        Mon, 15 Oct 2018 10:05:33 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s28-v6sm7219575qtc.92.2018.10.15.10.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 10:05:32 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:05:29 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
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

Change since V1:
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
