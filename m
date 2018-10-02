Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9266F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+Zvp9A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9266F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeJBJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:19:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38141 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJBJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:19:55 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so600463ioc.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9nmbkWVpdl3bfNdEXFUCLRERBEIsEDwWD4co/5XVrU=;
        b=W+Zvp9A9KaH7PhNUxSf9URilSY3o8MBg6mUztHOhU7OHOk6n56IFsbQQVoO1Esv3pC
         YyXe3JJRGFaDCrSmHf3yyUF5ulRAXdRv30MPVFE0RKkRjRMKwIt7t8PH1Vuy6gA48fDL
         p3y5VlJ1kPCOK4xT1JVFRjSQUUJd4vdkQk5UOpw8lH6vLYyixj2rQa8IbpJpX1IhlcKX
         PF1JHUWDDpEO+LLzZk7yeNJgLKYAs/93h9FkecqXZB+67VPa0bY8qIh9QA/eKneDAnKS
         UEZQjn1TL0fCXSd4j3mh+uR64i9dGYp72i2TTZneI7BCaEcCnl1e07AqEWKtKBIYI3UO
         flVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9nmbkWVpdl3bfNdEXFUCLRERBEIsEDwWD4co/5XVrU=;
        b=FMY7P16a5qN/4iZMgSeB7IfLpLLcSQMpbiJlVWWwAmGnWBimWNgo45wC9sE3dKinyp
         biNttNCDWcl42maCfVy4H7jDKMBQxZbQu4liGEIwF3Wz64LToO8UalDu6S+32My7eo+O
         qSKVhki7dNDoOuXqcLmB4WxncmPPyseFb55oCOeWHLO64EkKUXRU2i30XPnVMEuttL4L
         pGQlzcEytohEFxYlp7VyB6bqvncj98EKlVqQLe8gPFz1iiQ7yBKh1/dzY3jGA9DrjMm0
         CdPngwhO+fmkO4dNerkp6XiaAo3M5K8LPqpIz2d9HTakuCGnLsLgZmrocr9PmxEtDqTq
         efrQ==
X-Gm-Message-State: ABuFfoj5M+dZAGmz40QSR3AfHMAxCMx7e2gi9WG2qSOffXJ4WH0sGmpA
        LqNSEBCKAHVQHgaulfxoN0WKT+9m
X-Google-Smtp-Source: ACcGV61VS7gOsnwPgx3MzJNCWt15zjJj/zzHlXl44EYLAQtF8MeD5+PcUDclU8RKR16Lbh4a2VZM5Q==
X-Received: by 2002:a17:902:6848:: with SMTP id f8-v6mr14647058pln.27.1538447942847;
        Mon, 01 Oct 2018 19:39:02 -0700 (PDT)
Received: from localhost.localdomain ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id v83-v6sm35902744pfa.103.2018.10.01.19.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:39:01 -0700 (PDT)
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
Subject: [RFC][PATCH 2/3] printk: lock/unlock console only for new logbuf entries
Date:   Tue,  2 Oct 2018 11:38:35 +0900
Message-Id: <20181002023836.4487-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

Prior to 5c2992ee7fd8a29 ("printk: remove console flushing special
cases for partial buffered lines") we would do console_cont_flush()
for each pr_cont() to print cont fragments, so console_unlock() would
actually print data:

	pr_cont();
	 console_lock();
	 console_unlock()
	  console_cont_flush(); // print cont fragment
	...
	pr_cont();
	 console_lock();
	 console_unlock()
	  console_cont_flush(); // print cont fragment

We don't do console_cont_flush() anymore, so when we do pr_cont()
console_unlock() does nothing (unless we flushed the cont buffer):

	pr_cont();
	 console_lock();
	 console_unlock();      // noop
	...
	pr_cont();
	 console_lock();
	 console_unlock();      // noop
	...
	pr_cont();
	  cont_flush();
	    console_lock();
	    console_unlock();   // print data

We also wakeup klogd purposelessly for pr_cont() output - un-flushed
cont buffer is not stored in log_buf; there is nothing to pull.

Thus we can console_lock()/console_unlock()/wake_up_klogd() only when
we know that we log_store()-ed a message and there is something to
print to the consoles/syslog.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e72cb793aff1..aea37b7927dd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1916,8 +1916,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	int printed_len;
-	bool in_sched = false;
+	bool in_sched = false, pending_output;
 	unsigned long flags;
+	u64 curr_log_seq;
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
@@ -1929,11 +1930,13 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
+	curr_log_seq = log_next_seq;
 	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
+	pending_output = (curr_log_seq != log_next_seq);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && pending_output) {
 		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
@@ -1950,7 +1953,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	wake_up_klogd();
+	if (pending_output)
+		wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
-- 
2.19.0

