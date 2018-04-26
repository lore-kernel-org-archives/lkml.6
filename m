Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757110AbeDZSUZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:20:25 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:43404 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757086AbeDZSUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:20:18 -0400
X-Google-Smtp-Source: AIpwx4/w6i+Y7WElqYwyxSSEdeKIZKma/L+aLTUPONT1TaOyP/CNQcoP27THW9DzZ6ARbVgvDD9kk1qfmaCp
MIME-Version: 1.0
Date: Thu, 26 Apr 2018 11:19:32 -0700
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
Message-Id: <20180426181935.32977-4-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 3/6] ib_srpt: depend on INFINIBAND_ADDR_TRANS
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
2.17.0.484.g0c8726318c-goog
