Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeBDJQJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 04:16:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750818AbeBDJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 04:16:00 -0500
Date: Sun, 4 Feb 2018 01:16:01 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, parri.andrea@gmail.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com,
        akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180203084809.GE3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020409-0044-0000-0000-000003DB36DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008468; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00984726; UDB=6.00499587; IPR=6.00764097;
 BA=6.00005811; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019359; XFM=3.00000015;
 UTC=2018-02-04 09:15:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020409-0045-0000-0000-0000080AA497
Message-Id: <20180204091601.GO3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802040121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 05:10:06PM -0500, Alan Stern wrote:
> On Sat, 3 Feb 2018, Paul E. McKenney wrote:
> 
> > Please see below for an initial patch to this effect.  This activity
> > proved to be more productive than expected for these tests, which certainly
> > supports our assertion that locking needs more testing...
> > 
> > MP+polocks.litmus
> > MP+porevlocks.litmus
> > 
> > 	These are allowed by the current model, which surprised me a bit,
> > 	given that even powerpc would forbid them.  Is the rationale
> > 	that a lock-savvy compiler could pull accesses into the lock's
> > 	critical section and then reorder those accesses?  Or does this
> > 	constitute a bug in our model of locking?
> > 
> > 	(And these were allowed when I wrote recipes.txt, embarrassingly
> > 	enough...)
> > 
> > Z6.0+pooncelock+poonceLock+pombonce.litmus
> > 
> > 	This was forbidden when I wrote recipes.txt, but now is allowed.
> > 	The header comment for smp_mb__after_spinlock() makes it pretty
> > 	clear that it must be forbidden.  So this one is a bug in our
> > 	model of locking.
> 
> I just tried testing these under the most recent version of herd, and 
> all three were forbidden.

And they do for me as well once I upgraded to the most recent version of
herd.  Whew!!!

Boy, we weren't kidding when we said that you need to us the latest
and greatest herd7, now were we?  ;-)

							Thanx, Paul

	
