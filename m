Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeDQF6k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:58:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeDQF6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:58:38 -0400
Date: Mon, 16 Apr 2018 22:58:10 -0700
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-5c8dad48e4f53d6fd0a7e4f95d7c1c983374de88@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, vincent.weaver@maine.edu,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, songliubraving@fb.com,
        peterz@infradead.org
Reply-To: mingo@kernel.org, vincent.weaver@maine.edu, hpa@zytor.com,
        tglx@linutronix.de, songliubraving@fb.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180413185513.3626052-1-songliubraving@fb.com>
References: <20180413185513.3626052-1-songliubraving@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] trace_kprobe: Remove warning message "Could not
 insert probe at..."
Git-Commit-ID: 5c8dad48e4f53d6fd0a7e4f95d7c1c983374de88
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5c8dad48e4f53d6fd0a7e4f95d7c1c983374de88
Gitweb:     https://git.kernel.org/tip/5c8dad48e4f53d6fd0a7e4f95d7c1c983374de88
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Fri, 13 Apr 2018 11:55:13 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Apr 2018 07:54:57 +0200

trace_kprobe: Remove warning message "Could not insert probe at..."

This warning message is not very helpful, as the return value should
already show information about the error. Also, this message will
spam dmesg if the user space does testing in a loop, like:

    for x in {0..5}
    do
        echo p:xx xx+$x >> /sys/kernel/debug/tracing/kprobe_events
    done

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20180413185513.3626052-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/trace/trace_kprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1cd3fb4d70f8..02aed76e0978 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -512,8 +512,6 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret == 0)
 		tk->tp.flags |= TP_FLAG_REGISTERED;
 	else {
-		pr_warn("Could not insert probe at %s+%lu: %d\n",
-			trace_kprobe_symbol(tk), trace_kprobe_offset(tk), ret);
 		if (ret == -ENOENT && trace_kprobe_is_on_module(tk)) {
 			pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
 			ret = 0;
