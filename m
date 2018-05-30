Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186052-1527709461-2-4235423467799033622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527709460; b=VnVcNjfy61/Ur42RuTtyPPXlkITYxQronO4tXKjZ1Lqbrmm4JT
    ytRCJIMf3AXek7Y58S6ekUfGrDbb1sC/t0r4z4F6FMVOK6EtSJzLsuk69Q07pbvX
    dr0u1vxZE9Mlwk40plEBb3Nis6XA/10KfQSH3dJorq4lyd0N8eLVhEJsLjDYfmSI
    gc2IE4WIpsze9CuWetX8QEtGR8gCmSRQGxY6toI3Teki6tJ81a/qbIGMrqTQ8tId
    idi5cKQvaICB8R5zOl30AzXR/8QPHOk/VlBhv2mcptTVXtpvnTJckTHwqrflvbUx
    dHFILbs8mbEwdGDeDE9mxJFis1LfD2uZedOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527709460; bh=7TL7N+TIeSi7WqwuvnYiQPc
    9kV9C40l1ghV1j71ka00=; b=kb7uJn8lcSa5wScqf5umuDEuwGQwncLvIL6bRzJ
    K7IQAPqD7SQweyPvRqQC3WyxGkyq817vOFIBr1AmMurfo1kIjsJBBTSuaPuwVBot
    l478IKYQka7BoLl8kyL5Qqn3eOiB0oicXpwEHVt8+ji4f4OIJDZIVBylfgiQKDeU
    +mWFJD2gzaZQecwnCBChk7suH4tEW/ycg+ZjyQ3U4BwryRloioYO/cn+uOPeyAYY
    1KA4lWeXXmS7r+O2u+HnVWbExwo5MQGHUVjN1MDJ753Qk55aKchFXk4Iygwuzxa8
    0m4K8AQ2O9blOBU6YIK7I5m1/oET44MMxkk/KY1uAE3ab4Q==
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
X-CM-Envelope: MS4wfEGYY2SoScmSW5TuEMbnxhlKG3JYMCUMeh7+mQR/9osfivNjo08FnVh8HwzPNLaYXSXX9wcVix2BICkSDUc0KLsTY46Z2BuFeUBDlEuFU7jh3BnGZxby
    qlT4AVZyo9ilI45rzAu8vUZFDSVfKhvy6y+HjOBNM+kLFbHOdH73govhXH+e5I4cfSAom+Kf4bz4AVMVFGvwUremoaGXMkVc4vl41t8WAWuPUuv6954NrDVR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=fMqBbhjsDbo1JTeWER8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeE3ToR (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 15:44:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753686AbeE3ToR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 15:44:17 -0400
Date: Wed, 30 May 2018 12:45:54 -0700
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
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18053019-2213-0000-0000-000002B04AE6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039960; UDB=6.00532201; IPR=6.00819093;
 MB=3.00021381; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 19:44:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053019-2214-0000-0000-00005A4D5271
Message-Id: <20180530194554.GM7063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300210
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 03:08:43PM -0400, Alan Stern wrote:
> On Wed, 30 May 2018, Paul E. McKenney wrote:
> 
> > On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
> > > On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> > > wrote:
> > > 
> > > > >
> > > > > Can't we simplify the whole sequence as basically
> > > > >
> > > > >      A
> > > > >      if (!B)
> > > > >          D
> > > > >
> > > > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > > > whole "not executed" code.
> > > 
> > > > Your listing is slightly misleading.
> > > 
> > > No. You're confused.
> > > 
> > > You're confused because you're conflating two *entirely* different things.
> > > 
> > > You're conflating the static source code with the dynamic execution. They
> > > are NOT THE SAME.
> > 
> > I am going to go out on a limb and assert that Linus is talking about
> > what gcc and hardware do, while Alan is talking about what the tool and
> > memory model do.
> 
> Indeed.  The very first line Linus quoted in his first reply to me
> (elided above) was:
> 
> 	Putting this into herd would be extremely difficult, if not impossible,
> 	because it involves analyzing code that was not executed.
> 
> It should be clear from this that I was talking about herd.  Not gcc or
> real hardware.
> 
> (After rereading his message a few times, I'm not sure exactly what 
> Linus was talking about...)

>From what I could see, real compilers and real hardware.  ;-)

> >  In a perfect world, these would be the same, but it
> > appears that the world might not be perfect just now.
> > 
> > My current guess is that we need to change the memory-model tool.  If
> > that is the case, here are some possible resolutions:
> > 
> > 1.	Make herd's C-language control dependencies work the same as its
> > 	assembly language, so that they extend beyond the end of the
> > 	"if" statement.  I believe that this would make Roman's case
> > 	work, but it could claim that other situations are safe that
> > 	are actually problematic due to compiler optimizations.
> > 
> > 	The fact that the model currently handles only READ_ONCE()
> > 	and WRITE_ONCE() and not unmarked reads and writes make this
> > 	option more attractive than it otherwise be, compilers not
> > 	being allowed to reorder volatile accesses, but we are likely
> > 	to introduce unmarked accesses sometime in the future.
> 
> Preserving the order of volatile accesses isn't sufficient.  The
> compiler is still allowed to translate
> 
> 	r1 = READ_ONCE(x);
> 	if (r1) {
> 		...
> 	}
> 	WRITE_ONCE(y, r2);
> 
> into something resembling
> 
> 	r1 = READ_ONCE(x);
> 	WRITE_ONCE(y, r2);
> 	if (r1) {
> 		...
> 	}
> 
> (provided the "..." part doesn't contain any volatile accesses,
> barriers, or anything affecting r2), which would destroy any run-time
> control dependency.  The CPU could then execute the write before the
> read.

True, but almost all current litmus tests do have at least one volatile
access in their "if" statements.  I am guessing that this has the same
memory-model tooling issues as #2 below, but I am as usual happy to be
proven wrong.  ;-)

> > 2.	Like #1 above, but only if something in one of the "if"'s
> > 	branches would prevent the compiler from reordering
> > 	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
> > 	RMW atomic, ...).  Easy for me to say, but I am guessing
> > 	that much violence would be needed to the tooling to make
> > 	this work.  ;-)
> 
> This would be my preference.  But I'm afraid it isn't practical at the 
> moment.

I bet that some combination of scripting and smallish modifications to
tooling could make it happen in reasonably short term.  Might be more
difficult to make something more future-proof, though, agreed.

> > If I understand Alan correctly, there is not an obvious way to make
> > this change within the confines of the memory model's .bell and .cat
> > files.
> 
> No way at all.  It would require significant changes to herd's internal 
> workings and its external interface -- my original point.

I was afraid of that.  ;-)

Though truth be told, I was expecting an issue like this to crop up
sooner rather than later, so I was actually getting a bit nervous
about the fact that it had not yet shown itself...

							Thanx, Paul
