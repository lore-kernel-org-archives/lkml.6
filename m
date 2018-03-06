Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520295979-2-6917156912615205889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520295978; b=pZXMCPW4Es+wYol+jkZOZcIubKaus+M0vqN3OfwDDBKUI0C
    m1UUzqSdr2x686siA4l0fOizKabn5tayV13cjRgn8IfvzeVCt3gBC5Op6pJtSfNw
    MRxAVDAmE0On1upPpIpGXgg/YU5IAkV4ju1yjqgAPcoL6OXOUNhVnaP+oeZUaqKe
    thkbqgjodLlrsGYf0LYBlikoD1d0RW4Hq+Xt+TD5btNrbCtPrkFFAeiLEI6ETV2l
    bpOGL8VIC4R5CgJiB42rEb54OtZkLvGyEr6Td3QokwiIKLBNRQ1s0CjRyS6qXTYO
    ppT0XYnfK4z2sqiIInNfC3bJG/QfwjswVAOAQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520295978;
    bh=eqvTvsgMmpe8Dtlc+KxCIy9Xpc3R8OZAuIuNHF8ZsnU=; b=euF3XI1MIv0H
    LbmD9Pm/GjaNRGXjOeSG5KQfBdxDKlGdo4vwAEL7TXPVHeNVLLZgg7lSQAbATUm7
    vGO6aN41WrEP+hultHE93STv7dpaDbouE+8+wnCgcD3ZdJ2z14fIQ5OkBT9gMAOT
    2RJP/bbxV1jBsTxDE2ICW9ualHoqblVgtVG7bbudiF7/Pj9PSj1mc2uHrL/95mJP
    7o2MXCBhVqBEBiTOvlT0h96Xl41Q4TEUkFb17GFwEJqZvGPRQuyxyyvu4qUt0OWj
    3s43rNnv3DGmp8GdBlJHqDVgnFCLxFudOGe3KocHfGTOezAXNesQjuymochbXZDR
    wyDIS84FoQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BO6OmoWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BO6OmoWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeCFA0R (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34802 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbeCFA0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:14 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 13/65] x86/vm86/32: Switch to flush_tlb_mm_range() in mark_screen_rdonly()
Date: Mon,  5 Mar 2018 19:24:46 -0500
Message-Id: <20180306002538.1761-14-pasha.tatashin@oracle.com>
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

From: Andy Lutomirski <luto@kernel.org>

commit 9ccee2373f0658f234727700e619df097ba57023 upstream.

mark_screen_rdonly() is the last remaining caller of flush_tlb().
flush_tlb_mm_range() is potentially faster and isn't obsolete.

Compile-tested only because I don't know whether software that uses
this mechanism even exists.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/791a644076fc3577ba7f7b7cafd643cc089baa7d.1492844372.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 6ce9d1e6819e53c4de0bf980555c4e07bbedb4ce)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/vm86_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index fc9db6ef2a95..e0ae0a8ad5bd 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -194,7 +194,7 @@ static void mark_screen_rdonly(struct mm_struct *mm)
 	pte_unmap_unlock(pte, ptl);
 out:
 	up_write(&mm->mmap_sem);
-	flush_tlb();
+	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, 0UL);
 }
 
 
-- 
2.16.2
