Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3334576-1526423745-5-6087012014569222719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526423744; b=Hf5R7DV501nvHQcH2uoO6ihNZ3VPny/2fFYbAQSTecAJYi1Q7/
    pneWzRmzlNagix89CqnSUeRvZ5mta9jBOW4v5m+Nuh3TzknWBm/FM2Jao4xaLqeF
    Axs7XUYKafgDLGMO6QfnyftwNHcThlQZoHICUvv/2mb9VBXsjewbzmIU1YYN8sgB
    7B/DXXlFxU4SS8lW/ONHtJMar4YFqsjxQ9OrYwKgzEv3eNDrPBHYMX1Fe0h62yHu
    nT6VZ2fw16q4XSth57T93Wld0YQVqckH9eLnaSBoElCA2XPE7ZcuvljOeH/mkGwJ
    AR5hxTu9Pb4ayXclf5mNWvxUf72HzaPmp4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1526423744; bh=uIZNBF3L6T+1yQUIxasWjqWO8sI7YklTStrJnTv
    Trv4=; b=TXTtCzvB0BRj10w97zja3QIdTwRTLbOplioykvL4CDy63xjweUiOeoa
    gjNtbw8Lop1OSTnGm4wfZ93z+nA6RJKavrQXvSDCX7XmPkW9frWR+4Tuxeas008a
    uMJa5HK6u4DWRxFjz0aroxULHDd/JpDnxksNKTAG+zutnRa6FsWmq09JYNd4CtR/
    4aP0sEFqJCeDW0EU/qXXWWckS/kqHzWSnqfihuj/LZ7nXP2Xtj1nmrBc2ED4aT4E
    yywfaYQ+04ys4gSSlr1ERiygN7tBD4ALlRrFC/k6/RJH8AwwrbWf9CQOAJUhwR34
    dm+nVD5x31xLR2OLxtOaKbYrUQfq89A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNCSh9ztaiqASM/DFDxBTW57lKezg+2CLkLBjdtsUYbKrspF0k8IMSyUdTvB/T25GMxYQ4474KCtM9VJjxAeJhtLtZCSU3BxETCuQye1RI7Amto0WGqv
    ljB1IcdD8UYQ1lsCoDNpyct/hwYEIt1ONk1UrQ9mU3fPLJb+0GoYVT38Ih0dTQ7NVni/BZIB4TbBjjaPs2Vl1r8BPAaxtEg5k5Ap4qqOCsWPTTffx5xhLAvd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=iAo7guES1noA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=vuRrZLs7kxTnujWRqnwA:9
    a=5Iq2M_pMoPDz6YKL:21 a=NeHuBDhihVrWhjzz:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeEOWfl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 18:35:41 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:33496 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeEOWfk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 18:35:40 -0400
Date: Tue, 15 May 2018 23:34:28 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: Add DSP ASE regset support
In-Reply-To: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1805102034040.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526423691-298555-22302-23778-2
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define an NT_MIPS_DSP core file note type and implement a corresponding 
regset holding the DSP ASE register context, following the layout of the 
`mips_dsp_state' structure, except for the DSPControl register stored as 
a 64-bit rather than 32-bit quantity in a 64-bit note.

The lack of DSP ASE register saving to core files can be considered a 
design flaw with commit e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP 
ASE."), leading to an incomplete state being saved.  Consequently no DSP 
ASE regset has been created with commit 7aeb753b5353 ("MIPS: Implement 
task_user_regset_view."), when regset support was added to the MIPS 
port.

Additionally there is no way for ptrace(2) to correctly access the DSP 
accumulator registers in n32 processes with the existing interfaces.  
This is due to 32-bit truncation of data passed with PTRACE_PEEKUSR and 
PTRACE_POKEUSR requests, which cannot be avoided owing to how the data 
types for ptrace(3) have been defined.  This new NT_MIPS_DSP regset 
fills the missing interface gap.

Cc: <stable@vger.kernel.org> # 3.13+
Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 This was verified with 32-bit DSP and non-DSP hardware configurations by 
dumping cores and examining, with `readelf', the notes created.  In the 
former case DSP registers were filled with patterns by the program being 
crashed and the patterns verified in the core file produced.  I have no 
64-bit DSP hardware handy, but the same code has been used, except for the 
data type holding register data, for both 32-bit and 64-bit notes, so it 
should be obviously correct.

 As noted in the commit description I consider it a design flaw and 
therefore I think it makes sense to backport this change and propose doing 
so.

  Maciej 
---
 arch/mips/kernel/ptrace.c |  189 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h  |    1 
 2 files changed, 190 insertions(+)

linux-mips-regset-dsp.diff
Index: linux-jhogan-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-jhogan-test.orig/arch/mips/kernel/ptrace.c	2018-05-09 23:26:36.787614000 +0100
+++ linux-jhogan-test/arch/mips/kernel/ptrace.c	2018-05-09 23:53:18.864657000 +0100
@@ -41,6 +41,7 @@
 #include <asm/mipsmtregs.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/processor.h>
 #include <asm/syscall.h>
 #include <linux/uaccess.h>
 #include <asm/bootinfo.h>
@@ -589,9 +590,179 @@ static int fpr_set(struct task_struct *t
 	return err;
 }
 
+#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
+
+/*
+ * Copy the DSP context to the supplied 32-bit NT_MIPS_DSP buffer.
+ */
+static int dsp32_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
+{
+	unsigned int start, num_regs, i;
+	u32 dspregs[NUM_DSP_REGS + 1];
+
+	BUG_ON(count % sizeof(u32));
+
+	if (!cpu_has_dsp)
+		return -EIO;
+
+	start = pos / sizeof(u32);
+	num_regs = count / sizeof(u32);
+
+	if (start + num_regs > NUM_DSP_REGS + 1)
+		return -EIO;
+
+	for (i = start; i < num_regs; i++)
+		switch (i) {
+		case 0 ... NUM_DSP_REGS - 1:
+			dspregs[i] = target->thread.dsp.dspr[i];
+			break;
+		case NUM_DSP_REGS:
+			dspregs[i] = target->thread.dsp.dspcontrol;
+			break;
+		}
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, dspregs, 0,
+				   sizeof(dspregs));
+}
+
+/*
+ * Copy the supplied 32-bit NT_MIPS_DSP buffer to the DSP context.
+ */
+static int dsp32_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
+{
+	unsigned int start, num_regs, i;
+	u32 dspregs[NUM_DSP_REGS + 1];
+	int err;
+
+	BUG_ON(count % sizeof(u32));
+
+	if (!cpu_has_dsp)
+		return -EIO;
+
+	start = pos / sizeof(u32);
+	num_regs = count / sizeof(u32);
+
+	if (start + num_regs > NUM_DSP_REGS + 1)
+		return -EIO;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, dspregs, 0,
+				 sizeof(dspregs));
+	if (err)
+		return err;
+
+	for (i = start; i < num_regs; i++)
+		switch (i) {
+		case 0 ... NUM_DSP_REGS - 1:
+			target->thread.dsp.dspr[i] = (s32)dspregs[i];
+			break;
+		case NUM_DSP_REGS:
+			target->thread.dsp.dspcontrol = (s32)dspregs[i];
+			break;
+		}
+
+	return 0;
+}
+
+#endif /* CONFIG_32BIT || CONFIG_MIPS32_O32 */
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Copy the DSP context to the supplied 64-bit NT_MIPS_DSP buffer.
+ */
+static int dsp64_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
+{
+	unsigned int start, num_regs, i;
+	u64 dspregs[NUM_DSP_REGS + 1];
+
+	BUG_ON(count % sizeof(u64));
+
+	if (!cpu_has_dsp)
+		return -EIO;
+
+	start = pos / sizeof(u64);
+	num_regs = count / sizeof(u64);
+
+	if (start + num_regs > NUM_DSP_REGS + 1)
+		return -EIO;
+
+	for (i = start; i < num_regs; i++)
+		switch (i) {
+		case 0 ... NUM_DSP_REGS - 1:
+			dspregs[i] = target->thread.dsp.dspr[i];
+			break;
+		case NUM_DSP_REGS:
+			dspregs[i] = target->thread.dsp.dspcontrol;
+			break;
+		}
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, dspregs, 0,
+				   sizeof(dspregs));
+}
+
+/*
+ * Copy the supplied 64-bit NT_MIPS_DSP buffer to the DSP context.
+ */
+static int dsp64_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
+{
+	unsigned int start, num_regs, i;
+	u64 dspregs[NUM_DSP_REGS + 1];
+	int err;
+
+	BUG_ON(count % sizeof(u64));
+
+	if (!cpu_has_dsp)
+		return -EIO;
+
+	start = pos / sizeof(u64);
+	num_regs = count / sizeof(u64);
+
+	if (start + num_regs > NUM_DSP_REGS + 1)
+		return -EIO;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, dspregs, 0,
+				 sizeof(dspregs));
+	if (err)
+		return err;
+
+	for (i = start; i < num_regs; i++)
+		switch (i) {
+		case 0 ... NUM_DSP_REGS - 1:
+			target->thread.dsp.dspr[i] = dspregs[i];
+			break;
+		case NUM_DSP_REGS:
+			target->thread.dsp.dspcontrol = dspregs[i];
+			break;
+		}
+
+	return 0;
+}
+
+#endif /* CONFIG_64BIT */
+
+/*
+ * Determine whether the DSP context is present.
+ */
+static int dsp_active(struct task_struct *target,
+		      const struct user_regset *regset)
+{
+	return cpu_has_dsp ? NUM_DSP_REGS + 1 : -ENODEV;
+}
+
 enum mips_regset {
 	REGSET_GPR,
 	REGSET_FPR,
+	REGSET_DSP,
 };
 
 struct pt_regs_offset {
@@ -697,6 +868,15 @@ static const struct user_regset mips_reg
 		.get		= fpr_get,
 		.set		= fpr_set,
 	},
+	[REGSET_DSP] = {
+		.core_note_type	= NT_MIPS_DSP,
+		.n		= NUM_DSP_REGS + 1,
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.get		= dsp32_get,
+		.set		= dsp32_set,
+		.active		= dsp_active,
+	},
 };
 
 static const struct user_regset_view user_mips_view = {
@@ -728,6 +908,15 @@ static const struct user_regset mips64_r
 		.get		= fpr_get,
 		.set		= fpr_set,
 	},
+	[REGSET_DSP] = {
+		.core_note_type	= NT_MIPS_DSP,
+		.n		= NUM_DSP_REGS + 1,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.get		= dsp64_get,
+		.set		= dsp64_set,
+		.active		= dsp_active,
+	},
 };
 
 static const struct user_regset_view user_mips64_view = {
Index: linux-jhogan-test/include/uapi/linux/elf.h
===================================================================
--- linux-jhogan-test.orig/include/uapi/linux/elf.h	2018-05-09 23:22:44.799797000 +0100
+++ linux-jhogan-test/include/uapi/linux/elf.h	2018-05-09 23:51:32.646880000 +0100
@@ -424,6 +424,7 @@ typedef struct elf64_shdr {
 #define NT_METAG_RPIPE	0x501		/* Metag read pipeline state */
 #define NT_METAG_TLS	0x502		/* Metag TLS pointer */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
+#define NT_MIPS_DSP	0x700		/* MIPS DSP ASE registers */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
