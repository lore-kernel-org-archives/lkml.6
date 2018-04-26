Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757229AbeDZSVZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:21:25 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:56605 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757200AbeDZSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:21:02 -0400
X-Google-Smtp-Source: AIpwx4/us4jPxYxJgPbvvOJra8c1kwFswOZM4dfC6jp3a6ERQZsqmtBFEcGd1f2XYPuhypJRYtvm0uuornw6
MIME-Version: 1.0
Date: Thu, 26 Apr 2018 11:19:35 -0700
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
Message-Id: <20180426181935.32977-7-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 6/6] IB: make INFINIBAND_ADDR_TRANS configurable
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
2.17.0.484.g0c8726318c-goog
