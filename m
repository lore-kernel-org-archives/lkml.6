Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELuGpoegCM0DnEiXMAOa+wI0ddWYwRrWs7C4plMBFQsouNfsiAuuLgNQtdh/GO3AZQSqQKo3
ARC-Seal: i=1; a=rsa-sha256; t=1521042755; cv=none;
        d=google.com; s=arc-20160816;
        b=zMFbemWgHXuhIOqGC5cpHN7ChX1IMnr5sTfIaG34OkgHy3EeeWkwu2XaEIjqs1oE2M
         JMcKj4fHl9IYCZt0NNHfXdyGCbFjSB1oEq5ZXN4BNIs0PZSZx9r4qeDTQBLVBJ15bikX
         nMAcmntMc0XjOMHvAKwHUSR/NncYkULsgjVwUy9cLN+SxRwNrsRPKhVkwPWFtgx4bV1q
         cImB2zvBDOPjqfxFfJKwbMPaCWd9OuaV6huflgU0ci3pVrh5W7jDZnaN70hY08NAubTN
         umltnKogTK7MiJ0nJhOs3yjg1GKXjrNzs4STqd+5e8CPAqe3a2/KYnmYdHxp4AwdHGxV
         mKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=msPd3rYBbQEsltFA71FW5KliyuLdmpJBMNpqGizFD14=;
        b=Zp9I4yAL0KBucsZGX9KFRzTpOWDKcu6K+1yjMOmjEYVWOqnEivbMUMOJutJ0z89N9y
         lTl9BaW2Mf1+333B75ZdYWAJS1MkkVO2sQQTZDhdJQfhLioi9txtuwTV/x6uEXz7iTOT
         u94dAMstODC3DLzllhZz3r5xo8eGPUx7S204Hv7gAssYSdILuIxr2t+AL67DBRigdXFA
         sMpHTcB6r5lHz2PskL7z6Fqh5eOmf9jaNfSK1TdMxtHHNgjKRsQgIPLP9nQU2yv5OoDk
         tBH/hRF2xkkTeyUtHf+JJFmEKQEEik2DsDW7fC0l4iGNqqwbpZNh2SOv2M1XtHP1e/qe
         c/SQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 39/47] usb: isp1362: remove blackfin arch glue
Date: Wed, 14 Mar 2018 16:35:52 +0100
Message-Id: <20180314153603.3127932-40-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:c5JeVy1gON2m2+W6jRJWE8GnhlEPxsTBhlDcHbXJK/zAtH2CIS+
 LUZ2RfnaR2HxBq6yOj/jQGCvxIBH0w2g0DAYpUJZeZ7n7yrEpxdKwtB6AyUcYQBJvs0leEg
 WfCQY1TtpH0/x62di5/1/M5wtPV81Nxedz+YCsEZ7zInU+7/pb4sGDsfbTIRAWLMUtad3w1
 d1WexFQRZpL0HOzknhEyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nN+xlWwBoUA=:bpXUqT+2D7O0H5JosZ/hvl
 hX3ra+eU4s4xPCDdeQsIgyNFQ/rjopOslVGr2tA+w42F+2AwW9pjXu6L3CIN4KurN0GYYnY43
 UhWcNr0LyVjx7hFoOYO7i1qne8341HCf/ralAboobLSwpFY+M6mpbodglG3Y1MnI/9bp6RtNc
 5WoEgswdXYtA7YRuWxZBeIhzdV0gfeeAYgLz9K5EKus5cr8GdEFRFWNurvYVjFLjBuj0Ky63d
 zZBu8sR/iVex7XYSssr4UA1Vl0zKhGPDA5QfC7znCpgB2xkrT0GZOwnOf+O92dyMzMg8nIvN0
 iJ4Qv1nBnROgRTlBzk8O3HYzpyiWwdAroKA6n1FdmPGWq7dC6OGInWI7D8S0V/vT6G+jEpaNd
 Q9LpJw3StPpl6LCaDOZAlq/ebCLIBDvVfiPq/bW8tbWrdNcWpol/TN64s4C7U3RrwuPTqsdYX
 q3cIajjNIoMymUzim/4aar7JLcflTEwGJu+0qGoLgNrQIzyKe36Syu6CwGIDfx4ndI+vbjNTM
 2sLAVUZ7UV9PukGlEWjMwobUHEd8AEV6UOeT+yGkvvqJ2fzbCs723hGA9ZxZeeG/vsn5CX3yy
 +IPY7DT9KrvCW3A/jyc3IKR1yvht+dDskAdaf912BK5ztBeyxdjLPSmyCIZO+qzUnMqMCrFwF
 6Bh4b8FpRs5ds7zp+TshXfuKvxRU9secmpPo0MdDfsuDE+OEMnHf+h2zCS2/h25Bw/IfrtcSu
 Hdyr6KI5bLDPRpA7bZkoJO6QgkxbpcPejgLbCg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928928557634324?=
X-GMAIL-MSGID: =?utf-8?q?1594928928557634324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, and this is the last
remaining architecture specific setting, so the various hacks
can be removed now.

>From all I can tell, there are no remaining in-tree users of the
driver, but it could be used by out-of-tree platform ports.
I've marked the driver as 'depends on COMPILE_TEST', short of
removing it outright.

It was originally written for some ARM PXA machines using the same
chip, but that platform never really worked and the code has been
removed a long time ago.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig   |  1 +
 drivers/usb/host/isp1362.h | 44 --------------------------------------------
 2 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4fcfb3084b36..b85822f0c874 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -360,6 +360,7 @@ config USB_ISP116X_HCD
 config USB_ISP1362_HCD
 	tristate "ISP1362 HCD support"
 	depends on HAS_IOMEM
+	depends on COMPILE_TEST # nothing uses this
 	---help---
 	  Supports the Philips ISP1362 chip as a host controller
 
diff --git a/drivers/usb/host/isp1362.h b/drivers/usb/host/isp1362.h
index da79e36ced89..87c1ac97e538 100644
--- a/drivers/usb/host/isp1362.h
+++ b/drivers/usb/host/isp1362.h
@@ -9,47 +9,6 @@
 /*
  * Platform specific compile time options
  */
-#if defined(CONFIG_BLACKFIN)
-
-#include <linux/io.h>
-#define USE_32BIT		0
-#define MAX_ROOT_PORTS		2
-#define USE_PLATFORM_DELAY	0
-#define USE_NDELAY		1
-
-#define DUMMY_DELAY_ACCESS \
-	do { \
-		bfin_read16(ASYNC_BANK0_BASE); \
-		bfin_read16(ASYNC_BANK0_BASE); \
-		bfin_read16(ASYNC_BANK0_BASE); \
-	} while (0)
-
-#undef insw
-#undef outsw
-
-#define insw  delayed_insw
-#define outsw  delayed_outsw
-
-static inline void delayed_outsw(unsigned int addr, void *buf, int len)
-{
-	unsigned short *bp = (unsigned short *)buf;
-	while (len--) {
-		DUMMY_DELAY_ACCESS;
-		outw(*bp++, addr);
-	}
-}
-
-static inline void delayed_insw(unsigned int addr, void *buf, int len)
-{
-	unsigned short *bp = (unsigned short *)buf;
-	while (len--) {
-		DUMMY_DELAY_ACCESS;
-		*bp++ = inw(addr);
-	}
-}
-
-#else
-
 #define MAX_ROOT_PORTS		2
 
 #define USE_32BIT		0
@@ -60,9 +19,6 @@ static inline void delayed_insw(unsigned int addr, void *buf, int len)
 
 #define DUMMY_DELAY_ACCESS do {} while (0)
 
-#endif
-
-
 /* ------------------------------------------------------------------------- */
 
 #define USB_RESET_WIDTH			50
-- 
2.9.0
