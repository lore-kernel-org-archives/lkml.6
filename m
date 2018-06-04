Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1799621-1528127995-3-17434391799059178953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127994; b=h6MEOqCB3mf8TIRWeAWU6Y7te6UYjtI3+5M3ji0wdf3/hcTqn8
    0o1+SykjN9w7nB9KIoflQPd3qgT4ZZrYMhRrX6UDPkSFYk8Bqd5GSAwq+ngTtEC4
    E43bcqVw3VMBhXxnJh8dupXv7HREjeVKKRvU8c8MMQ3JVYg5AT/pFGfE+roNLFvz
    HONsvyK3aLY5ZVQjSWctFRGLBq70pijxkP2ZMDDNpFsbonF8CWInK1jYJ9x5twlH
    GRBK/hPM40h+Ki0K5mQQ4Idf3B+bLyP5SFAXoFcP2HbgF/Pg4wdXVHPqSsJJPpqU
    MvNLxQIW1pWv0KgKjc4eBVbRCbpCMFb14TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1528127994; bh=+0lK7E/A9D5x6r+I53JaIne
    SDwv0yAnXYR0ZJGRBQdg=; b=ZETtI9Q99fk3jBQNybpuK7Si4wGWk+B1HkVBK8Y
    hx2BUED0iovNaPEiLnJgWFkPCjkYWyBkeuYdmqiH1OfoSuGjohxYopm4+uhPF9Re
    4Rtu+XXB6JKPLREnA3vGZXTsYwLOf+juGNCqsR8vCW0rXP72uPyWuAfmzI9tfZzz
    eUv4naj4KI9R6B6ttdyu9HskQMa0gIysHnxZ+fAIiq9IJuzhshjxLFk03Pt4Vv6X
    c6kv5TOpx4BaLpKYdWE1PjLUOD95awN5lMcmlyUD9yWr+Nl9/6nvQfhJhkeEFc5X
    SbydDG6VVVh+HE3k0mYLjI2Engftt8kk+aaUDZQsL/+aI5g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
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
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNr/5E6C09ZMhZRvZ+dYQ2/o2FU/t108hP5uzZqtNnVA6JPgqj6W5a9xjMjgrH6+RoVOfZOFK0D+yt48P7glkzTIESq3TBjDA/zOHCKG8beAnD2FVtxg
    aUKZHew22mPKP9JQW8eenq9Wev3vNVck68gJV/R+bA44pSMQgKBAo+g1SmMpjeeMvTWzfVvu4xGxDCQwtFH+vGVBDi+/zykvN6SH9NxdblRRbqAghnSujhxq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=Hoh3fSOigZhugZ9RCpIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeFDP7v (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:59:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbeFDP7t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jun 2018 11:59:49 -0400
Date: Mon, 4 Jun 2018 09:01:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180602144440.GI3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1806041014250.1380-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806041014250.1380-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060415-0064-0000-0000-0000031500CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009128; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042241; UDB=6.00533671; IPR=6.00821372;
 MB=3.00021460; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 15:59:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060415-0065-0000-0000-0000397A0212
Message-Id: <20180604160129.GP3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040186
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 04, 2018 at 10:17:47AM -0400, Alan Stern wrote:
> On Sat, 2 Jun 2018, Paul E. McKenney wrote:
> 
> > One crude but effective workaround is to replicate the code following the
> > "if" statement into both legs of the "if" statement.  This has the effect
> > of extending the control dependency to cover all of the code that used to
> > follow the "if" statement, leveraging herd's current limited knowledge of
> > compiler optimization.  This workaround would of course be hopeless for
> > general Linux-kernel code, but should be at least semi-acceptable for the
> > very small snippets of code that can be accommodated within litmus tests.
> > 
> > Please see the litmus test shown below, which uses this workaround,
> > allowing the smp_store_release() to be downgraded to WRITE_ONCE().
> > 
> > Given this workaround, crude though it might be, I believe that we can
> > take a more measured approach to identifying a longer-term solution.
> > 
> > Thoughts?
> 
> Yes, this works, although it is clearly just a stopgap.  And obviously
> it can't be applied in situations where one of the legs of the "if"  
> statement contains a non-trivial branch.

A non-trivial branch as in a goto?  If so, that could be problematic
depending on exactly what herd does in that case.

> In the long run, I don't think this problem is solvable.  At least, not 
> for all cases.  It requires too much guesswork about what optimizations 
> a compiler might do.

I agree that it cannot be perfect, but I bet that we can come extremely
close.  But yes, we need to think carefully about nested "if" statements
at the very least.  And there might well be some other way to get in
trouble.  ;-)

							Thanx, Paul
