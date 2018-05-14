Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeENWkk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:40:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752049AbeENWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:40:39 -0400
Date: Mon, 14 May 2018 15:42:03 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [PATCH tip/core/rcu 0/21] Contention reduction for v4.18
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423030258.GA23370@linux.vnet.ibm.com>
 <20180514164233.7c7bff00@roar.ozlabs.ibm.com>
 <20180514160907.GX26088@linux.vnet.ibm.com>
 <20180515082120.1dbc32b5@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515082120.1dbc32b5@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051422-0008-0000-0000-000003076A89
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032366; UDB=6.00527774; IPR=6.00811497;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:40:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0009-0000-0000-0000393FF5C3
Message-Id: <20180514224203.GQ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:21:20AM +1000, Nicholas Piggin wrote:
> On Mon, 14 May 2018 09:09:07 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Mon, May 14, 2018 at 04:42:33PM +1000, Nicholas Piggin wrote:
> > > On Sun, 22 Apr 2018 20:02:58 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >   
> > > > Hello!
> > > > 
> > > > This series reduces lock contention on the root rcu_node
> > > > structure, and is also the first precursor to TBD changes to
> > > > consolidate the three RCU flavors (RCU-bh, RCU-preempt, and
> > > > RCU-sched) into one.  
> > > 
> > > Hi Paul,
> > > 
> > > I've been running your rcu/dev branch and haven't noticed any
> > > problems yet. The irqsoff latency improvement is a little hard to
> > > measure because the scheduler, but I've tried turning balancing
> > > parameters right down and I'm yet to see any sign of RCU in traces
> > > (down to about 100us on a 176 CPU machine), so that's great.  
> > 
> > Good to hear!!!
> 
> Yep, as in, various other latencies are down to 100us, and still
> no sign of RCU, so RCU must be sitting somewhere below that.

Sometimes you get lucky.  ;-)

> > > (Not that RCU was ever the worst contributor to latency as I said,
> > > just that I noticed those couple of traces where it showed up.)
> > > 
> > > Thanks very much for the fast response, sorry I've taken a while to
> > > test.  
> > 
> > Would you be willing to give me a Tested-by on that series of patches?
> 
> Yes of course, for your rcu/dev series
> 
> Tested-by: Nicholas Piggin <npiggin@gmail.com>

Thank you very much!

The rcu/dev branch has been a bit dynamic of late, so I am going to
apply your Tested-by up to the merge point, which is 434533a52e8d ("Merge
branches 'exp.2018.04.20a', 'fixes.2018.04.30a', 'lock.2018.04.22a' and
'torture.2018.04.20a' into HEAD").  That will allow me to send my
pull request, and we can work out which of the more recent commits
I can apply your Tested-by to later.  ;-)

> Let me know if you make any other changes you'd like me to test before
> merge.

Will do, and thank you again!

There are some additional commits that should further reduce RCU's
latency, but they won't be going in until the v4.19 merge window, that
is, the one after this coming one.

							Thanx, Paul
