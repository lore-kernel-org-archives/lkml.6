Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD008C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E972087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqjEy0pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E972087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeH2AH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:07:58 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:38013 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH2AH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:07:57 -0400
Received: by mail-vk0-f73.google.com with SMTP id d134-v6so1114570vkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uRAKHZlA0btsCxDvC9F6MjjKyQXLUpbtwbnShrkeMs8=;
        b=QqjEy0paB2ESV8Eq3Z0vETkQyMFWYL7kKtF/GF8hO4P+n/fyNdczSjh4I9yk7VBXvY
         CdhV263LIrzgGo+MzHtTLUaUlO3nB8ye5f7YrwPgbLec9ND8WyL3TClkV8zWEvQot1QC
         YDJ2LcFH7fE8hlvgDKcNHj+7L+QFJhbxV3CamRUr3H6aabclbqrGOtUn24Uli6u9w2sB
         a7qBwt5as4CNh3pVe6VdAO852f5kqRb4+n9ylOd4wZX/6AJILVnzc4TgZ82WUTcCU4Gp
         n2hdirYGHToTE8Bn1wxoIOSmqmdOPmgPnZRM7ghWxK/zE5SnF0mfpA0Dc2vaU802MtLJ
         q3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uRAKHZlA0btsCxDvC9F6MjjKyQXLUpbtwbnShrkeMs8=;
        b=diP8vp5p4bW2+sei1bYWURKfQR8VBTlODJWWGUCdnSohR+NCB642GeZKgpuLXCCoxm
         IGXVAGj+1y0mGFpDf6ol1DGgZRG6cQxZbm8V59XTrIwcAT6gYNAcXbtwnriE/hHaE/+f
         oKPAUdz8peQyaMWiGLun67eg3kARyDJGifzLc6CG0JqjvUjLfDYBWazw+zsVnNKxE0h9
         N9gKllj/TW/jtmExP0wNbmKtJipZTe3qtXv+DhJEh6St14pzuhAOy10izK+5AngbZY0Q
         iosK+BEgXqV1Uz+DJCPd3T0RHjU/TxkTzRyMipJu9LqzYw+uIx0n+e8Cib25Z7gv/6s1
         BFEA==
X-Gm-Message-State: APzg51DPcS2JtmCv8GsczmGLczo6RpaiT8zuH+gwuCbiH5zqBOVq6byJ
        dBaMEXI6Aj1dcORXf87pMdzpPAz4mA==
X-Google-Smtp-Source: ANB0VdZp/YDJc9C/v0lNpho7kK8NpP0tyQo06S1Yg8u9D8Ds1SiTDfbf4uwei9wnD4CvG4s+hIq1EkqCog==
X-Received: by 2002:a1f:d382:: with SMTP id k124-v6mr1430418vkg.14.1535487281915;
 Tue, 28 Aug 2018 13:14:41 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:15 +0200
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
Message-Id: <20180828201421.157735-2-jannh@google.com>
Mime-Version: 1.0
References: <20180828201421.157735-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 1/7] x86: refactor kprobes_fault() like kprobe_exceptions_notify()
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

This is an extension of commit b506a9d08bae ("x86: code clarification patch
to Kprobes arch code"). As that commit explains, even though
kprobe_running() can't be called with preemption enabled, you don't have to
disable preemption - if preemption is on, you can't be in a kprobe.

Also, use X86_TRAP_PF instead of 14.

Signed-off-by: Jann Horn <jannh@google.com>
---
v3:
 - avoid unnecessary branch on return value and split up the checks
   (Borislav Petkov)

 arch/x86/mm/fault.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..bcdaae1d5bf5 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -44,17 +44,19 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
 
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
+	if (!kprobes_built_in())
+		return 0;
+	if (user_mode(regs))
+		return 0;
+	/*
+	 * To be potentially processing a kprobe fault and to be allowed to call
+	 * kprobe_running(), we have to be non-preemptible.
+	 */
+	if (preemptible())
+		return 0;
+	if (!kprobe_running())
+		return 0;
+	return kprobe_fault_handler(regs, X86_TRAP_PF);
 }
 
 /*
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

