Return-Path: <kernel-hardening-return-12241-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELubxusHGo6un3ZdmXV0ajnz2APGo/lDaeG4HEyJkXV+oOECcTqI4QqXkFM3w+dxs5AO2Ga+
ARC-Seal: i=1; a=rsa-sha256; t=1520529655; cv=none;
        d=google.com; s=arc-20160816;
        b=0xihoiD4V9kQlq9BtZxn8RJcPTkV9UafeGlHNxFhe9HJ9M5vxXLdQbOWx/vtAFxA3c
         2gFVbksqzzPOS51jSc+G92fwQSS57gKO8t3JdM4qCFSMyAIz6ipIF9CBfNrk3sPilqHB
         IqixfwucNTBnSF4Stpq9hlhh/2HJxQQKlotZ67nMCLEzfa3Hi9/E6AC+vxQTDRXzK8IT
         c0JuP5qgkOMHW78jqD/b/5HfjKfmj0Vv6nfq5si57CVKp2mVJyrsTJiSimCeQqu+kAS0
         k2aU+MJJlIP7h3oePMV8VUvANYB972Z0tPjPOHmrehya9N2MC7VdnqTzFOv+w504cMBz
         stkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=nSAAsSuKIHxTU5aSprXRug7VF+e392PFASfqZFeUc1o=;
        b=xBAnKwxivFyq4wu/N0iCZyXxx1Zy+BpeS5ZaWte8CZDu8PZBa0A1yegN4rKhzLlPd6
         OcZKeBEk1wDIR7Y2YdmLtcphmLboh9CKe8L7twLHlYalmjCk5xOr0ZCBSCJGWt4wrjI1
         DrJ8HyTGa8JyeaYcTaYzZgE+Gkrndg/lWMhvJzTSqGGYw1rwrIrqFcDQU1FMGl8kS5kr
         yJEOOjdpipPAqRjqdb+uc7CIJdHu9d2tR8CSFcH+sJomjzdf5HmFAgXcyMo6FCGxIWsT
         b3Ji+v1kLfZq9iSkPOBXkovRZr0zryOTcw/iG9qaZefG6uKEH/Aat7BKuNywd/uZ/oo2
         GdOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12241-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12241-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12241-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12241-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 11:20:31 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] rtc: s5m: Remove VLA usage
Message-ID: <20180308172031.GA14541@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1etzDU-001sYn-4f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:58486
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594390903982064564?=
X-GMAIL-MSGID: =?utf-8?q?1594390903982064564?=
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
 drivers/rtc/rtc-s5m.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 6deae10..2b5f4f7 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -38,6 +38,9 @@
  */
 #define UDR_READ_RETRY_CNT	5
 
+/* Maximum number of registers for setting time/alarm0/alarm1 */
+#define MAX_NUM_TIME_REGS	8
+
 /*
  * Registers used by the driver which are different between chipsets.
  *
@@ -367,7 +370,7 @@ static void s5m8763_tm_to_data(struct rtc_time *tm, u8 *data)
 static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[MAX_NUM_TIME_REGS];
 	int ret;
 
 	if (info->regs->read_time_udr_mask) {
@@ -413,7 +416,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[MAX_NUM_TIME_REGS];
 	int ret = 0;
 
 	switch (info->device_type) {
@@ -450,7 +453,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[MAX_NUM_TIME_REGS];
 	unsigned int val;
 	int ret, i;
 
@@ -500,7 +503,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 {
-	u8 data[info->regs->regs_count];
+	u8 data[MAX_NUM_TIME_REGS];
 	int ret, i;
 	struct rtc_time tm;
 
@@ -545,7 +548,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 {
 	int ret;
-	u8 data[info->regs->regs_count];
+	u8 data[MAX_NUM_TIME_REGS];
 	u8 alarm0_conf;
 	struct rtc_time tm;
 
@@ -598,7 +601,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
-	u8 data[info->regs->regs_count];
+	u8 data[MAX_NUM_TIME_REGS];
 	int ret;
 
 	switch (info->device_type) {
-- 
2.7.4
