Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1929BC5AC75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50CC21873
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeEYZB4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeLXOgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:36:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45272 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbeLXOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:36:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so5859053pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lyxUDg0O1SeB4e+TXugmDOoz4HZud0oyCWvdwpLcabU=;
        b=oeEYZB4kB8/FbWOh3IW6GzqQAs6EYSWUns4O2B3rj2V9a3IDek1pWyjEKQSPdX/eg/
         uhwWL8y9ovTYs1RAJxtoAHwlicdmOAWS53PgVHZaBe5s572ZonfNPXkivIBw00eiYThY
         wtDJcP+qLkhffzU5zoUN/snfodjYWh1PZ4SU2l/jB1SH/hCmOXfygfXRcLPjfmFNeZHv
         Tz9Rw4VRvVpIvJrs8Bgx2NLYZEbOVL2dm2kbUG+Qw/6YxfcH+1P+pzU2cYiPXslm5Maz
         xUOLPK3WU1GPLexY+F+CP23XhgTKnzBFzP6b77UAzIo9ClwgiEvh4Y2U3E0blWYIXItj
         DG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lyxUDg0O1SeB4e+TXugmDOoz4HZud0oyCWvdwpLcabU=;
        b=tsKcXEd2wDOa3s5pAh6YQjUFAPW1qfutqZzpURhYQUgp6+j+xFO7F/37gJjcibDFe0
         A5b0slQ2/+p82m1VJ8Ebqx2D9zA9zU0+ceQcn8Xqa2o4HQDWygNv+wKQTS2HlDXNWwBc
         JgaUiP+G6QNZ3DEP04lX6FBNyF29wts4bTsxEcZqORqZv1XuLv3r1wuCz5yUGwUIwbqQ
         gaabTfH+b2rY/+BWw684ykRwJ1zJZ0kY5AEc4Oqn89EEbLWwx0o+HJQC979duSPgkGD0
         cZuveTV9B151v0lOgPqDOTT82yQk1T0GeLo/Y0h8E23qfrreXnE78PGqvVDf8WV0Yjar
         nj1w==
X-Gm-Message-State: AA+aEWYxXxXMxTDeN0+ispC5pjdTY3bVwfQVIVf/r2QFrCuflsynUWho
        eIDdXBzDOqgn8pmP9UUL9bo=
X-Google-Smtp-Source: AFSGD/UV589dMEFsehsKrjZ4RgAJVae3rLy86pdFSe+K8P8k+dgnAuZl5rcvu3BvWLdTd+9Kx9t/GQ==
X-Received: by 2002:a62:190e:: with SMTP id 14mr13288146pfz.70.1545662202519;
        Mon, 24 Dec 2018 06:36:42 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:4426:2a30:1140:b12d:deb2:6ca8])
        by smtp.gmail.com with ESMTPSA id r12sm38424454pgv.83.2018.12.24.06.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 06:36:41 -0800 (PST)
Date:   Mon, 24 Dec 2018 20:06:36 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] drm/drm_drv.c: Remove duplicate header
Message-ID: <20181224143636.GA3237@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove drm_crtc_internal.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 4126bb6e1a4a..75f4e6bf67ca 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -41,7 +41,6 @@
 #include "drm_crtc_internal.h"
 #include "drm_legacy.h"
 #include "drm_internal.h"
-#include "drm_crtc_internal.h"
 
 /*
  * drm_debug: Enable debug output.
-- 
2.17.1

