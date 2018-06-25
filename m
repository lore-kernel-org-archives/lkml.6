Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16592C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B791322432
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Drt2PMwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B791322432
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934678AbeFYWoQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:44:16 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:33419 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755570AbeFYWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:06 -0400
Received: by mail-qt0-f201.google.com with SMTP id o68-v6so14545377qte.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3sO3Q0vr9WbfC6HW1jNT+fUgdjvmwWTyo2KWl50eZ0U=;
        b=Drt2PMwXDWzZjPXqxbzC1JyyBsLcTXiVt5iWjNbAonuIG29fnjMioTgbjbjgoPjROQ
         jFU4xt0ont+NjCvhft2kreTjGemKGR8FIjDRkRNqNPy8JSCLEDxGzfGJK0yQa6VH+w4s
         pUU+Lb7LKLlGx96ogsf7R/PAfNU6zIG1IUP8+0DPyytFWlyp/P6zevL4hwbfJwGdq9n/
         a4ddhGMqT+TB5K6m/zZFnljfU3oKNuNeMbPmg1rEc4xbZoEWJTzbtpz5WrjFSZVPp61C
         KxowY7LiEIuTf02ZysGS9Lb02HAoI3M32EzsiqlbOYwIMxUj/2zLUpNSEuJaFgTYOySv
         rXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3sO3Q0vr9WbfC6HW1jNT+fUgdjvmwWTyo2KWl50eZ0U=;
        b=ZavlFsgkGjBmhoTeEoaWJGLHr/daQoWssfsk4S9fcPciGngMG8IsqAnocDfWK8E1wJ
         Bpc+9ntpG7a0kPwpeug4ioPj1vEYseo47zJNZ2ZbviuxhiBUoMgQdaXgLnm1qraIUwBc
         Ol6QbXigSrj59NsWT0NsvfIzt2vw7koQLwogGgS5xRRek5auO8wMKc9cgKtFeu4x/SPi
         idaKOK/PJGKu4kOUqrsnvDMsljHGK1kMSgHB9+WF8gbu9PCVz02yLVEQsU0A3kkXwkgk
         jn+JeMSHsBpo16B86g9dI/7yRlGSTl86rb/1zaU1J3aGK9/lf7q8w/E6+BqP89zpwd70
         M6Sg==
X-Gm-Message-State: APt69E0FoMt23B4MqHTQ+kgKnKmr33qFPxbC8b2uhMhvfci6KIy2UIz0
        jweYnHyckbMUxIBBdMKvByb4lAOBNeP5jg==
X-Google-Smtp-Source: ADUXVKInhT/3s9jKv8pd8LikYjtOUNIFDTJI1nTeXRVH64jgbER4G1M6Ewxsn4+YD0QHiaXv7MRWmuRvlS/a1A==
MIME-Version: 1.0
X-Received: by 2002:ac8:29b7:: with SMTP id 52-v6mr3203880qts.6.1529966525900;
 Mon, 25 Jun 2018 15:42:05 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:06 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-19-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 18/27] xen: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use the new _ASM_MOVABS macro which get a
symbol reference while being PIE compatible. Adapt the relocation tool
to ignore 32-bit Xen code.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/tools/relocs.c | 16 +++++++++++++++-
 arch/x86/xen/xen-head.S | 11 ++++++-----
 arch/x86/xen/xen-pvh.S  | 14 ++++++++++----
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index a35cc337f883..29283ad3950f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -832,6 +832,16 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 		strncmp(symname, "init_per_cpu_", 13);
 }
 
+/*
+ * Check if the 32-bit relocation is within the xenpvh 32-bit code.
+ * If so, ignores it.
+ */
+static int is_in_xenpvh_assembly(ElfW(Addr) offset)
+{
+	ElfW(Sym) *sym = sym_lookup("pvh_start_xen");
+	return sym && (offset >= sym->st_value) &&
+		(offset < (sym->st_value + sym->st_size));
+}
 
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
@@ -895,8 +905,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		 * the relocations are processed.
 		 * Make sure that the offset will fit.
 		 */
-		if (r_type != R_X86_64_64 && (int32_t)offset != (int64_t)offset)
+		if (r_type != R_X86_64_64 &&
+		    (int32_t)offset != (int64_t)offset) {
+			if (is_in_xenpvh_assembly(offset))
+				break;
 			die("Relocation offset doesn't fit in 32 bits\n");
+		}
 
 		if (r_type == R_X86_64_64)
 			add_reloc(&relocs64, offset);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 5077ead5e59c..4418ff0a1d96 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -28,14 +28,15 @@ ENTRY(startup_xen)
 
 	/* Clear .bss */
 	xor %eax,%eax
-	mov $__bss_start, %_ASM_DI
-	mov $__bss_stop, %_ASM_CX
+	_ASM_MOVABS $__bss_start, %_ASM_DI
+	_ASM_MOVABS $__bss_stop, %_ASM_CX
 	sub %_ASM_DI, %_ASM_CX
 	shr $__ASM_SEL(2, 3), %_ASM_CX
 	rep __ASM_SIZE(stos)
 
-	mov %_ASM_SI, xen_start_info
-	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
+	_ASM_MOVABS $xen_start_info, %_ASM_AX
+	_ASM_MOV %_ASM_SI, (%_ASM_AX)
+	_ASM_MOVABS $init_thread_union+THREAD_SIZE, %_ASM_SP
 
 #ifdef CONFIG_X86_64
 	/* Set up %gs.
@@ -46,7 +47,7 @@ ENTRY(startup_xen)
 	 * init data section till per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	movabsq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
 	cdq
 	wrmsr
 #endif
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index ca2d3b2bf2af..4b83f861b655 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -114,8 +114,8 @@ ENTRY(pvh_start_xen)
 	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
-	mov $_pa(pvh_bootparams), %rsi
-	mov $_pa(startup_64), %rax
+	movabs $_pa(pvh_bootparams), %rsi
+	movabs $_pa(startup_64), %rax
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
@@ -161,10 +161,16 @@ END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
+	/*
+	 * Use an ASM_PTR (quad on x64) for _pa(gdt_start) because PIE requires
+	 * a pointer size storage value before applying the relocation. On
+	 * 32-bit _ASM_PTR will be a long which is aligned the space needed for
+	 * relocation.
+	 */
 gdt:
 	.word gdt_end - gdt_start
-	.long _pa(gdt_start)
-	.word 0
+	_ASM_PTR _pa(gdt_start)
+	.balign 8
 gdt_start:
 	.quad 0x0000000000000000            /* NULL descriptor */
 #ifdef CONFIG_X86_64
-- 
2.18.0.rc2.346.g013aa6912e-goog

