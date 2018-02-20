Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x2258Q30x/ywv10btLBhD8K2hsVg81IqnYw2L5INwEqXBk/nRbX8sX00lJ9gM0lvtklFycadK
ARC-Seal: i=1; a=rsa-sha256; t=1519163053; cv=none;
        d=google.com; s=arc-20160816;
        b=OeQGpbasVAbX0oN5ftfWdiwZUz57XHOmGhFOh55//pJg5ZA6atFuaHsuQsCb7E9v7j
         trgDkUaMaAm7saZbWoLQaNIv9mfbq2h5CRt8GH9qQi7fUy+V/PbjM3JH64rhzMhIVl+q
         eujbfKqSsmcypFW1U4xJG3p32bbUGFNKQIrDtVAHvSIJ2mHalKlrv2+esh57yUggl0U/
         E0UotnrQUC+W2TcjLGuXbsL8jY8fAyPR/hfCBPf+bZ94eIpZv/6Y49h3bx9s3wmYMUpr
         dD7Vp7lGVFGFqsGyAI3NAN7i/g6tKlaJbY1aCLTOkx8jCtpxYii2BXUoqhN3K3HdAQnx
         wlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2kWeXgjIiDsb3bb24MKm5UI5R5qpeeb1MguztWr4J9c=;
        b=BcIOh6SwE0Q7USPrQldZ0kxFpWUljNaF8/NQqeqU3cRCC3r1gwOoIenlJ64RJDR/N1
         yWN7COP5mZ79Qz+5yk+YJU0Hl0TRjGnEu9NLOdCnJtYIJ9T2JKIi339/C/yjFbeT+yh/
         DXRbmavxzoYBY/I9Nve7GY/OwKhKnsdHwOiMWtbmWQ/ufDPVmMAnN1EC7dzsO3LXjxOI
         ePqx27ejT8i+xR3Kq7t42g8XFoJZMFSStD8SIYTu+7znBxPOesSEFQ4rsgHkZLhTiCyL
         mhThmcd3oMq3/g2uAazKfvvJXagRGLQ3o0Byniwu87VLvUjXAb44RpXqrEgNduFD3Veh
         J0lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="28597073"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Joe Perches <joe@perches.com>,
	Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 19/21] Input: hp_sdc_rtc - Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:58 +0200
Message-Id: <20180220214400.66749-20-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957917232615145?=
X-GMAIL-MSGID: =?utf-8?q?1592957917232615145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/misc/Kconfig      | 1 +
 drivers/input/misc/hp_sdc_rtc.c | 8 +++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 62a1312a7387..f0f09ef79081 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -525,6 +525,7 @@ config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on (GSC || HP300) && SERIO
 	select HP_SDC
+	select PRINTK_PEXT_TIMEDATE
 	help
 	  Say Y here if you want to support the built-in real time clock
 	  of the HP SDC controller.
diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 49b34de0aed4..503ff518dfa2 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -441,12 +441,10 @@ static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
 		seq_puts(m, "BBRTC\t\t: READ FAILED!\n");
 	} else {
 		seq_printf(m,
-			     "rtc_time\t: %02d:%02d:%02d\n"
-			     "rtc_date\t: %04d-%02d-%02d\n"
+			     "rtc_time\t: %ptRt\n"
+			     "rtc_date\t: %ptRd\n"
 			     "rtc_epoch\t: %04lu\n",
-			     tm.tm_hour, tm.tm_min, tm.tm_sec,
-			     tm.tm_year + 1900, tm.tm_mon + 1, 
-			     tm.tm_mday, epoch);
+			     &tm, &tm, epoch);
 	}
 
 	if (hp_sdc_rtc_read_rt(&tv)) {
-- 
2.15.1
