Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1587535-1526340910-2-15706278134435369713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340910; b=RFvMqoPK/lvVVSOm9JKGpB3wKcNphIHyRpMUa86YyMNvykZ+Ps
    YjuA78fW4sSFAg3o3FRfHNeqnylsCHFk+wNexJigE/0uBkUd4bp4TECkWq+7JgZi
    jGcOVLepbOJbweFFPq/IuA69aC3orj1KC/aZnQyOUL4n5a3qn5XTiu4I3y+nnAmF
    t0MtqDJkn9rCZRuPNA5Ws8BBj+Y7BPXZbV1ZnQXgm8X4PdWC6hYtClFH3ViY+qO2
    Vlv3yMBYQHlHraG8iPURdi6zbFQWVY9VA088Ru7Y9ouNK0uAlKSmgnYNU0FWxnTm
    JSDc5vQ7i9/SVrxwR8E5Hyx6ZpVmlyjvLb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526340910; bh=n
    6aalV8J+RiCfSj5Oe1RoOabpp0e2SoJCjYoAbLFM/M=; b=GR/zrcL1OwKfbzLMK
    ZrhMq3LfNKr/N86poecE6bL56FDrF29K4Obs/w9qfJpCIx/XVDWfGNs5EiV5N7gP
    6CG3f36M6svEUfXJpQSjTPtXLChDoHv5l5u9cs3KsvYIGDfA86KqfXoqN6RkmPe1
    wHEatNXiSiSXNU5/lr0lTvZ995R3HSGS6Gknbs0LNQQxB15KYqCoK+xi1qqB4iwU
    22lJnqTWje6ZiiMr/1REzVSEYCxptCrmh84fQM/QC0vEy/kYHi+0/U3m43RM1Evu
    k9Oxy4RUBn4YnuTp9LEF/GYZJkZUHp4cE4Kv0lQXWuiSbtPNBZW47LLyJ0yLbiF1
    WsfFA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnanbsHaCyncByYGcwKBD26aLXcQ40DkuORDWmwkMWEjBHGywUTa4uNWIQ6kvpUZSOtX9Jk9dismAIKvU5eP61PGuX4QJjMbkiwGNHBKe8sxnAt3ofG
    zz88NB1m/szy2JsmW+x63dr/zm/lnZV3sAOY7bh1xwgVFz0rOJAebrRUcIy6FscnvgyRe4OPUuMOdsCEUildqwtg6eCxxtXwILMRpuiXp49luqAGlzIzw0AB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=iP-xVBlJAAAA:8 a=20KFwNOVAAAA:8 a=yyJd0-ZHAAAA:8 a=VnNF1IyMAAAA:8
    a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8 a=w2VRsR6FWOquW7kR1P0A:9
    a=QgL9FckVMaP4exBr:21 a=JaaHwHigVM-Pdd7u:21 a=lHLH-nfn2y1bM_0xSXwp:22
    a=tZ66tqNesld6_HzJrOHp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeENXfG (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:35:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752458AbeENXce (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:34 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 13/19] tools/memory-model: Improve comments in lock.cat
Date: Mon, 14 May 2018 16:33:51 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0008-0000-0000-000003076DBE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811514;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0009-0000-0000-0000394010ED
Message-Id: <1526340837-12222-13-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140230
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

This patch improves the comments in tools/memory-model/lock.cat.  In
addition to making the text more uniform and removing redundant
comments, it adds a description of all the possible locking events
that herd can generate.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Akira Yokosawa <akiyks@gmail.com>
CC: Andrea Parri <andrea.parri@amarulasolutions.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: David Howells <dhowells@redhat.com>
CC: Jade Alglave <j.alglave@ucl.ac.uk>
CC: Luc Maranget <luc.maranget@inria.fr>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/lock.cat | 51 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 1f6d67e79065..df74de2148f6 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -4,15 +4,35 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>
  *)
 
-(* Generate coherence orders and handle lock operations *)
 (*
- * Warning, crashes with herd7 versions strictly before 7.48.
- * spin_islocked is functional from version 7.49.
+ * Generate coherence orders and handle lock operations
  *
+ * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
+ * spin_is_locked() is functional from herd7 version 7.49.
  *)
+
 include "cross.cat"
 
-(* From lock reads to their partner lock writes *)
+(*
+ * The lock-related events generated by herd are as follows:
+ *
+ * LKR		Lock-Read: the read part of a spin_lock() or successful
+ *			spin_trylock() read-modify-write event pair
+ * LKW		Lock-Write: the write part of a spin_lock() or successful
+ *			spin_trylock() RMW event pair
+ * UL		Unlock: a spin_unlock() event
+ * LF		Lock-Fail: a failed spin_trylock() event
+ * RL		Read-Locked: a spin_is_locked() event which returns True
+ * RU		Read-Unlocked: a spin_is_locked() event which returns False
+ *
+ * LKR and LKW events always come paired, like all RMW event sequences.
+ *
+ * LKR, LF, RL, and RU are read events; LKR has Acquire ordering.
+ * LKW and UL are write events; UL has Release ordering.
+ * LKW, LF, RL, and RU have no ordering properties.
+ *)
+
+(* Link Lock-Reads to their RMW-partner Lock-Writes *)
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
 
@@ -29,18 +49,16 @@ flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
 (* This will be allowed if we implement spin_is_locked() *)
 flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
 
-(* There should be no R or W accesses to spinlocks *)
+(* There should be no ordinary R or W accesses to spinlocks *)
 let ALL-LOCKS = LKR | LKW | UL | LF
 flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
-(*
- * Backward compatibility
- *)
-let RL = try RL with emptyset (* defined herd7 >= 7.49 *)
-let RU = try RU with emptyset (* defined herd7 >= 7.49 *)
+(* Backward compatibility *)
+let RL = try RL with emptyset
+let RU = try RU with emptyset
 
 (* Treat RL as a kind of LF: a read with no ordering properties *)
 let LF = LF | RL
@@ -55,7 +73,6 @@ let W = W | LKW
 let Release = Release | UL
 let Acquire = Acquire | LKR
 
-
 (* Match LKW events to their corresponding UL events *)
 let critical = ([LKW] ; po-loc ; [UL]) \ (po-loc ; [LKW | UL] ; po-loc)
 
@@ -65,7 +82,6 @@ flag ~empty UL \ range(critical) as unmatched-unlock
 let UNMATCHED-LKW = LKW \ domain(critical)
 empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
 
-
 (* rfi for LF events: link each LKW to the LF events in its critical section *)
 let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
 
@@ -86,18 +102,23 @@ let all-possible-rfe-lf =
 with rfe-lf from cross(all-possible-rfe-lf)
 let rf-lf = rfe-lf | rfi-lf
 
-(* Read from unlock, ie islocked returning false, slightly different *)
+(*
+ * RU, i.e., spin_is_locked() returning False, is slightly different.
+ * We rely on the memory model to rule out cases where spin_is_locked()
+ * within one of the lock's critical sections returns False.
+ *)
 
-(* islocked returning false can read from the last po-previous unlock *)
+(* rfi for RU events: an RU may read from the last po-previous UL *)
 let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
 
-(* any islocked returning false can read from any external unlock *)
+(* rfe for RU events: an RU may read from an external UL or the initial write *)
 let all-possible-rfe-ru =
    let possible-rfe-ru r =
      let pair-to-relation p = p ++ 0
      in map pair-to-relation (((UL|IW) * {r}) & loc & ext)
   in map possible-rfe-ru RU
 
+(* Generate all rf relations for RU events *)
 with rfe-ru from cross(all-possible-rfe-ru)
 let rf-ru = rfe-ru | rfi-ru
 
-- 
2.5.2
