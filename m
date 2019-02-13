Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96041C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711B9222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbfBMI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:59:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390952AbfBMI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:59:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D8wtZV195690
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 00:58:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D8wsLi195687;
        Wed, 13 Feb 2019 00:58:54 -0800
Date:   Wed, 13 Feb 2019 00:58:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-0192e6535ebe9af68614198ced4fd6d37b778ebf@git.kernel.org>
Cc:     righi.andrea@gmail.com, jolsa@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        mathieu.desnoyers@efficios.com, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Reply-To: mathieu.desnoyers@efficios.com, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          mhiramat@kernel.org, rostedt@goodmis.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, righi.andrea@gmail.com,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <154998787911.31052.15274376330136234452.stgit@devbox>
References: <154998787911.31052.15274376330136234452.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] x86/kprobes: Prohibit probing on optprobe template
 code
Git-Commit-ID: 0192e6535ebe9af68614198ced4fd6d37b778ebf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0192e6535ebe9af68614198ced4fd6d37b778ebf
Gitweb:     https://git.kernel.org/tip/0192e6535ebe9af68614198ced4fd6d37b778ebf
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:11:19 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:39 +0100

x86/kprobes: Prohibit probing on optprobe template code

Prohibit probing on optprobe template code, since it is not
a code but a template instruction sequence. If we modify
this template, copied template must be broken.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 9326638cbee2 ("kprobes, x86: Use NOKPROBE_SYMBOL() instead of __kprobes annotation")
Link: http://lkml.kernel.org/r/154998787911.31052.15274376330136234452.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 6adf6e6c2933..544bd41a514c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -141,6 +141,11 @@ asm (
 
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
+NOKPROBE_SYMBOL(optprobe_template_func);
+NOKPROBE_SYMBOL(optprobe_template_entry);
+NOKPROBE_SYMBOL(optprobe_template_val);
+NOKPROBE_SYMBOL(optprobe_template_call);
+NOKPROBE_SYMBOL(optprobe_template_end);
 
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)
