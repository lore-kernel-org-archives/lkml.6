Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7244C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CCA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CCA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeLLNV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:21:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbeLLNVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65AE44E93E;
        Wed, 12 Dec 2018 13:21:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93A46608C8;
        Wed, 12 Dec 2018 13:21:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CF0CE9990; Wed, 12 Dec 2018 14:21:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/18] drm/qxl: drop unused qxl_fb_virtual_address
Date:   Wed, 12 Dec 2018 14:20:53 +0100
Message-Id: <20181212132109.8126-3-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Dec 2018 13:21:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 38c5a8b1df..7eabf4a9ed 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -308,13 +308,6 @@ void qxl_ring_free(struct qxl_ring *ring);
 void qxl_ring_init_hdr(struct qxl_ring *ring);
 int qxl_check_idle(struct qxl_ring *ring);
 
-static inline void *
-qxl_fb_virtual_address(struct qxl_device *qdev, unsigned long physical)
-{
-	DRM_DEBUG_DRIVER("not implemented (%lu)\n", physical);
-	return 0;
-}
-
 static inline uint64_t
 qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 			unsigned long offset)
-- 
2.9.3

