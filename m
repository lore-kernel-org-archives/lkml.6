Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x224GBm0xzADJagEREelO0cW5lkRgJCLoTJd7A4xEW6HQpMyTOe3lRL5qjpfhDWtjaucMd6xo
ARC-Seal: i=1; a=rsa-sha256; t=1517954753; cv=none;
        d=google.com; s=arc-20160816;
        b=dJn4DpshJOnT7IwevICJl6JVEXj16ZI+FENoVQbZdAZmRBLAhvSW3wb03aAiM9eEdM
         GR4dT00sExcVHurrIm++ndDP2RE/AkQ36PYzpEYSYlVvQLbDyPdLmLuSNmQBTczj4LBe
         u4lF8lnAuf3qRU5roBwaRDNz+LKGdvtbnAOM22ySkl6lZns7OWr4pvVqEOYNPFkvICel
         HN+P9NOg7geYszJaGzJZoCP/PZ8ntr4K8bA4qlUWTEQMz6Gsc6f+jujgzHJ0ocRV+9Jj
         Le8apAN8h4OgAMOWmhVIzqDrH7VOcUpBKKr1hLta1QWLV+wfJbpJkXlcTdwLqZ7AXCws
         ovPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+hPL+/cwNpZSKpA4OBHNsrGpYsKw8gVA4vh6g66YEiM=;
        b=Ks6teBkRBtnbr9RVpj1IPhvmABnYwiNkX7yxrkw5kgjY2ftbLwR8iHlyG7T3JwVIEq
         HfLRdapSd24OWBrs6nuMTbb7bytpmXDjBeFPY5Q2Styc4ERBDNVb4n0HjBNFp8hhGh3s
         DghqctmgJ/gxTg9SCiyOeWP/PtGMVIIkUZBiff3kvEnspSzbjH0kuOtuRmO2FUwu5BOS
         hHcTl0jzK7DezHV3svkKRjBK30mRHENcb43PWbforMiFjFafrzxtjzbfkYbRbBmIZ/Qz
         SD/aeooG/OJqKhs1GjrlF6/iSnsNq+5YOfASftsk+MkCn3lR7mZms+7nZwj2e7TRZm30
         91NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] char: nvram: disable on ARM
Date: Tue,  6 Feb 2018 23:05:34 +0100
Message-Id: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591690923969903275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

/dev/nvram was never meant to be used alongside the RTC CMOS driver from
drivers/rtc as it already expose the NVRAM through another interface..
Anyway, the last defconfig to enable it properly was removed in 2010 so
prevent ARM users from selecting it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0c613d..9bcac927cfd0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -264,7 +264,7 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on ATARI || X86 || (ARM && RTC_DRV_CMOS) || GENERIC_NVRAM
+	depends on ATARI || X86 || GENERIC_NVRAM
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
-- 
2.15.1
