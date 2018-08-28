Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7DA2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjVRWclH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7DA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeH1Tlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:41:36 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:53258 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1Tlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:41:36 -0400
Received: by mail-vk0-f73.google.com with SMTP id x78-v6so769827vkd.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pQpuRBI7lWGLzA9kbZ11EVfx3PQyCUi87W3GW9OvBpc=;
        b=mjVRWclH5ERNY2tAZJSyo5bHeaRvuFHxz/kd1pNrMLx9mnrBxovQVkAGMPWlPEXkyd
         9CnsVF1t3VdrXh9yaj0E7/F4hNuIvIhweDAWoQ7CGPvn1A44w5q1mclIH9fPdxeQI273
         DVCrfA2HRJeANMvduhj9JetCrGhtmjHOWKdMz0VWwBu4L2wHMQzEp+LcjeAWg4l31tC9
         nbs5vjFFGW0nY+e/jjDAjBB/SYq2wZtW/NhMu/X1jBZfId8FkxSNFspsGedNoQfD3CPl
         UcxaOm8KvsGgfyyKaXh3hbAm8Pv/GVl1NbpNv/38VkvhMFzAAt/KALh+qDgGJ8B5G91V
         4xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pQpuRBI7lWGLzA9kbZ11EVfx3PQyCUi87W3GW9OvBpc=;
        b=AqkHurevaa4JD0IH88pZ0EInfs/kLGlfMaO4J4+l+sFtet8RA07GGe9oJQVHaEPf3l
         ArFqeqv6eXvrvi451YBnb7cctxygplRta1Dpl3gFsoxR8gIv/xxnBNzjqwtzhMXJUygR
         XuILDt/qith2s7mJJMY498VHpR+4nyAEOnQ0tYA2UC28Arkxgfc1q8sT1sSz9lHlxUg5
         FGpOzWJx6JG2D4seyvQN5ntfEmf7amf2YPKM5eZ0d48n6JG1X0+u14tnOA3ArMyPfsfh
         huS7GCLNklZp+5G3PmbvrD6nz/CYe9XeWui2h0LtNDwO9fIg4dcXasMgRMMgUM7EonHX
         k+vg==
X-Gm-Message-State: APzg51AFh9FBBhRqgmXNexFqFfpmrumPekBDVEJSVbyyr7xgyHWddcRl
        N400svUj3udlOe3ddtIIZ1kCcFhlQw==
X-Google-Smtp-Source: ANB0VdZgIbfm+H8unFv4S/AX3JLnhr5OXZPXIh9N/JSyds6NujeiA9Gz+RkR3iLKX5pfQ7x3/saJ0v5xiw==
X-Received: by 2002:ab0:61d6:: with SMTP id m22-v6mr979619uan.114.1535471359636;
 Tue, 28 Aug 2018 08:49:19 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:49:01 +0200
Message-Id: <20180828154901.112726-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2] x86/dumpstack: don't dump kernel memory based on usermode RIP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, jannh@google.com
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_opcodes() is used both for dumping kernel instructions and for dumping
user instructions. If userspace causes #PF by jumping to a kernel address,
show_opcodes() can be reached with regs->ip controlled by the user,
pointing to kernel code. Make sure that userspace can't trick us into
dumping kernel memory into dmesg.

Cc: stable@vger.kernel.org
Fixes: 7cccf0725cf7 ("x86/dumpstack: Add a show_ip() function")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
v2: Andy pointed out that I probably shouldn't be doing wrapping
arithmetic on pointers.

 arch/x86/include/asm/stacktrace.h |  2 +-
 arch/x86/kernel/dumpstack.c       | 13 ++++++++++---
 arch/x86/mm/fault.c               |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index b6dc698f992a..f335aad404a4 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
 	return (unsigned long)frame;
 }
 
-void show_opcodes(u8 *rip, const char *loglvl);
+void show_opcodes(struct pt_regs *regs, const char *loglvl);
 void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9c8652974f8e..14b337582b6f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -89,14 +89,21 @@ static void printk_stack_address(unsigned long address, int reliable,
  * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
  * guesstimate in attempt to achieve all of the above.
  */
-void show_opcodes(u8 *rip, const char *loglvl)
+void show_opcodes(struct pt_regs *regs, const char *loglvl)
 {
 #define PROLOGUE_SIZE 42
 #define EPILOGUE_SIZE 21
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
+	u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
+	/*
+	 * Make sure userspace isn't trying to trick us into dumping kernel
+	 * memory by pointing the userspace instruction pointer at it.
+	 */
+	bool bad_ip = user_mode(regs) &&
+		      __range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
 
-	if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE)) {
+	if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
@@ -112,7 +119,7 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
 #else
 	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
 #endif
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 void show_iret_regs(struct pt_regs *regs)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..47bebfe6efa7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -837,7 +837,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 
 	printk(KERN_CONT "\n");
 
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 static void
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

