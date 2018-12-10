Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A26C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0CD2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzbrB6QZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0CD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeLJUoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:44:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39574 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeLJUoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:44:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so32337wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAFBhCoIWdPJwhjOTKbWPt1miTzrc/kQ35Vv8Rxycpw=;
        b=nzbrB6QZoZNwzaVqsOn6BnssQ3je8K5Yjd+Jb0TaOisD04FZ0gjJu1EieOos7mrfK7
         iSRGrtaOMXww8d6EVjcGhJ2cFVvmGnNp0m/T5sk2LUisr8eMpAtQMib59gX7Md6J20sn
         zQdByUZT2Du+1B5qTjV0zNWJEbPcQkEYOYeRDJE6ujwXoxN1F0dhnSliLp6eL0TuPt7t
         jXWcW+jKisOCf3+d6PvZx9F56fMOb+6fR28D4PU/07CgAFG8/nTBTzF0YhXOlZOKokrW
         paYeQ2gqURl8IldmgE4qIQLHWLzFxXUlSPFA+UyNGy1wi1u8PI7R5a+7dOM334CMMRh/
         cqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAFBhCoIWdPJwhjOTKbWPt1miTzrc/kQ35Vv8Rxycpw=;
        b=I27uBExilGtpfiawqfJeYjI2Zi+zer4oau0LRAJXJBwqNKYB6r0YtOLxLm3AEkrpri
         FSwbPhFEzFkXMfsT4axKCZ0jNAYxfXc6DqJwGgw6yHY1xwZM7CkYZ6OFZ5nLDoElC4kA
         IX8R05s0MhG/wJf+ngeyt/j6LdlQZRfbASMCyhf5vk3Ps4A6LAbprSOg8PEGpPLWJCgQ
         fBc4zqWeyBgdbyo6M2aOzjXg0SAM1vjk0lrSDtiLh0ihjzP1xTNGH0T6hgapiggrlLuB
         KrOVULiGTndAbjEj3iwThBDHnptJeMGFgV3Agjr6MPJyvWY63NycsMDosj1ix0RQwBEh
         YXmg==
X-Gm-Message-State: AA+aEWa7Vkvtkm9nXqRc7VobBQlNLw17Uw3hYwrbdjzi0CG9XYVOeseR
        MVLEHp6OgcXwVpfXwiijO9k=
X-Google-Smtp-Source: AFSGD/W21idbVG3TaM3xUmJchLOEr24PJWhpFRDf8/n10P4+sF7VSdcEnyndffOKUptoI07YlMxWMA==
X-Received: by 2002:a1c:e90c:: with SMTP id q12mr7428413wmc.12.1544474643758;
        Mon, 10 Dec 2018 12:44:03 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id b131sm26985wma.21.2018.12.10.12.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 12:44:03 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 2/2] riscv: define CREATE_TRACE_POINTS in ptrace.c
Date:   Mon, 10 Dec 2018 21:43:55 +0100
Message-Id: <20181210204355.3483-3-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210204355.3483-1-david.abdurachmanov@gmail.com>
References: <20181210204355.3483-1-david.abdurachmanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define CREATE_TRACE_POINTS in order to create functions and structures
for the trace events. This is needed if HAVE_SYSCALL_TRACEPOINTS and
CONFIG_FTRACE_SYSCALLS are enabled, otherwise we get linking errors:

[..]
  MODPOST vmlinux.o
kernel/trace/trace_syscalls.o: In function `.L0 ':
trace_syscalls.c:(.text+0x1152): undefined reference to `__tracepoint_sys_enter'
trace_syscalls.c:(.text+0x126c): undefined reference to `__tracepoint_sys_enter'
trace_syscalls.c:(.text+0x1328): undefined reference to `__tracepoint_sys_enter'
trace_syscalls.c:(.text+0x14aa): undefined reference to `__tracepoint_sys_enter'
trace_syscalls.c:(.text+0x1684): undefined reference to `__tracepoint_sys_exit'
trace_syscalls.c:(.text+0x17a0): undefined reference to `__tracepoint_sys_exit'
trace_syscalls.c:(.text+0x185c): undefined reference to `__tracepoint_sys_exit'
trace_syscalls.c:(.text+0x19de): undefined reference to `__tracepoint_sys_exit'
arch/riscv/kernel/ptrace.o: In function `.L0 ':
ptrace.c:(.text+0x4dc): undefined reference to `__tracepoint_sys_enter'
ptrace.c:(.text+0x632): undefined reference to `__tracepoint_sys_exit'
make: *** [Makefile:1036: vmlinux] Error 1

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Fixes: b78002b395b4 ("riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig")
---
 arch/riscv/kernel/ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 60f1e02eed36..32a374a1b31a 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -24,6 +24,8 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/tracehook.h>
+
+#define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
 enum riscv_regset {
-- 
2.19.2

