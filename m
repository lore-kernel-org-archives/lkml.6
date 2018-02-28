Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834300-2-16682651957439838247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834299; b=nuBwbUeAea0F3bnDX/ovV6F6ZeGx+mzVAY0y7Xr/rel33VB
    rx+QEpxT60fpFbli7jOCURWg21fZj4Vc6yfNH8hTgBFRC5Xo8cQ/h2m2Z6tMCh9t
    c5l5Znl2V8BA6eIqHe26YlVxSm+505pL6H3e+CiQxUyINoTHZGpu8pUuXpZWxZNg
    x/2YM00SK8c0djmPbodH/d9nNMq4JzDzEAATu9pHVN2L8VHReq+lYqE2k94hvSX3
    053CTzVlFcGxTTsx557XAAw/ZCuPFg6fiBsjm/W9rJwBK0qn20Uf15XKLS8X5XaK
    TUzsTwGSjlhT1ay6bDBEwFkZAWHcrGrt7n6EPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834299; bh=qLMynzppgZVieDT6P3M
    NMaJzQlZYmpJ4HmWfVY/R7aU=; b=teOnpc3TZQaQmEuVcOuQ8fRGEpJRwMoK5e8
    el78bWTiIE/Bww55HT/aliSblhoYhoOPDGPbbJN8yf3gPyTy8KxpWcifcpEECSvz
    Mn4rsRECeQ2Y4NE9J8uYLcpGi/NDGBz9o4Oh/5Z3eoVHKrCAw3us5oTsm3S9VPhc
    bMg5lkWH6RCXiSzFAZ6x43CcICN8SzdDpwdZtm0PLBdctqldLjYKY16TvrNu3QB1
    yQ9EM4mJTWgVZVwnJqAdP/xU6Ala36A3HZwLRgsgFa/WD87CIC3kZHRlRXJ4NXeR
    ckfHTWQSefdPa9YxLfMBt7zW1J0KPfDtipI+F6mGD3CYf+SWGkA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeB1QIc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:08:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34953 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934474AbeB1QI3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:29 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Anshuman Khandual" <khandual@linux.vnet.ibm.com>,
        "Michal Hocko" <mhocko@suse.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.490346858@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 170/254] mm/mprotect: add a cond_resched() inside
 change_pmd_range()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

commit 4991c09c7c812dba13ea9be79a68b4565bb1fa4e upstream.

While testing on a large CPU system, detected the following RCU stall
many times over the span of the workload.  This problem is solved by
adding a cond_resched() in the change_pmd_range() function.

  INFO: rcu_sched detected stalls on CPUs/tasks:
   154-....: (670 ticks this GP) idle=022/140000000000000/0 softirq=2825/2825 fqs=612
   (detected by 955, t=6002 jiffies, g=4486, c=4485, q=90864)
  Sending NMI from CPU 955 to CPUs 154:
  NMI backtrace for cpu 154
  CPU: 154 PID: 147071 Comm: workload Not tainted 4.15.0-rc3+ #3
  NIP:  c0000000000b3f64 LR: c0000000000b33d4 CTR: 000000000000aa18
  REGS: 00000000a4b0fb44 TRAP: 0501   Not tainted  (4.15.0-rc3+)
  MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22422082  XER: 00000000
  CFAR: 00000000006cf8f0 SOFTE: 1
  GPR00: 0010000000000000 c00003ef9b1cb8c0 c0000000010cc600 0000000000000000
  GPR04: 8e0000018c32b200 40017b3858fd6e00 8e0000018c32b208 40017b3858fd6e00
  GPR08: 8e0000018c32b210 40017b3858fd6e00 8e0000018c32b218 40017b3858fd6e00
  GPR12: ffffffffffffffff c00000000fb25100
  NIP [c0000000000b3f64] plpar_hcall9+0x44/0x7c
  LR [c0000000000b33d4] pSeries_lpar_flush_hash_range+0x384/0x420
  Call Trace:
    flush_hash_range+0x48/0x100
    __flush_tlb_pending+0x44/0xd0
    hpte_need_flush+0x408/0x470
    change_protection_range+0xaac/0xf10
    change_prot_numa+0x30/0xb0
    task_numa_work+0x2d0/0x3e0
    task_work_run+0x130/0x190
    do_notify_resume+0x118/0x120
    ret_from_except_lite+0x70/0x74
  Instruction dump:
  60000000 f8810028 7ca42b78 7cc53378 7ce63b78 7d074378 7d284b78 7d495378
  e9410060 e9610068 e9810070 44000022 <7d806378> e9810028 f88c0000 f8ac0008

Link: http://lkml.kernel.org/r/20171214140551.5794-1-khandual@linux.vnet.ibm.com
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mprotect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -152,7 +152,7 @@ static inline unsigned long change_pmd_r
 
 		next = pmd_addr_end(addr, end);
 		if (!pmd_trans_huge(*pmd) && pmd_none_or_clear_bad(pmd))
-			continue;
+			goto next;
 
 		/* invoke the mmu notifier if the pmd is populated */
 		if (!mni_start) {
@@ -174,7 +174,7 @@ static inline unsigned long change_pmd_r
 					}
 
 					/* huge pmd was handled */
-					continue;
+					goto next;
 				}
 			}
 			/* fall through, the trans huge pmd just split */
@@ -182,6 +182,8 @@ static inline unsigned long change_pmd_r
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
 				 dirty_accountable, prot_numa);
 		pages += this_pages;
+next:
+		cond_resched();
 	} while (pmd++, addr = next, addr != end);
 
 	if (mni_start)
