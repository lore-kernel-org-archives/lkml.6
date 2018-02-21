Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938449AbeBUQFw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:05:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932308AbeBUQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:05:49 -0500
Date: Wed, 21 Feb 2018 08:06:02 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180217003959.GR3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802210958520.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802210958520.2032-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022116-0008-0000-0000-000002D8DD7B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008570; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993018; UDB=6.00504541; IPR=6.00772363;
 MB=3.00019674; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 16:05:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022116-0009-0000-0000-00003856D1FE
Message-Id: <20180221160602.GD3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:00:20AM -0500, Alan Stern wrote:
> On Fri, 16 Feb 2018, Paul E. McKenney wrote:
> 
> > On Fri, Feb 16, 2018 at 05:22:55PM -0500, Alan Stern wrote:
> > > Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> > > smp_read_barrier_depends() to READ_ONCE()") was merged for the 4.15
> > > kernel, it has not been necessary to use smp_read_barrier_depends().
> > > Similarly, commit 59ecbbe7b31c ("locking/barriers: Kill
> > > lockless_dereference()") removed lockless_dereference() from the
> > > kernel.
> > > 
> > > Since these primitives are no longer part of the kernel, they do not
> > > belong in the Linux Kernel Memory Consistency Model.  This patch
> > > removes them, along with the internal rb-dep relation, and updates the
> > > revelant documentation.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > I queued this, but would welcome an update that addressed Akira's
> > feedback as appropriate.
> 
> Is it too late to send a v2 of this patch?  I didn't want to do it 
> before now because the issue raised by Andrea wasn't settled.  (Some 
> could claim that it still isn't fully settled...)

Would you be willing to send a delta patch?  I can then place it directly
on top of your original patch, and once it settles out, I can ask Ingo
if he is willing to update the patch in -tip.

							Thanx, Paul
