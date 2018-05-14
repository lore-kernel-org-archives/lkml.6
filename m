Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572352-1526338813-2-17776225425000775907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338812; b=kZezaL+tzMizFQsGtmSWJiwTqWQ/HdyDVTgFFpr/VxBek7Y5ll
    t0g5G5+F1T+rpwqtWuamgHci60rST5s1/ylflj95PFycbFxNEkazo4s2O73nuO8k
    D+XE7BPB5IA3ky1kOuVc7ngBoOCMwHk5U3yHTUuFntu+maxDVcWIxQcwk7e6mQol
    q5PDcrm3a/FsHrggPe2qHRwa2lJ8OnwCE7DF72D4XDo6KOG5n6MWn0BG4ASUVNOb
    4uAkoJxloAFgyLF2LKAKfXn6kTT6DjuP1i6szszIQbcMiXBe1IyMRuO/fgim3+ZL
    UKQWwCH6Mgbxbtpdni/51peWWUJl/9fBJPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526338812; bh=k
    sgOXzgOwwc+fMIZ2PTZMS5Sb14H4sV2KwtmnJ2zaw8=; b=h6JBeQtLVu3Qz5pqD
    pUq36jUXa6bjVEbqsOA9WEgWnTir3HP9mbpCAFNuJNYkRar6Mv7gvi3UsKLBk0Zw
    OIRp+yWnM2xczrOva0wMk82J27O4R5bwB/mvl+YClguVk+MRrEtEVVeA90b0FPFN
    MAG/to7fukwQnJHKpe+yHw6XcPeAauF4Hd2f44mmxhhMvGjF75h6yGj077ddHyoT
    +/WwOvNJyxc/O8ihVpVE7pNrrs/LjgUrkg4aG+H1wzxIdIUn28/jyLsdrVhWBkS2
    GFzq/nbgLtOjoMjYvG/z+fYw0dgrvxvU4r4Za4JNJB9j8jrlhSn8X2gW/aoWWll7
    hCzbQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfEA1uhRpYc8k5qKatBZknHAukdHhY5eLr4LjqPQtywCIuqkXlbNoeYWHYfC9RUlNy6V+hnNJ4g9msfaZtlfRu7b5F14fqb3gpAG6IkP+m/pCFQ7fXu8J
    AEefOHqTPtLTaqKp+qMUrq8LhbyCugaYCSBzKNS+TXaDbOnfRq/t4YEoNG0ir5iCTj5zlTeS9LCUS7FGgWEImD7aMQdhhoWc9TCJD46IZEi3q5hhKKVDm7lT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=iP-xVBlJAAAA:8
    a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8
    a=Z4Rwk6OoAAAA:8 a=irODzuy0CcWcdx3xG2UA:9 a=lHLH-nfn2y1bM_0xSXwp:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeENXAJ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:00:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752378AbeENXAH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:00:07 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH memory-model 3/3] locking: Clean up comment and #ifndef for {,queued_}spin_is_locked()
Date: Mon, 14 May 2018 16:01:29 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514230105.GA6421@linux.vnet.ibm.com>
References: <20180514230105.GA6421@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0008-0000-0000-000003076B87
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032372; UDB=6.00527777; IPR=6.00811504;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:00:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0009-0000-0000-0000393FFE44
Message-Id: <1526338889-7003-3-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140227
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Removes "#ifndef queued_spin_is_locked" from the generic code: this is
unused and it's reasonable to conclude that it will continue to be unused.

Also removes the comment about spin_is_locked() from mutex_is_locked():
the comment remains valid but not particularly useful.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/asm-generic/qspinlock.h | 2 --
 include/linux/mutex.h           | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index b37b4ad7eb94..dc4e4ac4937e 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -26,7 +26,6 @@
  * @lock: Pointer to queued spinlock structure
  * Return: 1 if it is locked, 0 otherwise
  */
-#ifndef queued_spin_is_locked
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
@@ -35,7 +34,6 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 	 */
 	return atomic_read(&lock->val);
 }
-#endif
 
 /**
  * queued_spin_value_unlocked - is the spinlock structure unlocked?
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 14bc0d5d0ee5..3093dd162424 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -146,9 +146,6 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 static inline bool mutex_is_locked(struct mutex *lock)
 {
-	/*
-	 * XXX think about spin_is_locked
-	 */
 	return __mutex_owner(lock) != NULL;
 }
 
-- 
2.5.2
