Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557870-1526338509-2-55737456032073330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338509; b=SkhiMHd/L0OeA8M3vaeha6BUK8zitx/lR/KJmUDaaikMvVewr1
    pZU+A3SJBft5b4apP+1NwO+xI4zmkZRjK2DyVMpIdjTwuEbkRS3WQfhsH4U3m/i/
    0BH2nLLKvFA4Sr8ldeJx8k405SpH4y7p6qtngAwob1EHiUgQyVN78UO8OScCIAfI
    3F/hqCCmiKHuQ4p33AnoyV8d1I6FV+pC8alr/rn+JTjGVjKECKv9CVsE6rFRivvQ
    HZ/sVG541mt8JPv3oBsHrG4neqxdwLBDMlu5vU1BxiyuEraKdU3/0M4KarYRnbyB
    5HJ0m0iKrZULjsKbYDmMqftUbenci3LyrCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526338509; bh=6
    YhTpl+pJZcGca9zgzvyrH55JUpEROQCiLedBJigQwM=; b=B3z5u8iDdcJju64BX
    2x7j5OeY0J4z5J4w2EZNVJksjf/sMMN+8xNc73yuX0WTtapXHXxKSJnwvLKThXYr
    CJfqbveHP7JV+esrCF1F2v0lZKTWQ8X3y6xreFx4ulproGjWTAPkdt2wIHw6wUAq
    t4jIhnVAm7TAfj7WBhDJpCiQWbdCWyzWdOPJwy6KC5UDlpiOBT3AlwMUF2Ea9XN5
    ci3UUSKNVW6DxgqHqbNqE5j0+NLcTeE5IRDFzRZxKXhbptOgJ+5MU+T+B9o/ceaX
    mszURb+iz7EeV7hoUHaRzSZ6Ar6Dbrf4ggBhiXL+K/2PpHO97/IxvZClKk822I0T
    8wxRQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFl3ulmwNY4xKc7FpRcDyWrT8NboJ76HqYKQfQot1aEjVt+V7f5ymS9HsSAALnl5ee9Lc7oqqg1kvxx1jcUF/hp5GQXkClDQQKMFCNztMIbuQu6i6muQ
    265agpRKFk3mGNIT3uit+VqhoMFAZtnhP0Tid/L5tkD7TZiAO2SoQ9KXlVx/KWkSPO4wjpGHYi6ecainuQK6oQ+FBFd4W71mFbxKn54JEWY5QhIEjtdEB6HZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=VnNF1IyMAAAA:8 a=jjrtqIZLxSW9rhl--NUA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeENWzF (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 18:55:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752246AbeENWyL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:54:11 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 7/8] atomic_ops.rst: Fix wrong example code
Date: Mon, 14 May 2018 15:55:32 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051422-0056-0000-0000-0000044E3E2A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032370; UDB=6.00527776; IPR=6.00811501;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:54:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0057-0000-0000-0000089251DD
Message-Id: <1526338533-6044-7-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140226
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: SeongJae Park <sj38.park@gmail.com>

Example code snippets for necessary of READ_ONCE() and WRITE_ONCE() has
an unnecessary line of code and wrong condition.  This commit fixes
them.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 Documentation/core-api/atomic_ops.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index fce929144ccd..4ea4af71e68a 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -111,7 +111,6 @@ If the compiler can prove that do_something() does not store to the
 variable a, then the compiler is within its rights transforming this to
 the following::
 
-	tmp = a;
 	if (a > 0)
 		for (;;)
 			do_something();
@@ -119,7 +118,7 @@ the following::
 If you don't want the compiler to do this (and you probably don't), then
 you should use something like the following::
 
-	while (READ_ONCE(a) < 0)
+	while (READ_ONCE(a) > 0)
 		do_something();
 
 Alternatively, you could place a barrier() call in the loop.
-- 
2.5.2
