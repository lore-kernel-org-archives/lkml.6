Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB07C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C32F20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfAPQPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:15:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbfAPQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:15:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGEIrg026349
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:15:21 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q25b4014s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:15:20 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:15:19 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:15:16 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGFFmv13172844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:15:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BF5CB2071;
        Wed, 16 Jan 2019 16:15:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44F02B205F;
        Wed, 16 Jan 2019 16:15:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 16:15:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E5F4916C64DF; Wed, 16 Jan 2019 08:15:14 -0800 (PST)
Date:   Wed, 16 Jan 2019 08:15:14 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH] fs: ratelimit __find_get_block_slow() failure message.
Reply-To: paulmck@linux.ibm.com
References: <CACT4Y+brHvfKHb2CvkBFRxrm0hXKA+j_eW=orSWGWutcQwZ9iw@mail.gmail.com>
 <CACT4Y+atyYbmrkyX0n+kvBWOt0OaauQbvrRhpUezaHXce5ZDrA@mail.gmail.com>
 <54b68f21-c8b5-7074-74e0-06e3d7ee4003@i-love.sakura.ne.jp>
 <CACT4Y+ZyP2QGL3ENJZRe8qbiL8SB8yDPHRY-npTzb14+LB05RQ@mail.gmail.com>
 <20190116104308.GC26069@quack2.suse.cz>
 <CACT4Y+akwPNEAiBtd5j6r0M6M7DmXV3kig+bnDL39H7uu44O3Q@mail.gmail.com>
 <20190116115618.GE26069@quack2.suse.cz>
 <CACT4Y+ZtrBeZyNeSJ_9d3DdVuP21=h7TNnOZJ_wLhLu11+qAAA@mail.gmail.com>
 <20190116145130.GH26069@quack2.suse.cz>
 <CACT4Y+Y0Q=ZoQfV9cBozhCe1ujCcydhhUwzBwucniX+fQ_S5EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y0Q=ZoQfV9cBozhCe1ujCcydhhUwzBwucniX+fQ_S5EA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011616-0068-0000-0000-00000383B136
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010418; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147361; UDB=6.00597659; IPR=6.00927657;
 MB=3.00025158; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-16 16:15:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0069-0000-0000-00004727DF2C
Message-Id: <20190116161514.GJ1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:33:05PM +0100, Dmitry Vyukov wrote:
> On Wed, Jan 16, 2019 at 3:51 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 16-01-19 13:37:22, Dmitry Vyukov wrote:
> > > On Wed, Jan 16, 2019 at 12:56 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 16-01-19 12:03:27, Dmitry Vyukov wrote:
> > > > > On Wed, Jan 16, 2019 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Wed 16-01-19 10:47:56, Dmitry Vyukov wrote:
> > > > > > > On Fri, Jan 11, 2019 at 1:46 PM Tetsuo Handa
> > > > > > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > > > > > >
> > > > > > > > On 2019/01/11 19:48, Dmitry Vyukov wrote:
> > > > > > > > >> How did you arrive to the conclusion that it is harmless?
> > > > > > > > >> There is only one relevant standard covering this, which is the C
> > > > > > > > >> language standard, and it is very clear on this -- this has Undefined
> > > > > > > > >> Behavior, that is the same as, for example, reading/writing random
> > > > > > > > >> pointers.
> > > > > > > > >>
> > > > > > > > >> Check out this on how any race that you might think is benign can be
> > > > > > > > >> badly miscompiled and lead to arbitrary program behavior:
> > > > > > > > >> https://software.intel.com/en-us/blogs/2013/01/06/benign-data-races-what-could-possibly-go-wrong
> > > > > > > > >
> > > > > > > > > Also there is no other practical definition of data race for automatic
> > > > > > > > > data race detectors than: two conflicting non-atomic concurrent
> > > > > > > > > accesses. Which this code is. Which means that if we continue writing
> > > > > > > > > such code we are not getting data race detection and don't detect
> > > > > > > > > thousands of races in kernel code that one may consider more harmful
> > > > > > > > > than this one the easy way. And instead will spent large amounts of
> > > > > > > > > time to fix some of then the hard way, and leave the rest as just too
> > > > > > > > > hard to debug so let the kernel continue crashing from time to time (I
> > > > > > > > > believe a portion of currently open syzbot bugs that developers just
> > > > > > > > > left as "I don't see how this can happen" are due to such races).
> > > > > > > > >
> > > > > > > >
> > > > > > > > I still cannot catch. Read/write of sizeof(long) bytes at naturally
> > > > > > > > aligned address is atomic, isn't it?
> > > > > > >
> > > > > > > Nobody guarantees this. According to C non-atomic conflicting
> > > > > > > reads/writes of sizeof(long) cause undefined behavior of the whole
> > > > > > > program.
> > > > > >
> > > > > > Yes, but to be fair the kernel has always relied on long accesses to be
> > > > > > atomic pretty heavily so that it is now de-facto standard for the kernel
> > > > > > AFAICT. I understand this makes life for static checkers hard but such is
> > > > > > reality.
> > > > >
> > > > > Yes, but nobody never defined what "a long access" means. And if you
> > > > > see a function that accepts a long argument and stores it into a long
> > > > > field, no, it does not qualify. I bet this will come at surprise to
> > > > > lots of developers.
> > > >
> > > > Yes, inlining and other optimizations can screw you.
> > > >
> > > > > Check out this fix and try to extrapolate how this "function stores
> > > > > long into a long leads to a serious security bug" can actually be
> > > > > applied to whole lot of places after inlining (or when somebody just
> > > > > slightly shuffles code in a way that looks totally safe) that also
> > > > > kinda look safe and atomic:
> > > > > https://lore.kernel.org/patchwork/patch/599779/
> > > > > So where is the boundary between "a long access" that is atomic and
> > > > > the one that is not necessary atomic?
> > > >
> > > > So I tend to rely on "long access being atomic" for opaque values (no
> > > > flags, no counters, ...). Just value that gets fetched from some global
> > > > variable / other data structure, stored, read, and possibly compared for
> > > > equality. I agree the compiler could still screw you if it could infer how
> > > > that value got initially created and try to be clever about it...
> > >
> > > So can you, or somebody else, define a set of rules that we can use to
> > > discriminate each particular case? How can we avoid that "the compiler
> > > could still screw you"?
> > >
> > > Inlining is always enabled, right, so one needs to take into account
> > > everything that's possibly can be inlined. Now or in future. And also
> > > link-time-code generation, if we don't use it we are dropping 10% of
> > > performance on the floor.
> > > Also, ensuring that the code works when it's first submitted is the
> > > smaller part of the problem. It's ensuring that it continues to work
> > > in future what's more important. Try to imagine what amount of burden
> > > this puts onto all developers who touch any kernel code in future.
> > > Basically if you slightly alter local logic in a function that does
> > > not do any loads/stores, you can screw multiple "proofs" that long
> > > accesses are atomic. Or, you just move a function from .c file to .h.
> > > I can bet nobody re-proofs all "long accesses are atomic" around the
> > > changed code during code reviews, so these things break over time.
> > > Or, even if only comparisons are involved (that you mentioned as
> > > "safe") I see how that can actually affect compilation process. Say,
> > > we are in the branch where 2 variables compare equal, now since no
> > > concurrency is involved from compiler point of view, it can, say,
> > > discard one variable and then re-load it from the other variable's
> > > location, and say not the other variable has value that the other one
> > > must never have. I don't have a full scenario, but that's exactly the
> > > point. One will never see all possibilities.
> > >
> > > It all becomes super slippery slope very quickly. And we do want
> > > compiler to generate as fast code as possible and do all these
> > > optimizations. And it's not that there are big objective reasons to
> > > not just mark all concurrent accesses and stop spending large amounts
> > > of time on these "proofs".
> >
> > I guess you've convinced me that somehow marking such accesses is
> > desirable. So is using atomic_long_t and atomic_long_set()
> > / atomic_long_read() for manipulation instead what you suggest?
> 
> +Paul, Alan, Andrea, who may better know the long-term direction.
> I think the closer analog of "plain long read/write that is intended
> to be atomic" is using READ_ONCE/WRITE_ONCE with a normal non-atomic
> type. It should achieve the goal of just read/write it once without
> any tricks, but also makes them visible/searchable for humans and
> tools and potential future refactoring to something else.

Agreed, use of READ_ONCE() and WRITE_ONCE() should suffice.

The atomic_long_set() and atomic_long_read() would also work, but are
a bit more typing.  ;-)

							Thanx, Paul

