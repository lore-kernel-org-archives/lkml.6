Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x225OQv11Vt053ubQ5NOk/pw9aU+/ZJvVBQ0/EHiEhRW3t/iCdOZtJXzQVLDy43AswHz8Zhej
ARC-Seal: i=1; a=rsa-sha256; t=1519163052; cv=none;
        d=google.com; s=arc-20160816;
        b=IgRlkhOkn4ggcpf9IfOW8P6x612b/7pE/upiwz3DspqwXH1Yxc7nCItRyK3sWWkUkw
         b7Bv3yDVzvnp1pwWufYuQ9iMXNegIK7BflBLBWUlrdY8IET8D2A6Vv+Y2AZ6MRHiGyO6
         zRWl01J5bH5oR/qxa55eEyh8cTTqzdVU+Go1Z+pq+UyQ7Mslrs1Qoqs054hhHzVMWM5U
         1k2gYhB0tiiqRZaWDYzuzcN9b5nPlyrhPa289nc28HfKUznKg6Gm90Iq4OvwxRgvEBoV
         AUU7SBJP7h/mNNhA+c/GE0Y/ELFk4yvqpAZ/gNJCEsMOaPQKvg2l7RitkUKpJv5nT8Bu
         iU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=si6RgHZDUTmr+PY56nzCKuCLAJJxMRhaMAV3HNW0F4Q=;
        b=k8DlMNzghP7eayr70MSD8FLcRZ8pHcvVNCx8uWpTLzSgIXsV4iEPlqdBz5QyVwewjV
         jbivZ3Whh2SqK9ilv/UMtDqCD3eo1+IMl6zu1P0vRkSUi4vBXpJ8q2FWW/L6dRvGGHgS
         PWEJkxIOQEWoF90gf1ZMA/Lc8aspYMfRn/xggSnNxhIxsiq1EWGB0lexMlGEJdZkHGmy
         Vqjwh+IPnFoTbrKuNONZyyufznXRHTScF09V2m0zxLxeIhRjCI0ViK5b8QdISMwAKwTe
         vWU9igOwSOGPzY1cumWu8j96ADIsPE22SaMIM2h54u85lcKT66ROHJKqOWgpaDhOKUa/
         IIyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19075781"
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
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 17/21] rtc: tegra: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:56 +0200
Message-Id: <20180220214400.66749-18-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957917281747275?=
X-GMAIL-MSGID: =?utf-8?q?1592957917281747275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-tegra.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index d30d57b048d3..e9adfaa851f5 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -124,15 +124,7 @@ static int tegra_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_time_to_tm(sec, tm);
 
-	dev_vdbg(dev, "time read as %lu. %d/%d/%d %d:%02u:%02u\n",
-		sec,
-		tm->tm_mon + 1,
-		tm->tm_mday,
-		tm->tm_year + 1900,
-		tm->tm_hour,
-		tm->tm_min,
-		tm->tm_sec
-	);
+	dev_vdbg(dev, "time read as %lu. %ptR\n", sec, tm);
 
 	return 0;
 }
@@ -150,15 +142,7 @@ static int tegra_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_tm_to_time(tm, &sec);
 
-	dev_vdbg(dev, "time set to %lu. %d/%d/%d %d:%02u:%02u\n",
-		sec,
-		tm->tm_mon+1,
-		tm->tm_mday,
-		tm->tm_year+1900,
-		tm->tm_hour,
-		tm->tm_min,
-		tm->tm_sec
-	);
+	dev_vdbg(dev, "time set to %lu. %ptR\n", sec, tm);
 
 	/* seconds only written if wait succeeded. */
 	ret = tegra_rtc_wait_while_busy(dev);
@@ -235,15 +219,7 @@ static int tegra_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	/* if successfully written and alarm is enabled ... */
 	if (sec) {
 		tegra_rtc_alarm_irq_enable(dev, 1);
-
-		dev_vdbg(dev, "alarm set as %lu. %d/%d/%d %d:%02u:%02u\n",
-			sec,
-			alarm->time.tm_mon+1,
-			alarm->time.tm_mday,
-			alarm->time.tm_year+1900,
-			alarm->time.tm_hour,
-			alarm->time.tm_min,
-			alarm->time.tm_sec);
+		dev_vdbg(dev, "alarm set as %lu. %ptR\n", sec, &alarm->time);
 	} else {
 		/* disable alarm if 0 or write error. */
 		dev_vdbg(dev, "alarm disabled\n");
-- 
2.15.1
