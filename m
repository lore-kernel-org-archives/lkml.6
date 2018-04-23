Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755700AbeDWPqE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:46:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755244AbeDWPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:46:02 -0400
Date: Mon, 23 Apr 2018 08:47:07 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085127.GR4064@hirez.programming.kicks-ass.net>
 <20180423124000.GL26088@linux.vnet.ibm.com>
 <20180423094742.6582e19d@gandalf.local.home>
 <20180423141038.GA4064@hirez.programming.kicks-ass.net>
 <20180423103529.36848ae1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423103529.36848ae1@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042315-0040-0000-0000-00000420A83D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008906; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022153; UDB=6.00521692; IPR=6.00801388;
 MB=3.00020728; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 15:45:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042315-0041-0000-0000-00000826B23C
Message-Id: <20180423154707.GP26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:35:29AM -0400, Steven Rostedt wrote:
> On Mon, 23 Apr 2018 16:10:38 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >  http://lkml.kernel.org/r/20180227153646.GD3777@linux.vnet.ibm.com  
> > 
> > That thread using cond_resched_task_rcu_qs() seems like a _lot_ better
> > than having cond_resched() semantics change depending on random
> > !scheduler config parameters.
> 
> Yeah, I agree. Not sure why Paul didn't push it. Maybe because I never
> replied to that final email and he forgot?
> 
> Paul?

Yeah, I have been a bit event-driven of late.  So the thought is to keep
cond_resched() as-is and use cond_resched_task_rcu_qs(), that is after
the rename, for the stress tests instead of the current cond_resched().
Or did I lose the thread?

						Thanx, paul
