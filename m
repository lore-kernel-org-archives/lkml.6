Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2537649-1527620521-2-1980257486714787003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527620520; b=l+WENppvPrefPyFOQrC2WY1vz8tTPBMKjJMD1pwImsfC3n2lXB
    RdzIyF9tfA2Fbps7ntEAmzZUnYINRbVTVrpyFZxnOUyb3LBOiIf7MICQICO0GVL2
    XoukhZJ+gFO+yeT0JbDLr4jkpJMEuYh2jZrpGd2uoKMd7YIqFO0LtjYO7TSdo6k2
    TjYEETrOgs0IlAgvNVBytXvr/iaUIPr/MFVOO+gHeLsvgrQvyDGZuHia8RQUny8l
    FR+iAwiQY3NSKRKpfTQ54yqWqr8ZtnY1zKzkbS3QMuNUgrLY1ukbQ/O3vDj0hjT2
    l4wef1mPaQx7/hpQZ0Yyez2iGfWGSgJvcrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527620520; bh=FkuE/I2tc30lozAAORmbQvD
    aS6nJKUBD7c04y2zuGx8=; b=lLmlqPyN21YmwGbxxJi3gMHH0EA/s0mwTwNdKV1
    gBEoHp5GC8GYGSneYjJAk/URL3pKTU8gaQsppxcCt8UKrBaSXFVBoPQYvc4qYpc5
    WOcqdrx7dcswUBbgI7ey+/08jMVQ+w7L2mGJirf0XY+p29kD8giX3gh8BhJckbNA
    J0RVbP5v5QVfHWuIeJKOa18t1xe8xdMxQ7Hcvg9MpGcIQ9AHRwqRJ+kDPkho01TL
    k6LuROjGGOYKvh7eVnSPEXDfdusksj7RGDQlwqOUBo1k2iHzV38AASGh2llNVyuZ
    lBuWWp8SK+/43Iye3DtjKnFCe+9XxBn0YmbKcwfHX5/HDaw==
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
X-CM-Envelope: MS4wfOwphjc6aftDtBrtIKF62zbXQ5KxsY9zZHdeTm4U0L3JKFlmm8oXy9HzV9FP1NyOQa7wn/3tx0A4wk4eUyLcILewinBV0DudKQcHRdZSsiJKAoGOdPRs
    +xZH0kcpBRPX5BnYJd/Yf1c7rQrS9wD2HxcXZTyQs3UpbAdhsw4UtAZF84jVtYmUtwwsE0md+v2xvMCCd8+udYspGjYvT2XIG/QuuWquzmfhENuH+X0+EmMs
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=NEAV23lmAAAA:8 a=0U6YcF71nUTy-QeTNAkA:9 a=DZRB0zFcI8Bdr1Rd:21
    a=OW70vTQTGSTpZXyn:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965433AbeE2TB6 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 15:01:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965311AbeE2TB5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 15:01:57 -0400
Date: Tue, 29 May 2018 12:03:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andrea.parri@amarulasolutions.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, mingo@kernel.org, torvalds@linux-foundation.org,
        roman.penyaev@profitbricks.com
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180528220811.GA5221@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805291424440.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805291424440.1458-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052919-0024-0000-0000-000003622057
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039489; UDB=6.00532024; IPR=6.00818617;
 MB=3.00021361; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 19:01:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052919-0025-0000-0000-0000482BCB35
Message-Id: <20180529190332.GO3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290203
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 02:35:34PM -0400, Alan Stern wrote:
> On Mon, 28 May 2018, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > The litmus test below is a first attempt to model Roman's rcu-rr
> > round-robin RCU-protected linked list.  His test code, which includes
> > the algorithm under test, may be found here:
> > 
> > https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c
> > 
> > The P0() process below roughly corresponds to remove_conn_from_arr(),
> > with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
> > Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
> > that the algorithm is safe, and also claims that it becomes unsafe if
> > either synchronize_rcu() is removed.
> 
> This algorithm (the one in the litmus test; I haven't looked at Roman's
> code) does seem valid.  In addition to removing either
> synchronize_rcu(), interchanging the order of the stores in P0 (c
> first, then w) would also invalidate it.
> 
> This is a little unusual in that c is written by more than one thread 
> with no protection.  It works because the writes are all stores of a 
> single pointer.
> 
> Why does the litmus test use smp_store_release() in three places?  
> There doesn't seem to be any need; WRITE_ONCE() would be sufficient.

Because the algorithm did.  A bit of a stretch for kfree, but... ;-)

Let's try removing them, please see below.

> Alan
> 
> > Does this in fact realistically model Roman's algorithm?  Either way,
> > is there a better approach?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-RomanPenyaev-list-rcu-rr
> > 
> > {
> > 	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
> > 	int *y=z;
> > 	int *x=y;
> > 	int *w=x;
> > 	int *v=w; (* List head is v. *)
> > 	int *c=w; (* Cache, emulating ppcpu_con. *)
> > }
> > 
> > P0(int *c, int *v, int *w, int *x, int *y)
> > {
> > 	rcu_assign_pointer(*w, y); /* Remove x from list. */

No change when converting this to WRITE_ONCE();

> > 	synchronize_rcu();
> > 	r1 = READ_ONCE(*c);
> > 	if (r1 == x) {
> > 		WRITE_ONCE(*c, 0); /* Invalidate cache. */
> > 		synchronize_rcu();
> > 	}
> > 	smp_store_release(x, 0);  /* Emulate kfree(x). */

Converting this one to WRITE_ONCE() does have an effect:

	Test C-RomanPenyaev-list-rcu-rr Allowed
	States 8
	0:r1=0; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=0; c=0; v=w; w=y; x=0; y=z;
	0:r1=w; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=w; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=0; v=w; w=y; x=0; y=z;
	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
	0:r1=y; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
	0:r1=y; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
	0:r1=z; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
	Ok
	Witnesses
	Positive: 1 Negative: 7
	Condition exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0)
	Observation C-RomanPenyaev-list-rcu-rr Sometimes 1 7
	Time C-RomanPenyaev-list-rcu-rr 0.40
	Hash=2ec66290a6622117b9877436950e6a08

Maybe reordered with READ_ONCE(*c) when r1 != x?

> > }
> > 
> > P1(int *c, int *v)
> > {
> > 	rcu_read_lock();
> > 	r1 = READ_ONCE(*c); /* Pick up cache. */
> > 	if (r1 == 0) {
> > 		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
> > 	}
> > 	r2 = rcu_dereference(*r1); /* Advance to next element. */
> > 	smp_store_release(c, r2); /* Update cache. */
> > 	rcu_read_unlock();
> > 
> > 	/* And repeat. */
> > 	rcu_read_lock();
> > 	r3 = READ_ONCE(*c);
> > 	if (r3 == 0) {
> > 		r3 = READ_ONCE(*v);
> > 	}
> > 	r4 = rcu_dereference(*r3);
> > 	smp_store_release(c, r4);

Converting this to WRITE_ONCE() has no effect.

> > 	rcu_read_unlock();
> > }
> > 
> > locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
> > exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)
> 

							Thanx, Paul
