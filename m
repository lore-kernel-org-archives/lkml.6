Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A606FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DC5204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pq08K+zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DC5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeINSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:36:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36064 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeINSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:36:24 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F362DCE;
        Fri, 14 Sep 2018 15:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536931314;
        bh=N3lcie4VAKTDV9zfFKcbZj1/8O7cvA599VPOk/6qigI=;
        h=From:To:Cc:Subject:Date:From;
        b=pq08K+zBME+q3mNX+9rX+axtAnSX0hCzxdsE07i+IzveQYanml3SSQQduUX0zTx8m
         KylEfE4j8LvxX7xbcht23LrcC3BnZiJcbd6Idt0HQBsp1aETDuJD8P0AZSemoZzS/K
         ET5hL8yyr4rI8cT32BTeFU/y0uhDlBUbCh501t+0=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] drm: rcar-du: Remove packed VYUY support
Date:   Fri, 14 Sep 2018 14:21:49 +0100
Message-Id: <20180914132149.26354-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gen3 VSP used by the DU for display does not support packed the VYUY
pixel format. Gen2 VSP hardware is able to process this format, but it
is not officially supported there either and thus it's output can not be
guaranteed.

Remove the format from the capabilities of the DU driver.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 4480243813ec..4576119e7777 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -126,7 +126,6 @@ static const u32 formats_kms[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_UYVY,
-	DRM_FORMAT_VYUY,
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YVYU,
 	DRM_FORMAT_NV12,
@@ -155,7 +154,6 @@ static const u32 formats_v4l2[] = {
 	V4L2_PIX_FMT_ABGR32,
 	V4L2_PIX_FMT_XBGR32,
 	V4L2_PIX_FMT_UYVY,
-	V4L2_PIX_FMT_VYUY,
 	V4L2_PIX_FMT_YUYV,
 	V4L2_PIX_FMT_YVYU,
 	V4L2_PIX_FMT_NV12M,
-- 
2.17.1

