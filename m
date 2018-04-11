Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464169-5-8372810689945085132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464169; b=m9PKhABN8iFBqcQ8ghmrXTrp4gGVgPC0/mLVevCH1BXVnYkL6C
    Ie0oCn1tAWFG04T7nLWAmVnnWOePK0t7uz6GsFflbXjkBGymOuZwKC5kUBhShMnL
    HsTEXHjfJ6VFodOAn/xGm3YxMS+aotVW31+HUrwearUKzI4se83pWfpxhs7scqD7
    +XFauYZ6ekjFhMK0GC+xi+N6eN153MPnYAYfGsBpk11EnYJHEpCL420oPSw82BUE
    Q4+fTu3iVEjBq6lp7FsK/O3wOfp3R3QkMKR76D0dF0YgXXRLv4zBP1JdOL5GI0dj
    1nAN63W+kkJcJQmMraM0YdZx7gDTE4y7ijCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464169;
    bh=nK8Z8v+5xrIJBqSjHuPfwkIO4aLJSzQFq0zoox/+jFc=; b=eKJQMv2qHRW1
    bd1Sq7ZPd5Ka3Bl0VSUN3MroPHBd2z+jqC69Pwh7oAdVQdvvIoWcVW9/T9Xcpfa5
    7Fyk/KMIBhBEuc67Y+Zm6zA+CcZhnlEpyzsRKHKPN99keoXRVOH647svOFf++zmh
    MATzk9Px61juUwSlrNrlov8G6uGv9eonEb/2dEHuQYsxgkM0Rg1CeICcDTFFpsnr
    J9MWJH7HsET/Fpx5/3d4Vw5mA85dVx0/URAtpGJ8cxHEtsAIObZgYqarw23ZNiDi
    3kJt8BtLCD/vO/RsazAKeE0QiO0M7KDP1/qp5iXvhHWd9u7+wem41jUMx3BUckPr
    vWbMzphVwQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKaDfsR9ltYGBDMmhbTd1entucZ/34T8iy9zhzeELsPgLAunxl+m/KBBGkA4d813aIZWeh+44H4w8Je6NynzKyNWIgNSOMKWZDiS/FJvcDuJ8gFVwlgf
    pIXrq+NhAMlgOgHu01MoVcBQixr3gXaUWRrdpZt5G8vMlO8zeHVUUj8iu8zYdoLkzrCuVgLBd0EkWZqB9wDyHTCQM5HgP0IhzMwtldfQ095qLcXmOt+y983e
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Rt4o3Z7AAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=HBb39uKJ9T1tXzi0DUsA:9 a=QWiXWZXJ0S2QiCFC:21 a=zCkWoTFkJoyhpyrY:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jE01AiZSAJ7eki2zvjzZ:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeDKQZt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754127AbeDKQZq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:46 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/24] x86: Lock down IO port access when the kernel is
 locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:44 +0100
Message-ID: <152346394480.4030.1320576522708821046.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: x86@kernel.org
---

 arch/x86/kernel/ioport.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..abc702a6ae9c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -31,7 +31,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			kernel_is_locked_down("ioperm")))
 		return -EPERM;
 
 	/*
@@ -126,7 +127,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    kernel_is_locked_down("iopl"))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |

