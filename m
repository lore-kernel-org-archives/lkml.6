Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472837-2-11882277224042781921
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
    1523472836; b=nIdDFVvB0vG8qB/3vrBIiSfA6jinMFIYXCKRmekzRD1mQc6njy
    FN85zjg0U9QFlgd5HXhoBdj2nywGaOtVQCyt2c/h96eoOajwPsnMqUuV5N3oos/0
    pvS2mRq2IzazWRjWqEvHgO7+MQAuNNgkWxzB3VY5JUCLRKFvUMezKBPeeLAlnWDr
    68g1uGLBVwaeSf5Sw19HJqhmnEUicsdpab6MoijcAZZknMtu5nr3cDBX0qT3GB/w
    BWpOZnh2Ppupf7QYDKLfCSsajuIZoqu9tj++sj8cdizLjyROf+F7G4g5KzbLsgo4
    4nduHV9VSXWSxh4BZNNz9Z1A4GLQPl/fREuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472836; bh=3Hky99KNdbsVPR//NjoLLMC/8BqkS4
    aaTGU5Jo52SSk=; b=VYoOkDIjVmzsZLH0BITBY3TLz5MJsAdebExlNTsDzc3vx4
    4d4xOkGkfS5F5E2Ia2hOv/a9Oj663YDmRFECGHGgJiXrKe49jePUsTW8bMseKqf1
    IqsxLOoXP7E6ADPprQ3r/HvanhJfbOnAQLpmBD3BAurfz5nCrXjewIGQfxCvNKZd
    t+NzhdvJiNuHyvXgqFsuK+P3VNf9arJ9nxbHdKREp/B8wKLKh+7WjplkAteS2+kn
    ge02E6GZcfUUpwSGveVXLjIPnKK+gxmdwho8ocyD8M/IZrV/TRH3j/yB8H475hrv
    1Y5ewL2C7VdY1lOAXr6/uTsnVkT5SqV6eGfvVl4A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJgc+rTPnVTgKfcPHiLGsK8dqgzVVFGLJVqDgMk8GqdWPbGm44JxPAQJGku8WRHB8W2JVbyQdTFirNHj5gETen4JOZPKbqLTzwKNTpmoTS51nxf7o3qR
    fnC2vdPAh1JvFX6hsy6ZiFUV0ynbUUemIQJABALWeILGlMkGXQVW0ErGsSaWdJ1DdcaKen5UxtQ6OZLkylIrd41K60uzgq/OIY6E8YzIklhhJ9DcTlU5nfeC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=1dC9rZzOHYw4hMiY5wIA:9
    a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeDKSxx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933372AbeDKSxw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Davidson <md@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 006/310] x86/mm/kaslr: Use the _ASM_MUL macro for multiplication to work around Clang incompatibility
Date: Wed, 11 Apr 2018 20:32:25 +0200
Message-Id: <20180411183622.563621237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>


[ Upstream commit 121843eb02a6e2fa30aefab64bfe183c97230c75 ]

The constraint "rm" allows the compiler to put mix_const into memory.
When the input operand is a memory location then MUL needs an operand
size suffix, since Clang can't infer the multiplication width from the
operand.

Add and use the _ASM_MUL macro which determines the operand size and
resolves to the NUL instruction with the corresponding suffix.

This fixes the following error when building with clang:

  CC      arch/x86/lib/kaslr.o
  /tmp/kaslr-dfe1ad.s: Assembler messages:
  /tmp/kaslr-dfe1ad.s:182: Error: no instruction mnemonic suffix given and no register operands; can't size instruction

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Davidson <md@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170501224741.133938-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/asm.h |    1 +
 arch/x86/lib/kaslr.c       |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -34,6 +34,7 @@
 #define _ASM_ADD	__ASM_SIZE(add)
 #define _ASM_SUB	__ASM_SIZE(sub)
 #define _ASM_XADD	__ASM_SIZE(xadd)
+#define _ASM_MUL	__ASM_SIZE(mul)
 
 #define _ASM_AX		__ASM_REG(ax)
 #define _ASM_BX		__ASM_REG(bx)
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -5,6 +5,7 @@
  * kernel starts. This file is included in the compressed kernel and
  * normally linked in the regular.
  */
+#include <asm/asm.h>
 #include <asm/kaslr.h>
 #include <asm/msr.h>
 #include <asm/archrandom.h>
@@ -79,7 +80,7 @@ unsigned long kaslr_get_random_long(cons
 	}
 
 	/* Circular multiply for better bit diffusion */
-	asm("mul %3"
+	asm(_ASM_MUL "%3"
 	    : "=a" (random), "=d" (raw)
 	    : "a" (random), "rm" (mix_const));
 	random += raw;
