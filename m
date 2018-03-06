Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296092-2-6694346133003151014
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296091; b=Z4syFbeFuls2eKdFGMj+/Qrn8Vtz4KlHs9WEM1CtPN+5Hj9
    uRqhjksathUq9tws5O40ZvmsTpj3nVUKX7ezAlntCc6PrCPDmBFTz4lYJPh39fb2
    y7FC/ufyIJqZfWTRqpwymkkdxHGZrOUqRky7YlGRoJSmoqQzCzenUWLIgmhH0qQQ
    FoK3PJOsmxtu5NW4zkUlmyUa0mtd9ceJuGOg6Lz5zWlNE6bW7CII/MdEgIf1w15e
    gtoUAj92OozRLZ4QjyH0WnsgPhRTEaXyJ0uUkWzCdZCTetffgPqLzexg2w9X0lgX
    S7DYMuAISf7aomOEPiOHlr/9QC2nzDsl1MBzIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296091;
    bh=0cYr+0NPwIj5ilA6C0rxScjQVRMD5lMs+dR2smeb4ro=; b=I3CM2kv+0i5D
    mPbdmYR71CF+EXZLZk1HM/o8NXRbVDtdk+AXPYihWg+iLazi32TdkuhQOL3pjupr
    grpjdunOMpe/1IPOluEBDrUD9eSoYECEorBzrfcDzh0Bg/nKAJvEvgBJKFRZ6SCn
    VKYgHiqFoTZoIvkxWAw/zbMQy7KrEVsjSZzIaIb+/JKiEh+2DzqT/H7OVjbP86HH
    heHvyTMLy+d64qm3LZaQ5tyziyiISPDJZYDOjtgJGNbst1F1BvWREgEKXV4WfVjZ
    sZ+WEYboCqR+ByCvlP9CYrTzvHa2XmPhkL1ZR3nA0tlB3YDgfGS0333hTeV7kvC7
    HREYbO7aZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=fm8e5pkb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=fm8e5pkb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeCFA15 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:27:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35266 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeCFA1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 54/65] kaiser: drop is_atomic arg to kaiser_pagetable_walk()
Date: Mon,  5 Mar 2018 19:25:27 -0500
Message-Id: <20180306002538.1761-55-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

I have not observed a might_sleep() warning from setup_fixmap_gdt()'s
use of kaiser_add_mapping() in our tree (why not?), but like upstream
we have not provided a way for that to pass is_atomic true down to
kaiser_pagetable_walk(), and at startup it's far from a likely source
of trouble: so just delete the walk's is_atomic arg and might_sleep().

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 28c6de5441740f868a5b371804a0e8dde03757fb)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/mm/kaiser.c
---
 arch/x86/mm/kaiser.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index a8ce2e4737e0..c64bfef99ee8 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -108,19 +108,13 @@ static inline unsigned long get_pa_from_mapping(unsigned long vaddr)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static pte_t *kaiser_pagetable_walk(unsigned long address, bool is_atomic)
+static pte_t *kaiser_pagetable_walk(unsigned long address)
 {
 	pmd_t *pmd;
 	pud_t *pud;
 	pgd_t *pgd = native_get_shadow_pgd(pgd_offset_k(address));
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 
-	if (is_atomic) {
-		gfp &= ~GFP_KERNEL;
-		gfp |= __GFP_HIGH;
-	} else
-		might_sleep();
-
 	if (pgd_none(*pgd)) {
 		WARN_ONCE(1, "All shadow pgds should have been populated");
 		return NULL;
@@ -195,7 +189,7 @@ static int kaiser_add_user_map(const void *__start_addr, unsigned long size,
 			ret = -EIO;
 			break;
 		}
-		pte = kaiser_pagetable_walk(address, false);
+		pte = kaiser_pagetable_walk(address);
 		if (!pte) {
 			ret = -ENOMEM;
 			break;
-- 
2.16.2
