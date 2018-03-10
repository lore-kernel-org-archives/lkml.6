Return-Path: <kernel-hardening-return-12365-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtiHOD5khbXamI9EmGVst7dm/GfsR8CGS6VkccMjMO7zZJn7EH/XWph3Gb1rcX2lasWMdmT
ARC-Seal: i=1; a=rsa-sha256; t=1520663275; cv=none;
        d=google.com; s=arc-20160816;
        b=FCitPlQhXfRybapQLrXbtionTtjZG2SYU2jXOGdB7nt4uVWtZS8kSwFS0E02jK7qlM
         6cgQCxD2BEZz2MQvzyYJT23OqEXzFNOsFtl3sNL3gKSpTLcczZD2hnDamzyoT4dLkF3r
         ymwyhC34CX0yaSXp7bwPPNaLBKxghUvw9fADUle9YqssXCpdD5r3mUltkU/IzVPimUen
         N8F+6lw3Jy6CULWbbOdPsgZCsj187ksYy1qI5gDRjiqt0hoHE8T2R7w0V58pPgiVjYqj
         /zPft2eeMewJZZIZyZazCOXOIS2FwQtGm74JTx3xGF2tibOCoJJaAbs3fMQaV7TqbgvQ
         dd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=fXIyBNRa0vqhHE02ebxtxCjPHKEFT9gsmCw5zvwyeVQ=;
        b=rKlp0P7ORdw/FuQRwwxSdpHauAcn9gDuwUBA5966aqhYeJKbecOB9wQFZHmoMcfvC9
         daxDZ51A6cTAto1hrrsngh/6UcIuBAxXt4gJfgzowQLzm1ON+8EpY8A8t8KPhEQvE6Ya
         ExooVALJ60Y6j4N7aqo1icer7pIvb+1AyRrnGlFa8s4zh6WRAWLCaVd2SlnGNPP2Pa8L
         YXh9K1CZg7Cy2lm6lSCf4Y9bXCZUZIbuaLzQ1i+WD1KRKNEVyu21mBGhxwUoJ0LXRVZJ
         2KhU4dhAYm5+vOTnLSQdFP2rCUEWdw0XwYH3CrKzVJv+g+Z0NxjMNsle735CVJh/i1Sl
         ijRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12365-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12365-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12365-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12365-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 00:27:35 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 2/2] rtc: s5m: Remove VLA usage
Message-ID: <543a0a74122172acae549329b35964f402da8b77.1520660422.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1euXyh-001I5o-K6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:42578
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531014694271263?=
X-GMAIL-MSGID: =?utf-8?q?1594531014694271263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLAs and replace them
with fixed-length arrays instead.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-s5m.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 4c363de..8428455 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -47,6 +47,8 @@ enum {
 	RTC_MONTH,
 	RTC_YEAR1,
 	RTC_YEAR2,
+	/* Make sure this is always the last enum name. */
+	RTC_MAX_NUM_TIME_REGS
 };
 
 /*
@@ -378,7 +380,7 @@ static void s5m8763_tm_to_data(struct rtc_time *tm, u8 *data)
 static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret;
 
 	if (info->regs->read_time_udr_mask) {
@@ -424,7 +426,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret = 0;
 
 	switch (info->device_type) {
@@ -461,7 +463,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	unsigned int val;
 	int ret, i;
 
@@ -511,7 +513,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 {
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret, i;
 	struct rtc_time tm;
 
@@ -556,7 +558,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 {
 	int ret;
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	u8 alarm0_conf;
 	struct rtc_time tm;
 
@@ -609,7 +611,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[RTC_MAX_NUM_TIME_REGS];
 	int ret;
 
 	switch (info->device_type) {
-- 
2.7.4
