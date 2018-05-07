Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZptLrdk31uXFlUT7S6DuBLTqaT8lxnEVZf679T+PVcmx2MHZAZROdG053p7Pxdm+4KhwdrM
ARC-Seal: i=1; a=rsa-sha256; t=1525725375; cv=none;
        d=google.com; s=arc-20160816;
        b=y5nhdUUTQfnt0DFIuHSOyL6n6OyQkQUh8wiSA001virae0AFZ3jnRWwZU0C9/aeyRS
         C0Fxu6iCTgs7e8Z0wOdjU7qmz7nsUj2lzibyIx92rcqRYXUn2zb3pvvjG9RGmzOGNUPi
         qlsnuH6jrwM+DIu8TTrL14bgGyiKiXmAU5JbgucpAuBCU4ZM5q8l1kFjOmE7i0WWbilM
         YZheTRsEE+jiASMwPnVftoJyVId78Y7juDbPDamcrViHMSqUtM4ZmY72XMdR0rAvx+Y2
         DBtt7aMZXdR15Fe0Nq+UdYM9uHeENbwQAVWKJb1NKo6FOueU8CFf2lfnIjS+DRyrmQOo
         gjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=p4iy3rPVmOtVhj5GevPWNkxQYLpkAqcgc8ZRuqw7tLQ=;
        b=vISqlmT+J9ruEiH/rP/jm6Utyx0NNcOLiB0hj/K7VCHagAIteDsVse3X7GlZQSrmAd
         RJWEnrGi6tHdnFlXBJZ7bPqCyKNGEqkpvJ2HWDO5bqS3FQhZ4mUQjbj6C0BgiGsyKKx3
         qRgnc2OJkefPfqfv3XJJRFxwSqClceIaf+/URLqkiB2zO/qAtzU56JChjZmzTmRtz3zi
         X63I7WQwX+pdRkGhWhrubTRxivzL4N5qodda1jhhigVuLHJdYE25+ONAQSZgc3HqR1rU
         1XLYSmzrxrf9KM3lxaiIpZbziWDLzRgmxDGMjyWnGNPe9Sp8lR0O7izVBL9keozqOor1
         ZaIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jon Mason <jdmason@kudzu.us>
Date: Mon,  7 May 2018 14:36:05 -0600
Message-Id: <20180507203605.15865-8-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180507203605.15865-1-logang@deltatee.com>
References: <20180507203605.15865-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v17 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599839011741482167?=
X-GMAIL-MSGID: =?utf-8?q?1599839011741482167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the ifdefs which conditionally defined the io{read|write}64
functions in favour of the new common io-64-nonatomic-lo-hi header.

Per a nit from Andy Shevchenko, the include list is also made
alphabetical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 36 ++++------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f624ae27eabe..f403da24b833 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -13,12 +13,13 @@
  *
  */
 
-#include <linux/switchtec.h>
-#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
-#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/ntb.h>
+#include <linux/switchtec.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -35,35 +36,6 @@ module_param(use_lut_mws, bool, 0644);
 MODULE_PARM_DESC(use_lut_mws,
 		 "Enable the use of the LUT based memory windows");
 
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
 #define SWITCHTEC_NTB_MAGIC 0x45CC0001
 #define MAX_MWS     128
 
-- 
2.11.0
