Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D588C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CABB206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CABB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeLNFUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:20:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbeLNFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:20:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBE5JK1C061940
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:20:16 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pc39spau0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:20:16 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 05:20:15 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 05:20:10 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBE5K9JJ16777424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 05:20:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D135B205F;
        Fri, 14 Dec 2018 05:20:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04BA1B2065;
        Fri, 14 Dec 2018 05:20:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 05:20:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9440916C1017; Thu, 13 Dec 2018 21:20:08 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:20:08 -0800
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
References: <20181214002043.GP4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812132110100.26937-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812132110100.26937-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121405-0064-0000-0000-000003862A8E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010223; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131494; UDB=6.00588040; IPR=6.00911626;
 MB=3.00024687; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 05:20:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121405-0065-0000-0000-00003BACB171
Message-Id: <20181214052008.GT4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:26:47PM -0500, Alan Stern wrote:
> On Thu, 13 Dec 2018, Paul E. McKenney wrote:
> 
> > > > A good next step would be to automatically generate random tests along
> > > > with an automatically generated prediction, like I did for RCU a few
> > > > years back.  I should be able to generalize my time-based cheat for RCU to
> > > > also cover SRCU, though sys_membarrier() will require a bit more thought.
> > > > (The time-based cheat was to have fixed duration RCU grace periods and
> > > > RCU read-side critical sections, with the grace period duration being
> > > > slightly longer than that of the critical sections.  The number of
> > > > processes is of course limited by the chosen durations, but that limit
> > > > can easily be made insanely large.)
> > > 
> > > Imagine that each sys_membarrier call takes a fixed duration and each 
> > > other instruction takes slightly less (the idea being that each 
> > > instruction is a critical section).  Instructions can be reordered 
> > > (although not across a sys_membarrier call), but no matter how the 
> > > reordering is done, the result is disallowed.
> 
> This turns out not to be right.  Instead, imagine that each 
> sys_membarrier call takes a fixed duration, T.  Other instructions can 
> take arbitrary amounts of time and can be reordered abitrarily, with 
> two restrictions:
> 
> 	Instructions cannot be reordered past a sys_membarrier call;
> 
> 	If instructions A and B are reordered then the time duration
> 	from B to A must be less than T.
> 
> If you prefer, you can replace the second restriction with something a 
> little more liberal:
> 
> 	If A and B are reordered and A ends up executing after a 
> 	sys_membarrier call (on any CPU) then B cannot execute before 
> 	that sys_membarrier call.
> 
> Of course, this form is a consequence of the more restrictive form.

Makes sense.  And the zero-size critical sections are why sys_membarrier()
cannot be directly used for classic deferred reclamation.

> > It gets a bit trickier with interleavings of different combinations
> > of RCU, SRCU, and sys_membarrier().  Yes, your cat code very elegantly
> > sorts this out, but my goal is to be able to explain a given example
> > to someone.
> 
> I don't think you're going to be able to fit different combinations of
> RCU, SRCU, and sys_membarrier into this picture.  How would you allow
> tests with incorrect interleaving, such as GP - memb - RSCS - nothing,
> while forbidding similar tests with correct interleaving?

Well, no, I cannot do a simple linear scan tracking time, which is what
the current scripts do.  I must instead find longest sequence with all
operations of the same type (RCU, SRCU, or memb) and work out their
worst-case timing.  If the overall effect of a given sequence is to
go backwards in time, the result is allowed.  Otherwise eliminate that
sequence from the cycle and repeat.  If everything is eliminated, the
cycle is forbidden.

Which can be thought of as an iterative process similar to something
called "rcu-fence", can't it?  ;-)

							Thanx, Paul

