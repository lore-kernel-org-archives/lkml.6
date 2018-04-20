Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx493AoR/CSdqO5S+HvOEFBe9LguXiEnX4k0eQOzX+d7tVLsSFL/i9ujKZT4G2sHUUD62tJg8
ARC-Seal: i=1; a=rsa-sha256; t=1524248658; cv=none;
        d=google.com; s=arc-20160816;
        b=ulfgZ7su1QMrhjJlZAflIQWUAncJEwrtxmWlxZYEfNddP8NkygUveDCGAyp5THItpS
         LaSMxdpAb+Tb9/Tc01sgCFKW1bOB9iMngckusLLZw9D2oD6Yg33dnDYFdLjInvUt8BWn
         0FLTxvS4OuCd3wPPAbiPvwwKt7jAPdDN9VOe+R/mdYFZppBWvl9kk3/BWYLS+WjInhDH
         NDGmY0A1HU5C8JMD2w/vADZiirzHNEPn6VckQFsLSoS6jlGPTYgZJBpI2CrT2FxlF16h
         0UH7YMRrDJqku4qJeKLIwjLMRUJBeq39EAzz878qVPRk8JdLmB4Tpj5Yu/QZcXCAZK/a
         iyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=p4iy3rPVmOtVhj5GevPWNkxQYLpkAqcgc8ZRuqw7tLQ=;
        b=P1qbFque2c+g0bInxoU7fXCCJc44j6+M+iIXpEPJlCvyrPIR7gr+Vsn6GmNcJ/c1LL
         Zo8ZWMgRkggLtzEunl5lCn8oY0OyTpJQnJTvjFxUG6okewtUBFR4iD8dkzRcnDw3x0ty
         QIGe3vIXQGFmI4cDvtxrJBYu+GIUFuowU73eP5MbwIenp28t9n88s3onHgtpCjYzEWCL
         zZ9XNFtMpuhkzJAq5ZW7f9vvypDzqqTVd+ekXG4E33Ohcf8bpwWuk/P8ci97JseGoGg8
         vYEWTItMbwE4xOLM7jb5FtAbsxiLUDyt5NL8FWd0l4NWbPgfPt5+UkWgpVrL7mbQBDfS
         HETw==
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
Date: Fri, 20 Apr 2018 12:24:03 -0600
Message-Id: <20180420182403.9691-8-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420182403.9691-1-logang@deltatee.com>
References: <20180420182403.9691-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290561384516092?=
X-GMAIL-MSGID: =?utf-8?q?1598290561384516092?=
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
