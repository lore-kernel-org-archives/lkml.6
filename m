Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELsPAqH8oHE+XAfN0JNxmT8UoaR9z4Kr4GtfiDoIZEVF2NFk2cwKBaK3cmHNe+dLcTbUleCC
ARC-Seal: i=1; a=rsa-sha256; t=1521042049; cv=none;
        d=google.com; s=arc-20160816;
        b=zRQnv+kJIYjCUNvO5GpuLDXW5jOGdD68OuZLkVipvrht3bM1uUlyhBWFwgZ0YnLsrs
         +rQUSzWVPYkrykW8fwfD5wAVWabpElwavfLYuxnx1Y//b9DGQ814y9tfcvJLNweDFxVq
         x8gx+a71coURS+wBVMadnzeN9d5b/gZTrpnFeV9V3zwiuEPBpY2tH5oom9bcIn+/P1sy
         gVm/a5yronJVVssuRbkQPR2nWkPoup1howe9xiBvX2o8VYFG6ig2rU/DyMgTZJ79MVi/
         r4Q2UGEZVDQWTaxo5XNM8JxVk0ZJOsIarrWA2YJ0sfFHCws+IEkl0iUqdv2FmODV2wlg
         r4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=t2tIBilAUUE9+qRKM3cvNXaH/lJSBF2ARXxyRkwcupY=;
        b=gibPgC/l0mozqvQ/8Foi/2sQ/4Ga7GsicF3+fDjzBnEFW/HqIXqI/2IuHlZd1g2rVf
         bLrWmFFb7/HRkOcNGiZEwxmz9iM+fRXxsmCVozjH66Crtkm/ktA8sf7dZq4rkKMCvExr
         WGbA48POh8+PWrPL/lZwb+nVVUvwYaO+2fobv1sQYeNJqQ5eXm7a9zWj3q+YXr73ZF3n
         mID4cmtCMCn74XRG5nMYHEaArAlStyA0J4iwKdh6R5gb9590TYOLw2AyKPIZMe4SntEb
         2eswnI8wENsTuz2pgsCtE2qI6Php25Xk9NL5jp9Og58YtwvmlhV3GTBK5SruZCjzAskb
         vvng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/47] char: remove blackfin OTP driver
Date: Wed, 14 Mar 2018 16:35:25 +0100
Message-Id: <20180314153603.3127932-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:OOb2115TlYsbHhfTcsxhlpvr+iGMlWiPLhMFqVh71sFG6Kqf8ZS
 qjrvH9gcR/p7VriryKT9VK+KJNFNqPLf0+5E4NObJP0AsKpy09WVv0E74drcLhVWwrWUwW4
 Ze5HiKG0CTdI+HIaFK7OLvnvBaBRpWhfHqpXBNUFcifteNhiwKauTxMX9dygexGyO0NbaLo
 LthLIyLzLcL3SlguC3aTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8AqslNBuKd4=:6y5pKzVqbfhWnlLXAE7/kd
 tP+ecUOmbHiZ6HZLOl+7I/ozBQ3mZJ7SdOCymOOWzlb/wCNJC/6kUbLVyHXeTxUdff5c744MG
 Lbu/4LhJfAM3jLmTpIXi7aFZCcjsZwHPK04h6aKUGnAvp5mWwI0ro3ym+hzs44TS3/F84re/n
 +ZLAwz3yRxTOg9xczsBKCD/abWtcoex7FDZFlDIA5Ku2F8hpcLbEIZn23pG05qLHJXfDYNeT/
 FxOPfZvnO+4NB2yuk53X3sK39/sjYlDvO1/kF0Ea4WXev/GGGOgpeUk7YAlVN2Eshdhh/2i7l
 FkMawqSaue24v56ZWlkTH3HjYaRgKd+kh5UQuWFSMuWoYs4gAsvjXFLG2WizsAzOT5n69SD+y
 GMJERxgTEnkFXc8wzt1Pql++tWY9CJbPzr+J8yC3qOuAihihvpHFhVihMui2llfnZpl+a6ujy
 t8B6U4o6rzPABQ7vGbnemSNHxdYekSLOzxfVa7Q9cLwaaUYQ004V5VKDJtezrDmf8VIMswQN+
 Cm6hezPTzYmlycGCop4JYSVN/LTN2cF/aJbpx4V76zo7VQ31yqjQKYmhgrg5jMqf/MTmcDsl0
 QGcd+lGKg4aEAiHu5NwclD/4jRVtsKMSVz5BHiRu6pHEwvdL12zSuM2YiDxoZkLA0+1jKVgXQ
 cHNKoeLA00B8f3EA//hmD3gtAWmiUVHVDjAJpKJ8rKwI9/coOUYJX9TX5V3JQrkskraJLRH0R
 KIaQm9utBqgdw3Bk9sjH4o6HJHlKmFymTGhC0Q==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928187877566131?=
X-GMAIL-MSGID: =?utf-8?q?1594928187877566131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so we don't
need this driver any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig    |  28 ------
 drivers/char/Makefile   |   1 -
 drivers/char/bfin-otp.c | 237 ------------------------------------------------
 3 files changed, 266 deletions(-)
 delete mode 100644 drivers/char/bfin-otp.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c9c3c2028b0b..40947a796666 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -66,34 +66,6 @@ config TTY_PRINTK
 
 	  If unsure, say N.
 
-config BFIN_OTP
-	tristate "Blackfin On-Chip OTP Memory Support"
-	depends on BLACKFIN && (BF51x || BF52x || BF54x)
-	default y
-	help
-	  If you say Y here, you will get support for a character device
-	  interface into the One Time Programmable memory pages that are
-	  stored on the Blackfin processor.  This will not get you access
-	  to the secure memory pages however.  You will need to write your
-	  own secure code and reader for that.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called bfin-otp.
-
-	  If unsure, it is safe to say Y.
-
-config BFIN_OTP_WRITE_ENABLE
-	bool "Enable writing support of OTP pages"
-	depends on BFIN_OTP
-	default n
-	help
-	  If you say Y here, you will enable support for writing of the
-	  OTP pages.  This is dangerous by nature as you can only program
-	  the pages once, so only enable this option when you actually
-	  need it so as to not inadvertently clobber data.
-
-	  If unsure, say N.
-
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 49b7bd84fa20..c97c768cd1dd 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MSPEC)		+= mspec.o
 obj-$(CONFIG_UV_MMTIMER)	+= uv_mmtimer.o
 obj-$(CONFIG_IBM_BSR)		+= bsr.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
-obj-$(CONFIG_BFIN_OTP)		+= bfin-otp.o
 
 obj-$(CONFIG_PRINTER)		+= lp.o
 
diff --git a/drivers/char/bfin-otp.c b/drivers/char/bfin-otp.c
deleted file mode 100644
index 0584025bb0c2..000000000000
-- 
2.9.0
