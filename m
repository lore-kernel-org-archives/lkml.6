Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1587535-1526340890-2-4850924176467215222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340890; b=h5BJSNzccudCjXhx9M+YqZVgUoMVfHl5N6lgELDTx3gH0yMmdm
    Ux4OV3fBvXfhUu1TMl8XDGz07kKAtNs2BBMiO9AAwTbG0Lj7VueehEOcZHOSN1ek
    QwgA+iijBUXh+0/citGq6c8NojVUKkDfXpMlc3M18KHgzohyaxhcDfWV/PoqzViv
    ER/FMjvhB4lO6k+44BnkOJhS+lIX6kXDBg19IuzbnrNBBtgPcjiFbkyqfkwUu/F/
    dxMqcx1Fes0HnxuUDgGjHht9xwXRtCJWqcEsFtr1u5xFd4/RsSzOENhqzEdtrCZn
    WJ5Me7AMvR9ZwA4b7GwT8MsNGxbdxfbbbrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:mime-version:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1526340890; bh=Kd9DcNpVNurz
    4PQaYcjaNODYshXAkxegN7IxU6PGWm4=; b=DUR0oZlZcYABVeyZ1KiBbhsv4OAa
    bBeEOgGtvk4e7OSdIi2V8OoAjGYuwCOr5I5yeD/dr7e5O56ttDwxVxhvm9Z31QMz
    oqqMN0imJlJHWwEMhwkVZdjnTG0PZ0Scf/McmyZoGQUNiBcuZm07DJ5vCh/RddHK
    lrjJhIc/zWtgL2bv7UNMpwbQUGSmoxWkwyTXqBrLeqfFcHtbpqGeUGjieOfuQ8n+
    L8c4mXTWY8HEbuuOwnnotPYMGaUPO8uQnYlU5uswU208AvMsE91xy3lkJGOikGYH
    iptwPFjHP8i7jgWzdu4PvptIDzPDeboPeKeq30Xjxt6zpcGYjWBcfZvI9A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfE8Y1t6xzq366cZaTrKcqA8S4FlIPFIRmhr1PHVC+N26byzpaISK3QTNzuB3nyem1fou/eH45accodlS8pmQRJCydzLh38ocZIolTKKOpQAmrdJ2Q4Ru
    Kl+ZdAW9w+q2OpweUyMff6cfvfjOH8OwRgFep5JIvIiex7+NjQ2PHPQDHCPGXRXBr2LaZa5JePYz0DUpfEDWRTOxhpAWm3bd64pgaYJWh1Q8IA8pyQ+f3J2+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iP-xVBlJAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=yyJd0-ZHAAAA:8 a=VnNF1IyMAAAA:8 a=ZOzjf2MOAAAA:8
    a=Q4tLxrQX0-Gmlr7mPIUA:9 a=QEXdDO2ut3YA:10 a=lHLH-nfn2y1bM_0xSXwp:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=tZ66tqNesld6_HzJrOHp:22
    a=1Mhi-5-LkjG4w5oc0yAU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeENXes (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:34:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752380AbeENXce (ORCPT
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
Subject: [PATCH memory-model 18/19] tools/memory-model: Update ASPLOS information
Date: Mon, 14 May 2018 16:33:56 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051423-2213-0000-0000-000002A53F85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811515;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-2214-0000-0000-00005A1EAED1
Message-Id: <1526340837-12222-18-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Andrea Parri <andrea.parri@amarulasolutions.com>

ASPLOS 2018 was held in March: make sure this is reflected in
header comments and references.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/references.txt | 11 ++++++-----
 tools/memory-model/linux-kernel.bell            |  4 ++--
 tools/memory-model/linux-kernel.cat             |  4 ++--
 tools/memory-model/linux-kernel.def             |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index ba2e34c2ec3f..74f448f2616a 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -67,11 +67,12 @@ o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 Linux-kernel memory model
 =========================
 
-o	Andrea Parri, Alan Stern, Luc Maranget, Paul E. McKenney,
-	and Jade Alglave.  2017. "A formal model of
-	Linux-kernel memory ordering - companion webpage".
-	http://moscova.inria.fr/∼maranget/cats7/linux/. (2017). [Online;
-	accessed 30-January-2017].
+o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+	Alan Stern.  2018. "Frightening small children and disconcerting
+	grown-ups: Concurrency in the Linux kernel". In Proceedings of
+	the 23rd International Conference on Architectural Support for
+	Programming Languages and Operating Systems (ASPLOS 2018). ACM,
+	New York, NY, USA, 405-418.  Webpage: http://diy.inria.fr/linux/.
 
 o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 1)"
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 432c7cf71b23..64f5740e0e75 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
  *                    Andrea Parri <parri.andrea@gmail.com>
  *
- * An earlier version of this file appears in the companion webpage for
+ * An earlier version of this file appeared in the companion webpage for
  * "Frightening small children and disconcerting grown-ups: Concurrency
  * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
- * which is to appear in ASPLOS 2018.
+ * which appeared in ASPLOS 2018.
  *)
 
 "Linux-kernel memory consistency model"
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 1e5c4653dd12..59b5cbe6b624 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
  *                    Andrea Parri <parri.andrea@gmail.com>
  *
- * An earlier version of this file appears in the companion webpage for
+ * An earlier version of this file appeared in the companion webpage for
  * "Frightening small children and disconcerting grown-ups: Concurrency
  * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
- * which is to appear in ASPLOS 2018.
+ * which appeared in ASPLOS 2018.
  *)
 
 "Linux-kernel memory consistency model"
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index f0553bd37c08..6fa3eb28d40b 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
-// An earlier version of this file appears in the companion webpage for
+// An earlier version of this file appeared in the companion webpage for
 // "Frightening small children and disconcerting grown-ups: Concurrency
 // in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
-// which is to appear in ASPLOS 2018.
+// which appeared in ASPLOS 2018.
 
 // ONCE
 READ_ONCE(X) __load{once}(X)
-- 
2.5.2
