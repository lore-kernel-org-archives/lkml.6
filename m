Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1587535-1526340729-2-3331669708423417486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340729; b=WhyQyx/nlywf/Fl3JSHZbLoQm55/Q5ZSDrKmapt6ED2SL0I8t2
    jZ+5IPT4zulzM3dybVFzyEGRUizEMBfldxifcU2v1CT9DxgdINs8AZTs7j78QmQy
    G/zbrDqI7ycDInfZnx39IlgyniKINq0eo8zengQCyCzWG+EDvGlScRK1oOeumLRg
    wK7EvF9VR4WEGJdAZM0aLaDefLZtLJLNL0aR3Emsi33PgU/nbsVmek5SjAoZ2trd
    t8jXlNdM1dFYZZ8njIWZv1SKwNe92vZvTVIB18h08SLA+kPHD11aR5rXPcCp+fXE
    f6NBLM1GxpPJxN1PShsQodcsJfCqDOrK/sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :mime-version:content-type:message-id:sender:list-id; s=fm2; t=
    1526340729; bh=GjX3tl8ggFxGbGNED5unFWqaWeKNj9jyDs3KtWWlrTs=; b=G
    V7CkCMnSxqZVilwAVmyAHpBTI3p6vN89083Bi/sL0WslS4q/MwM4ROki+LZ2Lzlv
    niFtQFlTL92UJovFO5ENgVzpDGd7Y1akpAvgrUVxUCZnjAcycX27dSZ2BJ8BIws6
    FcC20w6BysbL7SY0Udqby8v0/Ltek+mjCjKWpfFri2uMS0xmM7OOxrXk8zZ+4uS4
    RYhkkoz/9+ypnOnuG/ehtcNxXeEENlfFaxkIKprN0kpy4soyN/gbhu4M+UZMRGdJ
    flWhLt3sMWZ4LrA//QsprUWwXg3iIKku2qGbuTWMXzOR3gwpfuDHQNWFQf1ekEqb
    2YDOgifrqOcwgi10R4lrg==
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
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLaG91tq4co1ni39V1LEkkE/pmuQANw99sjdxIu3FL/H3/IesjK9iqQ5zQiyvTTRuDbIHaRSGuCVmErUP8XfrcffHj08IpzilOH4L77F+dZpsOpQBp9o
    J6PStTyqh5TNHtVAC2Xrgd/ViFjGOJ4u9fW2BIcT7Jd+tt+JBiAXUT06vwt7bb5ovrfA0goEWprcp2oX6MLbj1iM1rZswCGVvEaRclbY4sUgIYkooqNXzf6W
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=SajGqXo6GS7U7wIx0SAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeENXcG (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:32:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752112AbeENXcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:05 -0400
Date: Mon, 14 May 2018 16:33:28 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH memory-model 0/19] Updates to the formal memory model
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051423-0048-0000-0000-0000026CF2FB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811514;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0049-0000-0000-0000451F4830
Message-Id: <20180514233328.GA7601@linux.vnet.ibm.com>
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

Hello!

This series contains updates to the Linux kernel's formal memory model in
tools/memory-model.  These are ready for inclusion into -tip.

1.	Rename LKMM's "link" and "rcu-path" relations to "rcu-link"
	and "rb", respectively, courtesy of Alan Stern.

2.	Redefine LKMM's "rb" relation in terms of rcu-fence in order
	to match the structure of LKMM's other strong fences, courtesy
	of Alan Stern.

3.	Update required version of herdtools7, courtesy of Akira Yokosawa.

4.	 Fix cheat sheet typo: "RWM" should be "RMW", courtesy of Paolo Bonzini.

5.	Improve cheatsheet.txt key for SELF and SV.

6.	Fix cheatsheet.txt to note that smp_mb__after_atomic() orders
	later RMW operations.

7.	Model smp_store_mb(), courtesy of Andrea Parri.

8.	Fix coding style in 'linux-kernel.def', courtesy of Andrea Parri.

9.	Add scripts to test the memory model.

10.	Add model support for spin_is_locked(), courtesy of Luc Maranget.

11.	Flag the tests that exercise "cumulativity" and "propagation".

12.	Remove duplicated code from lock.cat, courtesy of Alan Stern.

13.	Improve comments in lock.cat, courtesy of Alan Stern.

14.	Improve mixed-access checking in lock.cat, courtesy of Alan Stern.

15.	Remove out-of-date comments and code from lock.cat, which have
	been obsoleted by the settled-upon spin_is_locked() semantics,
	courtesy of Alan Stern.

16.	Fix coding style in 'lock.cat', bringing the indentation to
	Linux-kernel standard, courtesy of Andrea Parri.

17.	Update Andrea Parri's email address in the MAINTAINERS file,
	oddly enough courtesy of Andrea Parri.  ;-)

18.	Update ASPLOS information now that ASPLOS has come and gone,
	courtesy of Andrea Parri.

19.	Add reference for 'Simplifying ARM concurrency', courtesy
	of Andrea Parri.

								Thanx, Paul

------------------------------------------------------------------------

 MAINTAINERS                                                               |    2 
 tools/memory-model/Documentation/cheatsheet.txt                           |    7 
 tools/memory-model/Documentation/explanation.txt                          |  261 +++++-----
 tools/memory-model/Documentation/references.txt                           |   17 
 tools/memory-model/README                                                 |    2 
 tools/memory-model/linux-kernel.bell                                      |    4 
 tools/memory-model/linux-kernel.cat                                       |   53 +-
 tools/memory-model/linux-kernel.def                                       |   34 -
 tools/memory-model/litmus-tests/.gitignore                                |    1 
 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus          |    2 
 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus    |   35 +
 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus      |   34 +
 tools/memory-model/litmus-tests/README                                    |   19 
 tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus |    4 
 tools/memory-model/lock.cat                                               |  197 ++++---
 tools/memory-model/scripts/checkalllitmus.sh                              |   73 ++
 tools/memory-model/scripts/checklitmus.sh                                 |   86 +++
 17 files changed, 595 insertions(+), 236 deletions(-)
