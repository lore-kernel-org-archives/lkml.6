Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591105-2-11563044359246415686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES caenro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591104; b=X8fzlLcGbjiAoY4sU5A6CN0bKSdNf0NzNW05QyEpTvhVX0o
    QDTQbMmgE6qqzh59S/46pTbR9u/GmoQn0DvhFEApzfu9zd9eo3Nq9Z7hvcmXxnGm
    UUONHLUSjH06iuNllQluqxjpVwaCLBYrN2/9LTt204FlFe0HukILLST3V6leprVY
    qBuUxY+hYJ3e46e85gcwKo/MdIiqxwq16vASZgExSdgE3519Gp7pGQR3VlJc/BFW
    thxzZB3/J5BvqDARIFxjUAw1rVkmFkHMg3T/bjV/ePgcJizvO38pVpARgkJ0xL4e
    Lg6N+xMcaGPPgtlpZ9o9ydDXiRjl2wLgxM6+9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591104; bh=CT5LO0hbIildTZiuokrclQ4m8K
    5fbwvx9FX4OHw3RTM=; b=kUKZr4u4SFjct5OyoSwKLjZD9YMSqKCC+YmJuA2y/a
    D4Y53nWqQ23zsvBfvF1z8GOZ6P/42uEo5YFml0LvN28NZNyM2lW8HBl15XV2tob9
    qAnzProo5dKlSjbUeKmYBml4cZMTMY6nX4v9s4Qz4bY9xxuqPjP1nu9jCXodlF8F
    0A1qGEroI2Ei5XTTMARD5tNCn9il9xCdZT/kCLLaKe3ADUf9cOYKIOv4A3NMJSz6
    0/waa/dI2MQ9+eCffi1dkTkrrS9TeLKaJr9io5baR4ZyX9arF4KTlU0KLpUyu6qG
    3f4eJm/PPN2/C3CFus5Tgdh9J+SJLmW8ghb9hOxuVV6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeBBREs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36298 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeBBREr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Lippert <rlippert@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 46/86] hwmon: (pmbus) Use 64bit math for DIRECT format values
Date: Fri,  2 Feb 2018 17:58:06 +0100
Message-Id: <20180202140826.535387677@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Lippert <roblip@gmail.com>


[ Upstream commit bd467e4eababe4c04272c1e646f066db02734c79 ]

Power values in the 100s of watt range can easily blow past
32bit math limits when processing everything in microwatts.

Use 64bit math instead to avoid these issues on common 32bit ARM
BMC platforms.

Fixes: 442aba78728e ("hwmon: PMBus device driver")
Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/pmbus_core.c |   21 ++++++++++++---------
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
@@ -476,8 +477,8 @@ static long pmbus_reg2data_linear(struct
 static long pmbus_reg2data_direct(struct pmbus_data *data,
 				  struct pmbus_sensor *sensor)
 {
-	long val = (s16) sensor->data;
-	long m, b, R;
+	s64 b, val = (s16)sensor->data;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -505,11 +506,12 @@ static long pmbus_reg2data_direct(struct
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
@@ -629,7 +631,8 @@ static u16 pmbus_data2reg_linear(struct
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 				 struct pmbus_sensor *sensor, long val)
 {
-	long m, b, R;
+	s64 b, val64 = val;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -646,18 +649,18 @@ static u16 pmbus_data2reg_direct(struct
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
