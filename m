Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288202; cv=none;
        d=google.com; s=arc-20160816;
        b=YE8cJwUtM/MfAojOetmmL6OOasRcIUUATPrtJBNNIej4YUWf2ZP7lMIVxI+gQCcj3e
         WzUCJqbguTdk9BG7lDl1M7MLx0fe7A/NaMitB4GJ5XaUrJDA2yrgkXculfrbCEqFm0Ba
         uphPW7oOCoUQxYnIGiWraUAczq5VVQ+vl63sRactmhwI/zO29sZqDev8X8afhMJBHhAc
         altcuwVo/fvnRNQYM32l2xhAZxQ6jbes8MzvdxPj6jHoEFRd21ulYbXKvQIoNk3nDrkz
         dtyVAu/XMYhM5E3oa6Mge6fcLT74z9JcSlokqeum5phzJ9PDVY6+KaOiKcW8B0KlOHbp
         eGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sa47kacdk4A6CY2LuxKzGslqtwVkcT70aRUQGxEH/o8=;
        b=IOdkd59pCYe0RcvvHKeAgBAxGOf8uYSVoRkstLIxE+q4e84k97DEoSdmMv6J2n/hiX
         IdZapcevA03Ojk6eUHx9EqgGS2GGBgpE6IAkRWLOzCfHYbCIItWoR9sf2YIECEm7alOR
         EXImkLdwcGE0TrYFL9gFbhknR2JLdG1chivdHDJSp5n1+KnsX8jJmuEcH8AdxF8IBuv/
         y3r7Tcf38145+3LPeb7uU6uBeP7TNUbVqxSEy0p83iIFNNr1pS/YoTyUtRz/37GUWL6V
         6UYLn4fpCdAtA+B29hg1uhWggipBmI42wb+2Osb/Z9qFMSb6QjkyTxakSo8MtN1P/dbd
         5zgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Z58Go2DS;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Z58Go2DS;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpy61xOTfR7I7HJgI0+5v1fcI9Tf//da1QXFbrWIQJGSb4UvSRZrsVk7C40HRqPTmconwaprQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de,
	john.stultz@linaro.org,
	daniel.lezcano@linaro.org,
	arnd@arndb.de,
	tony@atomide.com,
	aaro.koskinen@iki.fi,
	linux@armlinux.org.uk,
	mark.rutland@arm.com,
	marc.zyngier@arm.com
Cc: baolin.wang@linaro.org,
	broonie@kernel.org,
	paulmck@linux.vnet.ibm.com,
	mlichvar@redhat.com,
	rdunlap@infradead.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	heiko@sntech.de,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	mingo@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	douly.fnst@cn.fujitsu.com,
	len.brown@intel.com,
	rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [RFC PATCH 04/10] clocksource: tegra20_timer: Remove register_persistent_clock() API
Date: Mon, 14 May 2018 16:55:30 +0800
Message-Id: <ee93d3f510b1840199f6c9afe8cb08c82d3afcf2.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429179008861466?=
X-GMAIL-MSGID: =?utf-8?q?1600429179008861466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We will convert all drivers to use persistent clock framework to compensate
the suspend time for OS time, instead of using the register_persistent_clock()
API in ARM architecture.

So this patch removes the register_persistent_clock() and implement its
function to read persistent clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/tegra20_timer.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a81..97a34cb 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -124,7 +124,7 @@ static u64 tegra_rtc_read_ms(void)
 }
 
 /*
- * tegra_read_persistent_clock64 -  Return time from a persistent clock.
+ * read_persistent_clock64 -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
@@ -133,10 +133,16 @@ static u64 tegra_rtc_read_ms(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	u64 delta;
 
+	if (!rtc_base) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+		return;
+	}
+
 	last_persistent_ms = persistent_ms;
 	persistent_ms = tegra_rtc_read_ms();
 	delta = persistent_ms - last_persistent_ms;
@@ -259,6 +265,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
+	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
1.7.9.5
