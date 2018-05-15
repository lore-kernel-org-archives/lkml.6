Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeEOQT0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:19:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751149AbeEOQTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:19:23 -0400
Date: Tue, 15 May 2018 09:20:48 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH memory-model 0/19] Updates to the formal memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514233328.GA7601@linux.vnet.ibm.com>
 <20180515061545.GA21993@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515061545.GA21993@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051516-0008-0000-0000-00000307E600
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009030; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032719; UDB=6.00527986; IPR=6.00811850;
 MB=3.00021128; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 16:19:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051516-0009-0000-0000-000039425E96
Message-Id: <20180515162048.GH26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:15:45AM +0200, Ingo Molnar wrote:
> 
> Hi,
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Hello!
> > 
> > This series contains updates to the Linux kernel's formal memory model in
> > tools/memory-model.  These are ready for inclusion into -tip.
> > 
> > 1.	Rename LKMM's "link" and "rcu-path" relations to "rcu-link"
> > 	and "rb", respectively, courtesy of Alan Stern.
> > 
> > 2.	Redefine LKMM's "rb" relation in terms of rcu-fence in order
> > 	to match the structure of LKMM's other strong fences, courtesy
> > 	of Alan Stern.
> > 
> > 3.	Update required version of herdtools7, courtesy of Akira Yokosawa.
> > 
> > 4.	 Fix cheat sheet typo: "RWM" should be "RMW", courtesy of Paolo Bonzini.
> > 
> > 5.	Improve cheatsheet.txt key for SELF and SV.
> > 
> > 6.	Fix cheatsheet.txt to note that smp_mb__after_atomic() orders
> > 	later RMW operations.
> > 
> > 7.	Model smp_store_mb(), courtesy of Andrea Parri.
> > 
> > 8.	Fix coding style in 'linux-kernel.def', courtesy of Andrea Parri.
> > 
> > 9.	Add scripts to test the memory model.
> > 
> > 10.	Add model support for spin_is_locked(), courtesy of Luc Maranget.
> > 
> > 11.	Flag the tests that exercise "cumulativity" and "propagation".
> > 
> > 12.	Remove duplicated code from lock.cat, courtesy of Alan Stern.
> > 
> > 13.	Improve comments in lock.cat, courtesy of Alan Stern.
> > 
> > 14.	Improve mixed-access checking in lock.cat, courtesy of Alan Stern.
> > 
> > 15.	Remove out-of-date comments and code from lock.cat, which have
> > 	been obsoleted by the settled-upon spin_is_locked() semantics,
> > 	courtesy of Alan Stern.
> > 
> > 16.	Fix coding style in 'lock.cat', bringing the indentation to
> > 	Linux-kernel standard, courtesy of Andrea Parri.
> > 
> > 17.	Update Andrea Parri's email address in the MAINTAINERS file,
> > 	oddly enough courtesy of Andrea Parri.  ;-)
> > 
> > 18.	Update ASPLOS information now that ASPLOS has come and gone,
> > 	courtesy of Andrea Parri.
> > 
> > 19.	Add reference for 'Simplifying ARM concurrency', courtesy
> > 	of Andrea Parri.
> > 
> > 								Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  MAINTAINERS                                                               |    2 
> >  tools/memory-model/Documentation/cheatsheet.txt                           |    7 
> >  tools/memory-model/Documentation/explanation.txt                          |  261 +++++-----
> >  tools/memory-model/Documentation/references.txt                           |   17 
> >  tools/memory-model/README                                                 |    2 
> >  tools/memory-model/linux-kernel.bell                                      |    4 
> >  tools/memory-model/linux-kernel.cat                                       |   53 +-
> >  tools/memory-model/linux-kernel.def                                       |   34 -
> >  tools/memory-model/litmus-tests/.gitignore                                |    1 
> >  tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus          |    2 
> >  tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus    |   35 +
> >  tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus      |   34 +
> >  tools/memory-model/litmus-tests/README                                    |   19 
> >  tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus |    4 
> >  tools/memory-model/lock.cat                                               |  197 ++++---
> >  tools/memory-model/scripts/checkalllitmus.sh                              |   73 ++
> >  tools/memory-model/scripts/checklitmus.sh                                 |   86 +++
> >  17 files changed, 595 insertions(+), 236 deletions(-)
> 
> Applied this and the other two series to the locking tree, thanks Paul!
> 
> I ended up editing some of the changelogs and titles, to better organize them:
> 
> 99c12749b172: tools/memory-model: Add reference for 'Simplifying ARM concurrency'
> 1a00b4554d47: tools/memory-model: Update ASPLOS information
> 5ccdb7536ebe: MAINTAINERS, tools/memory-model: Update e-mail address for Andrea Parri
> 05604e7e3adb: tools/memory-model: Fix coding style in 'lock.cat'
> cee0321a404f: tools/memory-model: Remove out-of-date comments and code from lock.cat
> 30b795df11a1: tools/memory-model: Improve mixed-access checking in lock.cat
> fd0359dbac3d: tools/memory-model: Improve comments in lock.cat
> 8559183ccaec: tools/memory-model: Remove duplicated code from lock.cat
> 1bd3742043fa: tools/memory-model: Flag "cumulativity" and "propagation" tests
> 15553dcbca06: tools/memory-model: Add model support for spin_is_locked()
> 2fb6ae162f25: tools/memory-model: Add scripts to test memory model
> d17013e0bac6: tools/memory-model: Fix coding style in 'linux-kernel.def'
> bf8c6d963d16: tools/memory-model: Model 'smp_store_mb()'
> bfd403bb3617: tools/memory-order: Update the cheat-sheet to show that smp_mb__after_atomic() orders later RMW operations
> 35bb6ee67906: tools/memory-order: Improve key for SELF and SV
> a839195186a2: tools/memory-model: Fix cheat sheet typo
> 5b62832c1e52: tools/memory-model: Update required version of herdtools7
> 9d036883a179: tools/memory-model: Redefine rb in terms of rcu-fence
> 1ee2da5f9b5a: tools/memory-model: Rename link and rcu-path to rcu-link and rb
> 1362ae43c503: locking/spinlocks: Clean up comment and #ifndef for {,queued_}spin_is_locked()
> c6f5d02b6a0f: locking/spinlocks/arm64: Remove smp_mb() from arch_spin_is_locked()
> b7e4aadef28f: locking/spinlocks: Document the semantics of spin_is_locked()
> 173af2613efd: locking/Documentation: Use `warning` RST directive
> fc7bdc90249b: locking/Documentation: Fix incorrect example code
> e89641dd038a: locking/memory-barriers.txt/kokr: Update Korean translation to de-emphasize smp_read_barrier_depends() some more
> e2ba8041f2ed: locking/memory-barriers.txt/kokr: Update Korean translation to fix description of data dependency barriers
> df9e0cc85c01: locking/memory-barriers.txt/kokr: Update Korean translation to cross-reference "tools/memory-model/"
> 1ea32723c42a: locking/memory-barriers.txt/kokr: Update Korean translation to de-emphasize smp_read_barrier_depends()
> eabed716672c: locking/memory-barriers.txt/kokr: Update Korean translation to indicate that READ_ONCE() now implies smp_barrier_depends()
> 5846581e3563: locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example

Very good, I will follow this style for the next merge window.

> In particular the Korean translation commits are IMHO more readable in this 
> fashion. I also simplified the translation commits internally:
> 
>     Translate this commit to Korean:
>     
>       f28f0868feb1 ("locking/memory-barriers: De-emphasize smp_read_barrier_depends() some more")

I have passed this on to SeongJae, and will check as well.

							Thanx, Paul
