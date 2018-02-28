Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838838-2-8701672690319037059
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
    t=1519838838; b=YK+7oOuEpa8NH0CAljqnGsj6CdYpCdQFnuRE926uEqUawNZ
    vDMR271gF5ZqME1fCxMZujZMQD9fTSGHzKBLZkS5DUtpPHrhQ2rElMODlfLw3wuH
    hiOzDMqGAfYZ3QVF2uuufj9auU3qtSrW+edSpjF3JqqiqQslzYLkHAoQoQyFTImi
    OGIadK5FbaPunteHYT9r/W7y8XA7arn0OvcT4iID2dahk1bE4ZqBe2Z3KU/XZwBl
    ge7mL4gFzZE0CYsgOA3QuUUyUKWgduTl+ong4HusfOCHeFkW++ewKHtdOkv8GDu5
    RVBYJS9tCNE7wQhyPGyvA7IZqoGtYVyZude5UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838838; bh=FZHj/2bFspll1XA9pvN
    wzuNPHgIdNifVT+zHCJAaWdk=; b=TgGPhGSXlmLo1bIVnR7cjc7o7iJVD2T9Ayb
    CoAMbZobFQA2suuQHHhMfowvdXIThi2zjx1ipJvC/4K5UmX4pLR2yZSGn6DTLCg2
    03tkG7D6JPq6v7heZyyeaBVmgCv4gKUl/H78TDqNZqAtsxKumW4/F8J+akCPzH42
    HtdD+5nKmzobAogevCbOst4BuW1JvtL46V7ctaLL7nTXF6kRng/RrA4D8jGoTt1i
    M5XIrGVLb8GtjRfv9xPvtEtpzG9RIAi32iE+WFn4BWlYFf/wlGwSxaNO3mhH6kTI
    VCffy3pDcpcY7ehx1CJ3l/2lZFYQ9qBhO84xYxEzKJXrYOnXSeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbeB1RZI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:25:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33284 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932612AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michal Hocko" <mhocko@suse.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Anshuman Khandual" <khandual@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.830079042@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 082/140] mm/mprotect: add a cond_resched() inside
 change_pmd_range()
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mprotect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -92,13 +92,15 @@ static inline void change_pmd_range(stru
 			if (next - addr != HPAGE_PMD_SIZE)
 				split_huge_page_pmd(vma->vm_mm, pmd);
 			else if (change_huge_pmd(vma, pmd, addr, newprot))
-				continue;
+				goto next;
 			/* fall through */
 		}
 		if (pmd_none_or_clear_bad(pmd))
-			continue;
+			goto next;
 		change_pte_range(vma->vm_mm, pmd, addr, next, newprot,
 				 dirty_accountable);
+next:
+		cond_resched();
 	} while (pmd++, addr = next, addr != end);
 }
 
