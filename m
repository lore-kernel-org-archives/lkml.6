Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A051C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AD0208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P251Yg4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AD0208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeH0Wpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:47 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:37065 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeH0Wpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:46 -0400
Received: by mail-qt0-f201.google.com with SMTP id b5-v6so27539qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uJWoCGq+dC+kv6D5HnpJpcUVVj9VCc0+wlPJZZu58Ic=;
        b=P251Yg4XTOGN9zPdxhNMgYM/EY0/UfzuP6Y77+vHpwGP/4ACr6sepDbjZrRXOio60G
         7wpuql49VaYM0tJPqYeSiBYq5GeynF83vXviLqmdy9hNxYGGiSQTS94rXZvJ/XpgL2F9
         RxwtGQuP37JVgQ1heB/5/cFE83tYYbR14GrSAFO6trSmAsY5CoWSJqGR1GklUSdceR8t
         58GNr6vj+/OEUAHuLPp3FfZafThnevrtJavIBOsbqR8+DfMN7G5EjFupooDFlS/oIC/U
         6EpJ3RH7tKZCaDtZP3ZlRjB1VUJJjkPGs5S4ClEynQsJ84UxoXPDpXz8oWNtKIqWOXfi
         5iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uJWoCGq+dC+kv6D5HnpJpcUVVj9VCc0+wlPJZZu58Ic=;
        b=IzLNtQtTHGpbR9J2pm4SMm59p5nNoVYqSFW4mLmGa3FDMk4aXVwm/f/NfH8csASHbm
         L4Wpy1D1brUSpI60Js7Z4g53LRz9kQAxEjnFhXsnx1JkfNbrRJinLTu3CyARJkMqcdag
         4lLtqAMRaynH8ObWOhUmutkHPEY9W65qcf5w4puqqVtpKvd5vAIyygcrjc9aYOPbx0jq
         ETiIVBNnVcoa6Zqq4c4JyXKi5+PNMEXkHzHY+SfwQN8GrVYM3Hrw7KXZ+axb0cyjN/Lk
         k5r/qS9mFHxhwSNE1W08fqhgTjklv/GGXT7EYwfJMxiTdmUi8+lnUzUvZOmfCBr6NB11
         X47Q==
X-Gm-Message-State: APzg51AtkL1Z6kOzQO4cQQXULtG60t+yfbxf4nxt9TjUF6Q4DoBf0EPF
        iOdXKB5N0D7G6KmOmTegWKyNHBtFaA==
X-Google-Smtp-Source: ANB0VdaUfyo3zrWPEn2HbXdjdwG/E5fPLdmcTAdii0N1YRweY5xFts+AtOUalUPZ1IZQmYtZpTf8JHM4sg==
X-Received: by 2002:a0c:d2da:: with SMTP id x26-v6mr19428qvh.36.1535396276214;
 Mon, 27 Aug 2018 11:57:56 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:26 +0200
In-Reply-To: <20180827185631.163506-1-jannh@google.com>
Message-Id: <20180827185631.163506-3-jannh@google.com>
Mime-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 2/7] x86: inline kprobe_exceptions_notify() into do_general_protection()
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        linux-edac@vger.kernel.org
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

