Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C34F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbeLQScl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:32:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbeLQSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:32:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHISqPR055167
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 13:32:39 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pef4hnrud-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 13:32:39 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 17 Dec 2018 18:32:37 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 18:32:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHIWWsk19071134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 18:32:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09479B2067;
        Mon, 17 Dec 2018 18:32:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA2FEB2065;
        Mon, 17 Dec 2018 18:32:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 17 Dec 2018 18:32:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EE29C16C2BA7; Mon, 17 Dec 2018 10:32:34 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:32:34 -0800
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
References: <20181216185130.GB4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812171054090.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812171054090.1630-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121718-0052-0000-0000-00000368AE23
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010241; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133150; UDB=6.00589054; IPR=6.00913319;
 MB=3.00024720; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-17 18:32:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121718-0053-0000-0000-00005F23FD9D
Message-Id: <20181217183234.GL4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=421 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:02:40AM -0500, Alan Stern wrote:
> On Sun, 16 Dec 2018, Paul E. McKenney wrote:
> 
> > OK, so "simultaneous" IPIs could be emulated in a real implementation by
> > having sys_membarrier() send each IPI (but not wait for a response), then
> > execute a full memory barrier and set a shared variable.  Each IPI handler
> > would spin waiting for the shared variable to be set, then execute a full
> > memory barrier and atomically increment yet another shared variable and
> > return from interrupt.  When that other shared variable's value reached
> > the number of IPIs sent, the sys_membarrier() would execute its final
> > (already existing) full memory barrier and return.  Horribly expensive
> > and definitely not recommended, but eminently doable.
> 
> I don't think that's right.  What would make the IPIs "simultaneous"  
> would be if none of the handlers return until all of them have started
> executing.  For example, you could have each handler increment a shared
> variable and then spin, waiting for the variable to reach the number of
> CPUs, before returning.
> 
> What you wrote was to have each handler wait until all the IPIs had 
> been sent, which is not the same thing at all.

You are right, the handlers need to do the atomic increment before
waiting for the shared variable to be set, and the sys_membarrier()
must wait for the incremented variable to reach its final value before
setting the shared variable.

> > The difference between current sys_membarrier() and the "simultaneous"
> > variant described above is similar to the difference between
> > non-multicopy-atomic and multicopy-atomic memory ordering.  So, after
> > thinking it through, my guess is that pretty much any litmus test that
> > can discern between multicopy-atomic and  non-multicopy-atomic should
> > be transformable into something that can distinguish between the current
> > and the "simultaneous" sys_membarrier() implementation.
> > 
> > Seem reasonable?
> 
> Yes.
> 
> > Or alternatively, may I please apply your Signed-off-by to your earlier
> > sys_membarrier() patch so that I can queue it?  I will probably also
> > change smp_memb() to membarrier() or some such.  Again, within the
> > Linux kernel, membarrier() can be emulated with smp_call_function()
> > invoking a handler that does smp_mb().
> 
> Do you really want to put sys_membarrier into the LKMM?  I'm not so 
> sure it's appropriate.

We do need it for the benefit of the C++ folks, but you are right that
it need not be accepted into the kernel to be useful to them.

So agreed, let's hold off for the time being.

							Thanx, Paul

