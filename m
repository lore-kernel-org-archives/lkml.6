Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE220834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CE220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHaCWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:22:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726732AbeHaCWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:22:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UMEoNX107245
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:18:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6qxjttex-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:18:19 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 18:18:18 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 18:18:13 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7UMICtu24903726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 22:18:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E59B2064;
        Thu, 30 Aug 2018 18:17:06 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1FE2B2066;
        Thu, 30 Aug 2018 18:17:06 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 18:17:06 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2877916C0487; Thu, 30 Aug 2018 15:18:14 -0700 (PDT)
Date:   Thu, 30 Aug 2018 15:18:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 3/7] EXP tools/memory-model: Add more LKMM
 limitations
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
 <20180830091713.GA4617@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830091713.GA4617@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083022-0040-0000-0000-000004680D84
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009641; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081216; UDB=6.00557782; IPR=6.00861201;
 MB=3.00023023; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 22:18:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083022-0041-0000-0000-0000086F286D
Message-Id: <20180830221814.GQ4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:17:13AM +0200, Andrea Parri wrote:
> On Wed, Aug 29, 2018 at 02:10:49PM -0700, Paul E. McKenney wrote:
> > This commit adds more detail about compiler optimizations and
> > not-yet-modeled Linux-kernel APIs.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  tools/memory-model/README | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index ee987ce20aae..acf9077cffaa 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -171,6 +171,12 @@ The Linux-kernel memory model has the following limitations:
> >  	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
> >  	and "A WARNING" sections).
> >  
> > +	Note that this limitation in turn limits LKMM's ability to
> > +	accurately model address, control, and data dependencies.
> > +	For example, if the compiler can deduce the value of some variable
> > +	carrying a dependency, then the compiler can break that dependency
> > +	by substituting a constant of that value.
> > +
> >  2.	Multiple access sizes for a single variable are not supported,
> >  	and neither are misaligned or partially overlapping accesses.
> >  
> > @@ -190,6 +196,36 @@ The Linux-kernel memory model has the following limitations:
> >  	However, a substantial amount of support is provided for these
> >  	operations, as shown in the linux-kernel.def file.
> >  
> > +	a.	When rcu_assign_pointer() is passed NULL, the Linux
> > +		kernel provides no ordering, but LKMM models this
> > +		case as a store release.
> > +
> > +	b.	The "unless" RMW operations are not currently modeled:
> > +		atomic_long_add_unless(), atomic_add_unless(),
> > +		atomic_inc_unless_negative(), and
> > +		atomic_dec_unless_positive().  These can be emulated
> > +		in litmus tests, for example, by using atomic_cmpxchg().
> 
> There is a prototype atomic_add_unless(): with current herd7,
> 
> $ cat atomic_add_unless.litmus
> C atomic_add_unless
> 
> {}
> 
> P0(atomic_t *u, atomic_t *v)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = atomic_add_unless(u, 1, 2);
> 	r1 = atomic_read(v);
> }
> 
> P1(atomic_t *u, atomic_t *v)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = atomic_add_unless(v, 1, 2);
> 	r1 = atomic_read(u);
> }
> 
> exists (0:r1=0 /\ 1:r1=0)
> 
> $ herd7 -conf linux-kernel.cfg atomic_add_unless.litmus
> Test atomic_add_unless Allowed
> States 3
> 0:r1=0; 1:r1=1;
> 0:r1=1; 1:r1=0;
> 0:r1=1; 1:r1=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Condition exists (0:r1=0 /\ 1:r1=0)
> Observation atomic_add_unless Never 0 3
> Time atomic_add_unless 0.00
> Hash=fa37a2359831690299e4cc394e45d966
> 
> The last commit in the herdtools7 repo. related to this implementation
> (AFAICT) is:
> 
>   9523c340917b6a ("herd/linux: make atomic_add_unless a primitive, so as to yield more precise dependencies for the returned boolean.")
> 
> but I can only vaguely remember those dependencies issues now :/  ...;
> maybe we can now solve these issues?  or should we change herd7 to re-
> turn a warning?  (Notice that this primitive is currently not exported
> to the linux-kernel.def file.)

Cool!  It would be good to add this to the .def file once the underlying
herd7 machinery is ready.  And then I would update the documentation
accordingly.  Or happily accept a patch updating the documentation,
as the case might be.  ;-)

							Thanx, Paul

>   Andrea
> 
> 
> > +
> > +	c.	The call_rcu() function is not modeled.  It can be
> > +		emulated in litmus tests by adding another process that
> > +		invokes synchronize_rcu() and the body of the callback
> > +		function, with (for example) a release-acquire from
> > +		the site of the emulated call_rcu() to the beginning
> > +		of the additional process.
> > +
> > +	d.	The rcu_barrier() function is not modeled.  It can be
> > +		emulated in litmus tests emulating call_rcu() via
> > +		(for example) a release-acquire from the end of each
> > +		additional call_rcu() process to the site of the
> > +		emulated rcu-barrier().
> > +
> > +	e.	Sleepable RCU (SRCU) is not modeled.  It can be
> > +		emulated, but perhaps not simply.
> > +
> > +	f.	Reader-writer locking is not modeled.  It can be
> > +		emulated in litmus tests using atomic read-modify-write
> > +		operations.
> > +
> >  The "herd7" tool has some additional limitations of its own, apart from
> >  the memory model:
> >  
> > @@ -204,3 +240,6 @@ the memory model:
> >  Some of these limitations may be overcome in the future, but others are
> >  more likely to be addressed by incorporating the Linux-kernel memory model
> >  into other tools.
> > +
> > +Finally, please note that LKMM is subject to change as hardware, use cases,
> > +and compilers evolve.
> > -- 
> > 2.17.1
> > 
> 

