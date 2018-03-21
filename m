Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeCUT1c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:27:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42451 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeCUT1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:27:25 -0400
X-Google-Smtp-Source: AG47ELsIN/UN6drflq5YNhxA1LPiiiX4FRWxQQiq+attQDNk+bRZtHo84F1qjjqCFP+yzNxyfLIUlw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: keith.busch@intel.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] nvme: make nvme_get_log_ext non-static
Date: Wed, 21 Mar 2018 20:27:07 +0100
Message-Id: <20180321192707.17749-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the lightnvm integration to use the nvme_get_log_ext()
function.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00ad24728074..e33527c84cd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2215,7 +2215,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			    u8 log_page, void *log,
 			    size_t size, size_t offset)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index eaa3af096eec..4cfd890ff5ca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -428,6 +428,9 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 log_page, void *log, size_t size, size_t offset);
+
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
-- 
2.11.0
