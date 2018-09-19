Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E891C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E1621528
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P0NUL8cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E1621528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbeITCby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:31:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41806 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732713AbeITCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so6028917edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDaZEMB2C80kMNyCOhHh/iJBiqAUF/7c7WB9+YRBuTE=;
        b=P0NUL8cABaWV9joJLNyZH6+AnE5fllXYkQLUGvmTy5DInTp/zeY7mAJXdjxlDDQnjG
         LtsPp5IrRvWcWhfqitKQsGOUqzN3AttsBlmgRa0ZK1BmossUYcMxvM5lGiwJRVJqWd2f
         c34ttnpn/dYMdFhiEqksd4ze/gypbGBA2wsqB3vhYLwKsi8higXyhVioVdbwWPU8n5B7
         ETrLpQnwMqKQ24iiSroFEBUDI0ncbwhI+PLjxWuluhL1/XTqnlHQkrDQMwqj3Li7rSjh
         VsNgh30iPovFFtYQy9erO7Hi5/smpxptktRLE4OQ7o0rVtEk/9qCiWdJLdJib5yZY06Y
         zviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDaZEMB2C80kMNyCOhHh/iJBiqAUF/7c7WB9+YRBuTE=;
        b=Nl/pjraqU7HbM5rtYktKjZF5Xa7vg5Z9Nonqk4ldVylXFK/Xs8BnIFiqW38HUHRhL0
         1v0zG8JA6doY3RIRi1rE4pzb2JsWiNiLz2ddSQgCAG1VYXWBzIW4dYCiskLK6ONExGtp
         NYt4nczx4T9rE7DOKJvOiwtPIGNm+hStOhnPXlFHKt4NJssesb4C2jOdiErF155CZzLf
         CZfTBfLIBYcqfEk8ZPoi34lLmvo8lKJd1if1xpELXo0yqExkAiS1k1bdh4UdYvcMjOqI
         W1KOtWD9VPerccUnmJMfgHVf6iqlQLddKsDUturgFmN6Fkj8ZkjdyMbBwf/JOiI+LAA4
         uzMQ==
X-Gm-Message-State: APzg51CA3in6I5c7HC6QilcvqsP2AG9yAXsLbzoF5JZ5PSiIQsj45vcD
        I/AXNNIvgCK+mFsgD+g/8tdOi+W5Eak=
X-Google-Smtp-Source: ANB0VdZ2RpIL2bqcX7Q+ETk4GV6KrEHP0TZTeZ43IiMVXoIm0tUoKl0bun77Fp485R0kOe4ehcjo4Q==
X-Received: by 2002:a50:a7a2:: with SMTP id i31-v6mr61302489edc.296.1537390249603;
        Wed, 19 Sep 2018 13:50:49 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [RFC 07/20] timens: Shift /proc/uptime
Date:   Wed, 19 Sep 2018 21:50:24 +0100
Message-Id: <20180919205037.9574-8-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect boottime inside time namespace for /proc/uptime

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/uptime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index a4c2791ab70b..4421ec058472 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
 static int uptime_proc_show(struct seq_file *m, void *v)
@@ -20,6 +21,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
 	ktime_get_boottime_ts64(&uptime);
+	timens_clock_from_host(CLOCK_BOOTTIME, &uptime);
+
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.13.6

