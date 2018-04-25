Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeDYWdf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:33:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34063 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753602AbeDYWdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:33:31 -0400
X-Google-Smtp-Source: AIpwx4/Cedd7vzn35/2TiwR8SKZF26+SyAevz1MGneQI9WrSMPsGfg4dTqgFz+Zv7dQ10ZetCbjepQ==
From: Greg Thelen <gthelen@google.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Tarick Bedeir <tarick@google.com>
Subject: [PATCH 2/5] nvmet-rdma: depend on INFINIBAND_ADDR_TRANS
Date: Wed, 25 Apr 2018 15:33:22 -0700
Message-Id: <20180425223322.206799-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVME_TARGET_RDMA code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Tarick Bedeir <tarick@google.com>
---
 drivers/nvme/target/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 5f4f8b16685f..3c7b61ddb0d1 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -27,7 +27,7 @@ config NVME_TARGET_LOOP
 
 config NVME_TARGET_RDMA
 	tristate "NVMe over Fabrics RDMA target support"
-	depends on INFINIBAND
+	depends on INFINIBAND && INFINIBAND_ADDR_TRANS
 	depends on NVME_TARGET
 	select SGL_ALLOC
 	help
-- 
2.17.0.441.gb46fe60e1d-goog
