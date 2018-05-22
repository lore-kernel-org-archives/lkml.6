Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeEVQEw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:04:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60949 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751196AbeEVQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:04:49 -0400
Date: Tue, 22 May 2018 09:05:34 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU branching for the v4.19 merge window
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180517144044.GA6089@linux.vnet.ibm.com>
 <20180522112736.4b44ae3c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522112736.4b44ae3c@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052216-0012-0000-0000-0000164A0853
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036074; UDB=6.00529992; IPR=6.00815202;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 16:04:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052216-0013-0000-0000-000052E328A1
Message-Id: <20180522160534.GT3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:27:36AM -0400, Steven Rostedt wrote:
> On Thu, 17 May 2018 07:40:44 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Hello, Steve!
> > 
> > Another year, another difficult-to-branch set of RCU commits.
> > 
> > In happy contrast to last year, I can make some branches (SRCU, some
> > of the torture commits, and a few miscellaneous commits), but I will
> > likely end up with several short branches and one huge one.  My thought
> > is to keep the long branch, but email the patches out in a few separate
> > serieses, with each depending on its predecessor.  For example, one series
> > from the big branch would be folding the ->gpnum and ->completed fields
> > into a single ->gp_seq, which helps the RCU-flavor consolidation task.
> > Another series suppresses some rare false-positive splats that have been
> > plaguing me for more than a year.  Yet another series within this huge
> > branch applies and optimizes funnel locking for grace-period startup.
> > 
> > The problem is that the conversion to ->gp_seq has a very large footprint,
> > which of course generates lots of conflicts.  I could of course collapse
> > these commits into a single commit, but if I did that I would also defer
> > to the merge window following v4.19 due to the resulting loss of bisection
> > within that change.
> > 
> > Any advice?
> > 
> > The commits are for-mingo..rcu/dev in my -rcu tree.
> 
> I don't see these branches (and I don't pull tags).

You don't see them yet because I don't create them until after -rc1 time,
which is a few weeks out.  If you go far enough down from rcu/dev you
will see branches (about 90 commits down from HEAD), but these branches
are already in -tip for v4.18.

> How bad are the conflicts? Or is it too late to respond to help (sorry,
> was on vacation :-)

The conflicts are already causing me substantial hassles when rebasing
bug fixes back to the buggy commits, so the conflicts are non-trivial.
Hence my reaching out to you, given your discomfort with last year's
long-chain RCU submission.

And you do have some time to respond.  ;-)

							Thanx, Paul
