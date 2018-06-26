Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9526C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB15926E37
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15926E37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754934AbeFZT3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:29:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751986AbeFZT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:29:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJTSYO109073
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:29:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jutw9hx1d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:29:48 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 15:29:47 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 15:29:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJTedg6750592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 19:29:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45FA6B2065;
        Tue, 26 Jun 2018 15:29:34 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 209A2B2066;
        Tue, 26 Jun 2018 15:29:34 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 15:29:34 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4038216CA0A3; Tue, 26 Jun 2018 12:31:46 -0700 (PDT)
Date:   Tue, 26 Jun 2018 12:31:46 -0700
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
 <20180626171454.GI2494@hirez.programming.kicks-ass.net>
 <20180626180855.GE3593@linux.vnet.ibm.com>
 <20180626192113.GM2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626192113.GM2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062619-0064-0000-0000-00000320A42E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052715; UDB=6.00539697; IPR=6.00830639;
 MB=3.00021867; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:29:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-0065-0000-0000-000039B9B14A
Message-Id: <20180626193146.GK3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 09:21:13PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 11:08:55AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 26, 2018 at 07:14:54PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > 
> > > > rcu_seq_snap may be tricky to decipher. Lets document how it works with
> > > > an example to make it easier.
> > > 
> > > Since you had me looking at them functions; why isn't rcu_seq_snap()
> > > using smp_load_acquire() and rcu_seq_end() using smp_store_release() ?
> > > Their respective comments seem to suggest that would be sufficent.
> > 
> > I do not believe that this would suffice.  Would it make sense to refer
> > to Documentation/RCU/Design/Memory-Ordering in the comment header?
> 
> No, because I can't read that thing in an editor.
> 
> > Except that this would invite sprinkling this pathname far and wide...
> > 
> > The key point is that these functions are part of the any-to-any
> > memory-ordering guarantee that RCU grace periods provide.
> 
> Then the existing comment is misleading and really needs change.

Would it be sufficient to add something like "The memory barrier is
required to support the many-to-many ordering guaranteed by RCU grace
periods"?

							Thanx, Paul

