Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELv3OfT506vrJdRs3yfcE7lGvLAjBMH3vvdsn6e1Z4l0McUJ1RKe3ZLGT+OhT+KKjDR8ztXB
ARC-Seal: i=1; a=rsa-sha256; t=1521215340; cv=none;
        d=google.com; s=arc-20160816;
        b=ZkqTVg2Cq2W0LfM5bApTvq3yC/ulhL4gPCD3KLeY38w9xKmeQTKjeliNGIWZsSn+cO
         e9srNKjUxqOgHbkgXlPqio2L+EtG+mkEhw8j9dE1mjPx7uLfhLq7GK2CAepk4FX1LYgP
         JP0uPbp+3IFgWEApSg81HteQrGhHeYwE6WCsS7FwSy1cvavd1Zdu79gELRoIzpBjwSUU
         PTk3RemOBZC8qQwpti4npFbR30jFExbkMmAs1QZuEj3aIl2jkwa7YJKDdTibauagb3Zk
         8grIig7TqlN5rQMZk9ztJEQn5ytcbeOHz6+4dP1lk8pgMa4YIloKcyksfJWEmU3iqy3l
         V2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=b2R3K1MGR381zb/JEvhh3b8EdrG078tvQ3ZdSFBFOHM=;
        b=PMHIMmwEZf9CEtw4q9O7F+rLzvP65B49JmxEVxx5nGe4N5NEsQG/D2Vqsbr1ipdyJi
         ayuTeyEAsBRosNR/DZyB/b9KxKaiO7rtXunfYO0gQjS5V20pGVv9e1EIawQFkSMT0SYk
         6LGbSJ7DVcAEV2bliN7Xz+Ye7LkjnwzgYKNLRpfm1Tn+bYsK3amdHdrKda3HI3vx9o7S
         6qheGsUzOjaMbVmSMfnRtlPjJ8BBpLn22XKiygakT/b7Rx85WBJPLtAEqW0X4rUsFa7m
         SeAHvMQQ9oRVDJrd+0jj5tMvo4JzCdPGpX0dXNzU4EXuHspBuO/BjBSeYSDn/stgA7ZI
         KK3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 16 Mar 2018 09:48:50 -0600
Message-Id: <20180316154852.13206-8-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180316154852.13206-1-logang@deltatee.com>
References: <20180316154852.13206-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 7/9] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109896933737082?=
X-GMAIL-MSGID: =?utf-8?q?1595109896933737082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that ioread64 and iowrite64 are available in io-64-nonatomic,
we can remove the hack at the top of ntb_hw_intel.c and replace it
with an include.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Acked-by: Jon Mason <jdmason@kudzu.us>

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Mon Jun 19 12:18:31 2017 -0600
#
# interactive rebase in progress; onto ae64f9bd1d36
# Last commands done (6 commands done):
#    pick cf3e4dab2173 io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
#    r 79b4c4b8490c ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
# Next commands to do (2 remaining commands):
#    r 19b6c1f3b15d crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
#    r f3c8723446ef ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
# You are currently editing a commit while rebasing branch 'io64_v9' on 'ae64f9bd1d36'.
#
# Changes to be committed:
#	modified:   drivers/ntb/hw/intel/ntb_hw_intel.c
#
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 156b45cd4a19..5cf40ab21366 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -59,6 +59,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "ntb_hw_intel.h"
 
@@ -149,35 +150,6 @@ MODULE_PARM_DESC(xeon_b2b_dsd_bar5_addr32,
 static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
 static int xeon_init_isr(struct intel_ntb_dev *ndev);
 
-#ifndef ioread64
-#ifdef readq
-#define ioread64 readq
-#else
-#define ioread64 _ioread64
-static inline u64 _ioread64(void __iomem *mmio)
-{
-	u64 low, high;
-
-	low = ioread32(mmio);
-	high = ioread32(mmio + sizeof(u32));
-	return low | (high << 32);
-}
-#endif
-#endif
-
-#ifndef iowrite64
-#ifdef writeq
-#define iowrite64 writeq
-#else
-#define iowrite64 _iowrite64
-static inline void _iowrite64(u64 val, void __iomem *mmio)
-{
-	iowrite32(val, mmio);
-	iowrite32(val >> 32, mmio + sizeof(u32));
-}
-#endif
-#endif
-
 static inline int pdev_is_xeon(struct pci_dev *pdev)
 {
 	switch (pdev->device) {
-- 
2.11.0
