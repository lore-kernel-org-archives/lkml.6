Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90264C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CE52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9MstZk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CE52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeH2AIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:08:04 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39291 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeH2AID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:08:03 -0400
Received: by mail-pg1-f201.google.com with SMTP id q12-v6so1771130pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=03TAXzBIbK9qSPjls82pb6bVgK3cZq6BxaYmPeOzPNA=;
        b=k9MstZk0c2zdNTFSvMTX0jVj6F0t2QStibNqEXye6Ey7CN7GTPilMG/QNGEft9wwy7
         7z3CUVCrnrHtFjQjnkrsiBgHyXu+V4ix9rOiV4ZhUDLlcDEls7cQ49zmOUuIeITJ89J+
         BBYyvErOgZn9brmOZMbBKpii+A8kEqmhE6h7D25Hru6B1N7gwxHGU+60IbF6vnTz/DUF
         8eJg1VRws24//e00HOVbKSAPVB5SIPxY1rTRctGFQWg7LZDxNcVr9KHesDp/YyZOqnVd
         S4e9L3Tt7fufL0H57G4qQL0Kd9YsY1Wb0/g0gCfLQ0RoCOiCmnpeQbkLBeXym0aCP8mS
         ZUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=03TAXzBIbK9qSPjls82pb6bVgK3cZq6BxaYmPeOzPNA=;
        b=SV2osJ0oLXVBEBXlsirlGtWnG/gSju7E8GRaHdRpPVYMe5Vt1CqjXJnClLfY1NGyOv
         g6m7IU9jtMJLlF9UvFXd13UxwSlqcBhz/7UYUG1p6ASSaMylUtqbEmNoj2/t9JfJsN5c
         Hg2xw9Pzhr4ueKiwHqH6cd7macfKi2XwSkfSlH121xmSDAw32ZQzI6RVYk8EPecu47W1
         7wFIwTez9ofCW8N12dRJzQYbV6bqq0cBe6m9A9GspIX9GvSG5PijiFAz/+iVLX4CbEHj
         os8pGUaFfCJywNaH3rh1FlIrUDySeR3EqPxhL0mXsn4nXNFJcEN65zMBVGV9bNLmfKFL
         Vckw==
X-Gm-Message-State: APzg51Ae6RkqLtR11GBl0rQxTwexKEuEwQGOe6p7w/VIjpq3G9Xc2iF2
        KGfC+0B0aJfzsW9wlJSIifCApo7geA==
X-Google-Smtp-Source: ANB0VdYgWZ5VfYWaGnKLfkPsMkmQJLzGAuQC5FQ4qD+JPJXy209W/KyIRBpY8ob3Rf+BctOyZwDckr/9yw==
X-Received: by 2002:a63:4406:: with SMTP id r6-v6mr853725pga.64.1535487288321;
 Tue, 28 Aug 2018 13:14:48 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:17 +0200
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
Message-Id: <20180828201421.157735-4-jannh@google.com>
Mime-Version: 1.0
References: <20180828201421.157735-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 3/7] x86: stop calling fixup_exception() from kprobe_fault_handler()
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

This removes the call into exception fixup that was added in
commit c28f896634f2 ("[PATCH] kprobes: fix broken fault handling for
x86_64").

On X86, kprobe_fault_handler() is called from two places:
do_general_protection() (for #GP) and kprobes_fault() (for #PF).
In both paths, the fixup_exception() call in the kprobe fault handler is
redundant.

For #GP, fixup_exception() is called immediately before
kprobe_fault_handler() is invoked - if someone wanted to fix up our #GP,
they've already done so, no need to try again. (This assumes that the
kprobe's fault handler isn't going to do something crazy like changing RIP
so that it suddenly points to an instruction that does userspace access.)

For #PF on a kernel address from kernel space, after the kprobe fault
handler has run, we'll go into no_context(), which calls fixup_exception().

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/kprobes/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 467ac22691b0..7315ac202aad 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1021,13 +1021,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
 			return 1;
 
-		/*
-		 * In case the user-specified fault handler returned
-		 * zero, try to fix up.
-		 */
-		if (fixup_exception(regs, trapnr))
-			return 1;
-
 		/* fixup routine could not handle it. */
 	}
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

