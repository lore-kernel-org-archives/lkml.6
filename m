Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572352-1526338808-2-982187987510741435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338808; b=imW3e67sZgof+u4ltaJNweZXbCXxQYgYP+RVzcxuiDMuUASbla
    8dtFGiw0Z1aqyYFYnWUPNIdrJDzJd23U9lTh08NYJW9vg9bi2axQRW6kI2o9ERg7
    bFO+amFYPaTEcv6VNJHGXv34L9EysEDh3mV/3d0bSPO5U66iWM38TW832WVdOvwM
    o6wmELuhIcDIwt32YCIy9ioajqFuRHsGKNtdPs2CA6lt3Sb78NkODTApNaRil3zj
    FI1X/+Q5GQ8O9Jx8y9OAv88Y6IIQ7MtODrzt9PyB09ojBeIPbHoreRCs+P+iD12o
    kK5JEZ6Ce1EaxECl4bvnYZQK7iqXarHVkiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526338808; bh=j
    uPKi78AIZiLeb2CP7jX6Gg6JAk3FMHXSq/bMb+V/Po=; b=KEn7NHAu3GVEyZ6lu
    sjRoEuyonunB5oR0UJ/9f10iW3ZxWsSbrteGPsUsbaAmRDaWbuHmsKSEPV/gKc6C
    nHff6HNOdUZimqvK7bffvNx2ii/2JXBOOrJv30rOnm/ksTeSVrmaLBUc92JMznqF
    IpgC2Ef5HGgmj6HwK21HaKn+I/iZODfCcrCPuQMDJb8XdQ+VV8y93WwyDhiDJlT6
    /ws6uRyyh8Y2NnY/8rduXYLG8GfGEO6iPdpCZaV11Ov6cfFFJJZlN1ZkrFXUaq6j
    PmXHkfNbf7svPuhB5usa62gzzveFcp8asn7uiCM76xHn9jTBP07g86wUXkiKzosv
    V5RDA==
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
X-CM-Envelope: MS4wfDtEuz0MLG4fjmMolOxquSmvSEv/lTd/cGz12zjVIBp2VHyxXEOiHE2mEJTTxePPp8E6wRcJ6W6s2+AvrSB9pcRtxB6GERg/S+WH3l25KFwDQPL9FynT
    TAqlgWaXdYUuX8vKpvRip4JrZ7FUtQIcebfJnzzqkKc1aJGjS7yHftREBLf99Rjpu7jtM6RKZUlEPrp91suzD8JUC0V1fXJ6D0sC3aR1j8rcq5QRTHJlquHz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=iP-xVBlJAAAA:8
    a=gu6fZOg2AAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=pGLkceISAAAA:8 a=yyJd0-ZHAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
    a=KMelJuxjKB3IlI2o8YoA:9 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=lHLH-nfn2y1bM_0xSXwp:22 a=2RSlZUUhi9gRBrsHwhhZ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=tZ66tqNesld6_HzJrOHp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeENXAH (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:00:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752357AbeENXAG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:00:06 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 1/3] locking: Document the semantics of spin_is_locked()
Date: Mon, 14 May 2018 16:01:27 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514230105.GA6421@linux.vnet.ibm.com>
References: <20180514230105.GA6421@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0052-0000-0000-000002EE70DC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032373; UDB=6.00527778; IPR=6.00811503;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:00:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0053-0000-0000-00005CAF30D5
Message-Id: <1526338889-7003-1-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140227
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

There appeared to be a certain, recurrent uncertainty concerning the
semantics of spin_is_locked(), likely a consequence of the fact that
this semantics remains undocumented or that it has been historically
linked to the (likewise unclear) semantics of spin_unlock_wait().

A recent auditing [1] of the callers of the primitive confirmed that
none of them are relying on particular ordering guarantees; document
this semantics by adding a docbook header to spin_is_locked(). Also,
describe behaviors specific to certain CONFIG_SMP=n builds.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
    https://marc.info/?l=linux-kernel&m=152042843808540&w=2
    https://marc.info/?l=linux-kernel&m=152043346110262&w=2

Co-Developed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Co-Developed-by: Alan Stern <stern@rowland.harvard.edu>
Co-Developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/spinlock.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d258..1e8a46435838 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -380,6 +380,24 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
 	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
 })
 
+/**
+ * spin_is_locked() - Check whether a spinlock is locked.
+ * @lock: Pointer to the spinlock.
+ *
+ * This function is NOT required to provide any memory ordering
+ * guarantees; it could be used for debugging purposes or, when
+ * additional synchronization is needed, accompanied with other
+ * constructs (memory barriers) enforcing the synchronization.
+ *
+ * Returns: 1 if @lock is locked, 0 otherwise.
+ *
+ * Note that the function only tells you that the spinlock is
+ * seen to be locked, not that it is locked on your CPU.
+ *
+ * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n,
+ * the return value is always 0 (see include/linux/spinlock_up.h).
+ * Therefore you should not rely heavily on the return value.
+ */
 static __always_inline int spin_is_locked(spinlock_t *lock)
 {
 	return raw_spin_is_locked(&lock->rlock);
-- 
2.5.2
