Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x224y/zyRewm8jqpFUkSdRMbU081qbVufd+ZiAx66N+bexCVakJynp6qBerB+duzQyDcbERk5
ARC-Seal: i=1; a=rsa-sha256; t=1518461170; cv=none;
        d=google.com; s=arc-20160816;
        b=eUkCaUHcR8dzOi1rAJRJ0sVAdJo4ASxMmswquNfWKENPArx0ZoxHCcn2k+4jpBcsI6
         5H4LGAXjY0zaAY5mSR9nLloGz4Biz88f+XWchhpvl0Yh0SlP1zJljwyT+ctf/d86pcyc
         sbvcqEPshZpiB7fjLl+7F6qe1EhDWNBZpGv9b6HeQ0CahZnHRn1sI3kYNb9Ntw9HFurc
         SP2sgnlEJj2RkfmdglxmlmuZn60Fc9v+nsjyTItCy4nsHMWXvOLAra0N6w6poq3l7Rip
         eqsB6fEgEMkDRHiB2jgYy/STOIE0qWRpEKHWbj2a9GFQBq9oUEWFh70nYrrDWhxfoM2C
         AZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/i6TuDJNgj4250w3zm8wGHYhfNkmg8vX0SxWN/pRArc=;
        b=kWkjSxg5uhU4lktmgAhTf8qBQwErk7UNVXijcUDx7PPxVmBUJwKA81aD/5F5JWjrfl
         L4UFjkZPqfvqOLI5EiVnvwBGSIWklYgNZKlMJ8LVWsB3d+6gqiNG2wiurQK/7yYnqOdy
         GzUNEE4uthf6V5206tYZrJ1UNtpHNT/5167359lzcFcJSsZNrhxIbJLuzc+b1yajBviM
         JA20n0EzT4PCX7yyKgKiyP3n/AwoyJTRKyR74+bOXL64STh12qV4olT50SZgrD5W0O1K
         iHQ9Se+RrBe3I1iKFCPelSt5aA3EHo4+GAxARd2iGXbW+Nmt7RyRHRgPflgfNhQd8bT+
         NzRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v5 17/20] hwmon: (core) Add hwmon_max to hwmon_sensor_types enumeration
Date: Mon, 12 Feb 2018 18:45:21 +0000
Message-Id: <1518461124-17371-18-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221940691763047?=
X-GMAIL-MSGID: =?utf-8?q?1592221940691763047?=
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
