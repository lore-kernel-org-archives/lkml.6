Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B37ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4066620835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCWlFmNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4066620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJJBo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:44:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44835 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJJBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:44:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so1209645pgu.11;
        Tue, 09 Oct 2018 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5QJusU5/d4avhEgm2gTpwu0vFMH2mbHWjs+94YLtZ30=;
        b=uCWlFmNyP+LrCtOOid2GEV+J/oursSv2Ljx9Kiw9No4t3nY8fu90NTJWlgjM07UvCb
         T1L7YTa/RiJPdvVWAqQnZggwVmRa1iIWGXejJi9BCiGu5OesgpKxskxXn1sswThDZD/C
         S9dnhIjzpe5sOoC6Ea8H0ylVMKtnN3hoIedKXyK6VcSxz2fdy7hpwyPpzcrk/wmqzbrZ
         3XoLO0FliF0bjZ8LUXyxyzKVk37svuuuQamvSxzKFw0kIJj5wZghP1qQg5ts9UPfJtT/
         CBg3MUcRtWujqgQdDNQhrCg/+9vWGvSqDcwCiPOJZRKg49dTzoVykbqDagjbGleHGwmY
         qsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5QJusU5/d4avhEgm2gTpwu0vFMH2mbHWjs+94YLtZ30=;
        b=N+r2SvK9eCiEbA9Cut+smBSRWuFOfS9pSML6DA/HMH4WHGvASNWg1xQn+clbjBQpWv
         5HxxT6R57gC3YzI2i29rr57KScZki66zhelEIfMeFPGQYSfo3FsGj5Xx3ulfzC2j5SkI
         8o32GLnqRkoTCHzN9HLUOtNktQjslco+3UjkeZUqHXCngNbJUtCFoRcwpWR5FcjYKs+f
         lIC96a2cA1MZyIiWW2ZS61TXYrLWi5PCjhvyOyU6JTAfDCOAfmQ+ZmJxg2yI3m0cSXE9
         pjN7+J2LdCoTC85sq0W0x1KeNKBd4g7nkRwIHj93kwYmp6ddALZ+0JObbxC59AZibPm5
         vOFw==
X-Gm-Message-State: ABuFfoj/9qZ5qSfM1iewU6Hv1SAdMfT7Or8w9rz6+xMS5N9vhQwyBbll
        M7AqYNhrO10y/IVOSz2LQXy+N91y
X-Google-Smtp-Source: ACcGV6264KtYggAjoYYyH1GI+Pp2LM28BO+busvu1Zc45NaWsC86TWQmIaInlovKE/6GIhwy8rqtIQ==
X-Received: by 2002:a62:830e:: with SMTP id h14-v6mr31877038pfe.29.1539109571776;
        Tue, 09 Oct 2018 11:26:11 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k12-v6sm6168962pgo.34.2018.10.09.11.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 11:26:11 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH] hwmon: (core) Add trace events to _attr_show/store functions
Date:   Tue,  9 Oct 2018 11:26:02 -0700
Message-Id: <20181009182602.3085-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace events are useful for people who collect data from the
ftrace output. This patch adds initial trace events for the
hwmon core. To call hwmon_attr_base() for aligned attr index
numbers, this patch also moves the function upward.

Ftrace outputs:
 ...: hwmon_attr_show_string: index=2, attr_name=in2_label, val=VDD_5V
 ...: hwmon_attr_show: index=2, attr_name=in2_input, val=5112
 ...: hwmon_attr_show: index=2, attr_name=curr2_input, val=440

Note that the _attr_show and _attr_store functions are tied
to the _with_info API. So a hwmon driver requiring the trace
events feature should use _with_info API to register a hwmon
device.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 MAINTAINERS                  |  1 +
 drivers/hwmon/hwmon.c        | 27 ++++++++++----
 include/trace/events/hwmon.h | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/hwmon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1640b9faa75e..589b32405bf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6461,6 +6461,7 @@ F:	Documentation/devicetree/bindings/hwmon/
 F:	Documentation/hwmon/
 F:	drivers/hwmon/
 F:	include/linux/hwmon*.h
+F:	include/trace/events/hwmon*.h
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
 M:	Matt Mackall <mpm@selenic.com>
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index ac1cdf88840f..975c95169884 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -24,6 +24,9 @@
 #include <linux/string.h>
 #include <linux/thermal.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/hwmon.h>
+
 #define HWMON_ID_PREFIX "hwmon"
 #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
 
@@ -171,6 +174,13 @@ static int hwmon_thermal_add_sensor(struct device *dev,
 }
 #endif /* IS_REACHABLE(CONFIG_THERMAL) && ... */
 
+static int hwmon_attr_base(enum hwmon_sensor_types type)
+{
+	if (type == hwmon_in)
+		return 0;
+	return 1;
+}
+
 /* sysfs attribute management */
 
 static ssize_t hwmon_attr_show(struct device *dev,
@@ -185,6 +195,9 @@ static ssize_t hwmon_attr_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	trace_hwmon_attr_show(hattr->index + hwmon_attr_base(hattr->type),
+			      hattr->name, val);
+
 	return sprintf(buf, "%ld\n", val);
 }
 
@@ -193,6 +206,7 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
 				      char *buf)
 {
 	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
+	enum hwmon_sensor_types type = hattr->type;
 	const char *s;
 	int ret;
 
@@ -201,6 +215,9 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	trace_hwmon_attr_show_string(hattr->index + hwmon_attr_base(type),
+				     hattr->name, s);
+
 	return sprintf(buf, "%s\n", s);
 }
 
@@ -221,16 +238,12 @@ static ssize_t hwmon_attr_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	trace_hwmon_attr_store(hattr->index + hwmon_attr_base(hattr->type),
+			       hattr->name, val);
+
 	return count;
 }
 
-static int hwmon_attr_base(enum hwmon_sensor_types type)
-{
-	if (type == hwmon_in)
-		return 0;
-	return 1;
-}
-
 static bool is_string_attr(enum hwmon_sensor_types type, u32 attr)
 {
 	return (type == hwmon_temp && attr == hwmon_temp_label) ||
diff --git a/include/trace/events/hwmon.h b/include/trace/events/hwmon.h
new file mode 100644
index 000000000000..d7a1d0ffb679
--- /dev/null
+++ b/include/trace/events/hwmon.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hwmon
+
+#if !defined(_TRACE_HWMON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HWMON_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(hwmon_attr_class,
+
+	TP_PROTO(int index, const char *attr_name, long val),
+
+	TP_ARGS(index, attr_name, val),
+
+	TP_STRUCT__entry(
+		__field(int, index)
+		__string(attr_name, attr_name)
+		__field(long, val)
+	),
+
+	TP_fast_assign(
+		__entry->index = index;
+		__assign_str(attr_name, attr_name);
+		__entry->val = val;
+	),
+
+	TP_printk("index=%d, attr_name=%s, val=%ld",
+		  __entry->index,  __get_str(attr_name), __entry->val)
+);
+
+DEFINE_EVENT(hwmon_attr_class, hwmon_attr_show,
+
+	TP_PROTO(int index, const char *attr_name, long val),
+
+	TP_ARGS(index, attr_name, val)
+);
+
+DEFINE_EVENT(hwmon_attr_class, hwmon_attr_store,
+
+	TP_PROTO(int index, const char *attr_name, long val),
+
+	TP_ARGS(index, attr_name, val)
+);
+
+TRACE_EVENT(hwmon_attr_show_string,
+
+	TP_PROTO(int index, const char *attr_name, const char *s),
+
+	TP_ARGS(index, attr_name, s),
+
+	TP_STRUCT__entry(
+		__field(int, index)
+		__string(attr_name, attr_name)
+		__string(label, s)
+	),
+
+	TP_fast_assign(
+		__entry->index = index;
+		__assign_str(attr_name, attr_name);
+		__assign_str(label, s);
+	),
+
+	TP_printk("index=%d, attr_name=%s, val=%s",
+		  __entry->index, __get_str(attr_name), __get_str(label))
+);
+
+#endif /* _TRACE_HWMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

