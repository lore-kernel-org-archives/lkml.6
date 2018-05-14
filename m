Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557870-1526338414-2-5127525181006769935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338414; b=PLDPVlmoQg8LFVq1ZFcgQTfogSLCe6U/Vpc06TxOrKGtLSTGdV
    vvJrkvGivLIAz3cpedH/YAGQKbsuOxbZF87hnvZlaMzPbSmxum2T6d0TBtW7CHTe
    cW648YC9nSMFBjQb574hDle2jDOCzw8CfQ6c6x50JjTepyBz2h+UCHZb7H7DNyH3
    U+re8q5YWjU3JNUyumUVWIm4wiE0vGO2fdZY9quJmIciTsWNbrwQr4v9Z4e9HX3r
    Nv1AALOiIOYdKuRJa5JA8DHtz4F64PsugugwIifNvpkNw5IojC1jYcc799Oi5o8E
    rnPh4mLcO5wBOewN5U2UDdoO0H9SowXeWOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :mime-version:content-type:message-id:sender:list-id; s=fm2; t=
    1526338414; bh=L64E2xyt+XSANpfhytftWJDKF5c89CEIwzjF5YABCuQ=; b=c
    0MydXFWOjftkmrpqoom+Ii03JUTk0/Y22OZ51fLY675QyhqxvEBoZnAX3ltEudUk
    eA6MH66K+vH1MJiaS59BHIjBlgAxgKbyua9EJKYkIvd3Y3lfz4BWLU3VKhHmDx4K
    XP6z613bsZqTMW5RutojrK3Pk3rbI3COFN2jJ4qUbpihLayJVRr3brRBSI5rl3ps
    j8vigb7hipbMiheR+Xn88YCFxTGbmxYfefwbqhi7dpAVk3shSZbqIji6N9kTJgqp
    8ZIATZjlFC9YKtO2E1VkF4lo4XuLVYKg8mVhYI98T+Qxof5thqJu3cWSmOaVGmKs
    PGVRU4QpFK+dxzrG0Ntgg==
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
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBobU+cG7UTkU7HIL5GsjlT9hRjPHMEXceT4TKi+++K/zAivJCVilI5VPV0ucvMgQyrCUBPAQR0vBaww0flNU8cLDkL97uRNHJ1jwbOlnZt7/L+FVuSh
    fDeVdgSuKfJY3aEAhdFY5KDl9s9jUFT9zHzdwW4NBh5pp4PVVWpkQrxXxmx5WWVeygMyuBQH31oc59gvQ+MQUu9dPZmIk4MfufcFe4r1VWPN0nG+jEkyqRaV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=jOOpVF3TZujADtHZnX0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeENWxc (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 18:53:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752077AbeENWxb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:53:31 -0400
Date: Mon, 14 May 2018 15:54:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH memory-model 0/8] memory-barriers.txt and atomic_ops.rst
 updates
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051422-2213-0000-0000-000002A53CEE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032370; UDB=6.00527776; IPR=6.00811502;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:53:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-2214-0000-0000-00005A1E9976
Message-Id: <20180514225457.GA5142@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140225
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

This series contains changes to the atomic_ops.rst file and to the
memory-barriers.txt file and its Korean translation.  These changes are
ready for inclusion into -tip.

1.	Fix memory-barriers.txt's ordering example contrasting DMA to
	MMIO, courtesy of Will Deacon.

2-6.	Updates to Korean translation of memory-barriers.txt, courtesy
	of SeongJae Park.

7.	Fix example code in atomic_ops.rst, courtesy of SeongJae Park.

8.	Use `warning` rst directive in atomic_ops.rst, courtesy of
	SeongJae Park.

							Thanx, Paul

------------------------------------------------------------------------

 core-api/atomic_ops.rst                |   13 ++++---
 memory-barriers.txt                    |   17 +++++-----
 translations/ko_KR/memory-barriers.txt |   56 +++++++++++++++++++++------------
 3 files changed, 53 insertions(+), 33 deletions(-)
