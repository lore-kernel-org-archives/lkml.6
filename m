Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELt3EW5grIxcb7tFdBLAP5BqYHq8itl+VP2AbYqA60FNK3axrqvLbxOtRi9QF2YCtlV3EECW
ARC-Seal: i=1; a=rsa-sha256; t=1521739035; cv=none;
        d=google.com; s=arc-20160816;
        b=lPb1COFpo4yPb4qFgN8yzmDQHIOMI5T0RIjlKbmmEJfHZKhotAh0HMGx7SKo3rUOv5
         +KCChHQZham9EIKmChrttfDyQx7AISvt49YTcrlJTkyGTjGK7puDD2pEmr6QUl16zegb
         GE6DkiUB7vduHCg3pzSSP5zWs57WS9UwBGOvcADskI/GzhJ+2ERtQmusAKHbBHNhBcgM
         zi/LAN1fHlJJ51SlEqPGzHmimdYE+K4lug4xUvLPhL9UbWmiFxVh9SimPrFKtaoH7F/n
         l72Ijt0GrQBCTPlBKSvdLIlHgGGhMfIfJbklJqIGEi9vA7RWUM6aqM98Ly0eRVBFqTt7
         g+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=p4iy3rPVmOtVhj5GevPWNkxQYLpkAqcgc8ZRuqw7tLQ=;
        b=nbkordGJyhvLxXQHkzbfryr0XEn9T6VH90yYdWh/ao2QRVKG2+JaLxXkWe3yGxdkmX
         8ZxvVsRJEriPtcJ+8RkcICFORxUK1o9dQ86PRQiiHCgdw2kM7ywfEapKNv2qvi9QlRfq
         T7iOo+0rskFIsU8HcgC7eL/PeYRsWCO7cx2SF/GEM21/qe0D07tqJMuA5wpvkEzm2Kjh
         6p0W4eeZApXAlqTIHgpazd/EO/khqbzrcY/dzokJWQbBWXyeVsuFltfCLOu4wV68NUA6
         setetDLvgnefLUYfzgOYB+qvtzCQqSH/tKHwt6iBN+fJQnHv0ydM9NxlrtSTxJs7qCXr
         px8g==
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
Date: Thu, 22 Mar 2018 11:17:03 -0600
Message-Id: <20180322171703.4300-11-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322171703.4300-1-logang@deltatee.com>
References: <20180322171703.4300-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 10/10] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659030789018417?=
X-GMAIL-MSGID: =?utf-8?q?1595659030789018417?=
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
