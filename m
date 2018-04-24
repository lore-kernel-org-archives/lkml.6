Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758340AbeDXOAr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:00:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52677 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757897AbeDXNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:19 -0400
X-Google-Smtp-Source: AIpwx49ri9hrEXRT2p4U8xkJNA7AoAHYjDZ6HXRH2NrLDDOLHASYyW8B0tSGVRyUixBOzSBTFnqzKA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix typing in (*hqd_destroy)
Date: Tue, 24 Apr 2018 15:14:16 +0200
Message-Id: <20180424131416.1702-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method (*hqd_destroy) is defined as using an 'uint32_t'
as 3rd argument but the the actual implementation of this
method and all its calls actually uses an 'enum kfd_preempt_type'
for this argument.

Fix this by using 'enum kfd_preempt_type' for (*hqd_destroy) too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 237289a72..2890e8581 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -298,7 +298,7 @@ struct kfd2kgd_calls {
 	bool (*hqd_is_occupied)(struct kgd_dev *kgd, uint64_t queue_address,
 				uint32_t pipe_id, uint32_t queue_id);
 
-	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, uint32_t reset_type,
+	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, enum kfd_preempt_type reset_type,
 				unsigned int timeout, uint32_t pipe_id,
 				uint32_t queue_id);
 
-- 
2.17.0
