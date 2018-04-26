Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757057AbeDZSUM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:20:12 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:54473 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757019AbeDZSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:20:06 -0400
X-Google-Smtp-Source: AIpwx4/cDhBdQXpZl16NP6JWeav2A/OWiVS3/iD/BDEj/pRXj91pjNN/fjizNqs55KHr/g4tJpwYUMoq/vpD
MIME-Version: 1.0
Date: Thu, 26 Apr 2018 11:19:31 -0700
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
Message-Id: <20180426181935.32977-3-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 2/6] nvmet-rdma: depend on INFINIBAND_ADDR_TRANS
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
2.17.0.484.g0c8726318c-goog
