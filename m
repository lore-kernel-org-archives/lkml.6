Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBF9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D20D21479
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF1iGwxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbeL1PiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:38:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40684 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbeL1PiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:38:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so21221352wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQ5DundM5mKyJSywQDNbpiGYqXBfM218ZySSb/64ceQ=;
        b=JF1iGwxWslVZKyYQT+YpI1icne4n5O3VmEmqvzX9eFGyFUHmAdpyv1EtPIlUoU0Ysz
         U0AiOjhg6OHEPmy8f441wAJD3eti01HfUaTCTaJhO0d1SxOCpngh3gskjhpnYH+afZGg
         AErYNZ9npZAzBkk/fppshty07I8jPHNYy9KdH3xG1xDdT0wOQlNa/qKhYAVUiStiqugs
         9XMOc4iRMlEFtFRCzM0NmEIUeE7TDcu0TzD5XBYYS5pxF8BPthT+TvCVzkNnFqzQDDgG
         ItXL8j+yORbZxO5/R15rDZujB0hGBS0IC1N54LC41w9C2xxP3qvkBlUeUvCBviCul5vk
         Ejkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQ5DundM5mKyJSywQDNbpiGYqXBfM218ZySSb/64ceQ=;
        b=gJ0Vq7zKF/THiH5EtZ+lwwZZ5vH0apzHxaxEp6+jgnKgpu0t+YY+84dlWmGzSb3lNQ
         gxXxYIlWkLzy816eO88gZx/tX6Qn/FsWSTY851XgfZo5/xJMRCqIh5ui6udet9OopzEv
         KaSXe009bXxIxp27MxGA3bI2fA+D2IIMpyz6Q/tw/iiudJoYwWcM2YejxwuQnhG708rg
         kckF/FkUuS0f1hHtuMlv+RvINK8p34hF2fqJifMO6LQXcalAJjjb4BySw+vHtmV4NCMt
         erFv2VA/3Qm23Q6Dw3NVL3DuRSBLioKLw1Wr9m+mGdYr6C20KKq6hqe+idzTBLoaEUwE
         rD1w==
X-Gm-Message-State: AJcUukfxPn4j4Dt4wupSIUPUxQ1MBX8wHIsWMVEkVv16Hit95qf0mkld
        D/jeOU2qgJWRmi/sV5w066T46HZP
X-Google-Smtp-Source: ALg8bN6mWF7KzA9VytEFr9MNlyjS8NRI9Vv36Eh5i6sd2/BeFEDKKn6yN9x29VL8C/MqR6GV/KGOlA==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr25263961wrq.38.1546011493956;
        Fri, 28 Dec 2018 07:38:13 -0800 (PST)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id v12sm18667215wmd.27.2018.12.28.07.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 07:38:13 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org
Subject: [PATCH] x86/asm: Use CC_SET/CC_OUT in percpu_cmpxchg16b_double
Date:   Fri, 28 Dec 2018 16:37:59 +0100
Message-Id: <20181228153759.3132-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CC_SET(z)/CC_OUT(z) instead of explicit setz instruction.
Using these two defines, the compiler that supports generation of
condition code outputs from inline assembly flags generates one
conditional jump instruction, e.g:

	[lea    (%rdi),%rsi
	 callq  this_cpu_cmpxchg16b_emu]
	-- or --
	[cmpxchg16b %gs:(%rdi)]
	jne    199764 <kmem_cache_alloc+0x44>

instead of

	[lea    (%rdi),%rsi
	 callq  this_cpu_cmpxchg16b_emu]
	-- or --
	[cmpxchg16b %gs:(%rdi)]
	sete   %cl
	test   %cl,%cl
	je     19ae04 <kmem_cache_alloc+0x44>

The complication with percpu_cmpxchg16b_double is, that the definition
defaults to the call to this_cpu_cmpxchg16b_emu library function, which
(depending on X86_FEATURE_CX16 flag) is later patched with real cmpxchg16b
instruction. To solve this complication, the patch changes
this_cpu_cmpxchg16b_emu library function to return the result in ZF flag of
%rflags register, instead of %al register.  Please also note that instead
of popf instruction (which restores flags register to a previously saved state),
the patched function uses sti, but followed by a nop, which ends the
inhibition of interrupts early.

The patch also introduces alternative_io_tail definition. This definition
can take a tail instruction, common to all alternatives. By using this
definition, it is possible to remove setz from cmpxchg16b alternatives, saved
in .altinstr_replacement section, thus saving a few bytes from the binary.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/alternative.h |  6 ++++++
 arch/x86/include/asm/percpu.h      | 14 ++++++++------
 arch/x86/lib/cmpxchg16b_emu.S      | 16 ++++++----------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 0660e14690c8..49b29990950a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -205,6 +205,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
 		: output : "i" (0), ## input)
 
+/* Like alternative_io, but with a common tail instruction. */
+#define alternative_io_tail(oldinstr, newinstr, feature, tail,		\
+			    output, input...)				\
+	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature) tail	\
+		: output : "i" (0), ## input)
+
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
 	asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 1a19d11cfbbd..9cf2e78eb4b3 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -495,12 +495,14 @@ do {									\
 	bool __ret;							\
 	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	alternative_io("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \
-		       "cmpxchg16b " __percpu_arg(1) "\n\tsetz %0\n\t",	\
-		       X86_FEATURE_CX16,				\
-		       ASM_OUTPUT2("=a" (__ret), "+m" (pcp1),		\
-				   "+m" (pcp2), "+d" (__o2)),		\
-		       "b" (__n1), "c" (__n2), "a" (__o1) : "rsi");	\
+	alternative_io_tail("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu", \
+			    "cmpxchg16b "__percpu_arg(1),		\
+			    X86_FEATURE_CX16,				\
+			    CC_SET(z),					\
+			    ASM_OUTPUT2(CC_OUT(z) (__ret),		\
+					"+m" (pcp1), "+m" (pcp2),	\
+					"+a" (__o1), "+d" (__o2)),	\
+			    "b" (__n1), "c" (__n2) : "rsi");		\
 	__ret;								\
 })
 
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 9b330242e740..d8c1ae48e0d9 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -17,20 +17,20 @@
  * %rdx : high 64 bits of old value
  * %rbx : low 64 bits of new value
  * %rcx : high 64 bits of new value
- * %al  : Operation successful
+ *
+ * Outputs:
+ * %rflags.zf: set if the destination operand and %rdx:%rax are equal
  */
 ENTRY(this_cpu_cmpxchg16b_emu)
 
 #
-# Emulate 'cmpxchg16b %gs:(%rsi)' except we return the result in %al not
-# via the ZF.  Caller will access %al to get result.
+# Emulate 'cmpxchg16b %gs:(%rsi)'
 #
 # Note that this is only useful for a cpuops operation.  Meaning that we
 # do *not* have a fully atomic operation but just an operation that is
 # *atomic* on a single cpu (as provided by the this_cpu_xx class of
 # macros).
 #
-	pushfq
 	cli
 
 	cmpq PER_CPU_VAR((%rsi)), %rax
@@ -41,13 +41,9 @@ ENTRY(this_cpu_cmpxchg16b_emu)
 	movq %rbx, PER_CPU_VAR((%rsi))
 	movq %rcx, PER_CPU_VAR(8(%rsi))
 
-	popfq
-	mov $1, %al
-	ret
-
 .Lnot_same:
-	popfq
-	xor %al,%al
+	sti
+	nop
 	ret
 
 ENDPROC(this_cpu_cmpxchg16b_emu)
-- 
2.20.1

