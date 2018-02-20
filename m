Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x225uc8ymqaQ3c8mPstcjkCvysdJijr8O884MBtYziCDaYt+kUFWa9Koa4QvkFiY1iGlyloTG
ARC-Seal: i=1; a=rsa-sha256; t=1519163045; cv=none;
        d=google.com; s=arc-20160816;
        b=MhH5gHIkqkQBnQcyUT6k3viURmRN+QZNFevIxeKVZTWLeNz0r0vnHbzBdaY/q/MAEU
         hQYyh81DFPRGsLaG9OKGZBFwWNx1Tw6xa5ioC95nzsYnowu3HZumwPBnCJR0bjfiagXq
         CEh3921vYYzQwD8nH3WZSx6HtKx/AvxzZX7Yp8LixgEdUN3YS1euG5TrB4OBj4SzmLsc
         A/j77/2qJqwsKLdFhAR4C6wPAX6QXyUBEP6Pl/99iIHA8gdZv42HMypOhLPIQiYK9K72
         pDSsaX9G9RwxsTCt2dxZbgTMC8UTYlZZT/UkncLwM2ymISzinWnA51ZM7aMg2Lg1GQaa
         u+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=eH1xd732hBVRZXIPf9pRSM50m0eI7C7wtcn7tWaW2Ow=;
        b=XCHkDZB9rFe1pql80JK8BN39QohUkG3toXWuGaz0ERjq1p9fOpudUUoSLkRFGwwfjx
         sNhq0Ubf11jJ3ZCpDLhdvOul6YKhQetXhHG2SeFKQB4d2sjFQI9qvFZeDi1B1KiOVU3R
         IlcU5VylXZG/rYydRy7AhD3HVoigNlqEyMzuDndZy+jOqDGH2PqoLEiW6uGcZF3iSKxy
         lfvQTTZKBm9PGgydUaqjke65tucxRJqxCn/ZWkEd+ytP2ObwUW41WFOSE/eF9ie68sHx
         H9IBd6kWpgevubEhuznE75jQZqSbJI0OzW1xPqEHytN+gnNI/J3Mx0jAQFyVCVwvTAYt
         59dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="28597056"
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/21] rtc: at91rm9200: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:42 +0200
Message-Id: <20180220214400.66749-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957909475516653?=
X-GMAIL-MSGID: =?utf-8?q?1592957909475516653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-at91rm9200.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index de81ecedd571..debffb9f7574 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -147,9 +147,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	tm->tm_year = tm->tm_year - 1900;
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s(): %ptR\n", __func__, tm);
 
 	return 0;
 }
@@ -161,9 +159,7 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long cr;
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s(): %ptR\n", __func__, tm);
 
 	wait_for_completion(&at91_rtc_upd_rdy);
 
@@ -209,8 +205,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->enabled = (at91_rtc_read_imr() & AT91_RTC_ALARM)
 			? 1 : 0;
 
-	dev_dbg(dev, "%s(): %02d-%02d %02d:%02d:%02d %sabled\n", __func__,
-		tm->tm_mon, tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec,
+	dev_dbg(dev, "%s(): %ptR %sabled\n", __func__, tm,
 		alrm->enabled ? "en" : "dis");
 
 	return 0;
@@ -247,9 +242,7 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		at91_rtc_write_ier(AT91_RTC_ALARM);
 	}
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		tm.tm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour,
-		tm.tm_min, tm.tm_sec);
+	dev_dbg(dev, "%s(): %ptR\n", __func__, &tm);
 
 	return 0;
 }
-- 
2.15.1
