Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163201-2-17380820556538479067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163201; b=gFA4N4CQF+t40Su0mnokFATidtfqQPJ80dGkBxKzzuG5jvgiD3
    /3SRTzXgvT2mGCnW9eFr646OZ4XfGyjWGcYBBHJpZahgTyeqPS0ogjpM1udjlr0a
    4Y9uuUBsdSBMHTds92FnXY5L64ig5wmMzY9chssoGf87iBe0o+wdKNbEKo4or0pZ
    GI+tf1M7ouqdVA7m4e9Cke7sOwlL3+06VicXVJn49HhOQPK6XTdkVX1QeOp93ykZ
    5JIPbtH9n4id1d9WTFOxAeEunre0EA1o08WnRsr/PSK8M2G6y3x8jzoOzPoEDvlV
    cwn2g/Rof3VFHeQuetCbHDloX2gxacerMc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163201; bh=W9AZ+AW2Fq5PJVQ5H+kCq8tzMudoa+
    l/MrpZ5I8ADW4=; b=hHSkg7F4MAVlxKcwmKik9TOWvkz7AZPxP4bynMV15UTnWM
    diijcuc837xapGNgnVic/A1Ta8686wrp0uLiFjVAC3M2q0TEUSqO7NL/1LEwk8FJ
    3OtzQSyaVpZ/nOKNtN2VV4Pl4CxB1e3iNL+Eyy2RHfmTxQAzzbUJrYIOi1pfj4q0
    p11HeSA2NwCFM9ecOfZnh2nGHtyxJN+MzQSELmXGJM/ROqpfNXiNX/0ZaP+5bMa4
    z6FmyZn+7ghZRA8aMMHECMCpUgyaXR/+QUrsHo48OspwzqZJlDqlZxepf2IlpCNT
    CrIF+PIPX7dpa7zccHS/xDkLz+qSc7Ke4YvNG0rQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1gJzKkZn x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1gJzKkZn x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAjzNlTsEt9Ihe0thFzUViz1iFOtW8a+tIeFV++RBUS1NGFi3my6BMl1JFbz3+YG/2uc5jTPoNfeuRyBHFGccvYkzWDIcpOEqIzR09ZLmQxUAEnO6j5O
    bFYzMblsL7ycz9nTJghPpq6zpZCWp/rIO/+6hE3+cdn8YjB3nk2FJxSQiZN8OHWEgAgXm/OisRpvisMSStXAJ+Cx/64/vSH2p0CwVhDZuEcJu/f35P/69fSt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=LfR2_N8ysYQO3oEyUZ8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966990AbeEXL70 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeEXJpQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 61/92] s390: remove indirect branch from do_softirq_own_stack
Date: Thu, 24 May 2018 11:38:38 +0200
Message-Id: <20180524093205.137407442@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 9f18fff63cfd6f559daa1eaae60640372c65f84b upstream.

The inline assembly to call __do_softirq on the irq stack uses
an indirect branch. This can be replaced with a normal relative
branch.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/irq.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -173,10 +173,9 @@ void do_softirq_own_stack(void)
 		new -= STACK_FRAME_OVERHEAD;
 		((struct stack_frame *) new)->back_chain = old;
 		asm volatile("   la    15,0(%0)\n"
-			     "   basr  14,%2\n"
+			     "   brasl 14,__do_softirq\n"
 			     "   la    15,0(%1)\n"
-			     : : "a" (new), "a" (old),
-			         "a" (__do_softirq)
+			     : : "a" (new), "a" (old)
 			     : "0", "1", "2", "3", "4", "5", "14",
 			       "cc", "memory" );
 	} else {
