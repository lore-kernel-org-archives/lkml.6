Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C091C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FAC2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kGiTxljn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfBFANp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:13:45 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35217 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfBFALU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id b17so321987eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNAVIH5tXGvK+Oi4RqlWPSq+okg61aIZvW5S3G/qiBk=;
        b=kGiTxljnyIIE3rrOlleGdhd1pRlAohejD4LkRskE5+y2/a0jtQl7LdGW/baXd39hk5
         6PVzXOMsvn9VJfA3HJjWv6ze6Llp3WQC+eDVJmW9l039ExoVmD/R9+mmX85TN0nBALg2
         mXrZBCPxwKa41imMM7oQxxVb4xdFKlWzpMGTPBPGH3DnSgWdPJYEfMPsLYUXFKRz4B0W
         qJ6miThUsQiY3ER+a1GFx4WV4FVqvaYQowO2r9U/g9VGcmYtOiJhDYGQIUJjAESKs2ki
         LD+qMlvq87wfBrs6zoHe6UaS8bt/i/U/ttxTs9uIqpqsuwY4IuYclPR761ZYloBIFFIn
         XUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNAVIH5tXGvK+Oi4RqlWPSq+okg61aIZvW5S3G/qiBk=;
        b=OCdcF91vlfu8vHL/55vQMtZhaktV9fP7aJfry2ff0tMhMscTZifPzzODziNZCynhWA
         SY0V9LIweprycmGN93AZE8wyS5kHPFdUsqR4rbg+D+CjZpMez4a+XpSZ4AtooyqtpJ9r
         apG4iZ0u/08Bs9/TrlQH0v4KV+dgMWJL4RpwWPGN0giGmTjdqAxUwwUb7KAwPMY7GYJv
         BIav/V9jE4zq5bZOHEMku1lhHnX5ucwPzGeuDHek6QUfn1vwWGep+Xhr6W6jzB6jzySH
         TDoQhCRqhG7HHaQOvFIdqXPtIkiX36/wqo9u9ZemhrtC3Hvl2Acky/4QGYxqFGvSNGZT
         PEUg==
X-Gm-Message-State: AHQUAuYnMHMHxAf/qbAAqrwcDKOxhUPy+ZMUnxm0HMffGjdGTLSzPY0i
        BkO8QLUUKFSUhRf1DkMzIMy2spCEZAM=
X-Google-Smtp-Source: AHgI3IaPvBqOrLOP+vL8jUT1qpf4Npz88ZbbKOComZFaE9NL7+R8tpsn0rstdY+I7PYhWGcWOyRIbA==
X-Received: by 2002:a17:906:1cd7:: with SMTP id i23mr5082403ejh.150.1549411878900;
        Tue, 05 Feb 2019 16:11:18 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:18 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 07/32] timens/kernel: Take into account timens clock offsets in clock_nanosleep
Date:   Wed,  6 Feb 2019 00:10:41 +0000
Message-Id: <20190206001107.16488-8-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire up clock_nanosleep() to timens offsets.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/hrtimer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f5cfa1b73d6f..47345aea406d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -42,6 +42,7 @@
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
+#include <linux/time_namespace.h>
 
 #include <linux/uaccess.h>
 
@@ -1721,9 +1722,16 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
+	struct timespec64 tp;
 	int ret = 0;
 	u64 slack;
 
+	if (!(mode & HRTIMER_MODE_REL)) {
+		tp = *rqtp;
+		rqtp = &tp;
+		timens_clock_to_host(clockid, &tp);
+	}
+
 	slack = current->timer_slack_ns;
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
-- 
2.20.1

