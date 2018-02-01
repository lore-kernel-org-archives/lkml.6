Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756022AbeBABRj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:17:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755937AbeBABRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:17:36 -0500
Date: Wed, 31 Jan 2018 17:17:28 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
        elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131090006.onaopgyqthppoysi@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020101-0044-0000-0000-000003D90593
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008457; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983247; UDB=6.00498647; IPR=6.00762530;
 BA=6.00005806; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019311; XFM=3.00000015;
 UTC=2018-02-01 01:17:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020101-0045-0000-0000-0000080870BC
Message-Id: <20180201011728.GL3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010012
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:00:06AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Mon, Jan 29, 2018 at 07:57:24AM +0100, Ingo Molnar wrote:
> > > 
> > > hi Paul,
> > > 
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > Hello, Ingo,
> > > > 
> > > > This pull request contains a single commit that adds a memory model to
> > > > the tools directory.  This memory model can (roughly speaking) be thought
> > > > of as an automated version of memory-barriers.txt.  It is written in the
> > > > "cat" language, which is executable by the externally provided "herd7"
> > > > simulator, which exhaustively explores the state space of small litmus
> > > > tests.
> > > > 
> > > > This memory model is accompanied by extensive documentation on its use
> > > > and its design.  Two versions have been sent to LKML and feedback
> > > > incorporated:
> > > > 
> > > > 1.	http://lkml.kernel.org/r/20171113184031.GA26302@linux.vnet.ibm.com
> > > > 2.	http://lkml.kernel.org/r/20180119035855.GA29296@linux.vnet.ibm.com
> > > > 
> > > > This model has been presented and demoed at a number of Linux gatherings,
> > > > including the 2016 LinuxCon EU, the 2016 Linux Plumbers Conference,
> > > > the 2016 Linux Kernel Summit, the 2017 linux.conf.au, and the 2017 Linux
> > > > Plumbers Conference, which featured a workshop helping a number of Linux
> > > > kernel hackers install and use the tool.
> > > > 
> > > > This memory model has matured to the point where it would be good to include
> > > > it in the Linux kernel, for example, to allow it to track changes as new
> > > > hardware and use cases are added.  We expect the rate of change to be similar
> > > > to that of Documentation/memory-barriers.txt.
> > > > 
> > > > This memory model is available in the git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git 
> > > > 
> > > > for you to fetch changes up to 1c27b644c0fdbc61e113b8faee14baeb8df32486:
> > > > 
> > > >   Automate memory-barriers.txt; provide Linux-kernel memory model (2018-01-24 20:53:49 -0800)
> > > 
> > > Looks good to me, but the commit is not in the master branch of your tree, which 
> > > branch should I pull?
> > 
> > Oops!!!  The branch is lkmm-for-mingo.
> > 
> > Please accept my apologies for the implicit maintainer treasure hunt!
> 
> No problem, was able to pull it!
> 
> I really like this formal description of of the Linux kernel memory coherency 
> model and the extensive documentation around it. Clearly a lot of effort went
> into this work!

Glad you like it, and kudos to my partners in crime!  ;-)

> A couple of questions:
> 
> - Would it be possible to include all the nice descriptions of the litmus tests in
>   the tests themselves? Right now it's a bit weird that most of them come with
>   zero explanations, but the tools/memory-model/litmus-tests/README lists most of
>   them.

Good point, and should be doable.

> - Similary, some of the high level descriptions in tools/memory-model/README
>   should probably propagated into the source code files as well: for example
>   both tools/memory-model/lock.cat and linux-kernel.cat could be improved that
>   way.

I gratefully accept Peter's and Will's offer here.  ;-)

> - Could tools/memory-model/MAINTAINERS be added to the main Linux MAINTAINERS file 
>   as well, like we do for other bits of tooling?

Easily enough.  Should we have both files, or just keep the
information in the main Linux MAINTAINERS file, eliminating
tools/memory-model/MAINTAINERS?  I have the usual concerns about
duplicating this information.

> - There's no description about why the .bell file is called 'bell' and what 
>   language/syntax it is in - I had to search around to figure out that it's a 
>   "Bell extension" to .cat files. This aspect IMHO isn't really obvious to first 
>   time readers so a bit more explanation would be nice.

This was named before my time, but I believe that it is a play on "bell
the cat" (https://en.wikipedia.org/wiki/Belling_the_cat).

Anyway, by convention (roughly speaking) the .bell file defines events
(loads, stores, atomic operations, barriers) and the .cat file defines
how those events interact, as in what cycles are permitted and not.

> - A high level question: have you considered calling it the "Linux kernel memory 
>   coherency model", instead of the "Linux memory model"? Another naming would be 
>   the "Linux kernel memory access model" as memory-barriers.txt calls it.
>   The "memory model" name is overly generic, ambiguous and somewhat misleading,
>   as we usually mean the virtual memory layout/model when we say "memory model".
>   GCC too uses it in that sense: 'small memory model' and 'large memory model' -
>   which too is about VM layout, not multiprocessing coherency.

Interesting point.  There is a lot of history calling these things
"memory models", so there may be different tradeoffs for different people.
Wikipedia has these two, which might indicate that the ambiguity is not
too problematic:

https://en.wikipedia.org/wiki/Memory_model_(programming)
https://en.wikipedia.org/wiki/Memory_address#Memory_models

But worth some thought!

> - A long term question: have you considered and would it make sense to generate a
>   memory-barriers.txt like file directly into Documentation/locking/, using the
>   formal description? That way any changes/extensions/fixes to the model could be
>   tracked on a high level, without readers having to understand the formal
>   representation.

I hadn't considered this at all, actually.  ;-)

The sections of memory-barriers.txt dealing with MMIO ordering would need
to stay hand-generated, but they are a very small fraction of the total.
The herd7 tool is capable of generating cool diagrams sort of like
this one: https://static.lwn.net/images/2017/mm-model/rmo-acyclic.png,
which might replace at least some of the hand-generated ASCII-art
diagrams.

Although I do confess harboring some skepticism about being able to
generated high-quality text, there is no denying that it would be
valuable to be able to do so.

> In any case, the base commit is certainly nice and clean and I've pulled it into 
> tip:locking/core for a v4.17 merge.

Very good!

> I believe these additional improvements (to the extent you agree with doing them!) 
> could/should be done as add-on commits on top of this existing commit.

Sounds good!

Would you prefer a pull request or a patch series for these?

							Thanx, Paul
