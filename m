Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELtfalV0k8fCKWpvTV+DGiZPak6+wfI0+6pbjFP69VdtsctV5VXTXA66UDViqKK7REwHqiXb
ARC-Seal: i=1; a=rsa-sha256; t=1521042404; cv=none;
        d=google.com; s=arc-20160816;
        b=gp6k3Du4U6QEOSC2cbv8hPGNzbQTlRhsy5nJ7+7bJUWME8rFnTWAJoznDOHvzVmB+j
         T9wCTuTbrGFL266hmJaawV0C8kWiuJCxYA+W4fHYxBjV2YO77E7ItjkDIDrzyADAJtqJ
         7XdNThNE1SiTZrjjeKxGeaIZILJCyRB2SxDpvLx41HI8BjDQqQi2530gaUqdgwGHeDT0
         XJwbO68hPtWLaaHhUme9lmG1nroUeVi+Cz2A4pJj3JezIRFBAy+oHkcwkcHInFTXY7jb
         qH4fRndD5sYy1tNI29ANBf9Y67yFM3CVfyoIeTHicPux8/TYCB3e7qrE6p88PB68NykJ
         /UXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M7NvSgNWakaTWcqJOagUgbcynuj5G+XWoNuky27/528=;
        b=UcCuzktsR0QyJ0K1igpUliWGRhNBSYzoD+Z/QeIv4uFmZxArKUJfk+S8FF4j8+VK+0
         7BQQqT47DQePZDwzzMANYrMShf8xXfIHXiSQqYwB2btZQee1o7B+6twnGojYDZoEtrDN
         uASbLl+3eqDTnkC2pOygN215orp+RWPAxu/23GNQhRsgg8mOSS3589w9rynaF5AU4uqi
         KG9xT2TqtilXM8rv7xF90fMvbeNktvp6IsARr6qOFCl3XdnAQVbrfqgNk154LmReOV2g
         trLExLgX4EsWLQmxfbKCwkPxy7AbSZpbaVYx0QYw4yb62P878s9C5hKl8sDfEqsV4gi0
         Ln1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tejun Heo <tj@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 26/47] ata: remove bf54x driver
Date: Wed, 14 Mar 2018 16:35:39 +0100
Message-Id: <20180314153603.3127932-27-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:3y3R4vxrDVMCsGvJNYpdvy7LxQQHiN6XQkk1lAWM10rGxi1Qmjk
 f86SKQ6CT/doNlSjienqMWporZRwNCcEX7Fy2XQBZMc5w+Tm70e/seabbapI9w0ImrT0ZX8
 WgGWAGEWp69rllNgqNqPXgys3MrADbztKoR2uxfNN6O6N6dVTqUbKBzJ66uIfplRdJ77+OM
 7VlI7gRVeKGemmBZgcyqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yKxeuhY1I1A=:Ymrmg725XNa4cOdopimjaB
 PUOzeuCYD7GmjYLPPypMLrMrd72og8HOp9t7JnKJKvCgTZwHNLsvsDJXN+muCjdwd3pjDD1Pw
 YUGZmyng1TzIu6/g8FOuMeJYjj+mf7k1fcvEJ1ArYSe412NzqA60tyHQSIsvjPLyWM90tZkaA
 PkffgScMk9qzvOg/FHUo8837NVyF2CGt6CwEop/HgCYnYcnR4lq1WlkcW+njvYJpWqcWx0FY4
 RRwhU5IeW7VzwPitdNLwI30X7iJ30gJ6W1C6OxhLzbiCsDulChA8+ZrwmRv/eG7O0+NcBPr7w
 Qsi8JMoQPCeMnJ5PFjqzGUS28Yll2613+QYTtuofj0WoT74kmGOOsxyf1FNcmSpzE/tKFyvMP
 hyYlzpOX6I8ExYnNHEjcFCIIk+pweHnXZcMJw+d1RZGBexOF1+qrbW2TsZanh8yoxV++nCwZ7
 er+CetJsirEtMHfONX4nFzVB7xn/O6x0FkmJl/GfYPUYvLCxXftnSFqIORRW+ema+BiXc4WFu
 tYBVMvf0JLYyEl59+BRsGioOpXpx6MP55QHFSTfmael0pGmdnHo+JEZGq21S5IQBnsvm6/8bZ
 3+AwvDGxpMB9u22/qRaPmlp8W8DVWIWOUgH0l0DPlehNaEwNXhGTL7M8X3FmO5/ObzkKQS4jm
 f4gI+iFWQS418cJTP/xxV8mCJDfasHUtQYL5AQSu/k+aqd5Kc2o/gn3EU/XvN9ucZrRjCws/G
 BoLSqx7sw7WBCSxGiVvkPpWERtOEbVtqkAh18Q==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928559830025521?=
X-GMAIL-MSGID: =?utf-8?q?1594928559830025521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so this driver
is obsolete as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/Kconfig      |    9 -
 drivers/ata/Makefile     |    1 -
 drivers/ata/pata_bf54x.c | 1703 ----------------------------------------------
 3 files changed, 1713 deletions(-)
 delete mode 100644 drivers/ata/pata_bf54x.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a7120d621154..4582fa27cf37 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -549,15 +549,6 @@ config PATA_ATP867X
 
 	  If unsure, say N.
 
-config PATA_BF54X
-	tristate "Blackfin 54x ATAPI support"
-	depends on BF542 || BF548 || BF549
-	help
-	  This option enables support for the built-in ATAPI controller on
-	  Blackfin 54x family chips.
-
-	  If unsure, say N.
-
 config PATA_BK3710
 	tristate "Palmchip BK3710 PATA support"
 	depends on ARCH_DAVINCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index f1f5a3fbc777..6dae8c985e8e 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_PATA_AMD)		+= pata_amd.o
 obj-$(CONFIG_PATA_ARTOP)	+= pata_artop.o
 obj-$(CONFIG_PATA_ATIIXP)	+= pata_atiixp.o
 obj-$(CONFIG_PATA_ATP867X)	+= pata_atp867x.o
-obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
 obj-$(CONFIG_PATA_BK3710)	+= pata_bk3710.o
 obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
 obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
deleted file mode 100644
index 0e55a8da2748..000000000000
-- 
2.9.0
