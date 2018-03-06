Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296128-2-10916977067101974149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296128; b=JAPqiEGG1AZF9x2s/RWRkDlifV/hHryDNI2U0RZ281x19EY
    dm06G8R3/I0NqtgfsLNtksSva4nNEnFB2eLT0R7eNyKzId/yK7Vfapk1jZm9pSxw
    KPnxy5kJkLTyrAFF30A0UqxaGAvtLarszO2vfnrPGv1zx7/bP/0ShnH9WbkmVriv
    e21lEq091+PvS9/dvCP6v5Tsjn0x6k+4djubkSfYXZKblFb51EfsztkQ0Bh+7xLM
    4XL96dVCdJdlmtwwM+uof9zuJRco+znVzTnq0DN6VkzWCNpxFQNYeGIQ5UMlN7Em
    YzKB2yHJXArJPuFhtcXi3OXYoYikUJbapsE/72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296128;
    bh=9w2ZhzNj+BSBYHWvaUeOSUgZyCZn0EaR/dYzmm6LKMM=; b=eF8S7NO6UWD4
    iPaB+huJW26NqhX7Gi8WG0ENumXG0P6FbdYdxFfWS/s6bCzCvXVE79hWASIHfmLs
    weUj3Web0tafX3L+b0PF3O4tJ2oPikD1o32K5t9nzbB7WH9QH4LLULjkL2u/m3Ep
    I6JI6kZJQpgCSbxMPRvDZQi2nQoAM/75R3nI9Q2WTggbvEFUujTWnpdl176NbvUK
    EgGoMNzz6l8Hi8Ixpsk8H5lohsz5iD3irgqJ613NFWn3oX4R6He8prUyF871pJ6n
    n5cb2ZT6+KyTlCJLPBOkKT3At2U6MO5acw/q0qTyeG15q1TwGqLzhARO6kjbhgaJ
    I0laYr7jOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=g0gDT7Yo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=g0gDT7Yo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeCFA2o (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:28:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56670 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeCFA07 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:59 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 61/65] x86/ldt: fix crash in ldt freeing.
Date: Mon,  5 Mar 2018 19:25:34 -0500
Message-Id: <20180306002538.1761-62-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=888
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jamie Iles <jamie.iles@oracle.com>

94b1f3e2c4b7 (kaiser: merged update) factored out __free_ldt_struct() to
use vfree/free_page, but in the page allocation case it is actually
allocated with kmalloc so needs to be freed with kfree and not
free_page().

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Jamie Iles <jamie.iles@oracle.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/ldt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 5797d437710d..5de9fbc4ab50 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -39,7 +39,7 @@ static void __free_ldt_struct(struct ldt_struct *ldt)
 	if (ldt->size * LDT_ENTRY_SIZE > PAGE_SIZE)
 		vfree(ldt->entries);
 	else
-		free_page((unsigned long)ldt->entries);
+		kfree(ldt->entries);
 	kfree(ldt);
 }
 
-- 
2.16.2
