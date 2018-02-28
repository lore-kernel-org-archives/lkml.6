Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834783-2-9518016094958427733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834783; b=Hzkqoi/b5squFghMwrNduSSLEie8dJt107y+9gXlyihoOKe
    SdS0lsEmzkvl4j0bXt/Kq5TOLejKC0Nqvpc9UlS7M1O7EcCKF07m/afmhQYgR8dd
    7nhhfzblcapOzTA+FG+FYyLeCBzSXBoBFwg6x/6XUy/NclOMmdRGa+fWXlCFghhK
    lxXyVEdtyVcd7mcIpHYdRWGlEseW+N1flIfKCXXfifYx4356c/7N3NnFXV1OVQ41
    t3adDd9zn8t5IgSQA9oy42K6Qbwa3ItB5ppcpr7Wqhi+nB9ZVn7DOhC0s7Yvi8yF
    jX9z7fkydeR4yUcxOGyurF99Jd3IcrPe98nOXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834783; bh=AaKsQYghqme0XbO8NVE
    tugYjVsTmWhJGPngte/YLbEw=; b=iOo7otbQKdQoH15h6nhibtm/s5XNNHiWZ+q
    EQH6TM16WLR66aXM/981ehn+DUzRJf+Gi1Uet8EyMM4B2wHXHj0Sa4LehF/ApFjR
    ZsfWgc6XlOgONeSKYXe9h7hMv1CLL4MgsD271NU+b2NkEniprKRxObjMjtIDpkmk
    Jy49/gfqymoJJZ65O2ArQ6x6FPzZktF42M/9erzMx/vevpLTQVDQ/WjPxr0BatEz
    j3LrdVJs9H3IS3DjkDBW88y0Brq6z4Mb5/sMNYxp/OR2P2ECuFMSYOYbolTIZg5T
    UBNSJZaOymbtpA478oXz4X61mo3E3nEaNwF0UFWxvXsi1xmvZ8Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935014AbeB1QRp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:17:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35267 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934903AbeB1QRn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:17:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Martin" <Dave.Martin@arm.com>,
        "Paul Burton" <Paul.Burton@mips.com>,
        "Alex Smith" <alex@alex-smith.me.uk>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "James Hogan" <james.hogan@mips.com>, linux-mips@linux-mips.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.658464417@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 107/254] MIPS: Factor out NT_PRFPREG regset access
 helpers
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@mips.com>

commit a03fe72572c12e98f4173f8a535f32468e48b6ec upstream.

In preparation to fix a commit 72b22bbad1e7 ("MIPS: Don't assume 64-bit
FP registers for FP regset") FCSR access regression factor out
NT_PRFPREG regset access helpers for the non-MSA and the MSA variants
respectively, to avoid having to deal with excessive indentation in the
actual fix.

No functional change, however use `target->thread.fpu.fpr[0]' rather
than `target->thread.fpu.fpr[i]' for FGR holding type size determination
as there's no `i' variable to refer to anymore, and for the factored out
`i' variable declaration use `unsigned int' rather than `unsigned' as
its type, following the common style.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17925/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 108 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 25 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -438,25 +438,36 @@ static int gpr64_set(struct task_struct
 
 #endif /* CONFIG_64BIT */
 
-static int fpr_get(struct task_struct *target,
-		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+/*
+ * Copy the floating-point context to the supplied NT_PRFPREG buffer,
+ * !CONFIG_CPU_HAS_MSA variant.  FP context's general register slots
+ * correspond 1:1 to buffer slots.
+ */
+static int fpr_get_fpa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       void **kbuf, void __user **ubuf)
 {
-	unsigned i;
-	int err;
-	u64 fpr_val;
-
-	/* XXX fcr31  */
+	return user_regset_copyout(pos, count, kbuf, ubuf,
+				   &target->thread.fpu,
+				   0, sizeof(elf_fpregset_t));
+}
 
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					   &target->thread.fpu,
-					   0, sizeof(elf_fpregset_t));
+/*
+ * Copy the floating-point context to the supplied NT_PRFPREG buffer,
+ * CONFIG_CPU_HAS_MSA variant.  Only lower 64 bits of FP context's
+ * general register slots are copied to buffer slots.
+ */
+static int fpr_get_msa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       void **kbuf, void __user **ubuf)
+{
+	unsigned int i;
+	u64 fpr_val;
+	int err;
 
 	for (i = 0; i < NUM_FPU_REGS; i++) {
 		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
-		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+		err = user_regset_copyout(pos, count, kbuf, ubuf,
 					  &fpr_val, i * sizeof(elf_fpreg_t),
 					  (i + 1) * sizeof(elf_fpreg_t));
 		if (err)
@@ -466,27 +477,54 @@ static int fpr_get(struct task_struct *t
 	return 0;
 }
 
-static int fpr_set(struct task_struct *target,
+/* Copy the floating-point context to the supplied NT_PRFPREG buffer.  */
+static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
+		   void *kbuf, void __user *ubuf)
 {
-	unsigned i;
 	int err;
-	u64 fpr_val;
 
 	/* XXX fcr31  */
 
-	init_fp_ctx(target);
+	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
+		err = fpr_get_fpa(target, &pos, &count, &kbuf, &ubuf);
+	else
+		err = fpr_get_msa(target, &pos, &count, &kbuf, &ubuf);
+
+	return err;
+}
 
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fpu,
-					  0, sizeof(elf_fpregset_t));
+/*
+ * Copy the supplied NT_PRFPREG buffer to the floating-point context,
+ * !CONFIG_CPU_HAS_MSA variant.   Buffer slots correspond 1:1 to FP
+ * context's general register slots.
+ */
+static int fpr_set_fpa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       const void **kbuf, const void __user **ubuf)
+{
+	return user_regset_copyin(pos, count, kbuf, ubuf,
+				  &target->thread.fpu,
+				  0, sizeof(elf_fpregset_t));
+}
+
+/*
+ * Copy the supplied NT_PRFPREG buffer to the floating-point context,
+ * CONFIG_CPU_HAS_MSA variant.  Buffer slots are copied to lower 64
+ * bits only of FP context's general register slots.
+ */
+static int fpr_set_msa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       const void **kbuf, const void __user **ubuf)
+{
+	unsigned int i;
+	u64 fpr_val;
+	int err;
 
 	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
-	for (i = 0; i < NUM_FPU_REGS && count >= sizeof(elf_fpreg_t); i++) {
-		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+	for (i = 0; i < NUM_FPU_REGS && *count >= sizeof(elf_fpreg_t); i++) {
+		err = user_regset_copyin(pos, count, kbuf, ubuf,
 					 &fpr_val, i * sizeof(elf_fpreg_t),
 					 (i + 1) * sizeof(elf_fpreg_t));
 		if (err)
@@ -497,6 +535,26 @@ static int fpr_set(struct task_struct *t
 	return 0;
 }
 
+/* Copy the supplied NT_PRFPREG buffer to the floating-point context.  */
+static int fpr_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int err;
+
+	/* XXX fcr31  */
+
+	init_fp_ctx(target);
+
+	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
+		err = fpr_set_fpa(target, &pos, &count, &kbuf, &ubuf);
+	else
+		err = fpr_set_msa(target, &pos, &count, &kbuf, &ubuf);
+
+	return err;
+}
+
 enum mips_regset {
 	REGSET_GPR,
 	REGSET_FPR,
