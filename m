Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELutry1yJLsuxZKdZ/a7b5BisO+EeQDpek0JMUKyjT6tv1YsQBVjPShOT11oiZH4UUYyYb9Q
ARC-Seal: i=1; a=rsa-sha256; t=1521042010; cv=none;
        d=google.com; s=arc-20160816;
        b=CBuli2043BulvElU6MMA5djTe5qCWnK21KxxieEAZPsK/rla0UmxrBwxGW9a/6sk6M
         uM6518s3dF9FEWAbUSlaZUTGkWBrw3EdIOc3sflUAh2h6dWMFg6jyJ0MWDypACjT/4I8
         RAGjfeY5u9baIJTL1SjYh8rKmhj8Qyt02r/NFquuQs6ACPJSI2z59Z4tuPmx1Vm6va/S
         NKh4VevUv6/X1YrW+zmhnseorcVFbxASLEVFrLeHEbThWYJOxVgAurDCC2osDlwY3kea
         QfZ2RJBkEcrDHOncBHfzuudf3PEcpc9yOuR0vusgnmncORopx8u7HwaovU8znAiIfaQd
         pd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6bWWGXkv+24lZ/1LijfLYA85O2ePLUE77YFsr79LXUg=;
        b=d4DrAS9HDa7HaQHvwxv5/kPcNYlqHxLX7FIZBFKbV2rgpbvLooqYr4LNPhlMOf0zAR
         yJMuMOpvOXRc1nJkKuzW0bxSWn7xYbbBceSp9cB97d0qnnGPlurbWwox1rGoCJRS1EyE
         uIeoMS+oj8yu3EbsqA5VKon95dzs8S7wok2twldIRhOcg3DlC3FR7rogRym//Hc41AzM
         6GFoahUES67xsoUBg18pt2g6q8Oy1+5S9dhQ4bTt+cVlFB3w4r9U32dIOKnF6IvIanx1
         ii1Is2kPLRv1w+a6DmtCCH/UsIjeYISxOwHdbOLYsPJli04M94qYvzXbIAmJmAdkAJ/z
         uelw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/47] char: remove obsolete ds1302 rtc driver
Date: Wed, 14 Mar 2018 16:35:23 +0100
Message-Id: <20180314153603.3127932-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:2ejy10Bv4MfRKb2qvKKRY8o+wyE1HfORyTPSD/sLk/3ocPYKG9g
 3Hv62hdwlw+MMQc3tDBTt8avQWix2fuW1zvVxQDMJwO2inynBZxISDOrBwFCTwe+2uZWKgf
 bonIHtaoUEC2twva94jpA52k6vWrbVpWY4t3jAzsDEU8e0fUT/pTR8u/JLfxGesGNkedJHY
 YKodfpKQPchUmaKyI+AEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:18Z8rBBg2pc=:iOuAtibiJpUPWcpHqGjbJp
 wjeJF18qdzixv+XLfY7ODSAkD83K14MbserH4B2UnuZjx+IAhvO3BNzOp44sdoLXMdFjm5jpK
 sW/M/zWV7PYfYxlFkVGLDtb+Rk4QY0xnVvJBwd1Qm2Q6y6bYVwOib9+FOJJr3HtMLhF6zfQ4C
 fkzp010zajDwlMnANax0vpO5Lhx52dQflop5L5SQPAt+cM0Ev9MGqd6dljcvXxGUdmHpUNlQ/
 8gEmTQnrs6rF8Jj4TsI83vkAqr14u4f85AJu060ZF9s4BfGBraCFMGvFyyTYxk7ynJ3QRW80E
 i46u5ctxOoQxCOrYAjNT3typet1xVT1ysM1c2CJW7DfQjEd2ss/v2qj2v+Nu8X2pfKqPQ+UKJ
 tNZ2vFVSm9udgHj5NMggkbVdyo1TIbrU7IKX9E08T1nrcVtyJO/xseMTPtlE+53PwbVfPP9iZ
 qy/UK8K2IvmuF9MQwBhIwORRp8To7jhozD+QZ7EL6og0Sf8UjxUybKEgS673VdZg67z8yONjE
 8N1jHDOIHSOzLeM3kFJguIrzlHw3EKr8XVU/Er0WQxfShoexV5kwW9PFdHtZF3HTQOKZ178zS
 zDx+CYnDgdKyVZ3sWs6jPOEnDlj6m6X9BgkrHxi+q9LmowC/izIW+/hX/FmCB5drJlt7twrPT
 XtEGs4z0WlLGQTneDmyA9pVBdH1e6u8WuEM8mf9zLH4CX/MeRfdqatLSYk8ZTl2G+gGghL/OD
 NKaBGGzWAvX0rVdZe1bvCQr2UvfAPDYJXrh5nw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928147005856110?=
X-GMAIL-MSGID: =?utf-8?q?1594928147005856110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The m32r architecture was the only user of the old-style
rtc driver for ds1302. The architecture is getting removed
now, and we have a modern driver for the same hardware in
drivers/rtc/rtc-ds1302.c, so this one won't be missed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig  |   9 --
 drivers/char/Makefile |   1 -
 drivers/char/ds1302.c | 357 --------------------------------------------------
 3 files changed, 367 deletions(-)
 delete mode 100644 drivers/char/ds1302.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0c613d..3f9561186ad7 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -346,15 +346,6 @@ config EFI_RTC
 	bool "EFI Real Time Clock Services"
 	depends on IA64
 
-config DS1302
-	tristate "DS1302 RTC support"
-	depends on M32R && (PLAT_M32700UT || PLAT_OPSPUT)
-	help
-	  If you say Y here and create a character special file /dev/rtc with
-	  major number 121 and minor number 0 using mknod ("man mknod"), you
-	  will get access to the real time clock (or hardware clock) built
-	  into your computer.
-
 endif # RTC_LIB
 
 config DTLK
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 7dc3abe66464..4a34a71fe3d7 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_SONYPI)		+= sonypi.o
 obj-$(CONFIG_RTC)		+= rtc.o
 obj-$(CONFIG_HPET)		+= hpet.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
-obj-$(CONFIG_DS1302)		+= ds1302.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
   obj-$(CONFIG_NVRAM)	+= generic_nvram.o
diff --git a/drivers/char/ds1302.c b/drivers/char/ds1302.c
deleted file mode 100644
index 8e16ad5d6d89..000000000000
-- 
2.9.0
