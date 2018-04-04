Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3600301-1522826723-2-15549399521541542175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522826722; b=hxPkn81oF7rquN8mTgYzn1QNxOj4r5qje/ItoWCPL0Si1SPFBm
    lvk9bS0yrOQ0gfVKZfZT/xoia0z2I9hgFtagJZxKostUvkDTM3RkTXz2YScK6iip
    bTgx//k0drnxGW8Usy8s1ufuXsW5+MofGYvq4EVk6Ug75nLF0iGlBI4QVjJ9fSyH
    FypqzKt7z4r/AdEOh0QfT4K94PoQgu9HcjVLvEDoHkrqLI8xR97VIYt0dE6Z+QK1
    byD2CSHx3JRdA9xyC4a5bOUfOhdUXR80rmt7GPRO3bQFK4rqZx/mRLvIzfFgOEF0
    xzqsL95oUriu3EowN7GNmYEXxDzzOhvoCfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522826722; bh=
    Eu2NMGQPs2U3R1ooG6dDfpvl8KMV31KL3B8FyYDPh6M=; b=GTdZuzzXNH5w3UfJ
    9SGb+x3Qxdv8yYnvr4ppsJPWjCjnQq9mcOs67M4ORuRfnFZ/EbSKw9HOOpR40GtZ
    UU7ZMYnu+BsPD7Kbxe4fYJIjA708jjVsiC7glQOocHl4VTHgJ5wAmZEtG/yYDbjT
    GKHaY6/ET8tbaIX5sGlSqXN/iwt1e2npKJ8zJUrsCq1vhJqUOvgtPqQg2okDKRih
    M+cv7YmrpevBiL34c+AuWUd8I5Gdasq7Xv9hN+ejXGoKUphoZovFj90cZqo36n2S
    vUGLk/7ZnWtyiecNQi4fGBwhYcjiv/MY+GskUzy77tuLv+C+/YUXu2SPdhab8i4Y
    IoAsFQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAeIjbPKKWJau8ENBjlRDWs7K50m7t54xWwB465TTsNerAJ68ogns6m6Xb1Q+/36T2AMpSfK2ZixxZZhn9dZOCMfQVj4DnGrX332DJH6+WB28y2fNE3/
    22fwqYSVRVWWO7RXOJgHcFKgM1aUkco8zjsdD2mQOrVrcoZvX+OsGOmEKUBYbP0EtEYtn6o3WKBs8cnz43HcOJMdwmf4pH88ccA9lRN5WyziFRQRrg9HzYXR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=meVymXHHAAAA:8
    a=VwQbUJbxAAAA:8 a=8k6WQxmsAAAA:8 a=8cYThTpUtsaJvHBqLhIA:9
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbeDDHZV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 03:25:21 -0400
Received: from mail.monom.org ([188.138.9.77]:49772 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbeDDHZU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 03:25:20 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail.monom.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 6/7] Revert "memcontrol: Prevent scheduling while atomic in cgroup code"
Date: Wed,  4 Apr 2018 09:16:51 +0200
Message-Id: <20180404071652.24196-7-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The commit "memcontrol: Prevent scheduling while atomic in cgroup code"
fixed this issue:

       refill_stock()
          get_cpu_var()
          drain_stock()
             res_counter_uncharge()
                res_counter_uncharge_until()
                   spin_lock() <== boom

But commit 3e32cb2e0a12b ("mm: memcontrol: lockless page counters") replaced
the calls to res_counter_uncharge() in drain_stock() to the lockless
function page_counter_uncharge(). There is no more spin lock there and no
more reason to have that local lock.

Cc: <stable@vger.kernel.org>
Reported-by: Haiyang HY1 Tan <tanhy1@lenovo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: That upstream commit appeared in v3.19 and the patch in
  question in v3.18.7-rt2 and v3.18 seems still to be maintained. So I
  guess that v3.18 would need the locallocks that we are about to remove
  here. I am not sure if any earlier versions have the patch
  backported.
  The stable tag here is because Haiyang reported (and debugged) a crash
  in 4.4-RT with this patch applied (which has get_cpu_light() instead
  the locallocks it gained in v4.9-RT).
  https://lkml.kernel.org/r/05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com
]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 493b4986d5dc..56f67a15937b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1925,17 +1925,14 @@ static void drain_local_stock(struct work_struct *dummy)
  */
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock;
-	int cpu = get_cpu_light();
-
-	stock = &per_cpu(memcg_stock, cpu);
+	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
 
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-	put_cpu_light();
+	put_cpu_var(memcg_stock);
 }
 
 /*
-- 
2.14.3
