Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019BC65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66F120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoWoU9KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66F120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLFPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:02:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39057 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeLFPCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:02:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so801471wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m+VGxXWqzzk+UmYyKJAtJtNfco3vK/6BU20MncbTSg=;
        b=AoWoU9KDHDQYaQPWpw5KuLwv/1GAQqp+BrIM+YLMxWKoGXYVNalfOqHXDkpSNclk5j
         7YhG2uss3UxJnsAAcJSMGY4julk0/gX8cimiVcrP70qjWuwCXNlpnL3+urPOQZ6bsFSa
         eTprO4juwSxg3iKj5RFcYwHLkd2NkEs9MsFowWn2+dJphT1qunRjXeOV0chp+fbuNPPr
         AjriJ2VQXcmu26wNn+eBy6dBtX4mVkW6Omg4R2V1mcCNJUdlwO8YGhP0S8TqhCNGO+hy
         XrTydIM0esFYvi5/kfaXEEB30PiOsTAza5xB3mazRBgUSbXpNSdLP5fkzDUOUWHQNklo
         ZuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m+VGxXWqzzk+UmYyKJAtJtNfco3vK/6BU20MncbTSg=;
        b=Pwj7bvejrtE80qxZoElDBFA7rD0XKHzNjhKKbjq2zvMXPUMwEDUzTYEeRwOYYaTXaI
         C5fEv6QiWdax0J+sK4W0kdBT6LojM14ym3iofSXa+OBdBOubK+2VjiC9NY4kFmWdywJ+
         m7TmBOP68Wlfnv2L9IBlB1XFKNY6sXSRzN++rz7wl8p9zVcWyPueqd+XjDLujxJ4q9R6
         c3apBZ+9MY/j2fqcJyR0ZEiL3h2KP2TtnbDVSQaweHpsSMiGCehHg8DbYE5GvaFONhR3
         G1BZSFkuBWdy+L0EIl8X0uGDsRmIQ9J/+FlCBSO7Z4Bkv/MXbeuBm9wQZVmAkwY3fSIQ
         iToA==
X-Gm-Message-State: AA+aEWb7V4huX99H4Lh00p1hQiiFnL1JdVdZGk4gOo8FVo1LLmiRhWkA
        gZLunqWRIJdO7kU9xCq3FX8=
X-Google-Smtp-Source: AFSGD/V4wxlb4lUV4iD4GJ0BinuooVz6UZLecT0zr/Gat1pDne/3gAwpAYc9Vojf4SOci/RplLDXlA==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr24658040wrx.134.1544108535714;
        Thu, 06 Dec 2018 07:02:15 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id 14sm1629981wmv.36.2018.12.06.07.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:02:15 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 2/2] riscv: fix syscall_{get,set}_arguments
Date:   Thu,  6 Dec 2018 16:01:56 +0100
Message-Id: <20181206150156.28210-3-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing with libseccomp master branch revealed that testcases with
filters on syscall arguments were failing due to wrong values. Seccomp
uses syscall_get_argumentsi() to copy syscall arguments, and there is a
bug in pointer arithmetics in memcpy() call.

Two alternative implementation were tested: the one in this patch and
another one based on while-break loop. Both delivered the same results.

This implementation is also used in arm, arm64 and nds32 arches.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/include/asm/syscall.h | 42 ++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index bba3da6ef157..26ceb434a433 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -70,19 +70,32 @@ static inline void syscall_set_return_value(struct task_struct *task,
 	regs->a0 = (long) error ?: val;
 }
 
+#define SYSCALL_MAX_ARGS 6
+
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
 					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
+	if (n == 0)
+		return;
+
+	if (i + n > SYSCALL_MAX_ARGS) {
+		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
+		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
+		pr_warning("%s called with max args %d, handling only %d\n",
+			__func__, i + n, SYSCALL_MAX_ARGS);
+		memset(args_bad, 0, n_bad * sizeof(args[0]));
+	}
+
 	if (i == 0) {
 		args[0] = regs->orig_a0;
 		args++;
 		i++;
 		n--;
 	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+
+	memcpy(args, &regs->a0 + i, n * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
@@ -90,14 +103,23 @@ static inline void syscall_set_arguments(struct task_struct *task,
 					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-        if (i == 0) {
-                regs->orig_a0 = args[0];
-                args++;
-                i++;
-                n--;
-        }
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	if (n == 0)
+		return;
+
+	if (i + n > SYSCALL_MAX_ARGS) {
+		pr_warning("%s called with max args %d, handling only %d\n",
+			__func__, i + n, SYSCALL_MAX_ARGS);
+		n = SYSCALL_MAX_ARGS - i;
+	}
+
+	if (i == 0) {
+		regs->orig_a0 = args[0];
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(&regs->a0 + i, args, n * sizeof(args[0]));
 }
 
 static inline int syscall_get_arch(void)
-- 
2.19.2

