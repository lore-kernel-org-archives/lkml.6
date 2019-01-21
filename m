Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA81C37123
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409DB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7q7YrH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAUU7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:59:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40325 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfAUU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:59:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so25065419qtf.7;
        Mon, 21 Jan 2019 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H/O+b8GHgbKyVwOKnVjreanleL+qjiqt6qZj2WCDncU=;
        b=n7q7YrH9x0qsPNT1MFJaTcBzyEc3BlKAAJm5hoFIHsdxrPCh6XD+w63HS0xYsnVMTh
         qF+7wUHUMK9njy26cD3vYazHc0dl0c2NuO0ZtF3tktbf+uY7OAUAUxQgTe2gRzpGHn/M
         sZG81qJzFHzwX2bUn0JfJg3pPS/1xCbeVCA194tQG/cuOcASDo74H+xU0O4lugTZRPsD
         AB25aHxbmR3Cq9s7/E1oQJQWwWCGWi4YiRpG3BQWwgIxCgVz2yb2cZCiq6MlIUObcrMF
         QmbfJ2zBmdLwglqUNE0ZfBgmYGs+rjceRpJNi0Ee/85Kx4n8JqmpPUvcAfb7c7ioxxt7
         soaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H/O+b8GHgbKyVwOKnVjreanleL+qjiqt6qZj2WCDncU=;
        b=VSHRaoO1OVVQIG1wKI8ywtZc10rb3lZUvWlsp/0X0P58Bkew8tKcD+VgioZnv7t/98
         9WZuycz+FLCcAvVB9wlYrboEPP56CdDK7XRrpdvLsGUBio8EJDtzpIOD73+AAJHG+NQu
         yO75VQlZkNuhNLiymEqDTKNd2J1pGtMb+cl5Wtn+rrbQmdd2xz8ceemhLYx/TpsPcQly
         hhXe4gfVuJw/3jsiGU0ba/3f750KGlHrlRSOAGFbrDqVjvWD5bgvIJcfjgZE8BM56BlZ
         bV5bRGAvw/RhIbD8YpLUH8Yj0c5KcQ1rBWepk3XvpYsTn1s+Y2+ATaS3rFngcDgI57NB
         S9nw==
X-Gm-Message-State: AJcUukfsWI2XfUud7RYXxXwlpPynASfacGTiRyQ7hQV/JqLMMeJkhyTc
        IlpJdBEh79fKVxg9GMvFuME=
X-Google-Smtp-Source: ALg8bN4oXoT29F5uGdbn/NgxlHDxCJmcTIeApTtzE0ARXORx+cvLT0J1Y4+OtHpq5h4nUtutDi8FMA==
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr27168786qvr.85.1548104341615;
        Mon, 21 Jan 2019 12:59:01 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o42sm74475118qtc.90.2019.01.21.12.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 12:59:00 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:58:57 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Fix license inconsistent
Message-ID: <20190121205857.pmd26boqrkp4pzjv@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes license inconsistent related to the VKMS driver and remove the
redundant boilerplate comment.

Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crc.c    | 3 ++-
 drivers/gpu/drm/vkms/vkms_crtc.c   | 8 +-------
 drivers/gpu/drm/vkms/vkms_drv.c    | 7 +------
 drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
 drivers/gpu/drm/vkms/vkms_gem.c    | 8 +-------
 drivers/gpu/drm/vkms/vkms_output.c | 8 +-------
 drivers/gpu/drm/vkms/vkms_plane.c  | 8 +-------
 7 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index 9d9e8146db90..d7b409a3c0f8 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+
 #include "vkms_drv.h"
 #include <linux/crc32.h>
 #include <drm/drm_atomic.h>
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 177bbcb38306..eb56ee893761 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 2a16b86196dc..944908c486f3 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -1,9 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 /**
  * DOC: vkms (Virtual Kernel Modesetting)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index e4469cd3d254..81f1cfbeb936 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
 #ifndef _VKMS_DRV_H_
 #define _VKMS_DRV_H_
 
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index 80311daed47a..138b0bb325cf 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/shmem_fs.h>
 
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 271a0eb9042c..4173e4f48334 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
 #include <drm/drm_crtc_helper.h>
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 418817600ad1..0e67d2d42f0c 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
 #include <drm/drm_plane_helper.h>
-- 
2.20.1

