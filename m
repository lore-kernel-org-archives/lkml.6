Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D59B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvav30om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D59B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeJ2Thd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:37:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53981 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeJ2Thc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:37:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id l26-v6so7688478wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aEWLaDb2yI+1DNd4jxamdSPIdF92GrY7Gw+p21fiuIo=;
        b=Wvav30omjGWoxCfcBTlkQcns3YJnsWigIDibAKGKPuOchPfuYZctMSh/Gni90RgKv8
         zlWy8msSsr/o/xxOLjWNECYki6/kTrTsEjyCzTyv0PmxAG4v9wRcxO0swdJKxJpJw8mF
         mJRLgz1IG3vStpp73BWaBzlnIIGM/7DIStxZe9MobrdLvyRJfP0s6OxEaAghy+1wdp/3
         BkjHik7oVvvBg1yeTSl/gA5sTr8YsZYdyTv836aCovRGiKgqnmPL6ZLX7aqoXERupdls
         1OcgZG7dvv1jkECCjVOx+b1Eq5B+vz1N01KIaFhyt0P//YYkxZ+7k+SvL9yaNjKZ5Efz
         K6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aEWLaDb2yI+1DNd4jxamdSPIdF92GrY7Gw+p21fiuIo=;
        b=d9mkcxrueRSAMqHXUFg0+IC+KXKF/Nc3rJFRYbGwd+/4XJ/KxmbfxF0hX5X6D49YH4
         yYdGB+z5jlkayPv1JuW2qJzmzGZQ5CAiKlodVLm2mZJTRzVfRD0j5Q/snp22wR85UdQ+
         rOyDhR7LxYzKCQTxGqNZA+E0HwzJSij2aCPTZ4ShY07KFvYBCa2UyH21F3VCljx/fWYN
         7K1q8+OAuqzhw2mSVFNkZJQafDkCr3QiO4klnl3tTno1uhjLeiK6XdMJND1t394+Whk1
         UbcPQaDGlvs7Jiu6HaAgxdpMHeev2DLB5j5rmSw4DYk7Wpxx1JQfu68GJY+aLvpHfp8O
         /PvA==
X-Gm-Message-State: AGRZ1gLnVPfY6d0cpogZYZ6mbioOutwfnX8Tnyk5ymvw2bT9662jIcHL
        l/AX2VCaNVQzyEc0MJjTa6UujBwBQzI=
X-Google-Smtp-Source: AJdET5dlWfPKGtpRUn8eutl97HqLkVnCWSWGK5D8iDGXIy72o5VQWKhyTJoX6qByOSaWCNyQPec9eQ==
X-Received: by 2002:a1c:9e93:: with SMTP id h141-v6mr14369759wme.56.1540810163070;
        Mon, 29 Oct 2018 03:49:23 -0700 (PDT)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id l70-v6sm36360609wma.0.2018.10.29.03.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 03:49:22 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 2/2] riscv: audit: add audit hook in do_syscall_trace_enter/exit()
Date:   Mon, 29 Oct 2018 11:48:54 +0100
Message-Id: <20181029104854.17432-3-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
References: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds auditing functions on entry to and exit from every system
call invocation.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 9f82a7e34c64..85b0c93f00c6 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
+#include <linux/audit.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <linux/regset.h>
@@ -111,10 +112,14 @@ void do_syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 #endif
+
+	audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, regs->a3);
 }
 
 void do_syscall_trace_exit(struct pt_regs *regs)
 {
+	audit_syscall_exit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall_exit(regs, 0);
 
-- 
2.17.2

