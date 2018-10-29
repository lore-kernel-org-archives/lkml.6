Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048020664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0o/8jgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8048020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeJ2VDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:03:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38621 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbeJ2VDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:03:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so8427208wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sLEKKbyvwHhkDcroeY9+oVKNgUdmgNgsvBDBfj2Nh14=;
        b=N0o/8jgYOWI/iOHZmz7TUZxMjmYsP2PMVUeH0JWPjiLen7CmTprSCGJeJy+K8bRjnX
         xQTWF9yBSJnU0xikP/Zqx7uYTtmmOSKLdpl66UysxoHgEOM0ScsHHk4gIdnPNTLTja0R
         HQBpdGWvLyif7mIvEPbvJW/fLwKh/JddxX156Qf07ITBPoJ5DtREWCN5g+q6bPg+Hb7z
         eJmFTCnxHdrOzpxeVlUkYhl39XozrSZGJmptTl0PMl0pOd8Q6mKoG9NocBVbIQ3Wm3At
         xg8ELmR68jf5+RDnYVU+wHRcciJdUhPQWPyZD58B2vTDOsB+V0W2EspacblA6FPdJQd2
         pn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sLEKKbyvwHhkDcroeY9+oVKNgUdmgNgsvBDBfj2Nh14=;
        b=FrOXPh+vAS6vhRZHc22Jyfnd+4AAid1DHRsrtozbCIyH10NRIEIjvqpfsbPv1NU2w7
         yGAEChMGezOoTuVQ2DsSTo9CB4ykY26Hqm2pmSKBByZ5oCANX/hX5n+A+Q/CJr/qUb6v
         FR+5QtKooGLddSmIQJsWOEa9mPbnk0NUSsBL5fDMcBR0hgahkt53xo2dFAeqASLcEbQs
         YGQ2BNXzoffCniA/OhIKFCOIICy1d0fYe2cc/vYfKctv27uLuSGwPuL1/hjsvE+BtPge
         UBPLUqlRw6V070ugNIL/SBDz282bjiTAWJkJqo/1Sn720+9rURc/vZZdOKEZ3pgGpxft
         +Jgw==
X-Gm-Message-State: AGRZ1gLAUaYu8r875coOAddIN/4frOniMOv5JLVbyPPR1qJTeiSmGwwI
        oPd7l7VJ7IYm2KX3Z2t0EM8=
X-Google-Smtp-Source: AJdET5c3SMdYrOC0BKrIf8ou6gBd7zGParOGg4pWp92AkXrk1Tc/a5CCuzPuQnv7aR/v7OVCy1wm7g==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr15551671wre.157.1540815324342;
        Mon, 29 Oct 2018 05:15:24 -0700 (PDT)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id y19-v6sm27359575wra.60.2018.10.29.05.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 05:15:23 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: fix trace_sys_exit hook
Date:   Mon, 29 Oct 2018 13:15:16 +0100
Message-Id: <20181029121516.29574-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on:
http://lists.infradead.org/pipermail/linux-riscv/2018-October/001931.html

Why we don't have HAVE_SYSCALL_TRACEPOINTS in arch/riscv/Kconfig?

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 9f82a7e34c64..9db7d0076375 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -120,6 +120,6 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs->regs[0]);
+		trace_sys_exit(regs, regs_return_value(regs));
 #endif
 }
-- 
2.17.2

