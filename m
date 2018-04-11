Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464225-2-15978495163197302779
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
    1523464225; b=Fcz8XKUA1R4O9iAI+Di7cMQf/XZiCqgxCxA1ge327C8Z0GsU2j
    1yoVyQRjv6m0gGdiBQFfpDRxngZbOFj20VtD+9QDjyU90qVkwR/K+RlY8FRkmcd2
    lyP7cHfyiTt0kzLzBQ/YCzgbvg6Y7/ubWn1IbL9OGI248nUMFKwK6OIFXMlsEHah
    vd6hv5ImVZ5GHMPERMTgAe9rjiEJTRyimJyZ0q35eH87r63bftdkw43MK/w1mZfd
    XyzYC6kBB+n9EiSS53AjLwznlZ3NR9zReOEPR6KJIYzKRUHbcvbdvnLoHsECLZka
    KDc3EqIJq7mIfDqLYtwzJuC5LVqn7OYdPBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464225;
    bh=sLdfnJRYFCG/ZrMy860DQwFY9JTVu/zk+hz2TsvIzD4=; b=I+WrJjYV5ka8
    njS/Zr0t47A7HNHI0e1kjEXFhWBKbpTqb0KX4b4QGPk1dyOSUs2cZsnIRihkIrUw
    9/pPEL0kFLomwT1CUOCfqjN7vXqVbuMm4FtrPgrI7ElC8fC7VItbeZOB2beE6qKk
    y48IrE1O3pk8Yyzl5v6/+zeL7lB3HK09vFyoSyGhwmDZFJKd4W9tpTPJZEmYcI5N
    lmS41oz1UiFkW/LTpNOc/AyyKDmh2oYU5wLoHs9/EqIlc6hVtmpWmH3N96mU41lK
    0ImbL3u/+RT5ZrpZ1GzevQJKL9uZUP3ug4WyXaAmT9Y+JH8hMICktefLlsVM/LLA
    WePeDFNykg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfMZJjzoKATzDZINHh0aLvf3JChilIDm98xCXHEfB4SQAE6Qtlcc/H21U7txAtneMx2116ZqulhfPVZqKxiQ89mN9tzunLoPUaNIzp/lFzByN0hegmE2T
    K/Agtj8cANrBaRTNcXJ6t6SMf9kg1J4Rcnp73FdAYsmQZLUq+7YF6Kv3C2xZqNpPyQYnaCFAUKB0L2xQQcF5YBbMoRjY5grplOCwnivR+k+AMrMVZ8yxfKXt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Rt4o3Z7AAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=yJgFNpO3Rp4rGEeYTYUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=jE01AiZSAJ7eki2zvjzZ:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDKQZQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbeDKQZO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:14 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/24] Restrict /dev/{mem, kmem,
 port} when the kernel is locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:12 +0100
Message-ID: <152346391203.4030.2594045084649898168.stgit@warthog.procyon.org.uk>
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

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
---

 drivers/char/mem.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffeb60d3434c..b2fca26e5765 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -784,6 +784,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port"))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 

