Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5249C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ED525CF1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ED525CF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeF0TJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751107AbeF0TJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RJ97Ai106072
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:09:25 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvehp4x3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:09:24 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 15:09:23 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 15:09:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RJ9Hsq6488382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 19:09:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9B71B206E;
        Wed, 27 Jun 2018 15:09:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 818EBB2064;
        Wed, 27 Jun 2018 15:09:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 15:09:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6765116C3F79; Wed, 27 Jun 2018 12:11:24 -0700 (PDT)
Date:   Wed, 27 Jun 2018 12:11:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, kernel-team@android.com
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
 <20180627043913.GA177710@joelaf.mtv.corp.google.com>
 <20180627175436.GC3593@linux.vnet.ibm.com>
 <20180627182726.GA79165@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627182726.GA79165@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062719-0072-0000-0000-0000037612CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009265; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053188; UDB=6.00539980; IPR=6.00831113;
 MB=3.00021886; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 19:09:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062719-0073-0000-0000-0000488267B4
Message-Id: <20180627191124.GE3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:27:26AM -0700, Joel Fernandes wrote:
> On Wed, Jun 27, 2018 at 10:54:36AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 26, 2018 at 09:39:13PM -0700, Joel Fernandes wrote:
> > > On Tue, Jun 26, 2018 at 07:30:55PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> > > > > +/*
> > > > > + * rcu_seq_snap - Take a snapshot of the update side's sequence number.
> > > > > + *
> > > > > + * This function returns the earliest value of the grace-period sequence number
> > > > > + * that will indicate that a full grace period has elapsed since the current
> > > > > + * time.  Once the grace-period sequence number has reached this value, it will
> > > > > + * be safe to invoke all callbacks that have been registered prior to the
> > > > > + * current time. This value is the current grace-period number plus two to the
> > > > > + * power of the number of low-order bits reserved for state, then rounded up to
> > > > > + * the next value in which the state bits are all zero.
> > > > 
> > > > If you complete that by saying _why_ you need to round up there, then
> > > > the below verbiage is completely redundant.
> > > > 
> > > > > + * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
> > > > > + * the seq is used to track if a GP is in progress or not. Given this, it is
> > > > > + * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
> > > > > + * why with an example:
> > > > > + *
> > > > > + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> > > > > + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> > > > > + * to account for the shift due to 2 state bits. Now, if the current seq is
> > > > > + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> > > > > + * is already in progress so the next GP that a future call back will be queued
> > > > > + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> > > > > + * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
> > > > > + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> > > > > + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
> > > > > + * overflow didn't occur. This masking is needed because in case RCU was idle
> > > > > + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> > > > > + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> > > > > + *
> > > > > + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> > > > > + * which can be generalized to:
> > > > > + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> > > > > + */
> > > > 
> > > > Is the below not much simpler:
> > > > 
> > > > >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> > > > >  {
> > > > >  	unsigned long s;
> > > > 
> > > > 	s = smp_load_aquire(sp);
> > > > 
> > > > 	/* Add one GP */
> > > > 	s += 1 << RCU_SEQ_CTR_SHIFT;
> > > > 
> > > > 	/* Complete any pending state by rounding up */
> > > 
> > > I would suggest this comment be changed to "Add another GP if there was a
> > > pending state".
> > > 
> > > > 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> > > > 
> > > 
> > > I agree with Peter's suggestions for both the verbiage reduction in the
> > > comments in the header, as the new code he is proposing is more
> > > self-documenting. I believe I proposed a big comment just because the code
> > > wasn't self-documenting or obvious previously so needed an explanation.
> > > 
> > > How would you like to proceed? Let me know what you guys decide, I am really
> > > Ok with anything. If you guys agree, should I write a follow-up patch with
> > > Peter's suggestion that applies on top of this one?  Or do we want to drop
> > > this one in favor of Peter's suggestion?
> > 
> > Shortening the comment would be good, so please do that.
> > 
> > I cannot say that I am much of a fan of the suggested change to the
> > computation, but I don't feel all that strongly about it.  If the two
> 
> Did you mean a code generation standpoint or from a higher level coding standpoint?

I mean from the viewpoint that this changes the source code from a
straightforward single-line computation that can be seen at a glance
into something using a macro with a "__" prefix that invokes yet another
macro that eventually does something.

And yes, once I looked up the macro definitions, I did see that it is
functionally equivalent to the original code.  ;-)

> >From a code generation perspective, the code is identical, I did a quick
> test to confirm that:
> 
> 0000000000000000 <rcu_seq_snap_old>:
>        0:       e8 00 00 00 00          callq  5 <rcu_seq_snap_old+0x5>
>        5:       48 8b 07                mov    (%rdi),%rax
>        8:       f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
>        e:       48 83 c0 07             add    $0x7,%rax
>       12:       48 83 e0 fc             and    $0xfffffffffffffffc,%rax
>       16:       c3                      retq
>       17:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>       1e:       00 00
> 
> 0000000000000020 <rcu_seq_snap_new>:
>       20:       e8 00 00 00 00          callq  25 <rcu_seq_snap_new+0x5>
>       25:       48 8b 07                mov    (%rdi),%rax
>       28:       f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
>       2e:       48 83 c0 07             add    $0x7,%rax
>       32:       48 83 e0 fc             and    $0xfffffffffffffffc,%rax
>       36:       c3                      retq
>       37:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>       3e:       00 00

That is reassuring.

							Thanx, Paul

> > of you agree on a formulation and get at least one other RCU maintainer
> > or reviewer to agree as well, I will take the change.
> > 
> 
> Cool, sounds good.
> 
> thanks!
> 
> - Joel
> 

