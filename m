Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeBYRvm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:51:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751837AbeBYRvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:51:39 -0500
Date: Sun, 25 Feb 2018 09:52:00 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 10/10] rcu: Account for rcu_all_qs() in
 cond_resched()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20171201192122.GA19301@linux.vnet.ibm.com>
 <1512156104-20104-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171202085626.GS3326@worktop>
 <20171202122220.GM7829@linux.vnet.ibm.com>
 <20180224151816.45597ca1@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224151816.45597ca1@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022517-0052-0000-0000-000002BE21F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008596; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00994971; UDB=6.00505700; IPR=6.00774305;
 MB=3.00019734; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-25 17:51:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022517-0053-0000-0000-00005BCF60A8
Message-Id: <20180225175200.GD2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 03:18:16PM -0500, Steven Rostedt wrote:
> On Sat, 2 Dec 2017 04:22:20 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Because there are a few key places within RCU and rcutorture that need it.
> > Without it, there are scenarios where the new cond_resched() never gets
> > activated, and thus doesn't take effect.
> > 
> > The key point is that with this series in place, it should not be necessary
> > to use cond_resched_rcu_qs() outside of kernel/rcu and kernel/torture.c.
> > Which is a valuable step forward, right?
> 
> I'm guessing the tracepoint benchmark is another situation. It's only
> existence is to benchmark tracepoints and should not be enabled on any
> production system. Thus, I think reverting patch 6 (the one removing it
> from the benchmark code) is the proper solution.

I would rather make the existing cond_resched() machinery work for
RCU-tasks, but please let me know if my proposed fix isn't doing what
you need.

And in any case, please accept my apologies for the hassle!

							Thanx, Paul
