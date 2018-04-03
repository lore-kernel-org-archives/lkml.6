Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDCQLG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:11:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751430AbeDCQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:11:05 -0400
Date: Tue, 3 Apr 2018 09:11:34 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180403133543.GA26653@andrea>
 <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
 <29562.1522759749@warthog.procyon.org.uk>
 <13191.1522763553@warthog.procyon.org.uk>
 <20180403141718.GG3948@linux.vnet.ibm.com>
 <20180403144300.GE4082@hirez.programming.kicks-ass.net>
 <20180403150356.GJ3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403150356.GJ3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040316-2213-0000-0000-0000028962A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008795; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012571; UDB=6.00516069; IPR=6.00791837;
 MB=3.00020394; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 16:11:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040316-2214-0000-0000-0000599F86D3
Message-Id: <20180403161134.GA31898@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 08:03:56AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 03, 2018 at 04:43:00PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 03, 2018 at 07:17:18AM -0700, Paul E. McKenney wrote:
> > > Suggestions for a fix?  Clearly great care is required when using it
> > > in things like WARN_ON()...
> > 
> > Yeah, don't use it there, use lockdep_assert_held().
> 
> Good point, -ETOOEARLY.  ;-)
> 
> > As I stated before in this thread, ideally we'd make *_is_locked() go
> > away entirely.
> 
> After being reminded of the issues on UP systems, I now have much more
> sympathy for that view...

And so the main remaining use case is debug prints on !PROVE_LOCKING
builds.  Which need some thought about the UP case.

Or am I missing something here?

							Thanx, Paul
