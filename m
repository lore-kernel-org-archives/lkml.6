Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbeC1OTa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:19:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753499AbeC1OTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:19:21 -0400
Date: Wed, 28 Mar 2018 07:20:04 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <20180328134813.GF4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328134813.GF4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032814-2213-0000-0000-000002865F6F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008758; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009655; UDB=6.00514354; IPR=6.00788937;
 MB=3.00020289; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-28 14:19:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032814-2214-0000-0000-0000598F955F
Message-Id: <20180328142004.GR3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 03:48:13PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 28, 2018 at 06:42:32AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > The prototype patch shown below provides files required to allow herd7 to
> > evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> > provided by s390.  
> 
> There really isn't anything s390 specific here is there? That is, would
> this not equally work for x86 and sparc, both of which are similarly TSO
> ?

As I understand it, there is a difference.  The difference from TSO
systems such as x86 is that s390 is multicopy atomic as well as TSO.
In contrast, x86 is TSO as well as other-multicopy-atomic.  I must defer
to Martin and Christian for details -- this should be interpreted as a
feeble first attempt on my part, not any sort of IBM-approved definition
of s390.  ;-)

> Given that, should this not be called TSO instead of s390 ?

I agree completely with a single tso.cfg, TSO.cfg, or whatever name,
as opposed to a bunch of identical files for x86, SPARC, ...

							Thanx, Paul
