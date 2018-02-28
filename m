Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519840051-2-16779717233522806131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519840050; b=LJtkDO5wSDs7up3U2Gq0MAzAC3Ji2+y2u+CQ81CR3l41pAx
    szDMhi/B19/rf2oAG+cfdddHkhbqzH278WXRc4IjAJ/RIPp/0HcwlxGJxApdAVvR
    YuLj0kY/fvbnkQRVvEnv7c4bgm9h3sV6R5ooFzBkcA6QnJxWBCHHlepfgSVbhfO+
    zlKZy1wDcpTs6yrV3m5YT89P1opJjIRSho4IHOuC/zJgMRKV6AgOcnQexC/ujuhg
    T+sCtY/m/56k1fh19ZZOcMiRv40H1q2lmlGDjxCcL+Bgr211xuK/y8SF6USIT338
    GZy9kxNTLXYSO11/zznVNMqboZIxQFpU4eZEJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519840050; bh=n2A3kspp7VuT6BDF3gd
    m8ToZtMXtjW1JDWwO4HpzMJc=; b=FW57OG1GYSwQe42k+OoLTZhUh7B1vHE7cZV
    B48WCdv4uHLoiqUNfpFB7G/SM+SjkmlwwEtoMRxDqKIAJ+flFe2ASg07LCqneR+t
    OsMBPEeTGK7YPIUGmuKAzvcoehqr/5kWpFBPhh36OD+KNN0O8TUrfotbUnLDXMP5
    bNEINuLxNK/AruxKyUx0K/c/QDGZuEToO7HjqZ+5uqt4+YUm7AHd8o2B/HSWR0OS
    ds8wNPYs0C9muN5cByARBtAfbKXIFRQbveCSRpFc4+Dqis8keclq/Y8krz762JD7
    Z7ioxUOGDxNghaLlGxo5Sgg2rC6tPRCjKSUxY5NmM8+FYYAUHgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeB1Rpr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:45:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33089 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932449AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>,
        "Robert Lippert" <rlippert@google.com>,
        "Robert Lippert" <roblip@gmail.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.425773900@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 013/140] hwmon: (pmbus) Use 64bit math for DIRECT
 format values
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Lippert <roblip@gmail.com>

commit bd467e4eababe4c04272c1e646f066db02734c79 upstream.

Power values in the 100s of watt range can easily blow past
32bit math limits when processing everything in microwatts.

Use 64bit math instead to avoid these issues on common 32bit ARM
BMC platforms.

Fixes: 442aba78728e ("hwmon: PMBus device driver")
Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[bwh: Backported to 3.2: use integer literals instead of S16_{MIN,MAX}]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hwmon/pmbus/pmbus_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -475,8 +476,8 @@ static long pmbus_reg2data_linear(struct
 static long pmbus_reg2data_direct(struct pmbus_data *data,
 				  struct pmbus_sensor *sensor)
 {
-	long val = (s16) sensor->data;
-	long m, b, R;
+	s64 b, val = (s16)sensor->data;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -504,11 +505,12 @@ static long pmbus_reg2data_direct(struct
 		R--;
 	}
 	while (R < 0) {
-		val = DIV_ROUND_CLOSEST(val, 10);
+		val = div_s64(val + 5LL, 10L);  /* round closest */
 		R++;
 	}
 
-	return (val - b) / m;
+	val = div_s64(val - b, m);
+	return clamp_val(val, LONG_MIN, LONG_MAX);
 }
 
 /*
@@ -620,7 +622,8 @@ static u16 pmbus_data2reg_linear(struct
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 				 enum pmbus_sensor_classes class, long val)
 {
-	long m, b, R;
+	s64 b, val64 = val;
+	s32 m, R;
 
 	m = data->info->m[class];
 	b = data->info->b[class];
@@ -637,18 +640,18 @@ static u16 pmbus_data2reg_direct(struct
 		R -= 3;		/* Adjust R and b for data in milli-units */
 		b *= 1000;
 	}
-	val = val * m + b;
+	val64 = val64 * m + b;
 
 	while (R > 0) {
-		val *= 10;
+		val64 *= 10;
 		R--;
 	}
 	while (R < 0) {
-		val = DIV_ROUND_CLOSEST(val, 10);
+		val64 = div_s64(val64 + 5LL, 10L);  /* round closest */
 		R++;
 	}
 
-	return val;
+	return (u16)clamp_val(val64, -32768, 32767);
 }
 
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
