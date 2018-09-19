Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF899ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DA62154B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="na/cDBjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DA62154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeITCa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40418 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbeITCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so6018465edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKtSdkBnxDPJmvhkpFaTo4RYz8881z3zXHLEjda03aw=;
        b=na/cDBjfADbmnnfncUiDb/JsunW4GTJS5sJUDanE0Lmh2YFiGcJZamFgnhbHpL0A19
         vrNtF/STLoN7HBl3EDZvot3Bmsc0xPwN/Ihme5KYEP2XcAlCDoURx84yie9oW5TzfsVl
         +9f5i7QseIgr1vr4ZaDGj+2BFH2xqUCIAqiw+vjCB4jNeznF7dGYAlSFZTP/jdctTGL1
         3VaLWexWz5+o37FkAubOkOMJT9i1+gHR5YqdJKawdFOeqvVdojWCdxnf1/DF0RRYJYF/
         vbGFQcp1C5M4Uj6PqrovPp3g6q8EbT2akPCYplYHl+G6EPLrCPEDgRjtOye0t1N5h4qM
         7oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WKtSdkBnxDPJmvhkpFaTo4RYz8881z3zXHLEjda03aw=;
        b=SSTaMlCVQIYWUd0QPZqMPcTK6RCGd+OCdjaivjG3Se9hA3JwNxdokgcWLvb50KgX1L
         8C8vT67EB6hfBZjioc9Ar9iRN+Dna9f6ywqTJGNudOCJlQTzuZbdYfauTeN46pPWc6PF
         R39+FVGN9/242xFxRd9TTYaLuks5TIkpY6ta7gku27oAl100/ReJnDA2fGHysJew4NFF
         sz/yzJYzI3A3N03/mQuox5/EZVeNEadSMPiStyZ+R2PU3OqOwHkMEZKZvnuf/M1I9TAE
         1nRnOUYZBi9Fu1uWVo8UlmJLvSvW67i7KlCTFILernDdGSbK8wmJq7GdfQekkXwScFw9
         ShvQ==
X-Gm-Message-State: APzg51BBEPNGkU+/bTE4d/AgGaCFs1KbMQxFjmodR00ss5Dw0bKblDhg
        hcwaSrvrL7aTlrbdf9GxHtPILhy1LxY=
X-Google-Smtp-Source: ANB0VdbkyjX3MCpCMt6mBSBTdfVo3xPGvUdaYU1j6X9u3dWr7PIz5s5kaFOUxHpLI1vwnqB7vkMNeg==
X-Received: by 2002:a50:82c5:: with SMTP id 63-v6mr61267233edg.200.1537390246599;
        Wed, 19 Sep 2018 13:50:46 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:46 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
Subject: [RFC 05/20] timerfd/timens: Take into account ns clock offsets
Date:   Wed, 19 Sep 2018 21:50:22 +0100
Message-Id: <20180919205037.9574-6-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Make timerfd respect timens offsets.
Provide two helpers timens_clock_to_host() timens_clock_from_host() that
are useful to wire up timens to different kernel subsystems.
Following patches will use timens_clock_from_host(), added here for
completeness.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c                   | 16 +++++++++++-----
 include/linux/time_namespace.h | 11 +++++++++++
 kernel/time_namespace.c        | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index d69ad801eb80..001ab7a0fd8b 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -433,22 +434,27 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 }
 
 static int do_timerfd_settime(int ufd, int flags, 
-		const struct itimerspec64 *new,
+		struct itimerspec64 *new,
 		struct itimerspec64 *old)
 {
 	struct fd f;
 	struct timerfd_ctx *ctx;
 	int ret;
 
-	if ((flags & ~TFD_SETTIME_FLAGS) ||
-		 !itimerspec64_valid(new))
-		return -EINVAL;
-
 	ret = timerfd_fget(ufd, &f);
 	if (ret)
 		return ret;
 	ctx = f.file->private_data;
 
+	if (flags & TFD_TIMER_ABSTIME)
+		timens_clock_to_host(ctx->clockid, &new->it_value);
+
+	if ((flags & ~TFD_SETTIME_FLAGS) ||
+		 !itimerspec64_valid(new)) {
+		fdput(f);
+		return -EINVAL;
+	}
+
 	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM)) {
 		fdput(f);
 		return -EPERM;
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 4960c54f1b33..910711d1c39d 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -38,6 +38,9 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+void timens_clock_to_host(int clockid, struct timespec64 *val);
+void timens_clock_from_host(int clockid, struct timespec64 *val);
+
 #else
 static inline void get_time_ns(struct time_namespace *ns)
 {
@@ -56,6 +59,14 @@ static inline struct time_namespace *copy_time_ns(unsigned long flags,
 	return old_ns;
 }
 
+static inline void timens_clock_to_host(int clockid, struct timespec64 *val)
+{
+}
+
+static inline void timens_clock_from_host(int clockid, struct timespec64 *val)
+{
+}
+
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index a985529754b4..f96871cb8124 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -154,6 +154,45 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 	return to_time_ns(ns)->user_ns;
 }
 
+static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+	struct timespec64 *offsets = NULL;
+
+	if (!ns_offsets)
+		return;
+
+	if (val->tv_sec == 0 && val->tv_nsec == 0)
+		return;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offsets = &ns_offsets->monotonic_time_offset;
+		break;
+	case CLOCK_BOOTTIME:
+		offsets = &ns_offsets->monotonic_boottime_offset;
+		break;
+	}
+
+	if (!offsets)
+		return;
+
+	if (to_ns)
+		*val = timespec64_add(*val, *offsets);
+	else
+		*val = timespec64_sub(*val, *offsets);
+}
+
+void timens_clock_to_host(int clockid, struct timespec64 *val)
+{
+	clock_timens_fixup(clockid, val, false);
+}
+
+void timens_clock_from_host(int clockid, struct timespec64 *val)
+{
+	clock_timens_fixup(clockid, val, true);
+}
+
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
 	.type		= CLONE_NEWTIME,
-- 
2.13.6

