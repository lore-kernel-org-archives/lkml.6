Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298618-1527716861-2-2360966449127089792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527716860; b=L+hk2RusAxEDkSPBwRTWoEHhiEVXCwt97rtkBkNfBDYU3jm5pL
    rbSr/3qJS5igz2pxzhvdXG/3SWrX/rnwz/uSgVG2lfPjlLryRQyw7LZaiJwERzY+
    iyNeZK4UEDzh0J0MavuTah01FYCFuErH2ocWekcNfgADGkJIbQknF/DeggR3V+KR
    cLuSfkBhILjTjBYkv1GLqx8b4NgGYtIdP1EhFWMFZaKfB9CX0Uq/1jXDsPs3yWPj
    2tQcCDb4MXRaahKjobONW36mymTiWSaOD9uCCeJ9bu5eAquZiWcLwifOcFiTTUv4
    apxQoK4jmW2wiyWZfA1rYXWNIBh/5ON0QiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527716860; bh=uC+/yhZRU2pd5OBiuPUgQAb
    8N78/uzhjS/3GbcoDSBo=; b=UZcvf/Rt/qHoUTUym3tPVHI3Op+5DH7K+PRC3+o
    3YZJB1y8W3iIcuXki2Njf+e3AFCqyAp9IDHDaXIbcdNbkMt3NgNiHM8pcv7MPqbq
    aXM0dXFjNQHrZn9M0jQxqI7pN+tdNLHLccL7K97+Gq2XLra7pt2U+jx7GwEu6PII
    H8hxLNTJm1xXsITj85pxUSxdezEGCKqgKrtBowvP55RcRhpVcyONRh4+BJOv3ZFp
    b4iJERBpT6OM5AKF0eDmX4UBhcsT5qbEphgsyaACIwiJchxUpCLWv+bO6MsQ+GQz
    fiFoFYHULQmnrbAEgRDEKMfQg9GCvDJULuDa+9gLYPVCUoQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLs9jiv++ADvmFpGhJKwRGOH+4VKMMwDxg2F9Az4wI59BBI6P6EVpXIcnTwnkBk1m2ly9j/QuCwuYZeO1avqAuTjZoxanUOkFOGekGZ2b8HLS7MnHki6
    PImqVhWHvcFTlCv7l3U65aAWHzZJpS7svytW9H/a/M5O8Hmfpv78O4O5AYIq6BwlINg2eKCDcEL9e5+kFNDdAV6cTp4ES7KkvMaQYPq2+HvQP4eQ+OxG22Uc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JTG-6osVLjuoNdvme6IA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeE3Vrh (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 17:47:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932222AbeE3Vrg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 17:47:36 -0400
Date: Wed, 30 May 2018 14:49:12 -0700
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
References: <20180530194554.GM7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301620020.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805301620020.1502-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18053021-0040-0000-0000-0000043716AE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040001; UDB=6.00530820; IPR=6.00819134;
 MB=3.00021384; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 21:47:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053021-0041-0000-0000-0000083D3CB8
Message-Id: <20180530214912.GN7063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300230
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 04:28:56PM -0400, Alan Stern wrote:
> On Wed, 30 May 2018, Paul E. McKenney wrote:
> 
> > > > My current guess is that we need to change the memory-model tool.  If
> > > > that is the case, here are some possible resolutions:
> > > > 
> > > > 1.	Make herd's C-language control dependencies work the same as its
> > > > 	assembly language, so that they extend beyond the end of the
> > > > 	"if" statement.  I believe that this would make Roman's case
> > > > 	work, but it could claim that other situations are safe that
> > > > 	are actually problematic due to compiler optimizations.
> > > > 
> > > > 	The fact that the model currently handles only READ_ONCE()
> > > > 	and WRITE_ONCE() and not unmarked reads and writes make this
> > > > 	option more attractive than it otherwise be, compilers not
> > > > 	being allowed to reorder volatile accesses, but we are likely
> > > > 	to introduce unmarked accesses sometime in the future.
> > > 
> > > Preserving the order of volatile accesses isn't sufficient.  The
> > > compiler is still allowed to translate
> > > 
> > > 	r1 = READ_ONCE(x);
> > > 	if (r1) {
> > > 		...
> > > 	}
> > > 	WRITE_ONCE(y, r2);
> > > 
> > > into something resembling
> > > 
> > > 	r1 = READ_ONCE(x);
> > > 	WRITE_ONCE(y, r2);
> > > 	if (r1) {
> > > 		...
> > > 	}
> > > 
> > > (provided the "..." part doesn't contain any volatile accesses,
> > > barriers, or anything affecting r2), which would destroy any run-time
> > > control dependency.  The CPU could then execute the write before the
> > > read.
> > 
> > True, but almost all current litmus tests do have at least one volatile
> > access in their "if" statements.  I am guessing that this has the same
> > memory-model tooling issues as #2 below, but I am as usual happy to be
> > proven wrong.  ;-)
> 
> It shouldn't be all that bad.  The dependencies are generated by herd,
> meaning that the code would have to be changed to make control
> dependencies extend beyond the ends of "if" statements.  I don't think
> the necessary changes would be tremendously big, especially since the
> LISA front end already behaves this way.

That was my thought.

> > > > 2.	Like #1 above, but only if something in one of the "if"'s
> > > > 	branches would prevent the compiler from reordering
> > > > 	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
> > > > 	RMW atomic, ...).  Easy for me to say, but I am guessing
> > > > 	that much violence would be needed to the tooling to make
> > > > 	this work.  ;-)
> > > 
> > > This would be my preference.  But I'm afraid it isn't practical at the 
> > > moment.
> > 
> > I bet that some combination of scripting and smallish modifications to
> > tooling could make it happen in reasonably short term.  Might be more
> > difficult to make something more future-proof, though, agreed.
> 
> I have no idea what sort of scripting/smallish modifications could do 
> the job.  You could ask Luc, if you're not afraid of giving him an 
> aneurysm.  :-)

Two "if" keywords, one that carries control dependencies past the end
of the "if" (assembly-language style) and another that does not.  The
script then rewrites the "if" statements to one style or the other
depending on the contents of the "then" and "else" clauses.

> > > > If I understand Alan correctly, there is not an obvious way to make
> > > > this change within the confines of the memory model's .bell and .cat
> > > > files.
> > > 
> > > No way at all.  It would require significant changes to herd's internal 
> > > workings and its external interface -- my original point.
> > 
> > I was afraid of that.  ;-)
> > 
> > Though truth be told, I was expecting an issue like this to crop up
> > sooner rather than later, so I was actually getting a bit nervous
> > about the fact that it had not yet shown itself...
> 
> The fact is, herd was never meant to act like a compiler.  Some 
> disagreements are inevitable.

Agreed, the bit about identical stores at the beginnings of "then"
and "else" is one example.  But we should fix the ones that are more
straightforward.

						Thanx, Paul
