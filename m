Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A2C26EDA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A2C26EDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeFZSI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:08:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752437AbeFZSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:08:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QHsX4e050275
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:08:27 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqk7r6g7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:08:26 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 14:08:25 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 14:08:21 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QI8KqU61931646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 18:08:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF1DDB2064;
        Tue, 26 Jun 2018 14:08:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0502B205F;
        Tue, 26 Jun 2018 14:08:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 14:08:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ABF7A16C15BE; Tue, 26 Jun 2018 11:10:25 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:10:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062618-0052-0000-0000-0000030463CA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052688; UDB=6.00539680; IPR=6.00830612;
 MB=3.00021865; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 18:08:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062618-0053-0000-0000-00005D26042C
Message-Id: <20180626181025.GF3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:30:55PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> > +/*
> > + * rcu_seq_snap - Take a snapshot of the update side's sequence number.
> > + *
> > + * This function returns the earliest value of the grace-period sequence number
> > + * that will indicate that a full grace period has elapsed since the current
> > + * time.  Once the grace-period sequence number has reached this value, it will
> > + * be safe to invoke all callbacks that have been registered prior to the
> > + * current time. This value is the current grace-period number plus two to the
> > + * power of the number of low-order bits reserved for state, then rounded up to
> > + * the next value in which the state bits are all zero.
> 
> If you complete that by saying _why_ you need to round up there, then
> the below verbiage is completely redundant.

I will leave this between you, Joel, and whoever else is interested.
The initial state worked for me.  ;-)

> > + * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
> > + * the seq is used to track if a GP is in progress or not. Given this, it is
> > + * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
> > + * why with an example:
> > + *
> > + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> > + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> > + * to account for the shift due to 2 state bits. Now, if the current seq is
> > + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> > + * is already in progress so the next GP that a future call back will be queued
> > + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> > + * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
> > + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> > + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
> > + * overflow didn't occur. This masking is needed because in case RCU was idle
> > + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> > + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> > + *
> > + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> > + * which can be generalized to:
> > + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> > + */
> 
> Is the below not much simpler:
> 
> >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> >  {
> >  	unsigned long s;
> 
> 	s = smp_load_aquire(sp);
> 
> 	/* Add one GP */
> 	s += 1 << RCU_SEQ_CTR_SHIFT;
> 
> 	/* Complete any pending state by rounding up */
> 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> 
> 	return s;
> }

Seems equivalent to me, but with more lines.  To say nothing of more
levels of lookup of macro definitions.  ;-)

							Thanx, Paul

