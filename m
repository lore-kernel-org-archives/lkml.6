Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520295988-2-7320164239271248940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520295987; b=C+e4arChMfb/PTXgkNgGEz9oAprB2h0ymJlDUral8O6GINV
    lVxHRWrgySRxR6dWAznzVZJY4ACjjI1wruYehRpRwJ/N/Hs57dLpU85mYvre/o/3
    srgpzEBitds0RYYhIHN1sD+Qv5+7wpMeB4AZY0/DrsF7dbeS/VM4rar3/wNNjBTm
    kifLSnW/WP9Pplqkvfmghag6U9UdnHZty0uaOb2Efu3te7M6vq1iL9Bo4Wjtazep
    Q6mgg5veAGA75BXm6RGqczFKfLjX+7DimOMuDu6CfAUeYAGtSqA7v9X8G4Ejuvwm
    /2ERParbmxW8q8DWgAi0WB/zh1QJi9lJM74J+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520295987;
    bh=bflzpeXFpNqWHPyV3zPVoIV2aLKx8l09W8kggEjg3tU=; b=iCja8wWOxsun
    6fXNzz7WwLPt/ga82i+mgCzzfpr14kwJN6HL1tfK+wT7DGUiPr88rdGzVrj15Xkr
    L0Jixuj79gUl1eomlIAOtOUoGNEO5LcLJhwYUkM4e7myns6X54jyohosr7Qw4Wnc
    gC3MkH3GILLFrNzROreHmdcmtDmLu1umnnOx/a2uPHnHx8Fmrox66pmIjmlgAWyt
    GvDF8R2i9cC1PuOEhJ1ql7T4UzQkS5NYgdDoAQIhpMTfBP2zHUA1ythI3j4F2ev4
    nwOBPq2dqU25in9sT09F5+Qu5v8c1N1eocnYvFTYDZr24NYoZiK1nEk5836GEKlh
    DohJHXdqSg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=idxSpNcV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=idxSpNcV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933127AbeCFA0X (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34868 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933101AbeCFA0V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:21 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 21/65] x86/mm/64: Fix reboot interaction with CR4.PCIDE
Date: Mon,  5 Mar 2018 19:24:54 -0500
Message-Id: <20180306002538.1761-22-pasha.tatashin@oracle.com>
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

commit 924c6b900cfdf376b07bccfd80e62b21914f8a5a upstream.

Trying to reboot via real mode fails with PCID on: long mode cannot
be exited while CR4.PCIDE is set.  (No, I have no idea why, but the
SDM and actual CPUs are in agreement here.)  The result is a GPF and
a hang instead of a reboot.

I didn't catch this in testing because neither my computer nor my VM
reboots this way.  I can trigger it with reboot=bios, though.

Fixes: 660da7c9228f ("x86/mm: Enable CR4.PCIDE on supported systems")
Reported-and-tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/f1e7d965998018450a7a70c2823873686a8b21c0.1507524746.git.luto@kernel.org
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(cherry picked from commit 6c4db09c291a19da66512f99c4bcb378a862f9e6)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0549ae3cb332..d9ea27ec9dbd 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -93,6 +93,10 @@ void __noreturn machine_real_restart(unsigned int type)
 	load_cr3(initial_page_table);
 #else
 	write_cr3(real_mode_header->trampoline_pgd);
+
+	/* Exiting long mode will fail if CR4.PCIDE is set. */
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr4_clear_bits(X86_CR4_PCIDE);
 #endif
 
 	/* Jump to the identity-mapped low memory code */
-- 
2.16.2
