Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4156032-1522167370-2-9885516869352725823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167366; b=WUerMYMCar4n5/xaRHwVFt4D37dABiXfxBtp5e32PN0oBI0
    Bv3B6heDG8Zy5drK6wUvUzBxb6F6ZtbWxpT2NgBmMfMcjWCZiwCeqG0KFWnR38eb
    +aCuxAV+lR5HL8gT8bS1WS968XXSilVryEl0TbGi3o09BGs4X7nQ9k5vP/j861OS
    olgCdFLlK2z1draG1EMqkkoDufix18Bdx4BNoie9u5BmtWHypiFXaUZIMZ0W+lNh
    FbW+0jOhQcej5TzG6d22yWyIRD7bXH4KgxQEwkdn6S8yBV5EumCa+KpnXfypVvKW
    SjMncl63GryQ3AGCU9407OizhIUHK4h/+ckOVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522167366;
    bh=/S1NBvuEq2dlSwGkuTsQn8gbMqCfNDp1Cjjaxlrne/A=; b=F6Nyh5gbV7NN
    0mvfXbpOLvvq/X4ONhEx62l3Eg++SRSGrd7v/3hY+HeRg1tiHH74RWrZhjM4wsNI
    2eVzZFzwRo+2HUAgT1m3kOyxZ8T4Hcv0osDDs7L6Sg86B0EsrcCvOlxMlORjFjXL
    Y4CNdOwb01qv9ytuWcz20MTBilDwz6eYwk+iVYV89CflyycP+gcOo2u77N+/zzmp
    S5Qwhkfo8k7b2zcjAcSHDntleWvr16bV59HCTgz28RaojARxaa5OAsOI/2CYWaP9
    eFNPPzCM/bc8D2NBOxB/n0Cn5LZqgydPIUuY1Zo5UCq9jpBY+DuDhzwVQbvy+R7x
    41ikcmf+OQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfBj/UvtQmJ7aXezE+etx5vTIimZJmR014zcwRrmxqFdVS1ASyWi0kHBW8d1dY9d0a7oHeeOMHOlL7OfyR9Qd7dYIuBvrqzJ1pFBX9/JqoUuWV7xoLj8q
    aBkw+diRSV+Qc55yqR4u/q+f5uZ1aG4qONIENWX/dXP60T6/ursRGDZpcDzcTFWFn3texkWgeGxsZ0PNmoChTCVdylz+aGxKyJTZEZMs9uGhx0JIZ0FS7gKy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=7d_E57ReAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8
    a=20KFwNOVAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=UPm3pfgAAAAA:8
    a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=nK1Qfd4pxio8lxmWJb4A:9
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22
    a=56QPVbyS4OZCpcuOg7Z9:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeC0QQF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:16:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:53324 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeC0QQA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 12:16:00 -0400
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.17 04/21] arm: Wire up restartable sequences system call
Date: Tue, 27 Mar 2018 12:05:25 -0400
Message-Id: <20180327160542.28457-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wire up the rseq system call on 32-bit ARM.

This provides an ABI improving the speed of a user-space getcpu
operation on ARM by skipping the getcpu system call on the fast path, as
well as improving the speed of user-space operations on per-cpu data
compared to using load-linked/store-conditional.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul Turner <pjt@google.com>
CC: Andrew Hunter <ahh@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 arch/arm/tools/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 0bb0e9c6376c..fbc74b5fa3ed 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -412,3 +412,4 @@
 395	common	pkey_alloc		sys_pkey_alloc
 396	common	pkey_free		sys_pkey_free
 397	common	statx			sys_statx
+398	common	rseq			sys_rseq
-- 
2.11.0

