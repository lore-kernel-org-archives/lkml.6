Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E32C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CC720685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgPisOFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CC720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405377AbeKVV2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:28:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeKVV2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:28:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so8755069wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QmpO1maSfD11uZY9o7vu+6wIZo+c06Bql9hdGlIjDoY=;
        b=YgPisOFJY37ovQiKLKldKWg4zPxa5BnwTJ37B0EMZHyrs5/O+z6Or/qZ7G42y3jx1X
         i5pzb3/z47qa+0mi7j31jeWn7CH8zyBI1R/pfWHv5uSFYgoMXleyZDuPzvUB4YJMnjqE
         Db3G59F7UolhiFc9wmuUu5aAAj/x6m7t/yYqspRZT7I9vgsSbzzyWoXj67LwPY9Kfg3H
         CT+HjMqCZj4M9pBE1Bqvqizp6wFKjFWPkWOXHJUv1Wbg20dzfoqkLDwVpEwZjDXQgp13
         vU5okXyNlaSF69VjNm1Aa2RCzdhiQO6LgRUnAukMNEuCU3tHN5p4byWrDyfeiFnbpVe/
         T9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QmpO1maSfD11uZY9o7vu+6wIZo+c06Bql9hdGlIjDoY=;
        b=jxnskUuvs+mr9Zl80WK6bvb5GD3afJ0DySpnZhwPrSSfjCEqj9n8+Bkh5PNOvpGzU9
         tB8S4yMxDHFj1YjJ6bBaj6jOYkRfnTURNb4IYWj65eNyP9+IwPjWpDkHFc4RLgb/t5wH
         pv1i/l3lgoDcNeGQXr4EAuQ8qj8VGYHrWTzJ98BvTc98nKIOvGkUZ55lU0RSuphCmvgm
         wvxSISx8jbs4bnNPBKDpRP/OQoZNmP2udZayoFo+g8WYBsStCqv2E2g1P5BIDz42zcY9
         XtaT1S6o7ugI2G3aHvLBpoHut9h0dx3vdnOkSZ1HA0+/l1oCMrHH9KagPzT1pTmYxvqE
         Y/cw==
X-Gm-Message-State: AA+aEWaedTWlJHC6s7xi/SvMM+MbgelqfdzbGhXrWa04LdlAkaa1LX6t
        uTGOjE/FX4HguCVoPHy9Xao=
X-Google-Smtp-Source: AFSGD/XalPItoidWPqvP6jeNIFedDy8gugR5RWD9D9HmrdUTQ2vt5m/hdIKZQYVjRSZYVTjDODqWug==
X-Received: by 2002:adf:9c02:: with SMTP id f2-v6mr8901139wrc.211.1542883754984;
        Thu, 22 Nov 2018 02:49:14 -0800 (PST)
Received: from ubuntu ([85.88.131.204])
        by smtp.gmail.com with ESMTPSA id e8-v6sm1995607wmf.22.2018.11.22.02.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 02:49:14 -0800 (PST)
From:   Ricardo Reis Marques Silva <ricardormsilva93@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Reis Marques Silva <ricardormsilva93@gmail.com>
Subject: [PATCH] staging: vboxvideo: Rename uint32_t type to u32
Date:   Thu, 22 Nov 2018 02:49:05 -0800
Message-Id: <20181122104905.5199-1-ricardormsilva93@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found by checkpatch.

CHECK: Prefer kernel type 'u32' over 'uint32_t'
+static const uint32_t vbox_cursor_plane_formats[] = {

CHECK: Prefer kernel type 'u32' over 'uint32_t'
+static const uint32_t vbox_primary_plane_formats[] = {

CHECK: Prefer kernel type 'u32' over 'uint32_t'
+       const uint32_t *formats;

Signed-off-by: Ricardo Reis Marques Silva <ricardormsilva93@gmail.com>
---
 drivers/staging/vboxvideo/vbox_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index 06e921844b1e..c43bec4628ae 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -479,7 +479,7 @@ static void vbox_cursor_cleanup_fb(struct drm_plane *plane,
 	vbox_bo_unpin(bo);
 }
 
-static const uint32_t vbox_cursor_plane_formats[] = {
+static const u32 vbox_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
@@ -500,7 +500,7 @@ static const struct drm_plane_funcs vbox_cursor_plane_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
-static const uint32_t vbox_primary_plane_formats[] = {
+static const u32 vbox_primary_plane_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
 };
@@ -529,7 +529,7 @@ static struct drm_plane *vbox_create_plane(struct vbox_private *vbox,
 	const struct drm_plane_helper_funcs *helper_funcs = NULL;
 	const struct drm_plane_funcs *funcs;
 	struct drm_plane *plane;
-	const uint32_t *formats;
+	const u32 *formats;
 	int num_formats;
 	int err;
 
-- 
2.17.1

