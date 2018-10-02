Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1FC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B76D208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQCiVT1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B76D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeJBJTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:19:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54164 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJBJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:19:49 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so1358330itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 19:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0stoVsAw0VRDll7xKIRYaZk/NNhRyx/JgJ4JBhyYBI=;
        b=MQCiVT1yBHZwhB1okfLL+82FvWp4GoO2TF0lo8c8BbIiB3TwHiwU1yv+AtrW74bum0
         ZrH9D4NnR2Q7185gqVr03WF+df6ykmmjIgdLxz9ITQ98FUpqKDy+j1T64DOlDBIS3/ri
         dTx4U8A0+Bi3UOebtpHAGMsSHd0qiuQqWkeTU3J6HVXuT2XpKjiQQzhWQLgCZZscxhyN
         07S5A5sdr3DDLUy4fxAWfGjQU1opQgqVZ61Jht7adcS4rLjFDW503bAgf+Jsm5Npco6n
         S//rTFy2nlO5BOBAearo71JbNKuXxKhqLPtUOR8oAqKkiBN8m+agSyy5iKXkQ1lDZ7pJ
         BZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0stoVsAw0VRDll7xKIRYaZk/NNhRyx/JgJ4JBhyYBI=;
        b=DaU/qkHA4shURwjhFpBXPAu0gBZIwnXsN26p3Hc6v4tjtcATr2k57HhIdW9dwLDwqo
         koWd5MY0eXeREwwV5ZqSk5o4WerMnjsIrXZJ8DGT97DvSgSwRUiDnJCc9AZx9llqXSpk
         GFaE7jivGVvd/WohXU/q2MrZmlac6/ARo2hdPHUbn8k+eMO3aBqR+vKmq0MPY/OPQ0Kr
         AhAzPEgmnSND+vUmDg8qe9j4Z2xGWjvqGX97FzmDYaiMuQQXEa8P3NiCiAwA9T8Z3zVd
         i+eqRoCOEMRDoPo6OZLy4a7138Jn1bSc2yUhlCObglFf9GgDYE0UcsCComLEBM9yzA9k
         VpLQ==
X-Gm-Message-State: ABuFfohHyEl73g79SFrvzwCNH0qnCYuBP3zpPX8OE6Fu/2/6zQe51qJQ
        6Hm5c2UFekAkEWVGKgJxmZw=
X-Google-Smtp-Source: ACcGV60vQ9D5L8UDYEI9Pq6eXE4BdCOmCN3VaFYhn5DAfU6p3EJlyUuCnfXG5Zoy4EM0CVlLbIm64g==
X-Received: by 2002:a63:4f20:: with SMTP id d32-v6mr12278543pgb.231.1538447936479;
        Mon, 01 Oct 2018 19:38:56 -0700 (PDT)
Received: from localhost.localdomain ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id v83-v6sm35902744pfa.103.2018.10.01.19.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:38:55 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 1/3] printk: keep kernel cont support always enabled
Date:   Tue,  2 Oct 2018 11:38:34 +0900
Message-Id: <20181002023836.4487-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5c2992ee7fd8a29 ("printk: remove console flushing special
cases for partial buffered lines") we don't print cont fragments
to the consoles; cont lines are now proper log_buf entries and
there is no "consecutive continuation flag" anymore: we either
have 'c' entries that mark continuation lines without fragments;
or '-' entries that mark normal logbuf entries. There are no '+'
entries anymore.

However, we still have a small leftover - presence of ext_console
drivers disables kernel cont support and we flush each pr_cont()
and store it as a separate log_buf entry. Previously, it worked
because msg_print_ext_header() had that "an optional external merge
of the records" functionality:

	if (msg->flags & LOG_CONT)
		cont = (prev_flags & LOG_CONT) ? '+' : 'c';

We don't do this as of now, so keep kernel cont always enabled.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 308497194bd4..e72cb793aff1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -192,16 +192,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 	return 0;
 }
 
-/*
- * Number of registered extended console drivers.
- *
- * If extended consoles are present, in-kernel cont reassembly is disabled
- * and each fragment is stored as a separate log entry with proper
- * continuation flag so that every emitted message has full metadata.  This
- * doesn't change the result for regular consoles or /proc/kmsg.  For
- * /dev/kmsg, as long as the reader concatenates messages according to
- * consecutive continuation flags, the end result should be the same too.
- */
+/* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
 
 /*
@@ -1806,12 +1797,8 @@ static void cont_flush(void)
 
 static bool cont_add(int facility, int level, enum log_flags flags, const char *text, size_t len)
 {
-	/*
-	 * If ext consoles are present, flush and skip in-kernel
-	 * continuation.  See nr_ext_console_drivers definition.  Also, if
-	 * the line gets too long, split it up in separate records.
-	 */
-	if (nr_ext_console_drivers || cont.len + len > sizeof(cont.buf)) {
+	/* If the line gets too long, split it up in separate records. */
+	if (cont.len + len > sizeof(cont.buf)) {
 		cont_flush();
 		return false;
 	}
@@ -2731,8 +2718,7 @@ void register_console(struct console *newcon)
 	}
 
 	if (newcon->flags & CON_EXTENDED)
-		if (!nr_ext_console_drivers++)
-			pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
+		nr_ext_console_drivers++;
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/*
-- 
2.19.0

