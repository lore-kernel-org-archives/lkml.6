Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELsff3nzP4N3XH6gUFx0F7IZlufu6o3dJKZPFX7bV3jcPcFt69J1bJkH+E8OzheAkh0ON9g+
ARC-Seal: i=1; a=rsa-sha256; t=1520276926; cv=none;
        d=google.com; s=arc-20160816;
        b=Uz2xoEsu7qv3BeerTWVdk8Fhm5HJmdDkjbEPP5Z7O54nzCLy+tjsuUAc9Ne6vO5/kC
         meMeNri/WeE+k+y7lypahY1M1DNmxs8uPUAjufpikKCRfqoo5wSN92lqDXJo/1IvU+tr
         5UG1EncubCBVvKafm71OLqcdRidK7I1XtNDW3lPxB7vnS3+3nT/ga8314dmGy3noiIcY
         ePa9wKZMiY5H2TnY8VqURL4zgBiWnry1aKR5ZFmaV+gihgGcDtj7d5GubV6Op9vO5ytN
         qaLMFVDar3dt0vJ+MGUXNAXL2pC/HR3Xtd+ofhPpQ5UFX9qVqjPmgJtCGqFFNSXYJ7iJ
         MN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=1DC3WJpFzbCmzBHdpBlUMbwm8ev3vh+p7NOOpdODLX0=;
        b=uZNCEe7+TTmYSkeScXtkvsfNS2K0RhvtnMjDNLaHMdiMxyUqWbbhZJL+/dnPiENCvR
         I9YlpLUlepZoQcPT8SbmQWLFVYE/eEiSXIY+5xGuFwIlSii5Perr7i7EZMVcYEw8fMII
         YP9gQGdHjpPZQkkU2SJ4lUXpEOzJLTUDM14I6/yUzywYWxWI40/OoD+T9el098xL3so9
         jpXRV7bNQj/Cm/OGHuEf9RSsAKSLGOwcn+MHopn62uJoux/fKPJ43BRST/l7htss9DQW
         dJzHFOvaO1pt9S/0A5leowkYF8vV6NeuJIiX3gCfyQvSIR0emFSGiWYsw5wKvGR6YSR9
         3JXA==
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
Date: Mon,  5 Mar 2018 12:08:24 -0700
Message-Id: <20180305190824.847-8-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180305190824.847-1-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125898084128153?=
X-GMAIL-MSGID: =?utf-8?q?1594125898084128153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the ifdefs which conditionally defined the io{read|write}64
functions in favour of the new common io-64-nonatomic-lo-hi header.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f624ae27eabe..d2a1e746b335 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -19,6 +19,7 @@
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/ntb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
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
