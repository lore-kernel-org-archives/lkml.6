Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405450-2-13122668817195149600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405450; b=UhRCf56VNrh0so1fD2JZyrWAIfSgw3Mmd+A5kcg3SJb3VhxnqH
    4fGooP4PIJu/lJaz3hH82rPI21WypVsVMdtvLElfVcEyQ+5ehZ9Azs4j0k5eMwfu
    eTzrEIAVULhTkPRyc1mVZwLrGK0VFd2Nx4H52PZOvCaE9wacgGSyKjuVT9obZ/dd
    QcW9U3AchZ5E7cBgWMPNH+mmqAIFdja3wPwFSlVJk2/x+V5rv3ppu2UuwbYwd7jK
    3P24YevDop3t4Bq/aWy0dD1fQH8jJus1ErKMK8z9aYkJpaNgb+4852RvVjW3FXzQ
    Z1g4wazAhJ5BtPekHeNOuHGI60n19nuq82zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405450; bh=7DYaZdesBcOMZkI0Zxr/B/5lbzF0u6
    Pcew4Kti7ReRA=; b=naG5uO5Av5a7BtzUxPbYFAmyQMZvFeDi1a0UTVgHYJfAJi
    8Gg9EabMbcm5iVY2zFbbwyzuYymcnki4+oIGImhA6ufo0U8g0NBusiWskjmfBaiv
    9xWcjvEvvBZgm0UFg44szZMZPysjao/pVaFqy0ujkZBLA6VfCsBajAAXxPUXwqAw
    VkrF6ZSrva19iH+Y/7kbiZIq6a9JKekZlAZyQ1r+pFh9NLwuwKuGWmjyQ1WL8yvz
    2ktXGjcHixi9me2OlEE1peR/16EOiYCeVBZGMKKRCMltr8jgkWkDNcCFrdCWqHQf
    ReEO+13j+X9KbshdJ/5ANRYpgZTQpMS1wSpXpoGA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEsrg2z/KSgQoa/oyrTGolwylYflt8nTqAfwq+CIB21xg4ZA5TlRbS1Yue8OlhJw1KVGZhw/MLzpWvR/EZ1SbOEZnhLC9hWI2JhwpeuEKij+k93yNv5h
    646cqs04giSZsFMeXqQf1ma/qpCoTExXPBT05jG7RDwvQ987DRxidYP5hKKunC1HEqdvKzynxGnwak3mzoBGHaDO9DL92luJVbnZn3Lp7XBpm2Sh0mhjBUWq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=HxyOmEZR8sH4CBheeFQA:9
    a=gtzk5QBKHHw1mnVw:21 a=UznQaf1r5Qw8h7KT:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeDVN51 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:57:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeDVN5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:57:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4.16 068/196] powerpc/mm/radix: Fix checkstops caused by invalid tlbiel
Date: Sun, 22 Apr 2018 15:51:28 +0200
Message-Id: <20180422135107.777570520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 2675c13b293a007b7b7f8229514126bd23df09a7 upstream.

In tlbiel_radix_set_isa300() we use the PPC_TLBIEL() macro to
construct tlbiel instructions. The instruction takes 5 fields, two of
which are registers, and the others are constants. But because it's
constructed with inline asm the compiler doesn't know that.

We got the constraint wrong on the 'r' field, using "r" tells the
compiler to put the value in a register. The value we then get in the
macro is the *register number*, not the value of the field.

That means when we mask the register number with 0x1 we get 0 or 1
depending on which register the compiler happens to put the constant
in, eg:

  li      r10,1
  tlbiel  r8,r9,2,0,0

  li      r7,1
  tlbiel  r10,r6,0,0,1

If we're unlucky we might generate an invalid instruction form, for
example RIC=0, PRS=1 and R=0, tlbiel r8,r7,0,1,0, this has been
observed to cause machine checks:

  Oops: Machine check, sig: 7 [#1]
  CPU: 24 PID: 0 Comm: swapper
  NIP:  00000000000385f4 LR: 000000000100ed00 CTR: 000000000000007f
  REGS: c00000000110bb40 TRAP: 0200
  MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48002222  XER: 20040000
  CFAR: 00000000000385d0 DAR: 0000000000001c00 DSISR: 00000200 SOFTE: 1

If the machine check happens early in boot while we have MSR_ME=0 it
will escalate into a checkstop and kill the box entirely.

To fix it we could change the inline asm constraint to "i" which
tells the compiler the value is a constant. But a better fix is to just
pass a literal 1 into the macro, which bypasses any problems with inline
asm constraints.

Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/tlb-radix.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -33,13 +33,12 @@ static inline void tlbiel_radix_set_isa3
 {
 	unsigned long rb;
 	unsigned long rs;
-	unsigned int r = 1; /* radix format */
 
 	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
 	rs = ((unsigned long)pid << PPC_BITLSHIFT(31));
 
-	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4)
-		     : : "r"(rb), "r"(rs), "i"(ric), "i"(prs), "r"(r)
+	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, 1)
+		     : : "r"(rb), "r"(rs), "i"(ric), "i"(prs)
 		     : "memory");
 }
 
