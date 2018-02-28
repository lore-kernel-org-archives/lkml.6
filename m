Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519833701-2-14745257825871197824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833700; b=IEPvdwEhQvIWAt+mOOwMqitYAW7lNZNuGcHUaGlHqVBPnpP
    gejA5xC13OApCS2kUrAG+DSziuHvNTAcbD2rnFYz7VreLYKmSYPIXcGsZp9nEVAa
    f6n1P86ewLLORo5C2iIAQlLT9J1Fcfj3/Ca42qS8d9m+i8zp1Rwo6pJDfVHwTYCk
    TEIOXFaG9RDMMFwLiMLZXe9bZemKQvK9bJ6yZRL9fZDLMBXwSTq/KLcWHjPgzmwu
    18GcJLtbIic9HROFVtDkFPUktCrjhVmENpDnyaJnjw5G+TR1owfN5OmERIelLK7S
    bm8+Brej18ZWoEhb4KZRofjlo53g1omydRCR+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833700; bh=hjj4kWbvf3qXgomW8QY
    XAJadkPJlylyPIxqPWJIDCno=; b=FZqWr23rY4f1FDyKA4h/x9gRD83agrzVdYq
    PmNaXoCc2b6n6Q2Ivjlhsc90b9CEar62MKV2t3GOoABoFPoW0UqmbNQQeOfpNySn
    hxFEGA283My2C9eXgGSJMCOvq6qgk7Mfth6Mj1oCzt6dr/GYWjpcLvQyXqgFXGnu
    IR2kSvlkOYYRsUIWo3tIKeOBW9ZuPe3DYCeoUOa1hAjhx8cls8KjrPL+2r2uuuFu
    2R6vPHOHYQgcGZJk2mGSYkkgRZ/Kl89qA9L0pBuKACRrUoKAQYKES2csMtJBKot2
    z2sgFOxUW8tPK0ZnxfKYaaG5dJsPbH5pnV/MnXdSLzTzismMF2Q==
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
        id S1752615AbeB1QBX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:01:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34689 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932146AbeB1QBI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:01:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Robert Lippert" <rlippert@google.com>,
        "Robert Lippert" <roblip@gmail.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.575894016@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 017/254] hwmon: (pmbus) Use 64bit math for DIRECT
 format values
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hwmon/pmbus/pmbus_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -443,8 +444,8 @@ static long pmbus_reg2data_linear(struct
 static long pmbus_reg2data_direct(struct pmbus_data *data,
 				  struct pmbus_sensor *sensor)
 {
-	long val = (s16) sensor->data;
-	long m, b, R;
+	s64 b, val = (s16)sensor->data;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -472,11 +473,12 @@ static long pmbus_reg2data_direct(struct
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
@@ -588,7 +590,8 @@ static u16 pmbus_data2reg_linear(struct
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 				 struct pmbus_sensor *sensor, long val)
 {
-	long m, b, R;
+	s64 b, val64 = val;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -605,18 +608,18 @@ static u16 pmbus_data2reg_direct(struct
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
+	return (u16)clamp_val(val64, S16_MIN, S16_MAX);
 }
 
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
