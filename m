Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtx6p1wTd8Z/39/t1uWQ3NQO2vslwbpO3VnBnUU3ejgyQvaBDDzNpwoPNzP/p4wzDEVpyec
ARC-Seal: i=1; a=rsa-sha256; t=1519403076; cv=none;
        d=google.com; s=arc-20160816;
        b=wPHsD9Dne8QflgAsIq1206cGNqGP6dsslhhdQrJ5HS57JnYkNEzeBslac6e4Xg+ltL
         6+1DOf/9KbKQ/ZOIF9MY1qUe9GRd8jU2+jFyrJjl1NBgMlvn7ftDQ8wgIInAjtkR7+Uy
         KUsHMt1ZhTEwyaUHGoXJlpHdeF9pIW8DGKWg1VgNYzA+IN/JLgu/Qpf71Gu8A8XxH3AA
         wxntMD6zeYi2lhGA9g2w8WOqwjpjqtmDvtG0yT1fIO3rkz3YkQrmMs2uV8HpvGr6WsmX
         l4QM1cCBYVNoDkzid8U2UzGqq8FtBQNHA0MifAtwH8YXCS7NHuLQ57X4CNWjmqv9TXDa
         z3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/i6TuDJNgj4250w3zm8wGHYhfNkmg8vX0SxWN/pRArc=;
        b=WP6/ho1cc8/DzeFps0s7aGiyGG7CnHN5guP3yvIkU5Z38BbW0lNWtu7MFlBtQQfsX4
         CKxfTGSd0OhjUl09Hlhl45wphsORhheCDHAzjxXOOFcfxDlC/rNFo2B0aom660i2egUg
         gJG9VcDB+KEiAIxD5JJ02Pj20nz08ObIv00r6Ec6NKTvidjFvogTbkMXX9yFpZMjMXP9
         GCZGgSM0G+UhWrRdSpqORttJyl8If6esmY7MEUjfl20DeSfcouj/+FUlD9ps+zCeIWAx
         aWQZbtqUg8HZFkyeDC3ITmGxX0tc+A2lA/K/P/eyEqOEFQgKtgMJXYPVNy2PLXhOzLA+
         BmiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v6 17/20] hwmon: (core) Add hwmon_max to hwmon_sensor_types enumeration
Date: Fri, 23 Feb 2018 16:23:47 +0000
Message-Id: <1519403030-21189-18-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209600426349215?=
X-GMAIL-MSGID: =?utf-8?q?1593209600426349215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's useful to know the maximum types of sensor supported by hwmon
framework. It can be used to allocate some data structures when sorting
the monitors based on their type.

This will be used by scmi hwmon support.

Cc: linux-hwmon@vger.kernel.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/hwmon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index ceb751987c40..e5fd2707b6df 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -29,6 +29,7 @@ enum hwmon_sensor_types {
 	hwmon_humidity,
 	hwmon_fan,
 	hwmon_pwm,
+	hwmon_max,
 };
 
 enum hwmon_chip_attributes {
-- 
2.7.4
