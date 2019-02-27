Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78008C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529A5217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfB0Oop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:44:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfB0Oop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:44:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AE85309D07B;
        Wed, 27 Feb 2019 14:44:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-248.ams2.redhat.com [10.36.117.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6D205F9D5;
        Wed, 27 Feb 2019 14:44:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1025C1747C; Wed, 27 Feb 2019 15:44:42 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/virtio: implement prime pin/unpin
Date:   Wed, 27 Feb 2019 15:44:40 +0100
Message-Id: <20190227144441.6755-3-kraxel@redhat.com>
In-Reply-To: <20190227144441.6755-1-kraxel@redhat.com>
References: <20190227144441.6755-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 27 Feb 2019 14:44:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-gpu objects never move around, so effectively they are pinned
all the time.  This makes the the implementation pretty easy ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index b4c9199349e7..0fcae0e46abd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -30,13 +30,13 @@
 
 int virtgpu_gem_prime_pin(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
-	return -ENODEV;
+	/* nothing: all virtio-gpu objects are pinned all the time */
+	return 0;
 }
 
 void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
+	/* nothing */
 }
 
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
-- 
2.9.3

