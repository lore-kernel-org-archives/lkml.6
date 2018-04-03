Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeDCPDI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:03:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751332AbeDCPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:03:06 -0400
Date: Tue, 3 Apr 2018 08:03:56 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403144300.GE4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040315-0024-0000-0000-0000034015FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008795; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012548; UDB=6.00516055; IPR=6.00791815;
 MB=3.00020392; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 15:03:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040315-0025-0000-0000-000047888969
Message-Id: <20180403150356.GJ3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 04:43:00PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 03, 2018 at 07:17:18AM -0700, Paul E. McKenney wrote:
> > Suggestions for a fix?  Clearly great care is required when using it
> > in things like WARN_ON()...
> 
> Yeah, don't use it there, use lockdep_assert_held().

Good point, -ETOOEARLY.  ;-)

> As I stated before in this thread, ideally we'd make *_is_locked() go
> away entirely.

After being reminded of the issues on UP systems, I now have much more
sympathy for that view...

							Thanx, Paul
