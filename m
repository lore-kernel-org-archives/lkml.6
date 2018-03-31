Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeCaX2u (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 19:28:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752547AbeCaX2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 19:28:49 -0400
Date: Sat, 31 Mar 2018 16:29:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-4.17 0/3] Changes and clean-ups for
 spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522230353-12213-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180330113645.kd3rjjuboz4gcq7m@gmail.com>
 <20180330120919.GA5879@andrea>
 <20180331131200.GA6084@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331131200.GA6084@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18033123-0056-0000-0000-00000435DB77
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008779; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01011278; UDB=6.00515320; IPR=6.00790556;
 MB=3.00020349; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-31 23:28:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18033123-0057-0000-0000-00000877EC1D
Message-Id: <20180331232940.GE3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-31_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803310246
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 03:12:00PM +0200, Andrea Parri wrote:
> On Fri, Mar 30, 2018 at 02:09:19PM +0200, Andrea Parri wrote:
> > On Fri, Mar 30, 2018 at 01:36:45PM +0200, Ingo Molnar wrote:
> > > 
> > > (Paul and PeterZ Cc:-ed)
> > > 
> > > hi Andrea,
> > > 
> > > * Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> > > 
> > > > A resend of the "arch_spin_is_locked() patches" discussed in the last
> > > > days,  together with a third patch/clean-up suggested by Will during
> > > > the review procees.  The first two patches are unmodified, except for
> > > > the inclusion of Acked-by:'s.
> > > > 
> > > > Cheers,
> > > >   Andrea
> > > > 
> > > > Andrea Parri (3):
> > > >   arm64: Remove smp_mb() from arch_spin_is_locked()
> > > >   powerpc: Remove smp_mb() from arch_spin_is_locked()
> > > >   locking: Clean-up comment and #ifndef for {,queued_}spin_is_locked()
> > > > 
> > > >  arch/arm64/include/asm/spinlock.h   | 5 -----
> > > >  arch/powerpc/include/asm/spinlock.h | 1 -
> > > >  include/asm-generic/qspinlock.h     | 2 --
> > > >  include/linux/mutex.h               | 3 ---
> > > >  4 files changed, 11 deletions(-)
> > > 
> > > Could you please also Cc: Paul to the next version of your series, who is usually 
> > > collecting these patches? He might not have noticed these patches in the 
> > > linux-kernel mailing list firehose which is way too high traffic.
> > > 
> > > Also, could you please use "git-send-email --no-chain-reply-to" or so, to make 
> > > sure mails 1/2/3 properly email-chain off the mail 0 in a non-nested way? Right 
> > > now the mails are 4 separate mails with nothing connecting them.
> > 
> > Absolutely. Thank you for the recommendations.
> 
> I'm planning to wait for some feedback on v2 before sending v3 (or pinging
> on v2); please let me know if you'd prefer a RESEND of v2 instead.
> 
> Paul:
> 
> In the meantime, here are (for easy of reference) the message IDs of the 3
> emails corresponding to the patches contained in this series/version:
> 
>   [1/3] arm64: Remove smp_mb() from arch_spin_is_locked()
> 	<1522230419-12275-1-git-send-email-andrea.parri@amarulasolutions.com>
> 
>   [2/3] powerpc: Remove smp_mb() from arch_spin_is_locked()
> 	<1522230457-12337-1-git-send-email-andrea.parri@amarulasolutions.com>
> 
>   [3/3] locking: Clean-up comment and #ifndef for {,queued_}spin_is_locked()
> 	<1522230518-12398-1-git-send-email-andrea.parri@amarulasolutions.com>
> 
> The discussion on the previous/first version can be found here:
> 
> 	https://marc.info/?l=linux-kernel&m=152223054224291
> 	https://marc.info/?l=linux-kernel&m=152223531625930&w=2
> 
> Please notice that these patches are all targetting 4.17. Also, 2/3 hasn't
> been acked by the arch maintainers (so, we should hold off on this patch).

Agreed, plus a couple of the powerpc maintainers objected.  The smp_mb()
isn't hurting anything given current use cases, so without their ack we
should not push 2/3.

I suspec that we are a bit late for 4.17, but who knows?  If we are too
late, 4.18 will be here before we know it.  Might need a bit of merging,
but these patches should not be hard to merge, so this should not be a
problem.

> Given these patches/discussion, you may want to also collect the (related):
> 
>   https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> 
> (you were Cc-ed): this has been stalling since more than a couple of weeks
> now, and I'm not aware of any objections to it.

Especially given that one of the objections from the powerpc maintainers
was a lack of documentation.

In your v3, could you please send 1/3 and 3/3 along with the patch adding
the docbook header to spin_is_locked() as a three-patch series using
the method Ingo suggested?  I will pull it into my tree, and we can
go from there.  If the powerpc maintainers change their minds on 2/3,
we can pull that in as well.  (And I am back home, so should be a bit
more responsive than I have been for the past four weeks!)

							Thanx, Paul

>   Andrea
> 
> 
> > 
> >   Andrea
> > 
> > 
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> 
