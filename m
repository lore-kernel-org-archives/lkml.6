Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684311-1523561580-2-2821288173157785884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523561579; b=Kbi09eeaakxDjujzVVKKQBptLS9aJQmk7C4apwRIFHklmdBQE+
    E0jUXW9anRibhLn6+L9+214A7ZIuEw7W83j8atwSHtvdHazc+ceAXtgaNPYR0lFh
    dZ7auysa6OCBhyHa/BMEt78mjEiGPZ/fnvzaVOQrl/SdwJ5hLr1Izb6u8PV3NYl5
    yGPh7HGIBK0Ws743pB1kVFaENnetfGxBdFJIoPZKwvTsUJlV3f1FiFk/sfHQhBq8
    gi9hWLFkxL7CN3MBja7q+jdpDR2IpUqJdMQHsEcZWCup2BAMIGVTgVtQU3p4mUG4
    eTLqYZOtsTiFji2V4Twr/7zQ9B1opavhEEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523561579; bh=
    UhPlrO3lskkIqViBErIyY/T0vWlZBC2aFkGaO5oSwSQ=; b=JxyKpKhmfAWreKjX
    8FF48r2vAjEdTyzbSfbr6YmqQqO4fVFhhQs9uK2Cdj9tLj/o9o1ocpjEUayjN1Df
    URFSovjRg2bMjXdak2P5IYJ9hHvFk+1oc/u81KymjY3blq1Tazn6AMIzNxEtvwZn
    P2pwbJY7LrCRurry9p2OI/wnCU63oTm/7vav29jJsEFyLNk0qo8Ee4Ht7Yo3iI3j
    2HWt2/gcCHtyjsgpVj2G5NxC5rE1FWJib6I94/7qqGHStVx08//z9QfU7ImFMhUT
    mM5+q5d5Ict94UH0FZfZyxt7VMhFJ+cRsMNaBsZBEy4SikRuLANcN8zB284Az79u
    DLtWxg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOqp81FdrQKuJ6H8AKxWRGEwuvji7GkDr2fQnNUWju6/bINVk8ksXmUsn99+AA1dcLC8Gz34jLSWe+jxqRbawNVU58TOnKoayAp87KNG5ZSCAFdgmioW
    qZ4BF5vJKEXXQsBu6/RDjxEs69stMc12lsR8OUnYySMYzQNR1/Lf/Sz5RItnP3Pzi4yqKQ9hnWgT5dL5lRfaRj2TbfhYeLbUZkS1RhciFoYrikQIYiJoNc05
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=SOq6UgPBAAAA:8
    a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8 a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=37rDS-QxAAAA:8
    a=VwQbUJbxAAAA:8 a=PcGdOUl1GkNCjaGyiRMA:9 a=GnsHPoFplh_JSEo5:21
    a=VzndIavU7QtvWCZz:21 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=k1Nq6YrhK2t884LQW06G:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeDLTbl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:31:41 -0400
Received: from mail.efficios.com ([167.114.142.138]:45804 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbeDLT2Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:28:24 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-mm@kvack.org
Subject: [RFC PATCH for 4.18 11/23] mm: Provide is_vma_noncached
Date: Thu, 12 Apr 2018 15:27:48 -0400
Message-Id: <20180412192800.15708-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provide is_vma_noncached() static inline to allow generic code to
check whether the given vma consists of noncached memory.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andrew Hunter <ahh@google.com>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-mm@kvack.org
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..1f93a061a43b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2425,6 +2425,30 @@ static inline struct page *follow_page(struct vm_area_struct *vma,
 	return follow_page_mask(vma, address, foll_flags, &unused_page_mask);
 }
 
+static inline bool pgprot_same(pgprot_t a, pgprot_t b)
+{
+	return pgprot_val(a) == pgprot_val(b);
+}
+
+#ifdef pgprot_noncached
+static inline bool is_vma_noncached(struct vm_area_struct *vma)
+{
+	pgprot_t pgprot = vma->vm_page_prot;
+
+	/* Check whether architecture implements noncached pages. */
+	if (pgprot_same(pgprot_noncached(PAGE_KERNEL), PAGE_KERNEL))
+		return false;
+	if (!pgprot_same(pgprot, pgprot_noncached(pgprot)))
+		return false;
+	return true;
+}
+#else
+static inline bool is_vma_noncached(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 #define FOLL_GET	0x04	/* do get_page on page */
-- 
2.11.0

