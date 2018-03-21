Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELvYaYNqiWruW3Z5LsKu801NHDwaLt/1iXrhftW/dD6td+plJp2yZ9LYR4V+y5rlAT9wSB2M
ARC-Seal: i=1; a=rsa-sha256; t=1521650276; cv=none;
        d=google.com; s=arc-20160816;
        b=EqoYjGonpAzxGQOGKyjGgy4YrASc5ajk6IqHQUisa1ZUOlfn0Auu45f43ieXKic5y9
         2HwEhhRwjUYccmhVCjYuOCa/HWJptZnn4hq0cfa78EkplY3du0YKN9WIr1dJesMnb8RV
         xGFOB3Vd9xMg4yCOO7MDwCPQnNUVfRc4SxsoOR177pTwDabmI+mpAQzN7CyBZgBfrBvE
         3SC2MtL4BDEu6TDNJeyAkE5Im4PlXiVpb+5f2UNxCDxvv7Q7IIpHonafTUcyXIOWXY61
         crRIe26bNOJAeVCY+qHmv6uZzOr+ojorrEk8nRRoOWJfTWKG0z4iNc1rxYR2vcxuiIb3
         L0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=lZVuHHhC+13V9POSc1MvwQ6pVMrqydkL5QxEgOrODn4=;
        b=JBW3uUqOzSEyJA+suzmyOWx5Z5ZNu+A5F3rO9NywqUZ0TiU65cpFdFYgRbWniFDFza
         zFKX8jeKfmSzQlupLQiH0OKiVDOT4NGfIVpbdyDHNl4afi3K7p2avaD4/IZY1Mjcy0sw
         nQL/McDwyoSeFq3zV+f8ff2OFDE1pZ8EfEqi3/LxNZtfWpsbfIgZ6I4u04jYoPCDLW4G
         1HC5Li98nXcxP6mN5Rd0QBhoU9oOi/w5VXXbEibCRQ/13RgQw87JifWAxa+XyojQCnV4
         VhXrvgq7TpOfcy2c24V2mpM3lfr3pTE3g+4p6B9xPZ8PsbekGwwEdVjAiRmRDDQOT7ww
         KFPQ==
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
	Logan Gunthorpe <logang@deltatee.com>,
	Jon Mason <jdmason@kudzu.us>
Date: Wed, 21 Mar 2018 10:37:45 -0600
Message-Id: <20180321163745.12286-11-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180321163745.12286-1-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v13 10/10] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565960735025009?=
X-GMAIL-MSGID: =?utf-8?q?1595565960735025009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the ifdefs which conditionally defined the io{read|write}64
functions in favour of the new common io-64-nonatomic-lo-hi header.

Per a nit from Andy Shevchenko, the include list is also made
alphabetical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
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
