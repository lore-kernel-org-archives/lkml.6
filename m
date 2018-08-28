Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27044C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67882087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRO1epmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67882087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeH2AIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:08:01 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44318 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH2AIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:08:01 -0400
Received: by mail-ua1-f73.google.com with SMTP id d22-v6so1103845uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uJWoCGq+dC+kv6D5HnpJpcUVVj9VCc0+wlPJZZu58Ic=;
        b=MRO1epmGNwUCnHbU0i4f57VR08as3uyxoIBp5RmzwmlCtcWAZJpI/2we+TaZa0z2Ln
         3CrQkFyomt9BxMQNrkOBsV/YeVZN7p0iSiAehzruglhiG7k0hmVwlAzkxmiXtor6HVR8
         aT9r5T4hsK7PawtQzM7IesKSESdyb3FO4V3bFN+gYo6L0zwP7B6OWqaAqB3ZiYh7lXJb
         7SPdAY3RQ/DIrZb/kkiP/6f/txQyJ+f2WxkbINoeft9TbTBfUC1EdzbX8XJhMSldC4iT
         WK0q9e7si8qmOK7RWk5k4lF0hwIfI9BwmmORBhUTIGJTbB9v7RMieIa30NrxStXHDa45
         SubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uJWoCGq+dC+kv6D5HnpJpcUVVj9VCc0+wlPJZZu58Ic=;
        b=YxYVNKoFo8+62MaOZzoXGkMAT+u0JS8ixY80X+6haPcuxU9SQZx0AT8AUyDZqh0TAE
         5FJgZiNrpoIribP8Hi+jTA/yotJXMDS9NZUQ63pRX6MNStpYs9yQlQ0rPz7icfrhu4Wr
         THZI0JJr5WZpTZpkaeDxNRG5EWXnCYZuDAoz6HX9XkW1oHVqEQTbsIi/01MUgaFSQQO7
         UfAqA79A3oH2HdylQM+iLd21UBYYXUkEsLmnrcEazgfvxF/I8ZZgTnhs8IgaQZUvqhNz
         ku1nulm4TD2fTqE96fVGc9vDto+PRa/B/Nr3zBgO0Tf3UDmjef2CqTiOhtzE3D3pgD5p
         jJJA==
X-Gm-Message-State: APzg51CPHuEaPSnMOzB3l8zlVgGdysdfPY5+zZxURCMnDE2/ofFJU866
        SM2DCH6IUZ5P1JCF05lAJVUg3gsDDQ==
X-Google-Smtp-Source: ANB0VdbkegCsYkP9pgf34tu1wuFJg7i0BU53xS/AZqQ1qT0piv2l5bWT4weTcWV+ofjP9fz0MVA73wFxiQ==
X-Received: by 2002:a67:341d:: with SMTP id b29-v6mr901vsa.53.1535487285116;
 Tue, 28 Aug 2018 13:14:45 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:16 +0200
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
Message-Id: <20180828201421.157735-3-jannh@google.com>
Mime-Version: 1.0
References: <20180828201421.157735-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 2/7] x86: inline kprobe_exceptions_notify() into do_general_protection()
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opaque plumbing of #GP from do_general_protection() through
notify_die() into kprobe_exceptions_notify() makes it hard to understand
what's going on.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/kprobes/core.c | 31 +------------------------------
 arch/x86/kernel/traps.c        | 10 ++++++++++
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b0d1e81c96bb..467ac22691b0 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1028,42 +1028,13 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		if (fixup_exception(regs, trapnr))
 			return 1;
 
-		/*
-		 * fixup routine could not handle it,
-		 * Let do_page_fault() fix it.
-		 */
+		/* fixup routine could not handle it. */
 	}
 
 	return 0;
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
-/*
- * Wrapper routine for handling exceptions.
- */
-int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
-			     void *data)
-{
-	struct die_args *args = data;
-	int ret = NOTIFY_DONE;
-
-	if (args->regs && user_mode(args->regs))
-		return ret;
-
-	if (val == DIE_GPF) {
-		/*
-		 * To be potentially processing a kprobe fault and to
-		 * trust the result from kprobe_running(), we have
-		 * be non-preemptible.
-		 */
-		if (!preemptible() && kprobe_running() &&
-		    kprobe_fault_handler(args->regs, args->trapnr))
-			ret = NOTIFY_STOP;
-	}
-	return ret;
-}
-NOKPROBE_SYMBOL(kprobe_exceptions_notify);
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	bool is_in_entry_trampoline_section = false;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..bf9ab1aaa175 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -556,6 +556,16 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
+
+		/*
+		 * To be potentially processing a kprobe fault and to
+		 * trust the result from kprobe_running(), we have to
+		 * be non-preemptible.
+		 */
+		if (!preemptible() && kprobe_running() &&
+		    kprobe_fault_handler(regs, X86_TRAP_GP))
+			return;
+
 		if (notify_die(DIE_GPF, "general protection fault", regs, error_code,
 			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
 			die("general protection fault", regs, error_code);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

