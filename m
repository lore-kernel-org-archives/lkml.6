Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937365-2-518245874202027834
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937364; b=EQMZDxz1QcpcCbWp/57jGWZMhGED6G3HM14Hv0ishrNCyO91jl
    ts8F4Ev7ILTzEuOgZMKXwyoqp2HcH52D/M4xU3ZHla9ZWcQSgXYl2vQmtZVgR6ME
    bg7HpY9ALm3Q+foO6JzXUIPFFDx/tL+r3bueP2+QddAA8+igIys1sjXL1PyaQjyu
    NuYWgieSF+HrYPsGnOaremqzWAD0SBXjfu09Ypwrly3UV8ASeWuT3G2D7I1DO9FH
    Ue+/3/OwAgEdLnU9s4xUjmbasQZ0M+WA0+NKttoi0dQh0L6Xdw4/FRBPrgXSqcje
    DQ5t9FClEWmdnVZjyOAxPnAb91lGD/W+Ginw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937364; bh=3fSsq6saIvdOCd00mCBp94ims2+l2v
    N451lJ46M8+XY=; b=Qcoo8MG2p99H5j8bGmxstl7gTI69iZYzM31sBPwjFkRTU2
    RsgLiVCvWCZlpFqIco2j29IMwfhOaRu1NK1mxfqkvajMtNYE2ZtFyTIj90bxP+o+
    TF0xv6wX8fEYBFLeuFLqsXpdGBwuzp0cq45VNIpV7ZyaHJAUAnObiRyUkKJDHZ5r
    L3V8QCBJHpbu7G1rUvT8o68+QTDxZCWUsgFpm+OO5LGQ8yhv0ccwhFaGvFxdiuMY
    Lot81dY53KraCFKlYV09jilZemPvxpOs/xNaB/PkMzBasmaXCT1Odu/RcoHbDnr/
    jFzMZM5263ZdOhZoRpBMas0o65w2CAK4B4AfSq3w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=UBV8BmLR x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=UBV8BmLR x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJLMjvM7BDwmxH+u8cJlWB9mXxoZN5ulsoKyr9Z4shuBpFR9THX1b8SLs++XhZB46ZZAmLlvMxlHGOknRRGCVLzuZlT5mun4o7wve1X+15uB61/efCF5
    PPq29Olx+ZjwYA6YLnys45g+MynaRAd3FseVn+lg5/8JSEHew1fvpsFxohQTou2Eik2QjdAvRiIpPRBfwUH9lCLjHyO4O1SpzHMqgLFE9f9klffIDoIxT0KY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=YEJRCRz9AAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=pBOR-ozoAAAA:8
    a=ag1SF4gXAAAA:8 a=tsO3I-MFJaM0yNIm18IA:9 a=lyG0_9LBSh2oPxmB:21
    a=ZzJ1YRuaQ6ajM5EZ:21 a=QEXdDO2ut3YA:10 a=To4gpNYZFyF9PdtASVO2:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeEUVQC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbeEUVP6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:15:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyle Huey <khuey@kylehuey.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 51/87] x86/process: Correct and optimize TIF_BLOCKSTEP switch
Date: Mon, 21 May 2018 23:11:27 +0200
Message-Id: <20180521210424.973793630@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Huey <me@kylehuey.com>

commit b9894a2f5bd18b1691cb6872c9afe32b148d0132 upstream

The debug control MSR is "highly magical" as the blockstep bit can be
cleared by hardware under not well documented circumstances.

So a task switch relying on the bit set by the previous task (according to
the previous tasks thread flags) can trip over this and not update the flag
for the next task.

To fix this its required to handle DEBUGCTLMSR_BTF when either the previous
or the next or both tasks have the TIF_BLOCKSTEP flag set.

While at it avoid branching within the TIF_BLOCKSTEP case and evaluating
boot_cpu_data twice in kernels without CONFIG_X86_DEBUGCTLMSR.

x86_64: arch/x86/kernel/process.o
text	data	bss	dec	 hex
3024    8577    16      11617    2d61	Before
3008	8577	16	11601	 2d51	After

i386: No change

[ tglx: Made the shift value explicit, use a local variable to make the
code readable and massaged changelog]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-3-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    1 +
 arch/x86/kernel/process.c        |   12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -141,6 +141,7 @@
 
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -227,13 +227,15 @@ void __switch_to_xtra(struct task_struct
 
 	propagate_user_return_notify(prev_p, next_p);
 
-	if ((tifp ^ tifn) & _TIF_BLOCKSTEP) {
-		unsigned long debugctl = get_debugctlmsr();
+	if ((tifp & _TIF_BLOCKSTEP || tifn & _TIF_BLOCKSTEP) &&
+	    arch_has_block_step()) {
+		unsigned long debugctl, msk;
 
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 		debugctl &= ~DEBUGCTLMSR_BTF;
-		if (tifn & _TIF_BLOCKSTEP)
-			debugctl |= DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
+		msk = tifn & _TIF_BLOCKSTEP;
+		debugctl |= (msk >> TIF_BLOCKSTEP) << DEBUGCTLMSR_BTF_SHIFT;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
 	if ((tifp ^ tifn) & _TIF_NOTSC) {
