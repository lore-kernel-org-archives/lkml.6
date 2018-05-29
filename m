Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2698890-1527626990-2-1957976508179412234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527626990; b=ZR7uMjy331i+llxX1hOp2tetga25hmdxK7hA+Jcm+8DrhZT/E/
    sugsxdUilX6n9vFZyauNBPpDLdHlFi8LU96UYHsEhIXA7cgme1X6K+Lm8UnSOOo4
    ZUMtPE1eULKX3SSaz3rSOR/IgDEpXngXkfEKrYtT7Plf7OpMIagUn1Fd72LAQum+
    psccp97xOww+fms4FHFmoi5LQSl7TRg6v//XDhq8Xuj+qHCvxefLTNo6dDiTQ2Tk
    NzeMFHZfeMKLGfTn/C1qiggSxsBzHOrXEekoy+zrCAbFYqzg5qzv/bqtz+AAf38c
    c/fC26EEDZcz7KSvlDWqcNclFBq6M450wrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1527626990; bh=hJb0IuotHm35o8Vahy//1QZOfzcl4bmOEeXxBVUKHoE=; b=Q
    T5kYpDRaQzE06YSK6JiDxuVg/F/EfcTjaKY8vahBhfmOHrnNthcWa6YE2vHJbUye
    qemvNBcmT5BXblHaVe7lv0tGfR6JuXMf5gqAOnKCnvhjNR0bytE75cOjmBLjBOvG
    4fgkT46KSWIJQt0zhDIAlGt2zqyxiBJ1VoTg2PI0mxd7y7KCFMNJlDYiZWrWx1Fo
    +ImYVIa3lkbZ19LHu9wJcDW29DeRFrrGS/WNY3inn5rH1oZEsGr9MBtdVItRntGz
    k14jdWNeSmUHEV4XySa//ost+d1iaKI1z2gYYPuAPnSfXr3OBLQPoDV+MqIgujk5
    e3tJgmAyQudfdVyDI295g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFg6A0U6F4AQOLqWVbZNMMbqr9973KbBDxJykZSzC8azK8AbBgsh+wj+4/cqu0bu4SL2kAR4dak6ufVst5Ii6auwuDohNbevhwq43rTirbRBzLNGq5fL
    jIAzIYW7dLdPMyh5z6mS7i/f4vOFKS1I9AzSkFNdrzkh1PgIGeLYzZPPekmLZF/q6xCLtL7Qel3Bif7xYbzIDwWu5SQhd//wdqLU5VsKyW/TXz8asMhdI44W
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=NEAV23lmAAAA:8 a=thdUo-Z6GbBcKmNfmeIA:9 a=3TCRmjgYIJj8nOiV:21
    a=BYmDn7qkXHL7xjLk:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966524AbeE2Utr (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 16:49:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46862 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S966397AbeE2Utr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 16:49:47 -0400
Date: Tue, 29 May 2018 16:49:45 -0400 (EDT)
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
In-Reply-To: <20180529190332.GO3803@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 29 May 2018, Paul E. McKenney wrote:

> On Tue, May 29, 2018 at 02:35:34PM -0400, Alan Stern wrote:
> > On Mon, 28 May 2018, Paul E. McKenney wrote:
> > 
> > > Hello!
> > > 
> > > The litmus test below is a first attempt to model Roman's rcu-rr
> > > round-robin RCU-protected linked list.  His test code, which includes
> > > the algorithm under test, may be found here:
> > > 
> > > https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c
> > > 
> > > The P0() process below roughly corresponds to remove_conn_from_arr(),
> > > with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
> > > Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
> > > that the algorithm is safe, and also claims that it becomes unsafe if
> > > either synchronize_rcu() is removed.
> > 
> > This algorithm (the one in the litmus test; I haven't looked at Roman's
> > code) does seem valid.  In addition to removing either
> > synchronize_rcu(), interchanging the order of the stores in P0 (c
> > first, then w) would also invalidate it.
> > 
> > This is a little unusual in that c is written by more than one thread 
> > with no protection.  It works because the writes are all stores of a 
> > single pointer.
> > 
> > Why does the litmus test use smp_store_release() in three places?  
> > There doesn't seem to be any need; WRITE_ONCE() would be sufficient.
> 
> Because the algorithm did.  A bit of a stretch for kfree, but... ;-)
> 
> Let's try removing them, please see below.
> 
> > Alan
> > 
> > > Does this in fact realistically model Roman's algorithm?  Either way,
> > > is there a better approach?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > C C-RomanPenyaev-list-rcu-rr
> > > 
> > > {
> > > 	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
> > > 	int *y=z;
> > > 	int *x=y;
> > > 	int *w=x;
> > > 	int *v=w; (* List head is v. *)
> > > 	int *c=w; (* Cache, emulating ppcpu_con. *)
> > > }
> > > 
> > > P0(int *c, int *v, int *w, int *x, int *y)
> > > {
> > > 	rcu_assign_pointer(*w, y); /* Remove x from list. */
> 
> No change when converting this to WRITE_ONCE();
> 
> > > 	synchronize_rcu();
> > > 	r1 = READ_ONCE(*c);
> > > 	if (r1 == x) {
> > > 		WRITE_ONCE(*c, 0); /* Invalidate cache. */
> > > 		synchronize_rcu();
> > > 	}
> > > 	smp_store_release(x, 0);  /* Emulate kfree(x). */
> 
> Converting this one to WRITE_ONCE() does have an effect:
> 
> 	Test C-RomanPenyaev-list-rcu-rr Allowed
> 	States 8
> 	0:r1=0; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=0; c=0; v=w; w=y; x=0; y=z;
> 	0:r1=w; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
> 	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=w; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
> 	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=0; v=w; w=y; x=0; y=z;
> 	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
> 	0:r1=y; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
> 	0:r1=y; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
> 	0:r1=z; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
> 	Ok
> 	Witnesses
> 	Positive: 1 Negative: 7
> 	Condition exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0)
> 	Observation C-RomanPenyaev-list-rcu-rr Sometimes 1 7
> 	Time C-RomanPenyaev-list-rcu-rr 0.40
> 	Hash=2ec66290a6622117b9877436950e6a08
> 
> Maybe reordered with READ_ONCE(*c) when r1 != x?

Probably.  This points out a weakness in the memory model.  Even though
the memory model allows that reordering, no compiler would reorder the
two statements and no CPU would execute the store before the load.

The general pattern is this: Suppose we have

	A;
	if (B)
		C;
	D;

where A is a load, B depends on A, D is a store, and C contains a
memory barrier or something else that orders D after A in the case
where B is true.  Furthermore, assume that B sometimes really is true
(i.e., the compiler can't prove that B is always false).  Then the
compiler is not allowed to move D up before A or B, and consequently
even when B is false, the CPU can't execute D before A.

Putting this into herd would be extremely difficult, if not impossible, 
because it involves analyzing code that was not executed.

Alan
