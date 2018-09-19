Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95150C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4597B2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Vum7eVmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4597B2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeITCa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33439 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732336AbeITCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so6063901edv.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bP6x72afHhqDJ7ddcE8DNcBh4tk+zD9yWPVM9lT5xD8=;
        b=Vum7eVmU+8KkpZOqjqgsLPRxNn/ZFXt/4P3gwZ0Rpe/jMT1GjJqaEMwDdikL7aTHDx
         PXNzNbSYPKejyf5RBQ0qfKl9u9Gs5dVAQFeSOK2fkUthFOAPSBMVBUATrtviGwmbugo4
         jecWAPrnnWVHrh/XK+NcMq8TX4jrHSRxB4uGrgVvp8LoiUKiBeXz4JeeKXKczH3brbdQ
         n6p+EhuXt1pEAh09pCu8/xEPkCjGwfFIU9u1AiGx/g68pWsZ8ENHriREpQxJuk39f/Cg
         M5ybJhAP9IElcF6jTRqxNycNMcK7TIywG6G4Fe0Nlk8BHkDIIRMrvnVrC+mR677eQOVB
         aEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bP6x72afHhqDJ7ddcE8DNcBh4tk+zD9yWPVM9lT5xD8=;
        b=Aog2ZxETwxW4Dl1EL4G5Ik9q9SZWxkctZ3Vc2OxfRJurqEDv0hdW+NYJucrFWJoKaE
         F7Uy8iseyB/xoK5/hXWl4KZWvK8PbZnBwOE61xVAl7Yjc4vku0rTL+SFIasf0EPZn2hV
         RIE8MbYNGInWb3ZPkzCFEicq5rQHWSqYE1YnRYorLBSrVviUCh+sILO3w35xyitNYuV8
         ROndBBb5UhfFi05fyqA7ZwLxFwcIH5XZjXTnfGhJ8kVQCOv/+j0H7iC+ZJ3jFSqMGjgP
         6n+/v+KEoo63+wXN4H6G8vsmEr6ihsVbFHHWzq7lmVoSWgJ9Q1fKK3zjn+szMm9fQwf+
         AKGQ==
X-Gm-Message-State: APzg51Bxc0uKTg7st8LNDJsOVcTM56lFa769b+zeMccNfhMlU/eBFoo7
        20vXiG0FywpLNUI+8M16bjpK5C14KsE=
X-Google-Smtp-Source: ANB0VdYdepDti0Z4R2+cyHD577UJjM7xe0joMQKhFQVm/L2BJ1KqPgQy2AEMwOevgnuqAVV02x7mkQ==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr59897039edr.38.1537390245276;
        Wed, 19 Sep 2018 13:50:45 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:44 -0700 (PDT)
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
Subject: [RFC 04/20] timens: Introduce CLOCK_BOOTTIME offset
Date:   Wed, 19 Sep 2018 21:50:21 +0100
Message-Id: <20180919205037.9574-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Adds boottime virtualisation for time namespace.
Provide clock_set() API to set boottime clock inside ns.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h |  1 +
 kernel/time/posix-timers.c     | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 248b0c0bb92a..777530c46852 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -4,6 +4,7 @@
 
 struct timens_offsets {
 	struct timespec64  monotonic_time_offset;
+	struct timespec64  monotonic_boottime_offset;
 };
 
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 3c1f98760dec..d38835a21c5d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -276,7 +276,32 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 
 static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
 {
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
 	ktime_get_boottime_ts64(tp);
+
+	if (!ns_offsets)
+		return 0;
+
+	*tp = timespec64_add(*tp, ns_offsets->monotonic_boottime_offset);
+
+	return 0;
+}
+
+static int posix_set_boottime(clockid_t which_clock, const struct timespec64 *tp)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+	struct timespec64 ktp;
+
+	if (!ns_capable(current->nsproxy->time_ns->user_ns, CAP_SYS_TIME))
+		return -EPERM;
+
+	ktime_get_boottime_ts64(&ktp);
+
+	if (ns_offsets)
+		ns_offsets->monotonic_boottime_offset = timespec64_sub(*tp, ktp);
+	else
+		return -EINVAL;
 	return 0;
 }
 
@@ -1362,6 +1387,7 @@ static const struct k_clock clock_tai = {
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_boottime,
+	.clock_set		= posix_set_boottime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
-- 
2.13.6

