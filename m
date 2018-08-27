Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D509FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934AF208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9crLYXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934AF208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeH0Wpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:44 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:56396 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeH0Wpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:43 -0400
Received: by mail-yw1-f73.google.com with SMTP id v144-v6so9124285ywa.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KBDYTwl+4YqOfnO5Qfg86x4cKuvMKrAYQHW8MjM7Sds=;
        b=o9crLYXA1KBVkHprU7iR4oojNCYfx0uxHyHSLNCkuQrKYrCnSBnaqMMyFELgVXd1NZ
         DAXXMej5rPOgAvVYzUelSVx7IIGxcrD9FAWTz9rULDc3e9Ac+TfzU2AcJ/5GGyVGnVKJ
         hS11XZbVar/Zr3KgB/yy7tXA93X55V8ZjgGKtfh+sn9FrvgVjJgFkPHLLa8nZQet3U9V
         n2de6p9ZUNe5uC2cMTEdz8g7WDzmcSLRfNTcOLaNa+u1aHrzpekIM0kxppOOijTsP5eS
         kPWizBb7tbRMa064qCQl6hhgL9mjFA94KU5fMeCVpvrZx4rUNkNhFKmvuh0GVRswxZ75
         XuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KBDYTwl+4YqOfnO5Qfg86x4cKuvMKrAYQHW8MjM7Sds=;
        b=lmNWHXtHIWKY7BO1DsVShDlkTqe6yJADu1CDN159W7/lvhbkx56JbFkZQZVAZKWFUp
         4Hlk7mPjKEIK8DK5zh1kfy+/0USPzW6Z6xSVA97prTGenpY0zS5FHAtZiJHdkdvfdDoM
         nnwc82PIrDLSOihDFQiMFNTqV2XRRtCZEeP87+DqGTAzYhGseMLlgbhdcYAPgaAyiWeQ
         jGTCJJxL1i/h8rZ2hNujlfC5aiQ/yeW7jNtR/gDMjiGWZ6UbdRd3P6U3AaxnlIRWLiXx
         lkZBxBgMp5o6rlxtBXAoTKd9vJBeVkd5kwIqNiIbC/10H8ZP2bOP7KCbnXB7zV8awi/P
         KdRQ==
X-Gm-Message-State: APzg51DYCGODPCEwnHG/5HAeh3fXKXVU0CqmF3oKCOBcdfVKKXvr0Zal
        FllUvFJNQi6Sf+B8lhaLBn1xTSTgHg==
X-Google-Smtp-Source: ANB0VdYevvTK8UaxtYEQwxoCuHfWK0zoq9LG6T+yi/CM+Cq4Si26e92JZ4jvKH6PfCJcXKmEluyhASxfKQ==
X-Received: by 2002:a81:a1c3:: with SMTP id y186-v6mr4485ywg.206.1535396273261;
 Mon, 27 Aug 2018 11:57:53 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:25 +0200
In-Reply-To: <20180827185631.163506-1-jannh@google.com>
Message-Id: <20180827185631.163506-2-jannh@google.com>
Mime-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 1/7] x86: refactor kprobes_fault() like kprobe_exceptions_notify()
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

This is an extension of commit b506a9d08bae ("x86: code clarification patch
to Kprobes arch code"). As that commit explains, even though
kprobe_running() can't be called with preemption enabled, you don't have to
disable preemption - if preemption is on, you can't be in a kprobe.

Also, use X86_TRAP_PF instead of 14.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/mm/fault.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..2254a30533b9 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -44,17 +44,14 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
 
 static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
 {
-	int ret = 0;
-
-	/* kprobe_running() needs smp_processor_id() */
-	if (kprobes_built_in() && !user_mode(regs)) {
-		preempt_disable();
-		if (kprobe_running() && kprobe_fault_handler(regs, 14))
-			ret = 1;
-		preempt_enable();
-	}
-
-	return ret;
+	/*
+	 * To be potentially processing a kprobe fault and to be allowed to call
+	 * kprobe_running(), we have to be non-preemptible.
+	 */
+	if (kprobes_built_in() && !user_mode(regs) && !preemptible() &&
+	    kprobe_running() && kprobe_fault_handler(regs, X86_TRAP_PF))
+		return 1;
+	return 0;
 }
 
 /*
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

