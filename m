Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeEOAak (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:30:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752222AbeEOAai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:30:38 -0400
Date: Mon, 14 May 2018 17:32:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525964381.git.joe@perches.com>
 <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
 <20180514222456.GO26088@linux.vnet.ibm.com>
 <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
 <20180514235832.GR26088@linux.vnet.ibm.com>
 <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051500-0052-0000-0000-000002EE86FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009027; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032402; UDB=6.00527796; IPR=6.00811534;
 MB=3.00021115; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 00:30:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051500-0053-0000-0000-00005CAF728B
Message-Id: <20180515003205.GT26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:23:59PM -0700, Joe Perches wrote:
> On Mon, 2018-05-14 at 16:58 -0700, Paul E. McKenney wrote:
> > OK, so if I define pr_fmt as follows, I get the old behavior?
> > 
> > 	#define pr_fmt(fmt) fmt
> 
> yes.

OK, then I will queue patches with this for the near term for
the various torture files.

> > I just queued
> > a commit to be squashed into my version of your patch 18/18 that adds
> > this to kernel/rcu/rcu_segcblist.c.  This joins the ones that your
> > patch added to kernel/rcu/srcutree.c and kernel/rcu/tree.c.
> > 
> > Should I also add "#define pr_fmt(fmt) "rcu: " fmt" to these files?
> > 
> > kernel/rcu/srcutiny.c
> > kernel/rcu/sync.c
> > kernel/rcu/tiny.c
> 
> Well, I don't actually remember why the define
> was added to rcu_segcblist.c.
> 
> Most of this was done via a script which looked
> for pr_<level> uses without a pr_fmt in the same
> file.
> 
> Dunno why rcu_segcblist was modified.
> Maybe it was a braino.

So this change does not affect WARN_ON_ONCE() and friends?  (That was
my guess.)  If not, I will revert my squash patch.

And it could also be that the files changed between your running the
script and sending the patch.

							Thanx, Paul
