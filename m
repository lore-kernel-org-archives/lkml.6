Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B30AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2282522419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2282522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbeKMCqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:46:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeKMCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:46:13 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8109:92c0:207d:68ed:6b77:5dd1:d3e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E82D27E98F;
        Mon, 12 Nov 2018 16:52:08 +0000 (GMT)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.co>,
        Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v5 4/4] drm/virtio: bump driver version after explicit synchronization addition
Date:   Mon, 12 Nov 2018 17:51:57 +0100
Message-Id: <20181112165157.32765-5-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112165157.32765-1-robert.foss@collabora.com>
References: <20181112165157.32765-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

To reflect the (backward compatible) changes in the uabi we are bumping
the driver's version.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---

Changes since v3:
 - Emil: Added r-b

 drivers/gpu/drm/virtio/virtgpu_drv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index acd130c58e33..4632bd7e1972 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -47,8 +47,8 @@
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

