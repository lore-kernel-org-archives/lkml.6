Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1587535-1526340911-2-11933644265146445564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340911; b=Wved3n98U5jQ+s8Th8rcuOkaZJ/0W51eLzC3qQNTcyAmiLJ6Ds
    +3J/NOh7JCapuaJM5d3xnlJImtX6b+aAa5DXjjO/UTBBwFCZRFw9wsEgYXFYH41G
    2wUxcNZXYmNGuaEhyjAd527CM80frd5HGRGpn2q7JR0Tz4FOX5JJi6G9nxQIS/F2
    8PlQb7chT/IUcm8r77y+3WNoExrILOymNb0cRCA+s6Q9JqPM0Hs7QU8vrVeKde7N
    Sa+YPBnPuBdw+YPFsTScGr7dWt99+nQ3anHSr1JTHYAkEa6O9D1YOsVEInLYPhbr
    TN2B/brVf9coysUnV8oEM5bdI1yzHnWKkGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526340911; bh=J
    4ncGLaSaZ1vpsqEtYqH0lKAx0V9kAiAQ1COWaT/9/I=; b=JiuMKVDX8bmptI0Lz
    8yHY6xR45PSzBB1xR9jRUXWzOmC0lk+706JouvjisplcQTz6DzTvQeiTcHl9q7TH
    D/vcNd6dxvdl/Hbgy2RLF8PhPAYJRh+ZP/w9phhYAMxPCp5LzVg1XWKstvi0keTH
    oPiIZRqElBKd9t0rOSz1A7m0PEpOBhZIX1Rxv+tCc48d4Hem2tY9NbHNr0hvoBG9
    1Rk2ZNpVBa7W1Pf/cxRNhHq69LnmtJjXI55F8QtcHscfpDu4qqBmjtki0QWkBbRH
    2RD/tHDRwxZbGvarcKT/hHkiQSw0ezM4IIu8GPIktcTbqp6j6BFij9OlCS1AbiuR
    cb4iw==
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
X-CM-Envelope: MS4wfGc61JDLq9pXBJazuKGJWqCt3m73X+VSHsPxrgX6aJXvIQJaKS29/qGmsMp10JjYiHcMrpFaAy4qcBXOYwcLWNQnmflsokvlW+oKAmqPJodeYTEra+rz
    /UdoPomWNrITm0iJJIe5abwy9mtSp3f5QE0h8/6MCBkUtHCcelp8lvzu87rY9l7rz7OybM8LcojHjQX7YZK/W1QjWHjVsYyFvgHQe7r5vZTSOgE2SvPs+dzF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=iP-xVBlJAAAA:8 a=20KFwNOVAAAA:8 a=yyJd0-ZHAAAA:8 a=VnNF1IyMAAAA:8
    a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8 a=oXiNDDYW58o3JmKJRWEA:9
    a=gBxkMI0cu84t9vag:21 a=kxon2zltULUilFhL:21 a=lHLH-nfn2y1bM_0xSXwp:22
    a=tZ66tqNesld6_HzJrOHp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeENXfI (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:35:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752452AbeENXce (ORCPT
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
Subject: [PATCH memory-model 14/19] tools/memory-model: Improve mixed-access checking in lock.cat
Date: Mon, 14 May 2018 16:33:52 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0036-0000-0000-000002F4AC87
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811515;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0037-0000-0000-00004455DC15
Message-Id: <1526340837-12222-14-git-send-email-paulmck@linux.vnet.ibm.com>
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

The code in lock.cat which checks for normal read/write accesses to
spinlock variables doesn't take into account the newly added RL and RU
events.  Add them into the test, and move the resulting code up near
the start of the file, since a violation would indicate a pretty
severe conceptual error in a litmus test.

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
 tools/memory-model/lock.cat | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index df74de2148f6..7217cd4941a4 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -32,6 +32,17 @@ include "cross.cat"
  * LKW, LF, RL, and RU have no ordering properties.
  *)
 
+(* Backward compatibility *)
+let RL = try RL with emptyset
+let RU = try RU with emptyset
+
+(* Treat RL as a kind of LF: a read with no ordering properties *)
+let LF = LF | RL
+
+(* There should be no ordinary R or W accesses to spinlocks *)
+let ALL-LOCKS = LKR | LKW | UL | LF | RU
+flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
+
 (* Link Lock-Reads to their RMW-partner Lock-Writes *)
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
@@ -49,20 +60,9 @@ flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
 (* This will be allowed if we implement spin_is_locked() *)
 flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
 
-(* There should be no ordinary R or W accesses to spinlocks *)
-let ALL-LOCKS = LKR | LKW | UL | LF
-flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
-
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
-(* Backward compatibility *)
-let RL = try RL with emptyset
-let RU = try RU with emptyset
-
-(* Treat RL as a kind of LF: a read with no ordering properties *)
-let LF = LF | RL
-
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
-- 
2.5.2
