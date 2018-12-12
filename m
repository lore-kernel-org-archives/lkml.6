Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B85C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F9220849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F9220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeLLVwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:52:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbeLLVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:52:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCLdvZD082315
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:52:52 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb7mfr37u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:52:52 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 21:52:50 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 21:52:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCLqi3k22020186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 21:52:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2074B205F;
        Wed, 12 Dec 2018 21:52:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91AF0B2064;
        Wed, 12 Dec 2018 21:52:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 21:52:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 94AD816C3266; Wed, 12 Dec 2018 13:52:45 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:52:45 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        mathieu.desnoyers@efficios.com,
        Florian Weimer <fweimer@redhat.com>, triegel@redhat.com,
        libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <20181212194225.GB4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812121604430.1543-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812121604430.1543-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121221-0052-0000-0000-00000366358A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010216; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130865; UDB=6.00587662; IPR=6.00910998;
 MB=3.00024673; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121221-0053-0000-0000-00005F15216E
Message-Id: <20181212215245.GC4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=606 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:32:50PM -0500, Alan Stern wrote:
> On Wed, 12 Dec 2018, Paul E. McKenney wrote:
> 
> > OK.  How about this one?
> > 
> >          P0      P1                 P2      P3
> >          Wa=2    rcu_read_lock()    Wc=2    Wd=2
> >          memb    Wb=2               Rd=0    synchronize_rcu();
> >          Rb=0    Rc=0                       Ra=0
> > 	         rcu_read_unlock()
> > 
> > The model should say that it is allowed.  Taking a look...
> > 
> >          P0      P1                 P2      P3
> > 				    Rd=0
> > 					    Wd=2
> > 					    synchronize_rcu();
> > 	                                    Ra=0
> > 	 Wa=2
> > 	 membs
> > 	         rcu_read_lock()
> > 		 [m01]
> > 		 Rc=0
> > 		 		    Wc=2
> > 				    [m02]   [m03]
> > 	 membe
> > 	 Rb=0
> > 	         Wb=2
> > 		 rcu_read_unlock()
> > 
> > Looks allowed to me.  If the synchronization of P1 and P2 were
> > interchanged, it should be forbidden:
> > 
> >          P0      P1      P2                 P3
> >          Wa=2    Wb=2    rcu_read_lock()    Wd=2
> >          memb    Rc=0    Wc=2               synchronize_rcu();
> >          Rb=0            Rd=0               Ra=0
> >                          rcu_read_unlock()
> > 
> > Taking a look...
> > 
> >          P0      P1      P2                 P3
> >                          rcu_read_lock()
> >                          Rd=0
> >          Wa=2    Wb=2                       Wd=2
> >          membs                              synchronize_rcu();
> >                  [m01]
> >                  Rc=0
> >                          Wc=2
> >                          rcu_read_unlock()
> > 			 [m02]              Ra=0 [Forbidden?]
> > 	 membe
> >          Rb=0

For one thing, Wb=2 needs to be down here, apologies!  Which then ...

> Have you tried writing these as real litmus tests and running them 
> through herd?

That comes later, but yes, I will do that.

> > I believe that this ordering forbids the cycle:
> > 
> > 	Wa=1 > membs -> [m01] -> Rc=0 -> Wc=2 -> rcu_read_unlock() ->
> > 		return from synchronize_rcu() -> Ra
> > 
> > Does this make sense, or am I missing something?
> 
> It's hard to tell.  What you have written here isn't justified by the
> litmus test source code, since the position of m01 in P1's program
> order is undetermined.  How do you justify m01 -> Rc, for example?

... justifies Rc=0 following [m01].

> Write it this way instead, using the relations defined in the 
> sys_membarrier patch for linux-kernel.cat:
> 
> 	memb ->memb-gp memb ->rcu-link Rc ->memb-rscsi Rc ->rcu-link
> 		
> 		rcu_read_unlock ->rcu-rscsi rcu_read_lock ->rcu-link 
> 
> 		synchronize_rcu ->rcu-gp synchronize_rcu ->rcu-link memb
> 
> Recall that:
> 
> 	memb-gp is the identity relation on sys_membarrier events,
> 
> 	rcu-link includes (po? ; fre ; po),
> 
> 	memb-rscsi is the identity relation on all events,
> 
> 	rcu-rscsi links unlocks to their corresponding locks, and
> 
> 	rcu-gp is the identity relation on synchronize_rcu events.
> 
> These facts justify the cycle above.
> 
> Leaving off the final rcu-link step, the sequence matches the
> definition of rcu-fence (the relations are memb-gp, memb-rscsi, 
> rcu-rscsi, rcu-gp with rcu-links in between).  Therefore the cycle is 
> forbidden.

Understood, but that would be using the model to check the model.  ;-)

							Thanx, Paul

