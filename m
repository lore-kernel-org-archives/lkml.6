Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x226oy0veEa0MB/XUaSBGtWUCPnAjVeuU9RmJ8bZEU8CHlSEjTaoHrPmVWuDdzJVMyU8YOGIa
ARC-Seal: i=1; a=rsa-sha256; t=1519163049; cv=none;
        d=google.com; s=arc-20160816;
        b=KN3gTkYWEjZb+ABBIwX0DnRg7+dAvmczVitQZc6pWcEa5gjI6w+wo/RDmI1bsjtIPt
         s+iBAQA5JJqFS0HKrVlRWiu8gsglZFGg4hQPVm4IutY2mMCftc4hNqQ0Yj1BVhmUWj5I
         dr8+kA5jzigdP8YyVdkVjBnRYLNUUkl6sVYMGdJbffkgfz8VRtOYHZ2WCqmPLKx2U8gL
         bPBi9SX5yM96F+3YqlkBYUwoFSreWa0H198ddQIdHRPqAI/wCGxBdxPB6fyxchXJDiOs
         UK1qdsXyMS94XhY2zgnAfpgoMj/d+k/T0NnBgd2JqbGnjdC6hnuU934u5egok0MarABX
         kM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3n0EtOpf3bWwPePmIiVvbxZ/oZ8yTtV5PfIfdZorxeA=;
        b=xBRyPPVTiaoql50tG/1WvzR6n1KsNBt6+z2LQK41UDNs8uJ9bLnqRBk25ciZwGsV+X
         Wm1c+imxqmkjbwfxtAEl83elNT5og73SmFUgsfsGbnBPO4SR2K35tfpQfY9GSORhUdxi
         EPYd0TpCcoPHbQ24X16PYzhnFZfA4CNYPnSq/4XE6i06igWmJZcIxgGhvtEwpiOle5jo
         HVoxuaH6XpBz9Po/IKaRbU0Ts5mcUeiI7hoiD08gP1YPqqmOCZVGoVpPrHWU1F8L9kKj
         sbRPpc+RSnuKQwNCQguulnTm82C+0+/0y2os3yH0Tv6ZPMeUFXRMYzsG9Ye4c0ETuPrV
         VA6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="205722113"
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
	Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: [PATCH v2 11/21] rtc: puv3: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:50 +0200
Message-Id: <20180220214400.66749-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957913321654363?=
X-GMAIL-MSGID: =?utf-8?q?1592957913321654363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-puv3.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index 9e83be32ff43..f77ef282f013 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -90,9 +90,7 @@ static int puv3_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 {
 	rtc_time_to_tm(readl(RTC_RCNR), rtc_tm);
 
-	dev_dbg(dev, "read time %02x.%02x.%02x %02x/%02x/%02x\n",
-		 rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		 rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+	dev_dbg(dev, "read time %ptRr\n", rtc_tm);
 
 	return 0;
 }
@@ -101,9 +99,7 @@ static int puv3_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long rtc_count = 0;
 
-	dev_dbg(dev, "set time %02d.%02d.%02d %02d/%02d/%02d\n",
-		 tm->tm_year, tm->tm_mon, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %ptRr\n", tm);
 
 	rtc_tm_to_time(tm, &rtc_count);
 	writel(rtc_count, RTC_RCNR);
@@ -119,10 +115,7 @@ static int puv3_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = readl(RTC_RTSR) & RTC_RTSR_ALE;
 
-	dev_dbg(dev, "read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
-		 alrm->enabled,
-		 alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		 alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "read alarm: %d, %ptRr\n", alrm->enabled, alm_tm);
 
 	return 0;
 }
@@ -132,10 +125,7 @@ static int puv3_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time *tm = &alrm->time;
 	unsigned long rtcalarm_count = 0;
 
-	dev_dbg(dev, "puv3_rtc_setalarm: %d, %02x/%02x/%02x %02x.%02x.%02x\n",
-		 alrm->enabled,
-		 tm->tm_mday & 0xff, tm->tm_mon & 0xff, tm->tm_year & 0xff,
-		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
+	dev_dbg(dev, "set alarm: %d, %ptRr\n", alrm->enabled, tm);
 
 	rtc_tm_to_time(tm, &rtcalarm_count);
 	writel(rtcalarm_count, RTC_RTAR);
-- 
2.15.1
