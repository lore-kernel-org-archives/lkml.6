Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523897985-2-16617241610001078759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_FUTURE_06_12 1.947,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523897984; b=sX88ARCSBBBCafMlNTC9bHa/Z5LNjZMJlgMB1urauUs0sqyP4Y
    MlqePLjwbXP0WFmApknB/Kwi42NW53fAYXWjp62eRma9fiJ+FMFa/+Ue8TE5Nm5I
    oG4RckjEcxgLNZcRs2E+lP1zaU3IZX11/mkxzc8ZfPcqNFazYQH4DuvmO7PC0xma
    rWRXgnyazH04RUoZFHNNPw5MMtHrX3zWMvzfqtunKFJjyzD0zJ9A9n79zqTwYtxv
    UNBIX4j9HHs38CdyvtdMIMXliA0mcJaPAFlPlRik+PqvBqJtlbjVAZ78JqaFCWwM
    go8xaD5iv7k6qUTuF1bwh0jXtIpNVr5wZerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523897984; bh=
    L3Fa1hLE7gRLvHJGIVKv0bvTkfUhBLi156LLb2KS9/o=; b=O1f0++8gM9Cp1U/R
    VMrw4FzP7P5LpFpFX5r6RAstZDa8SKi/DmkyHB7XM2L4FtruMgowqhERSZa7IdN8
    QAbI26jBIfISzoO8NvaeltoJ5zyNhFB+772GrSRWhaFYvXdXLv51xIx+ih/3wIWG
    Sf0ZTw8HRkVF7eMR6GqrrqRzuRXoGyFjHQXxzJxwMtRmP5LoXCpkHY5BGyvK2OSy
    NTswpj4Odm4liZ+3YLIkthN6y398fH9l/7BBcwA0FTxhf1FOIPgQAKyFqbEsRe1J
    udOdEG3p4gP/LJKfQVxpuJtCTBlq+SKjHxd/sPighXOEXKD4ilu64sJj0GM0Pvyk
    xrckgg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJSCSLEg6E/IQXmirZOUuR5qz2kXeqS1pYdujscC4Ixrou3xWVYTl6KrMmWDiIUgvACpKdH8UNgQGWund0eYxRwJjkCdKA21m8EeMHtOcXsOd4Mbla0e
    QQpQUVcjBuE9zvCdZY5cakTLEH+5X07glK7baFzmBhXLhpxTziQ2YrSPXDKjWLBJVejvI2eKZSDZ98rXVHW9RFysl6uJaBksVM2wvWLxAgXYa1ZaEiNeZSwH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=pBOR-ozoAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8
    a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=jy6tb_pfYMEvXl5KHEEA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeDPQ6a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:58:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:60647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752947AbeDPQ62 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:58:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="33033993"
From: Youquan Song <youquan.song@intel.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: tim.c.chen@linux.intel.com, ashok.raj@intel.com,
        dave.hansen@intel.com, yi.y.sun@linux.intel.com,
        youquan.song@intel.com, youquan.song@linux.intel.com,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        arjan.van.de.ven@intel.com, bp@alien8.de, jmattson@google.com,
        karahmed@amazon.de, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP
Date: Tue, 17 Apr 2018 00:27:10 -0400
Message-Id: <1523939240-16508-14-git-send-email-youquan.song@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523939240-16508-1-git-send-email-youquan.song@intel.com>
References: <1523939240-16508-1-git-send-email-youquan.song@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ingo Molnar <mingo@kernel.org>

(cherry picked from commit d72f4e29e6d84b7ec02ae93088aa459ac70e733b)

firmware_restrict_branch_speculation_*() recently started using
preempt_enable()/disable(), but those are relatively high level
primitives and cause build failures on some 32-bit builds.

Since we want to keep <asm/nospec-branch.h> low level, convert
them to macros to avoid header hell...

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Youquan Song <youquan.song@linux.intel.com> [v4.4 backport]
---
 arch/x86/include/asm/nospec-branch.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 27582aa..4675f65 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -214,20 +214,22 @@ static inline void indirect_branch_prediction_barrier(void)
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
+ *
+ * (Implemented as CPP macros due to header hell.)
  */
-static inline void firmware_restrict_branch_speculation_start(void)
-{
-	preempt_disable();
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
-			      X86_FEATURE_USE_IBRS_FW);
-}
+#define firmware_restrict_branch_speculation_start()			\
+do {									\
+	preempt_disable();						\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,	\
+			      X86_FEATURE_USE_IBRS_FW);			\
+} while (0)
 
-static inline void firmware_restrict_branch_speculation_end(void)
-{
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
-			      X86_FEATURE_USE_IBRS_FW);
-	preempt_enable();
-}
+#define firmware_restrict_branch_speculation_end()			\
+do {									\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,			\
+			      X86_FEATURE_USE_IBRS_FW);			\
+	preempt_enable();						\
+} while (0)
 
 #endif /* __ASSEMBLY__ */
 
-- 
1.8.3.1
