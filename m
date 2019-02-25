Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECA52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfBYR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:57:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbfBYR5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:57:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PHvckD065847
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:57:48 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qvjrcrrw4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:57:47 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Feb 2019 17:55:22 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 17:55:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PHtHtI20185304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 17:55:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C12AB2064;
        Mon, 25 Feb 2019 17:55:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D655B205F;
        Mon, 25 Feb 2019 17:55:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Feb 2019 17:55:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 43B6F16C4294; Mon, 25 Feb 2019 09:55:17 -0800 (PST)
Date:   Mon, 25 Feb 2019 09:55:17 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022517-0060-0000-0000-0000031214D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010663; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01166252; UDB=6.00609178; IPR=6.00946855;
 MB=3.00025736; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-25 17:55:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022517-0061-0000-0000-0000486C6260
Message-Id: <20190225175517.GK4072@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 02:00:14PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 22, 2019 at 12:21:28PM +0100, Andrea Parri wrote:
> > > What I do object to is a model that's weaker than any possible sane
> > > hardware.
> > 
> > Not the first time I hear you calling this out.  And inevitably, every
> > time, other slogans come to my mind:  "C is not an assembly language",
> 
> But it bloody well should be ;-)

Yeah, we had some debates about this sort of thing at the C++ Standards
Committee meeting last week.

Pointer provenance and concurrent algorithms, though for once not
affecting RCU!  We might actually be on the road to a fix that preserves
the relevant optimizations while still allowing most (if not all) existing
concurrent C/C++ code to continue working correctly.  (The current thought
is that loads and stores involving inline assembly, C/C++ atomics, or
volatile get their provenance stripped.  There may need to be some other
mechanisms for plain C-language loads and stores in some cases as well.)

But if you know of any code in the Linux kernel that needs to compare
pointers, one of which might be in the process of being freed, please
do point me at it.  I thought that the smp_call_function() code fit,
but it avoids the problem because only the sending CPU is allowed to
push onto the stack of pending smp_call_function() invocations.

That same concurrent linked stack pattern using cmpxchg() to atomically
push and xchg() to atomically pop the full list -would- have this problem.
The old pointer passed to cmpxchg() might reference an object that was
freed between the time that the old pointer was loaded and the time
that the cmpxchg() executed.  One way to avoid this is to do the push
operation in an RCU read-side critical section and use kfree_rcu()
instead of kfree().  Of course, code in the idle loop or that might
run on offline CPUs cannot use RCU, plus some data structures are not
happy with kfree_rcu() delays, so...

Again, if you know of any code in the Linux kernel that would have
problems with aggressive optimizations based on pointer provenance,
please let me know!

							Thanx, Paul

