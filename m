Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519981201-2-3438537654373466284
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981200; b=LjZEkSBA4rLX/VBB1vgidss8kGv6CF9shcMcuHm8d4VfzNG
    zYvZuTkvmawKqqAW53yG1aLYAAo5A2yFt3AWdpubNIzNCyUBX701+ZzAKVbOFL7N
    71VSNCYpeuJu/weWwPHvCD1VPsnEUsZqJpeqYTHSCkunNAcb+SmVkSXXUBGEaNQS
    jUVPxDDyEH8dm2eZvoUR8HyEHLBUQnbINj8pAy+rqQJp8YRjPQo7HC4YgwYukx9I
    HPoxEAzI+TnKNo2rtVjGnaH8ZktgD7CBarEYuGKuYKKr1QMdhOezS2qooMDr3x9X
    B6TQ4KQfgRSi2ZFW8PDnDD1hsLMe/RdSVytSesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981200; bh=+TwLiiLBt/pue/GKQg7pFA3T4o
    ai7SO0lhEbQfIY88E=; b=SU5D0DBG65K8BuLaUhjBmMTw/55AWD8Qhzmnoio3YQ
    jCoeObtPpZ5Hg/4sbpqMafY7jaKPWSYGBHc8YVxULuH5Rtatk0fPDyREPbyIORYm
    JfBVwKd1u7nq31ixp2W3nXm7JB5rccJlXBpBeYBM1LCix3TnmExJGC+xbI5TD3VM
    C5dJBwx1jD0dRTjjdFM/P/eVxrXBr+EhIUdiMDqEzWgqyXw9b+LtXrDDv7an+5jt
    gf8AkP2rTekJXP0au5OAzW6LSpRT6rmKF+1Mp902t0IK2NLlsZITdR0X6zyR5e/p
    rqGzXkHdvEbwTDm4Iep96uUzoFL36t4QoECKNr8wJGgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424470AbeCBI75 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:59:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423236AbeCBI7w (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:59:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 003/115] mm/frame_vector.c: release a semaphore in get_vaddr_frames()
Date: Fri,  2 Mar 2018 09:50:06 +0100
Message-Id: <20180302084503.989358942@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 1f704fd0d14043e76e80f6b8b2251b9b2cedcca6 ]

A semaphore is acquired before this check, so we must release it before
leaving.

Link: http://lkml.kernel.org/r/20171211211009.4971-1-christophe.jaillet@wanadoo.fr
Fixes: b7f0554a56f2 ("mm: fail get_vaddr_frames() for filesystem-dax mappings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/frame_vector.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -62,8 +62,10 @@ int get_vaddr_frames(unsigned long start
 	 * get_user_pages_longterm() and disallow it for filesystem-dax
 	 * mappings.
 	 */
-	if (vma_is_fsdax(vma))
-		return -EOPNOTSUPP;
+	if (vma_is_fsdax(vma)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref = true;
