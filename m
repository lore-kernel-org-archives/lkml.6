Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54AFC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC85205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsFW+f1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC85205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbeG3TgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:36:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32896 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3TgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:36:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so8968818wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=duT2/RNQLVJAEyBlseVnxbcovHLJrHb/hZ0wqCrMIBg=;
        b=tsFW+f1fEPvJdYeXTPGEvq+FJXItC/EfOlCmhOLeCk3JMk/6NAcJClizI7dK/go3NC
         S3+9ViZNp6hcFCrOUaXuT1eDJLmhjtzDym8uedXXi/D8DC41wQfdRA69reZZvE6CI+7/
         VTRKDxo+DxbcrhLCy80sPDnBeskkaiWPu5oJJ+gPGcHk4QhbQFPUmtLB/Klkyad85hlw
         2dbf7Jf//xasI0wXhgPseoArgVUq+S5TmXY2iachCXTyYdxpR3nJXqStOcgAw+CnhR9b
         qmDuu5cnZ4OlY7KeuyDL9Th8/T56GvTtxtpICPJmGvapLlOzKpMwE17WiyptKEhHziGT
         9xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=duT2/RNQLVJAEyBlseVnxbcovHLJrHb/hZ0wqCrMIBg=;
        b=HgtvDr1aYikoQSAkTmceBE4BCdaj/eYGclcILhJWZ2RjtC8SIQPldLoXhsDqEwA+/4
         2/+Q5tC0PLq2RR6XwWJyJ1M1RKHQCXGjFpvP15KZwQYXiXzf67KlES6n0BgVNQW/eltH
         M0sMeG6icE+NGH9Ko8/CzogSnXirlr39xk7Uvyo4niA6vzEi58SISkgUM7HHvG0xNIrW
         81uXTkVbkl/EDBeUOR7MNS92X1//OYfsgahI0+vrm+P7QVxCaqhwAFO1YhT9ftCQeNDi
         sYUIiMiq8b8ycPZwcj/4sJSXU6NJxcQQetR5isKzxtJeMduIgmA/Ox1aStpVmf4Ag1Sz
         BVtQ==
X-Gm-Message-State: AOUpUlF33rAJ0FFkvClK6yW72QXeqZpyHX87jhPl/RBsFwTWy8X4cVr1
        loUSKYexnjVKOnXQTlMdh+M=
X-Google-Smtp-Source: AAOMgpevWNgzpx8HIjZsxNYnHJonzlJIoXQpZSBxxKsDMx4Kg8JcfDRr9YK3jwTEOGkDKwiOGk5+XQ==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr195945wml.45.1532973598686;
        Mon, 30 Jul 2018 10:59:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l11-v6sm15844817wru.25.2018.07.30.10.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:59:58 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:59:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20180730175956.GA3245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 92a4728608a8fd228c572bc8ff50dd98aa0ddf2a x86/boot: Fix if_changed build flip/flop bug

Misc fixes:

 - a build race fix
 - a Xen entry fix
 - a TSC_DEADLINE quirk future-proofing fix
 
 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit

Kees Cook (1):
      x86/boot: Fix if_changed build flip/flop bug

Len Brown (1):
      x86/apic: Future-proof the TSC_DEADLINE quirk for SKX


 arch/x86/boot/compressed/Makefile |  8 ++++++--
 arch/x86/entry/entry_64.S         | 18 ++++--------------
 arch/x86/kernel/apic/apic.c       |  3 +++
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..169c2feda14a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,9 +106,13 @@ define cmd_check_data_rel
 	done
 endef
 
+# We need to run two commands under "if_changed", so merge them into a
+# single invocation.
+quiet_cmd_check-and-link-vmlinux = LD      $@
+      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
+
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
-	$(call if_changed,check_data_rel)
-	$(call if_changed,ld)
+	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 73a522d53b53..8ae7ffda8f98 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -981,7 +981,7 @@ ENTRY(\sym)
 
 	call	\do_sym
 
-	jmp	error_exit			/* %ebx: no swapgs flag */
+	jmp	error_exit
 	.endif
 END(\sym)
 .endm
@@ -1222,7 +1222,6 @@ END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch GS if needed.
- * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
@@ -1269,7 +1268,6 @@ ENTRY(error_entry)
 	 * for these here too.
 	 */
 .Lerror_kernelspace:
-	incl	%ebx
 	leaq	native_irq_return_iret(%rip), %rcx
 	cmpq	%rcx, RIP+8(%rsp)
 	je	.Lerror_bad_iret
@@ -1303,28 +1301,20 @@ ENTRY(error_entry)
 
 	/*
 	 * Pretend that the exception came from user mode: set up pt_regs
-	 * as if we faulted immediately after IRET and clear EBX so that
-	 * error_exit knows that we will be returning to user mode.
+	 * as if we faulted immediately after IRET.
 	 */
 	mov	%rsp, %rdi
 	call	fixup_bad_iret
 	mov	%rax, %rsp
-	decl	%ebx
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 END(error_entry)
 
-
-/*
- * On entry, EBX is a "return to kernel mode" flag:
- *   1: already in kernel mode, don't need SWAPGS
- *   0: user gsbase is loaded, we need SWAPGS and standard preparation for return to usermode
- */
 ENTRY(error_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
-	testl	%ebx, %ebx
-	jnz	retint_kernel
+	testb	$3, CS(%rsp)
+	jz	retint_kernel
 	jmp	retint_user
 END(error_exit)
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 2aabd4cb0e3f..adbda5847b14 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -573,6 +573,9 @@ static u32 skx_deadline_rev(void)
 	case 0x04: return 0x02000014;
 	}
 
+	if (boot_cpu_data.x86_stepping > 4)
+		return 0;
+
 	return ~0U;
 }
 
