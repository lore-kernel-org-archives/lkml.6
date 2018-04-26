Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757009AbeDZSUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:20:04 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:47407 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeDZST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:19:57 -0400
X-Google-Smtp-Source: AIpwx4/oeL45DGJBQWkeSKJsIypg3ZM9EoRgZVvBvR3DNJ+EypAquxxgJ0qS4OVX/XjleG/FsVyfBqQKYvVs
MIME-Version: 1.0
Date: Thu, 26 Apr 2018 11:19:30 -0700
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
Message-Id: <20180426181935.32977-2-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 1/6] nvme: depend on INFINIBAND_ADDR_TRANS
From: Greg Thelen <gthelen@google.com>
To: Bart.VanAssche@wdc.com, hch@lst.de, dledford@redhat.com, jgg@ziepe.ca,
        axboe@fb.com, keith.busch@intel.com, sagi@grimberg.me,
        sfrench@samba.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, gthelen@google.com, tarick@google.com
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>, Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
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
2.17.0.484.g0c8726318c-goog
