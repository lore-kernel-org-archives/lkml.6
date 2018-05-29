Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbeE2Gta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:49:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45166 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeE2GtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:49:23 -0400
X-Google-Smtp-Source: AB8JxZoKc2rWbCBZ8VN0qAG2r7F1dYmPVSCsmJ5A35pMDWVwl7lxv3aqgOG7izrJBX1tnuuZPfx4AQ==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: prefer strlcpy to strncpy
Date: Mon, 28 May 2018 23:49:18 -0700
Message-Id: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e..b823ecb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2017,7 +2017,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+		strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.7.4
