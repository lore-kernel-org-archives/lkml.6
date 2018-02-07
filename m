Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-726958-1518036998-2-8310753631824469465
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518036997; b=tnVoTQYVkL7r2INSnQW1GfTtWQymj8luVena0L1RLQJZlXn
    FKT8njo2078mcrJ/7lrCTvz1iKtldIszEDmSzfEQakgdoLtARBG0A7VVGC3tJjYi
    W8YqBBGpJqjZz8SOu2lBeEde5Fssj6Um6iObNr8rpb5AxR3GKsVip0HdgWinmSGS
    8U+PjPIbKLdcQKloo1AFf0iDA1Y/HvPsAaCuuOEmb6Il2zgdjikOMffQYRyzhetW
    xBn+V8bmArOfGFFPwBkKcIWewpp+aVzJDWwPQ5vZ7UYk9hN3T2q8jRj1PDIQzDHm
    7N/dCpkSwJZJmGzajAIrFyC9Ldz4L78zR1hVt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518036997; bh=8S4HCZx1GwOii+ddTJEsoncMXe
    IJBF/7KHujMh85D3A=; b=v4YiZsfK65d7hDgczJbAvunCC1G28LhYemtL8o8b2j
    aqC1j/cmoCHJicjHvjDlsKRfiYObJI8FjJ0sLAC6dLOkV+i1VhZ9I/cnE02XwXS+
    CoPDPeE5PY3uuqmEUVUz7jv2JTLkntSt1Ah0pmFsI3y2LYiJNVQa03u/IBTK9gVz
    skauy+rY21YqLrPqwzTQg4RK792VrwQHHZ4xHY92cxddHObYJffsb2buSeA1d6lQ
    pEatpH+eKf3D5DGMmBKgz5gIXk0e9DU2nczi2MXdwLQ/JYblHyQtYgJwKNSTSku+
    F6wvVzfhBRHxy/UMdKlDZ67mene118ZxVz+q0q6cGoIA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXoUdFJP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXoUdFJP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeBGU4f (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 15:56:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43059 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754127AbeBGU4e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 15:56:34 -0500
X-ME-Sender: <xms:AWh7Wu4Gvef1mAyOTAmnxtJkd3yUhSu663U0Ed8tpdU5in57qZ0xpQ>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen: Fix {set,clear}_foreign_p2m_mapping on autotranslating guests
Date: Wed,  7 Feb 2018 21:47:40 +0100
Message-Id: <20180207204740.518-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 82616f9599a7 ("xen: remove tests for pvh mode in pure pv paths")
removed the check for autotranslation from {set,clear}_foreign_p2m_mapping
but those are called by grant-table.c also on PVH/HVM guests.

Cc: <stable@vger.kernel.org> # 4.14
Fixes: 82616f9599a7 ("xen: remove tests for pvh mode in pure pv paths")
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/p2m.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 13b4f19b9131..159a897151d6 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -694,6 +694,9 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 	int i, ret = 0;
 	pte_t *pte;
 
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return 0;
+
 	if (kmap_ops) {
 		ret = HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,
 						kmap_ops, count);
@@ -736,6 +739,9 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
 {
 	int i, ret = 0;
 
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return 0;
+
 	for (i = 0; i < count; i++) {
 		unsigned long mfn = __pfn_to_mfn(page_to_pfn(pages[i]));
 		unsigned long pfn = page_to_pfn(pages[i]);
-- 
2.15.1
