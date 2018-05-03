Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeECSXJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:23:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751095AbeECSXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:23:08 -0400
Date: Thu, 3 May 2018 11:24:25 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Reply-To: paulmck@linux.vnet.ibm.com
References: <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
 <20180503144450.GD12217@hirez.programming.kicks-ass.net>
 <20180503161231.GI26088@linux.vnet.ibm.com>
 <20180503164508.GG12217@hirez.programming.kicks-ass.net>
 <20180503171850.GL26088@linux.vnet.ibm.com>
 <20180503175456.GI12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503175456.GI12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050318-0048-0000-0000-00000267B194
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008963; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027002; UDB=6.00524569; IPR=6.00806135;
 MB=3.00020910; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-03 18:23:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050318-0049-0000-0000-000044FE3296
Message-Id: <20180503182425.GM26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 07:54:56PM +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 10:18:50AM -0700, Paul E. McKenney wrote:
> > > +	if (per_cpu(rcu_cpu_started, cpu))
> > 
> > I would log a non-splat dmesg the first time this happened, just for my
> > future sanity, but otherwise looks fine.  I am a bit concerned about
> > calls to rcu_cpu_starting() getting sprinkled all through the code.
> > Or am I being excessively paranoid?
> 
> Don't think so, but lets first see if this at all works. If not we'll
> need to figure out something else anyway.

Works for me!

							Thanx, Paul
