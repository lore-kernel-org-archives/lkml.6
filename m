Return-Path: <kernel-hardening-return-12364-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuSVczSiA2Bxvep6MM+vEvGnA6zKpepntRVqw3BUJtGr5nejP6pAfi8MaZS5rEF57NZRS8T
ARC-Seal: i=1; a=rsa-sha256; t=1520663255; cv=none;
        d=google.com; s=arc-20160816;
        b=yy9TnnYW0xV7fz56Pl+nrT93g4xxUe2hgeEL7xOUZhzNbZanXyLM+B5uN8ciz6cl1J
         nIkfGag5f2KBhNJ5RudHC8RYKcrA4qOwt+o35yRs0LWTgk3gWlJVuZCH+Mp2Krn7YIXq
         n6rmW79DyXKrWL5Ed4HcMP3N0RgOKubvoEV8cYb6ogoFiFBgq5fHSQadKAhbI3Wst7Lr
         ocbdBhDDRy3cjAyiUW/TgxiGIcGs6FcmujoqZOinz0MsPaJ6BMC0/IeV2uLbW4a2iAvq
         /l2BuAQTdIIU5lVWfAJ6IOCDldJrwRHfOsVN9WVu9IiOMVI+LKU1LWxeFW6F/WgtRtqZ
         0PIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=K+hubXW5W4Rt8G+O106eo5Ho/k97CbhNA/XxH8krFsc=;
        b=eKI2HDFXQ/KHfcTz2jXoLkN4KIPgKV675SqjJIkVRfWIeHsPccIQ2AT0awILJsBenM
         KbIVWCsvSP5xbIWW1F02EQ7NwEPR0qEr6UXsP88zN4xgX3Dza0n7F0WVHbV0e2OtOXqR
         3aJ/uRpolrNKI6CBkUdRMtLocRYw/B9oM+143G+Zh3oFQTAX6tzmDGVkM1sWpdbwMh37
         2MmyANEChulToTtR/XdZhtSAlB5QrF3KRm4cd5x6RPp3mEMb94P2A3ZOUcBUXDK6ZSb2
         wyZovJkcahBNUR1u5Ng0zpJe09semsAm1fOuZvWQi4rrxnsrZ8ncUeljuLLrFrv9xAg6
         AmXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12364-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12364-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12364-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12364-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 00:27:15 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
Message-ID: <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520660422.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euXyN-001HoT-Dh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:42576
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530993391759902?=
X-GMAIL-MSGID: =?utf-8?q?1594530993391759902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].

[1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-s5m.c           | 11 +++++++++++
 include/linux/mfd/samsung/rtc.h | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 6deae10..4c363de 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -38,6 +38,17 @@
  */
 #define UDR_READ_RETRY_CNT	5
 
+enum {
+	RTC_SEC = 0,
+	RTC_MIN,
+	RTC_HOUR,
+	RTC_WEEKDAY,
+	RTC_DATE,
+	RTC_MONTH,
+	RTC_YEAR1,
+	RTC_YEAR2,
+};
+
 /*
  * Registers used by the driver which are different between chipsets.
  *
diff --git a/include/linux/mfd/samsung/rtc.h b/include/linux/mfd/samsung/rtc.h
index 48c3c5b..9ed2871 100644
--- a/include/linux/mfd/samsung/rtc.h
+++ b/include/linux/mfd/samsung/rtc.h
@@ -141,15 +141,4 @@ enum s2mps_rtc_reg {
 #define WTSR_ENABLE_SHIFT	6
 #define WTSR_ENABLE_MASK	(1 << WTSR_ENABLE_SHIFT)
 
-enum {
-	RTC_SEC = 0,
-	RTC_MIN,
-	RTC_HOUR,
-	RTC_WEEKDAY,
-	RTC_DATE,
-	RTC_MONTH,
-	RTC_YEAR1,
-	RTC_YEAR2,
-};
-
 #endif /*  __LINUX_MFD_SEC_RTC_H */
-- 
2.7.4
