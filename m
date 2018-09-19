Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A8ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ACA2152B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MEGRm48S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4ACA2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeITCa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34894 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731940AbeITCaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so6053061edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WmvQTDBqrUvuaJAVNsVZ+YKAQl6WccszsrgCxCEzfbQ=;
        b=MEGRm48S8HnF7VITHl93LxtkofNQ9ttBkW21XwLkWloB4CB/Xf1KE/G85lpMgt0wp5
         a0FLu5UM+qkkv0jfSGl5mNSkHi/IAIjDsTQCe5mf5F0rWeSnBFDJc/ftX/XM9VRLWOWd
         JnQw1kI9MmIj/qSbLV/9qBoNPv/UCoK/z9gP+aJcN3PQp210fyTlTmq63TB/IX9ni6Fs
         6AiP/C/heXPTIwve83/nuhN49Ku+mmJ3Pnj73vURZs6RF73R7EE41SR1/ycQwP62+DY7
         ozNO94S/KevdRCxn+aIqxfWjXIg3oUGBfrAS1BkNHcza5FrOYF5u4NoUD92Gf+qE/A/P
         QT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WmvQTDBqrUvuaJAVNsVZ+YKAQl6WccszsrgCxCEzfbQ=;
        b=plaRCCfK6PC4DlubUrbgarbrvsMcpL18r8mCcAb2Pr27pYv6z2gBJo+caMyipq+yi5
         SV/w5Vc37wD2Zp1P9J6tK2HyoXH/a7Z792AbTm4s2FLkry1W/Oy5RZvYXi+/KRiHzCH6
         o+ZpktCBJA/V2uSoLm39WIRgEO5Y3j293m2ml/3GCSsWwWEAll0Axrf15WKIB586pLyX
         WyOFtwXl/ozwjeCAmKJDYl389AU441L1aURtW9Z8sPTgg2CpHHDFNGlLOzjso00tvakh
         LoKdSVUWxGTjdXrIoWbhOmZk69WR81BjA6VrlxNLMhSfTyEdr/c20MfuQO84SgrYQzPR
         i4sQ==
X-Gm-Message-State: APzg51ChpjvuiSyBRLQjYQ1yN3O1u1GNbHJzs1XmOiCdS2C5+urUg03v
        PFK2hiHPQDAadBapU7OoucGbvw26lsQ=
X-Google-Smtp-Source: ANB0Vda5lDevNnmbA/LnFiBMR/zz7fmXjIUXbwK5y7J4E1Z+a7hVBOtgvvgEpD/ZTQ5mkz34/gp9bg==
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr63245742eda.33.1537390243901;
        Wed, 19 Sep 2018 13:50:43 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:43 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 03/20] timens: Introduce CLOCK_MONOTONIC offsets
Date:   Wed, 19 Sep 2018 21:50:20 +0100
Message-Id: <20180919205037.9574-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Adds monotonic time virtualisation for time namespace.
Provide clock_set() API to set monotonic time inside ns.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h |  1 +
 kernel/time/posix-timers.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 7d7cb68ea778..248b0c0bb92a 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -3,6 +3,7 @@
 #define _LINUX_TIME_OFFSETS_H
 
 struct timens_offsets {
+	struct timespec64  monotonic_time_offset;
 };
 
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4b9127e95430..3c1f98760dec 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -51,6 +51,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -205,12 +206,40 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 	return do_adjtimex(t);
 }
 
+static void timens_adjust_monotonic(struct timespec64 *tp)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*tp = timespec64_add(*tp, ns_offsets->monotonic_time_offset);
+}
+
+static int posix_ktime_set_ts(clockid_t which_clock,
+				const struct timespec64 *tp)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+	struct timespec64 ktp;
+
+	if (!ns_capable(current->nsproxy->time_ns->user_ns, CAP_SYS_TIME))
+		return -EPERM;
+
+	ktime_get_ts64(&ktp);
+
+	if (ns_offsets)
+		ns_offsets->monotonic_time_offset = timespec64_sub(*tp, ktp);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Get monotonic time for posix timers
  */
 static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_adjust_monotonic(tp);
 	return 0;
 }
 
@@ -220,6 +249,7 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_adjust_monotonic(tp);
 	return 0;
 }
 
@@ -234,6 +264,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_adjust_monotonic(tp);
 	return 0;
 }
 
@@ -1283,6 +1314,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_ktime_get_ts,
+	.clock_set		= posix_ktime_set_ts,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1298,6 +1330,7 @@ static const struct k_clock clock_monotonic = {
 static const struct k_clock clock_monotonic_raw = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_monotonic_raw,
+	.clock_set		= posix_ktime_set_ts,
 };
 
 static const struct k_clock clock_realtime_coarse = {
@@ -1308,6 +1341,7 @@ static const struct k_clock clock_realtime_coarse = {
 static const struct k_clock clock_monotonic_coarse = {
 	.clock_getres		= posix_get_coarse_res,
 	.clock_get		= posix_get_monotonic_coarse,
+	.clock_set		= posix_ktime_set_ts,
 };
 
 static const struct k_clock clock_tai = {
-- 
2.13.6

