Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeDYWeL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:34:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35824 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbeDYWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:34:09 -0400
X-Google-Smtp-Source: AIpwx4+4NCPlAj62hS6wfBX1KFYfvd+CWZ827xrJAAAmATV8/1jLjdd5LRA7x2bMjvQdCHnuH43G0A==
From: Greg Thelen <gthelen@google.com>
To: Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Tarick Bedeir <tarick@google.com>
Subject: [PATCH 3/5] ib_srpt: depend on INFINIBAND_ADDR_TRANS
Date: Wed, 25 Apr 2018 15:33:39 -0700
Message-Id: <20180425223340.206907-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INFINIBAND_SRPT code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Tarick Bedeir <tarick@google.com>
---
 drivers/infiniband/ulp/srpt/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
index 31ee83d528d9..fb8b7182f05e 100644
--- a/drivers/infiniband/ulp/srpt/Kconfig
+++ b/drivers/infiniband/ulp/srpt/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_SRPT
 	tristate "InfiniBand SCSI RDMA Protocol target support"
-	depends on INFINIBAND && TARGET_CORE
+	depends on INFINIBAND && INFINIBAND_ADDR_TRANS && TARGET_CORE
 	---help---
 
 	  Support for the SCSI RDMA Protocol (SRP) Target driver. The
-- 
2.17.0.441.gb46fe60e1d-goog
