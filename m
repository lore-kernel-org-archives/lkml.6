Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELudzVM2Diav14LQ4/yZGev7GGCKeQC7qZT2OTSZa8tiwNUNiUYEzcQ9NegYxjpSMVWj5nu3
ARC-Seal: i=1; a=rsa-sha256; t=1521042032; cv=none;
        d=google.com; s=arc-20160816;
        b=hH3pG9aZzIk54WZnoj3EMdC/kRJbwVr6/kSDhh13KmfcIu/E1QVqytQVwN86x524gz
         4hMwGmhMCukdivK3dEZ1ihyFROcPRAFTWMyfB58RdL0ju3LNzz+zg/MU98/UCXRAqHiD
         hiWM9HhmIoZXhFXYr9NGCi9pBuy1yTDnepVR043130a/uQ7zoIihcfYWa0/qiYGQmmND
         ZmCpqA0JSGXdjGzBalKGNr4LYroaSx3OHnoZhlbytZj+XmNgRoz43rh8TqMc3GEmuAKG
         BAccoUeYYXUmfbcYTY2mE+zh0NApUq6eISfF88LUOo3VlqX32HplVlJ4joikZw2jr01L
         Mhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0EezoZbKTJBTmYHl40NN1pu4DD2vcW/lIGz8uJYiGSk=;
        b=bI/RFHqpJdztXUiZTcAFBg7MqP99d5mZprEz+GokYK4yYULb01b23NP3634TCQwMoK
         EIVjd1nXLoXlq1lIiotgXDd0b1xduD42T6zjRjQqtaHyAwQ47j14LKPpemeywCqUaV2G
         +a5i+LZqhL+VSkDaVtV4kmBYO8S7PPzXRp11ErBLZ0FIXz1iUmuKfGoVbUFBgHyZyl7L
         AHiNaJdvP0KwboErj4fX4ozTloLJplqBuI/Dm61UnkmV45rpQ3VPExxQLNI1LEhcjqY5
         1ce92Yz+5ka+KbdVVAoNDlSpeDwTUCky94Qokve0gUOwK/tKbP5KnCl1PA2DxPn4x0B5
         VNuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.187 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.187 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/47] char: remove tile-srom.c
Date: Wed, 14 Mar 2018 16:35:24 +0100
Message-Id: <20180314153603.3127932-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:rYx5LtKRz2Vkp2fRuhfxdH19acOQlWEbD8LGi5kWsLX+BM1oJd8
 N8YEvZeCfLUTHX8LOqEd0qgtdg5P9mc3mNPzrb5no5N5QqwRKe+HSh6iQgcC9Us+Bw1PL7E
 iLXtE5gp2yP201eMhow+DrL3swAFqoN6j3q+7K/rxsoG5eocsULgHWgDEwKc9xhMUJV8dRA
 5oXhYfJ43Q3QYVgJIYLXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QTf5mzL6csI=:eP47eogMgzIu5yI4DVXsRf
 B7hPo8vjJK6ANIUZVWdgjRhNximvGUlxPjhdvL9WhpCXs5sOpBXaw+ekLpyumxiaoH/D1urF6
 Jndq26fz3rmcicYduxHXVqLC7TCuO5yVuRrxccRgGbMLtH+zWscCbtYvYfjt4/k5xl2RJwoQe
 5mNREcg3YEpCxgEMFr8rdJtRGZoFEyNvAyw1/C5D+V1Z4D3iTUJD2ot+X/PJfLh8jQ50sGXNf
 hnlix6Hie2zQSEKXr1W45lolu0JrpBQbcbwdnL3XsTqBDCqcYtNYGbKNlydYZ6us11XWWW+Rp
 reHmVapVN4G77UcAyTVn/fA+LvSHZPLpA0GNCCTgyNk8obF07755kNxP4dO+YS6dVFehw/01j
 cAyXXewVk1Ps16hz/UK0nVPg3SSQyYMLbJnVyD1MedfqWkxTfR8uwKfenVdhKGxugkJa0jaL4
 cK4FcEJg64+NreiQQijGNMDAfuPvpuFg2EWUDRahZNPqSHC75xK5xD+gTKrLqARNMZZCUhGdj
 07Jxtzd3RBvyRbdIjsUNDPiUpB1hP29yMAGjsonvJ7g6dP3owXxHCmD3cVmKqWJyqGF7V9j9k
 Hp7M7A+ttvac3trPGBsVSTlJCmTMo+KwOjka0aU8Rf6UgGPFzoJqUqFQSj91PUVbrlK51RLlu
 qM5a9dz+ZF9lcjnkKchlXvxQ5aStXkdUkPs0eSsPJUB/mFxL0JPSRx1xMhN4581JbrEzpRflp
 qtSNkRCg3UpKsR6hhDO2BSy0pdbPOib0BY9ntg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928170020149674?=
X-GMAIL-MSGID: =?utf-8?q?1594928170020149674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tile architecture is being removed, so we no longer need this driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig     |  11 --
 drivers/char/Makefile    |   1 -
 drivers/char/tile-srom.c | 475 -----------------------------------------------
 3 files changed, 487 deletions(-)
 delete mode 100644 drivers/char/tile-srom.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 3f9561186ad7..c9c3c2028b0b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -566,17 +566,6 @@ config DEVPORT
 
 source "drivers/s390/char/Kconfig"
 
-config TILE_SROM
-	tristate "Character-device access via hypervisor to the Tilera SPI ROM"
-	depends on TILE
-	default y
-	---help---
-	  This device provides character-level read-write access
-	  to the SROM, typically via the "0", "1", and "2" devices
-	  in /dev/srom/.  The Tilera hypervisor makes the flash
-	  device appear much like a simple EEPROM, and knows
-	  how to partition a single ROM for multiple purposes.
-
 source "drivers/char/xillybus/Kconfig"
 
 endmenu
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 4a34a71fe3d7..49b7bd84fa20 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -56,6 +56,5 @@ obj-$(CONFIG_PS3_FLASH)		+= ps3flash.o
 obj-$(CONFIG_JS_RTC)		+= js-rtc.o
 js-rtc-y = rtc.o
 
-obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
diff --git a/drivers/char/tile-srom.c b/drivers/char/tile-srom.c
deleted file mode 100644
index 3d4cca64b2d4..000000000000
-- 
2.9.0
