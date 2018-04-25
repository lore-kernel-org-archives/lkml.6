Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeDYWek (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:34:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38670 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeDYWee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:34:34 -0400
X-Google-Smtp-Source: AB8JxZpwEs5kDZw3oc2t8cvEPOtfMA9ZVFrb9/HsIZIf5a3G3xuS6fLRJFJMpUlEKNRhBA3GO7fFvg==
From: Greg Thelen <gthelen@google.com>
To: Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Tarick Bedeir <tarick@google.com>
Subject: [PATCH 5/5] IB: make INFINIBAND_ADDR_TRANS configurable
Date: Wed, 25 Apr 2018 15:34:24 -0700
Message-Id: <20180425223424.207228-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow INFINIBAND without INFINIBAND_ADDR_TRANS because fuzzing has been
finding fair number of CM bugs.  So provide option to disable it.

Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Tarick Bedeir <tarick@google.com>
---
 drivers/infiniband/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ee270e065ba9..2a972ed6851b 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -61,9 +61,12 @@ config INFINIBAND_ON_DEMAND_PAGING
 	  pages on demand instead.
 
 config INFINIBAND_ADDR_TRANS
-	bool
+	bool "RDMA/CM"
 	depends on INFINIBAND
 	default y
+	---help---
+	  Support for RDMA communication manager (CM).
+	  This allows for a generic connection abstraction over RDMA.
 
 config INFINIBAND_ADDR_TRANS_CONFIGFS
 	bool
-- 
2.17.0.441.gb46fe60e1d-goog
