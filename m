Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2537649-1527618939-2-15152753175202654614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527618938; b=jPsFdWDf2G5Idm6y58cbutcHFe6RVQzkseaA1KGhE21P28jkcN
    ZuFI3WlryFKkMW/1vfIoSP0bq2XqsR4bBJYvKQrh5xBYE7PZpq27BmLIhsQ/w76i
    C7q7VhNV4t47V5nI0zJSYrGEOk4nNiAZtea8lh4Y0hqeXKb2ovuLa87z8cle0r7P
    bnWgh0Ey/y3SUQSY78Xb6EgM14inbNgHK3fh12jKdjnPkhiEi3ozi6x628l69vsB
    l05K8LShH08VkWFpghjA1MXqy4ROlJYW1Rz3DLWCQn2sxoVCUnOrM67yF6TwfUer
    EsON4RHqh+oSrlYjXeTlj/QZpJWTDKj2MJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527618938; bh=dhjMqv1PpfVXoT3lxHwmpyOL/3QKpDL7cHT672x1Dfk=; b=F
    KYPsrvxek45AICq5ON3zV+D9Pfq9zRhIIy3w8en6J39kI0RA7SASCPR5Fn58VYim
    oM1eG061uXt4YTcEELao423lfW91VaWrrN/mae1SFl/MbPevW4PZRW5G9azXJLUU
    omprNDKfhnpU6DeDY8ouSQkfsjiYN+SRaMq8+9ikZpZOKdM+kGVlfebT3G8Dplov
    5dx8wIlgFzkltNfZcfqfLZtP5VxGKsFmBDyoZOcqs4lpbP9idln6YypL5FfdbpCi
    6toXF71WStYB1+Zk/FQMnUR0Gule4HkSNBDqsPVedUXW/+SLkbHV9VWDo+FvwPoY
    8aWirKR43rdiE85A5eZ8Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rowland.harvard.edu header.result=pass
    header_org.domain=harvard.edu header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rowland.harvard.edu header.result=pass
      header_org.domain=harvard.edu header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJE8TVcTzSCTDASCVkgxh1ffUq1nr+WhjooKploooDZPRXGRQzhKeWYTqRyS4MbRsy/nkRusm9XJzeLk1/dj+/XDGtzZqfkAcID8xTN1/Ddw8fzsxj6U
    x3eHQJMF/Z65V7g4E/+ZjWbmN7fSCSUvS12tqtcL7ltc1OnbRWb/k50P0WB9ogS48J784XU2wXiTJqPb3YNXJVa9WNVdZRityEkihqyFTnzH/Fxf5ER3voFb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=NEAV23lmAAAA:8 a=5aRqEyX1flWzTGqFPO0A:9 a=NEwe2WGsTahafmrP:21
    a=NSqPq87eV1lG8uyt:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965863AbeE2Sfg (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:35:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46514 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S965871AbeE2Sff (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 14:35:35 -0400
Date: Tue, 29 May 2018 14:35:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, <linux-arch@vger.kernel.org>,
        <andrea.parri@amarulasolutions.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <akiyks@gmail.com>, <mingo@kernel.org>,
        <torvalds@linux-foundation.org>, <roman.penyaev@profitbricks.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
In-Reply-To: <20180528220811.GA5221@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1805291424440.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 28 May 2018, Paul E. McKenney wrote:

> Hello!
> 
> The litmus test below is a first attempt to model Roman's rcu-rr
> round-robin RCU-protected linked list.  His test code, which includes
> the algorithm under test, may be found here:
> 
> https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c
> 
> The P0() process below roughly corresponds to remove_conn_from_arr(),
> with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
> Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
> that the algorithm is safe, and also claims that it becomes unsafe if
> either synchronize_rcu() is removed.

This algorithm (the one in the litmus test; I haven't looked at Roman's
code) does seem valid.  In addition to removing either
synchronize_rcu(), interchanging the order of the stores in P0 (c
first, then w) would also invalidate it.

This is a little unusual in that c is written by more than one thread 
with no protection.  It works because the writes are all stores of a 
single pointer.

Why does the litmus test use smp_store_release() in three places?  
There doesn't seem to be any need; WRITE_ONCE() would be sufficient.

Alan

> Does this in fact realistically model Roman's algorithm?  Either way,
> is there a better approach?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> C C-RomanPenyaev-list-rcu-rr
> 
> {
> 	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
> 	int *y=z;
> 	int *x=y;
> 	int *w=x;
> 	int *v=w; (* List head is v. *)
> 	int *c=w; (* Cache, emulating ppcpu_con. *)
> }
> 
> P0(int *c, int *v, int *w, int *x, int *y)
> {
> 	rcu_assign_pointer(*w, y); /* Remove x from list. */
> 	synchronize_rcu();
> 	r1 = READ_ONCE(*c);
> 	if (r1 == x) {
> 		WRITE_ONCE(*c, 0); /* Invalidate cache. */
> 		synchronize_rcu();
> 	}
> 	smp_store_release(x, 0);  /* Emulate kfree(x). */
> }
> 
> P1(int *c, int *v)
> {
> 	rcu_read_lock();
> 	r1 = READ_ONCE(*c); /* Pick up cache. */
> 	if (r1 == 0) {
> 		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
> 	}
> 	r2 = rcu_dereference(*r1); /* Advance to next element. */
> 	smp_store_release(c, r2); /* Update cache. */
> 	rcu_read_unlock();
> 
> 	/* And repeat. */
> 	rcu_read_lock();
> 	r3 = READ_ONCE(*c);
> 	if (r3 == 0) {
> 		r3 = READ_ONCE(*v);
> 	}
> 	r4 = rcu_dereference(*r3);
> 	smp_store_release(c, r4);
> 	rcu_read_unlock();
> }
> 
> locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
> exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)
