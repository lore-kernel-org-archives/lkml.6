Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406191-2-13556324107841926814
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
    1524406191; b=M0lBtAZNIBFq7FF9gdRV3oGoZNsRcqQ+per0S9yv/A/wOAFvPk
    RbbJTqbEJoEwT6Rg4a/u2SqccQliVu0cwrqb97i60UJekMRhhaaoFu498ooqibDo
    z3DPbvtkJl6cNBKo0VYGd3sHuADFdvqjtgshAZT44ML6SExpAv6MJprDWbXoHA29
    RbaCi7x6uDD8Zh0AmUNcQJxClk9arAA1gDUC7Mmg9QPTLkGSkoRr5B0ypdLkn9XO
    MnJzDToz+aPTYUM9feVtbFL2XTe7t6DAmI3mDWrE4+61plYxR0af61Y0rYbYxE2D
    d5G3iCCAQ28DRnsAOuump37C+RbJtcFwZKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406191; bh=vbZWA1JqtkZ6aqR2xKhRmnZUcUkP7+
    qM8E/VXtLFF28=; b=iX7PFmznfzRgrZqH1hRG6Q+uJW2H07XHmBLgB0qMll6Oy7
    leDoElcbb6UIyYqkCcINMOCZrfFAC0i4DngwEI51/8k3A+tHT0/80MFjWoqOXeYM
    M3e1wawGsrk+as5ISttsMkBC8DLWmwIcCboVI92dpmfLZR7CFTy0ACel9Ok+x0wp
    ok14sYC+M9QHORlq10FhCZW1fOyp6GaTH+/MEWGrB0WSuRro90cxxNzn3E6hOB5D
    MmhxHVy++0DDM/Q9T5tlmkGJtox4+1GuemFaO+JqhZWk/f2YwIX2+IM3LcnYSROr
    Ma9MHqf7e6q6MByAl7YNUz0ZGbO9mJYO5FDQF6qQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfIq6/K94jw2LU82P+ReMD7DnuoDobzLq7m9qlj4tLOOEnTc8zzWNg3aAzDGmG0Rf5aLQnHpZNFDbxAkqZ8uBwLOOXp9GGV4tgv18H4hLD7Ge190QGuav
    uRVA+R/u7R5Jqd/JmAvVDJTrRuRjRXh+0gEccbv9dBNpianzsG0uXoY1rod8x00GAYiylAiicFTB/mFhpomOcXGmCJu6V6j9/XKLNxnllh6wIetUzXRXAqoU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gPJu0pBYAAAA:8 a=QyXUC8HyAAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=91bsxVqKFJvqs9A2FmIA:9 a=2adtovz_5owTzxBS:21
    a=Vur5ncPZs8SqN0HK:21 a=QEXdDO2ut3YA:10 a=AlIIF0cMT2hfDT4axODj:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756156AbeDVOJp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:09:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755924AbeDVOJo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:09:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuanhua Lei <chuanhua.lei@intel.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 142/164] MIPS: memset.S: EVA & fault support for small_memset
Date: Sun, 22 Apr 2018 15:53:29 +0200
Message-Id: <20180422135141.281569775@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit 8a8158c85e1e774a44fbe81106fa41138580dfd1 upstream.

The MIPS kernel memset / bzero implementation includes a small_memset
branch which is used when the region to be set is smaller than a long (4
bytes on 32bit, 8 bytes on 64bit). The current small_memset
implementation uses a simple store byte loop to write the destination.
There are 2 issues with this implementation:

1. When EVA mode is active, user and kernel address spaces may overlap.
Currently the use of the sb instruction means kernel mode addressing is
always used and an intended write to userspace may actually overwrite
some critical kernel data.

2. If the write triggers a page fault, for example by calling
__clear_user(NULL, 2), instead of gracefully handling the fault, an OOPS
is triggered.

Fix these issues by replacing the sb instruction with the EX() macro,
which will emit EVA compatible instuctions as required. Additionally
implement a fault fixup for small_memset which sets a2 to the number of
bytes that could not be cleared (as defined by __clear_user).

Reported-by: Chuanhua Lei <chuanhua.lei@intel.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/18975/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -219,7 +219,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -260,6 +260,11 @@
 	jr		ra
 	andi		v1, a2, STORMASK
 
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
+
 	.endm
 
 /*
