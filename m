Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572352-1526340888-2-14518190171460985407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340888; b=V3E5vT3f27TZMKdmLFlyB5OyeVoHOzWSFdZ4M0GLUY2CrMz3Te
    P3Z+/6Ok0srHYoOOVUUxEBGWEiUFwIspdpj1GkKf50U5/dbd+yjJQvCs8j1ECUAP
    Gn3pl2c04G0sgIFFejYEX1SUCTu0UE3Nld9NoEiEHRQPniTAUekm/R9cYSD0sOQj
    Ilh0ex1X6cuAB6mZDSdFyb+Cx3Be1wwc98uY2EAqHsxWrUbabqRo9GCsmw+9a/ph
    tt9s97eeUAePw3IVaX/M38DIC5peUJH4szykcnagCQSYmRsDQoJptXpDBc0s9YO0
    i6dIaXv0G+npvexulYiG4+8msw328geZlj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526340888; bh=P
    kMY/IXyHE9AnMrCpTj8kRL4d9O+AvcF0e4426P0sXU=; b=Ai4FhccoKBD7TVOJD
    TkCWVFMHr8QdmQn8/UALS6RmQTeMNzaqpLJYC3UzxPGQPUJB//DvZ07FvaI20q3x
    Kro5Met8M6dcoZrjTi4fNl1xRaZZ0cwKfpmeTjRZUl6wnDM7u8SolH3b7VnziXNm
    yi5DnCB7MZEyXhds27rvepk02CD2sIUk8tD/UNJIkouVKIme3jEWK3CJp2oEo+ft
    ymP9NchrGbJyykPHc6lY7KNRj6Ns38VdGj1THQlfIwg44c0n3hfmJQ6npOWqKcF2
    ROLh8BqOfUY8yXo+cl5vwWNdoRS5ZKtOU/PW9PCLiG7LycXs1JDvZnyPI0M7NQnq
    i0QaQ==
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
X-CM-Envelope: MS4wfOqB19TnOQjJzblqqRFxJ9vXBrmeqLOHhO7s2a/3CAW8mDxgGnUHkpy4IpxtaFVk59nuOJCV1DtJTkTn1FWz6Q+kF6NxfhpiGoBZudUlyxGI8cXZ124m
    o1biJEkSNo2Yv7X3yn/oaKIW65D0jmOSEPaJ05cgHNsLRK9xzWxLiU0bXjsUynbYNU5/m+Fg/2HDJB/x8SGGa5LPdbgL3LL/wX4bvXlOgYNhzTOzakXmb8y9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=iP-xVBlJAAAA:8
    a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
    a=yyJd0-ZHAAAA:8 a=VnNF1IyMAAAA:8 a=QhuDiEQyN9obfO2gYJsA:9
    a=aGdbNNDKtmbq0hWO:21 a=AHN3Br4oVwjvV1Bu:21 a=3EQ2ZgbX-S0A:10
    a=lHLH-nfn2y1bM_0xSXwp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=tZ66tqNesld6_HzJrOHp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeENXer (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:34:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752489AbeENXce (ORCPT
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
Subject: [PATCH memory-model 17/19] MAINTAINERS: Update e-mail address for Andrea Parri
Date: Mon, 14 May 2018 16:33:55 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0044-0000-0000-000004143D4E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811514;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0045-0000-0000-0000084650FB
Message-Id: <1526340837-12222-17-git-send-email-paulmck@linux.vnet.ibm.com>
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

I moved to Amarula Solutions; switch to work e-mail address.

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
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ffa56e7550..2544827564f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8153,7 +8153,7 @@ F:	drivers/misc/lkdtm*
 
 LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <parri.andrea@gmail.com>
+M:	Andrea Parri <andrea.parri@amarulasolutions.com>
 M:	Will Deacon <will.deacon@arm.com>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
-- 
2.5.2
