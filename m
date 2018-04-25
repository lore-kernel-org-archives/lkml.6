Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeDYWdM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:33:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34037 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeDYWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:33:10 -0400
X-Google-Smtp-Source: AIpwx48FLsangVX+LBdKhqrhSxRlpeJbm54b4nTqxF4S8z9YQGuBiBQb3UZCE6JSdYT02wmcYnyxww==
From: Greg Thelen <gthelen@google.com>
To: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Tarick Bedeir <tarick@google.com>
Subject: [PATCH 1/5] nvme: depend on INFINIBAND_ADDR_TRANS
Date: Wed, 25 Apr 2018 15:32:41 -0700
Message-Id: <20180425223241.206434-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVME_RDMA code depends on INFINIBAND_ADDR_TRANS provided symbols.  So
declare the kconfig dependency.  This is necessary to allow for enabling
INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Tarick Bedeir <tarick@google.com>
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index b979cf3bce65..88a8b5916624 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -27,7 +27,7 @@ config NVME_FABRICS
 
 config NVME_RDMA
 	tristate "NVM Express over Fabrics RDMA host driver"
-	depends on INFINIBAND && BLOCK
+	depends on INFINIBAND && INFINIBAND_ADDR_TRANS && BLOCK
 	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
-- 
2.17.0.441.gb46fe60e1d-goog
