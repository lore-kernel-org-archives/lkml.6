Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479015-2-2890840502333370630
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
    1523479014; b=o0r8haRFxTNqOol+cFuHGNFaIEK4j0TgsIiiDLm8gPRPB+wnZf
    yZrYfZId9mYcguyI80LbyJv6sZeGWn9orQm85r28bdy3Z2SzTjosFAKr8Nqyd3V8
    fZ6TbGy9ei/IC/sohnPW8NgTQC8UIsBUJIZFGPwPNiniFzzpK2FmJFks6/jajGeY
    4P7mz9UDIrWttf7mS8+4Cv44ZUjgCwKBlO/7XzjVHsI42yN1/SPLtubXAGP97UB8
    B1ESV4Nc0bKTTKdplJXSUxP5m6a3qfDMNLeWTFCPKmt8CqH7jyrsUfALN7zKeYXP
    rdEWpXvoaRC00zdRRYcFk0D/X8xuIzjWy7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479014; bh=MrMRDi54JcLE3YgiXxeRI0GJ/MGAdp
    0hT1Ohaf44NXE=; b=vz2ISh8j/bX4AT6T9e8ajrsMfDSgTTQ4yw671ZOMzMnv4K
    OWddFhUq3CCxMLQvUM7aSYvuhow1ozjutDZp6SltZ+dXUlXzzhs7Ba4wt6QkkSum
    uGdnZZQ2KqNqi9Vn0dNZoLOf4fVS76dhzKVvSWGPtqgbykgjesCuDAh/FkUNrDek
    zIwIIlL8M8yotyZOAc5rQ3P6U0bChsgW5cH27eCa4ewmnrdsrfF9/WEOUgy+3KRc
    AOgtcq8uS6UUyAHhJXRopG3xMpD3h5gYSKwojFN+OI0DzWPvhHb5MFqnOBpSc8+X
    Isi8GtWykKTWMS3TU4rZCIUNFDjcXm1Qt1rKS6dA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfF4/aIdjKz68vuY8X6KqROjLlrHmVv0z2HnjcCf+bJG7aLiZUoqYFy702onsKOyLLG6E2l5z94V8zsj1S0knV6pI9V1KT02p5FqhomIrJF71AZu8xWd4
    arUAW6T81AWoOG9GpZca/nBkhRlvLZ3m6JvcCVz+p0WICyXP3pQlrS0yguSF/qOj1/aUIrSslWDR+A2BgRng8Ac/+0BklinvOggOoYpfErJw/AxhcPw1Ktvb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=DsOz3A4AW7707SHTs3UA:9
    a=UCYFAe-4tTnB6sJv:21 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbeDKSsk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:48:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeDKSsi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 099/190] arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage
Date: Wed, 11 Apr 2018 20:35:45 +0200
Message-Id: <20180411183556.339662900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit 5f16a046f8e144c294ef98cd29d9458b5f8273e5 ]

FUTEX_OP_OPARG_SHIFT instructs the futex code to treat the 12-bit oparg
field as a shift value, potentially leading to a left shift value that
is negative or with an absolute value that is significantly larger then
the size of the type. UBSAN chokes with:

================================================================================
UBSAN: Undefined behaviour in ./arch/arm64/include/asm/futex.h:60:13
shift exponent -1 is negative
CPU: 1 PID: 1449 Comm: syz-executor0 Not tainted 4.11.0-rc4-00005-g977eb52-dirty #11
Hardware name: linux,dummy-virt (DT)
Call trace:
[<ffff200008094778>] dump_backtrace+0x0/0x538 arch/arm64/kernel/traps.c:73
[<ffff200008094cd0>] show_stack+0x20/0x30 arch/arm64/kernel/traps.c:228
[<ffff200008c194a8>] __dump_stack lib/dump_stack.c:16 [inline]
[<ffff200008c194a8>] dump_stack+0x120/0x188 lib/dump_stack.c:52
[<ffff200008cc24b8>] ubsan_epilogue+0x18/0x98 lib/ubsan.c:164
[<ffff200008cc3098>] __ubsan_handle_shift_out_of_bounds+0x250/0x294 lib/ubsan.c:421
[<ffff20000832002c>] futex_atomic_op_inuser arch/arm64/include/asm/futex.h:60 [inline]
[<ffff20000832002c>] futex_wake_op kernel/futex.c:1489 [inline]
[<ffff20000832002c>] do_futex+0x137c/0x1740 kernel/futex.c:3231
[<ffff200008320504>] SYSC_futex kernel/futex.c:3281 [inline]
[<ffff200008320504>] SyS_futex+0x114/0x268 kernel/futex.c:3249
[<ffff200008084770>] el0_svc_naked+0x24/0x28
================================================================================
syz-executor1 uses obsolete (PF_INET,SOCK_PACKET)
sock: process `syz-executor0' is using obsolete setsockopt SO_BSDCOMPAT

This patch attempts to fix some of this by:

  * Making encoded_op an unsigned type, so we can shift it left even if
    the top bit is set.

  * Casting to signed prior to shifting right when extracting oparg
    and cmparg

  * Consider only the bottom 5 bits of oparg when using it as a left-shift
    value.

Whilst I think this catches all of the issues, I'd much prefer to remove
this stuff, as I think it's unused and the bugs are copy-pasted between
a bunch of architectures.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/futex.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -53,16 +53,16 @@
 	: "memory")
 
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 {
 	int op = (encoded_op >> 28) & 7;
 	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
+	int oparg = (int)(encoded_op << 8) >> 20;
+	int cmparg = (int)(encoded_op << 20) >> 20;
 	int oldval = 0, ret, tmp;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
+		oparg = 1U << (oparg & 0x1f);
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
