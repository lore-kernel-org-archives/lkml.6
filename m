Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454E320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454E320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJZDLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:11:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZDLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:11:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id 19FA627A4BF
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.co>,
        Robert Foss <robert.foss@collabora.com>
Subject: [PATCH 5/5] drm/virtio: bump driver version after explicit synchronization addition
Date:   Thu, 25 Oct 2018 20:37:39 +0200
Message-Id: <20181025183739.9375-6-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

To reflect the (backward compatible) changes in the uabi we are bumping
the driver's version.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index e8d2a67d8049..a26483b5016e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -46,8 +46,8 @@
 #define DRIVER_DATE "0"
 
 #define DRIVER_MAJOR 0
-#define DRIVER_MINOR 0
-#define DRIVER_PATCHLEVEL 1
+#define DRIVER_MINOR 1
+#define DRIVER_PATCHLEVEL 0
 
 /* virtgpu_drm_bus.c */
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev);
-- 
2.17.1

