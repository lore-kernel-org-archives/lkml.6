Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387526-1519633808-2-12863372607524765538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633807; b=WorH+arsJLGN/mPrCp8H8HUQojoRXG71YGzfFd7Qhiof9aD
    ViOIPDlv5fNtI3W6tCa+doSFgIJyW8j8czeNM9OOWD3jtf/IQPgzv62mbQRAlBn4
    aNtp7dJPZsnFzy1KskvY0nj5+s1sVT29MRyngyuhlM1EzsMzNAcw07RA5dnolNK8
    hVkK6ZKH/A05uAgEh5Qkp+tiNEvXhSuYx8mHOJRBzX3GXTNPW3kEmKO82XwQ6Mcq
    B8dS9QTRJsn/+X0TsL6vUlpphOJ3wmNJXWiD/JWKWYsRPexdrfr1nIBADWc99X94
    mJq8xtKbkHcXJKLlfftBD6rCbOOu+tN3r9hVL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633807;
    bh=Jk3msMDfhwzjnG4JcoVxRkkc9wQeB0h3mvpSGrDHyMI=; b=DxXdUjCaKWij
    8Qto7rc1eZc2tUvOudauqWHQOwZak1mNyRGTYECYk5ORIYcfkAY6Pmz8cMoU9HfI
    11JS6WLGzhGqBotCMWbN922cwsMtN3av4XVlQCOjIo84953FHjCEugakOoASCEzV
    NF7xy8vzHSH8CtQ0vp8k2QOaQ0znmk1FF7mvgCIuwOkhQ6rkUtoDeM8GTUcQx/iD
    MwnNMq1kkd93Dp25nGTNxvhgaGWTLMHbYXqcGKyTIuqxA+h5lrVhuFHX3gCEnv9k
    9qm6oOHtK6FO3VSyM0OJBwBs5FhL+Pi4bpvTUsD/UqIcDVjd+KCKhEukhDvPLlCo
    TcNI6Fw13A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K2VXzaPB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KPpBNna7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K2VXzaPB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KPpBNna7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeBZI0q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:26:46 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41338 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeBZI0n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:26:43 -0500
X-Google-Smtp-Source: AH8x226bxZNoM/ytam9tDrZl8ExbuiKsiy2AWA2KHlYB2xVTNvlWCJQO6xQtBXvLmhfcj63QdRaAtg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 43/52] arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
Date: Mon, 26 Feb 2018 16:20:17 +0800
Message-Id: <1519633227-29832-44-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit f2d3b2e8759a upstream.

One of the major improvement of SMCCC v1.1 is that it only clobbers
the first 4 registers, both on 32 and 64bit. This means that it
becomes very easy to provide an inline version of the SMC call
primitive, and avoid performing a function call to stash the
registers that would otherwise be clobbered by SMCCC v1.0.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 include/linux/arm-smccc.h | 141 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index dd44d84..a031897 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -150,5 +150,146 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 #define arm_smccc_hvc_quirk(...) __arm_smccc_hvc(__VA_ARGS__)
 
+/* SMCCC v1.1 implementation madness follows */
+#ifdef CONFIG_ARM64
+
+#define SMCCC_SMC_INST	"smc	#0"
+#define SMCCC_HVC_INST	"hvc	#0"
+
+#elif defined(CONFIG_ARM)
+#include <asm/opcodes-sec.h>
+#include <asm/opcodes-virt.h>
+
+#define SMCCC_SMC_INST	__SMC(0)
+#define SMCCC_HVC_INST	__HVC(0)
+
+#endif
+
+#define ___count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
+
+#define __count_args(...)						\
+	___count_args(__VA_ARGS__, 7, 6, 5, 4, 3, 2, 1, 0)
+
+#define __constraint_write_0						\
+	"+r" (r0), "=&r" (r1), "=&r" (r2), "=&r" (r3)
+#define __constraint_write_1						\
+	"+r" (r0), "+r" (r1), "=&r" (r2), "=&r" (r3)
+#define __constraint_write_2						\
+	"+r" (r0), "+r" (r1), "+r" (r2), "=&r" (r3)
+#define __constraint_write_3						\
+	"+r" (r0), "+r" (r1), "+r" (r2), "+r" (r3)
+#define __constraint_write_4	__constraint_write_3
+#define __constraint_write_5	__constraint_write_4
+#define __constraint_write_6	__constraint_write_5
+#define __constraint_write_7	__constraint_write_6
+
+#define __constraint_read_0
+#define __constraint_read_1
+#define __constraint_read_2
+#define __constraint_read_3
+#define __constraint_read_4	"r" (r4)
+#define __constraint_read_5	__constraint_read_4, "r" (r5)
+#define __constraint_read_6	__constraint_read_5, "r" (r6)
+#define __constraint_read_7	__constraint_read_6, "r" (r7)
+
+#define __declare_arg_0(a0, res)					\
+	struct arm_smccc_res   *___res = res;				\
+	register u32           r0 asm("r0") = a0;			\
+	register unsigned long r1 asm("r1");				\
+	register unsigned long r2 asm("r2");				\
+	register unsigned long r3 asm("r3")
+
+#define __declare_arg_1(a0, a1, res)					\
+	struct arm_smccc_res   *___res = res;				\
+	register u32           r0 asm("r0") = a0;			\
+	register typeof(a1)    r1 asm("r1") = a1;			\
+	register unsigned long r2 asm("r2");				\
+	register unsigned long r3 asm("r3")
+
+#define __declare_arg_2(a0, a1, a2, res)				\
+	struct arm_smccc_res   *___res = res;				\
+	register u32           r0 asm("r0") = a0;			\
+	register typeof(a1)    r1 asm("r1") = a1;			\
+	register typeof(a2)    r2 asm("r2") = a2;			\
+	register unsigned long r3 asm("r3")
+
+#define __declare_arg_3(a0, a1, a2, a3, res)				\
+	struct arm_smccc_res   *___res = res;				\
+	register u32           r0 asm("r0") = a0;			\
+	register typeof(a1)    r1 asm("r1") = a1;			\
+	register typeof(a2)    r2 asm("r2") = a2;			\
+	register typeof(a3)    r3 asm("r3") = a3
+
+#define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
+	__declare_arg_3(a0, a1, a2, a3, res);				\
+	register typeof(a4) r4 asm("r4") = a4
+
+#define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
+	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
+	register typeof(a5) r5 asm("r5") = a5
+
+#define __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res)		\
+	__declare_arg_5(a0, a1, a2, a3, a4, a5, res);			\
+	register typeof(a6) r6 asm("r6") = a6
+
+#define __declare_arg_7(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
+	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
+	register typeof(a7) r7 asm("r7") = a7
+
+#define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
+#define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
+
+#define ___constraints(count)						\
+	: __constraint_write_ ## count					\
+	: __constraint_read_ ## count					\
+	: "memory"
+#define __constraints(count)	___constraints(count)
+
+/*
+ * We have an output list that is not necessarily used, and GCC feels
+ * entitled to optimise the whole sequence away. "volatile" is what
+ * makes it stick.
+ */
+#define __arm_smccc_1_1(inst, ...)					\
+	do {								\
+		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
+		asm volatile(inst "\n"					\
+			     __constraints(__count_args(__VA_ARGS__)));	\
+		if (___res)						\
+			*___res = (typeof(*___res)){r0, r1, r2, r3};	\
+	} while (0)
+
+/*
+ * arm_smccc_1_1_smc() - make an SMCCC v1.1 compliant SMC call
+ *
+ * This is a variadic macro taking one to eight source arguments, and
+ * an optional return structure.
+ *
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This macro is used to make SMC calls following SMC Calling Convention v1.1.
+ * The content of the supplied param are copied to registers 0 to 7 prior
+ * to the SMC instruction. The return values are updated with the content
+ * from register 0 to 3 on return from the SMC instruction if not NULL.
+ */
+#define arm_smccc_1_1_smc(...)	__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
+
+/*
+ * arm_smccc_1_1_hvc() - make an SMCCC v1.1 compliant HVC call
+ *
+ * This is a variadic macro taking one to eight source arguments, and
+ * an optional return structure.
+ *
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This macro is used to make HVC calls following SMC Calling Convention v1.1.
+ * The content of the supplied param are copied to registers 0 to 7 prior
+ * to the HVC instruction. The return values are updated with the content
+ * from register 0 to 3 on return from the HVC instruction if not NULL.
+ */
+#define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
2.7.4
