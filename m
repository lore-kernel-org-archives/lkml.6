Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELuxXD7M5yhdqQ7wtB9VHA3Be2EzJaTjDbS2/fVDb9kQ1JYN0CCpdMpt9hr68cSwjRT/MabB
ARC-Seal: i=1; a=rsa-sha256; t=1520276926; cv=none;
        d=google.com; s=arc-20160816;
        b=YEMgx220iLygF5/PQloTMDbrNsE6K2WsXWKyUKFLlv8dFfKgFxxu4T9yt7TJNeIWnI
         cEjufzeII7truWr8e/EXKMZc7TrvIWkrmR40nnz17EkigPGmFrRR0YNCiGziFOWp8IDt
         /ouoOjMR6ncIIOjjhTNry0pstUqFhZIyFuEVf4Lm0YDsvUn/4K+v0aVPaqUy38wg5nZt
         QzHBHc6llqsstgZgAxrmdY/twUIBNfldI7bFz9uZr5VeeIPErIaFWjdB4fyx+XkihfNz
         TW14nYe1V34nDyoyUPu4yFqkckcipx4gPrYXiCFyAfwdrEzlsjRxQvYNz9lth0AFDpkm
         L2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=b2R3K1MGR381zb/JEvhh3b8EdrG078tvQ3ZdSFBFOHM=;
        b=dW1bXsu0yCSwFuHK75sUW2eIO2BBavU15c8xrfgQlbL94lDdol5DkDKyIn9sBkITSp
         iglmTKdyVz4M9uTRaj9CsW7KzDOF8PE2h7HYxZcab8ruwVrUdME25bmv0Q6AxzsY1D5f
         MVu7540zg+2MADrxpRnT4JJNyRSH9GZhi4Rw+CGMXtdDjq6u/H2fQXszRZnukLRP9ylY
         A5pudkTUfh1S/gpKl9JXbNzau72kiLWgBgqmknGCA3ZGnP9YVNTGyQBLlsmCnt/1MSOw
         AaGMzTkfPbTwe4juftPIBRkGZJ3BbCvDnFGrhxeev+GD707HJLWpf0I0vT0oIHR58np/
         Q6gA==
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
Date: Mon,  5 Mar 2018 12:08:22 -0700
Message-Id: <20180305190824.847-6-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180305190824.847-1-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 5/7] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125898766823916?=
X-GMAIL-MSGID: =?utf-8?q?1594125898766823916?=
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
