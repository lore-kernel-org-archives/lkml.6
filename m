Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeENVE1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:04:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752096AbeENVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:04:25 -0400
Date: Mon, 14 May 2018 14:05:50 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525964381.git.joe@perches.com>
 <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <2b66d372-dac9-0fad-af44-bfa84d996985@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b66d372-dac9-0fad-af44-bfa84d996985@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051421-0052-0000-0000-000002EE6867
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032334; UDB=6.00527754; IPR=6.00811465;
 MB=3.00021113; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 21:04:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051421-0053-0000-0000-00005CAEF361
Message-Id: <20180514210550.GM26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:52:48PM -0700, Randy Dunlap wrote:
> On 05/14/2018 01:29 PM, Paul E. McKenney wrote:
> > On Thu, May 10, 2018 at 08:45:44AM -0700, Joe Perches wrote:
> >> Use a consistent logging prefix for all rcu related output.
> >>
> >> Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > I took parts of this (thank you!) but have concerns about other parts.
> > 
> >> ---
> >>  kernel/rcu/rcu_segcblist.c |  2 ++
> >>  kernel/rcu/rcuperf.c       | 10 ++++---
> >>  kernel/rcu/rcutorture.c    | 46 +++++++++++++++----------------
> >>  kernel/rcu/srcutiny.c      |  2 ++
> >>  kernel/rcu/srcutree.c      |  5 +++-
> >>  kernel/rcu/tiny.c          |  3 +++
> >>  kernel/rcu/tree.c          |  8 +++---
> >>  kernel/rcu/tree_plugin.h   | 67 +++++++++++++++++++++++++++-------------------
> >>  kernel/rcu/update.c        | 19 ++++++++-----
> >>  9 files changed, 96 insertions(+), 66 deletions(-)
> >>
> 
> >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >> index 648e1c25707d..45d98ff0d5b8 100644
> >> --- a/kernel/rcu/rcutorture.c
> >> +++ b/kernel/rcu/rcutorture.c
> >> @@ -22,6 +22,7 @@
> >>   *
> >>   * See also:  Documentation/RCU/torture.txt
> >>   */
> >> +
> >>  #include <linux/types.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/init.h>
> >> @@ -908,7 +909,7 @@ rcu_torture_writer(void *arg)
> >>  	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> >>  	if (!can_expedite)
> >>  		pr_alert("%s" TORTURE_FLAG
> >> -			 " GP expediting controlled from boot/sysfs for %s.\n",
> >> +			 " GP expediting controlled from boot/sysfs for %s\n",
> >>  			 torture_type, cur_ops->name);
> >>
> >>  	/* Initialize synctype[] array.  If none set, take default. */
> >> @@ -916,27 +917,27 @@ rcu_torture_writer(void *arg)
> >>  		gp_cond1 = gp_exp1 = gp_normal1 = gp_sync1 = true;
> >>  	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync) {
> >>  		synctype[nsynctypes++] = RTWS_COND_GET;
> >> -		pr_info("%s: Testing conditional GPs.\n", __func__);
> >> +		pr_info("%s: Testing conditional GPs\n", __func__);
> >>  	} else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync)) {
> >> -		pr_alert("%s: gp_cond without primitives.\n", __func__);
> >> +		pr_alert("%s: gp_cond without primitives\n", __func__);
> >>  	}
> >>  	if (gp_exp1 && cur_ops->exp_sync) {
> >>  		synctype[nsynctypes++] = RTWS_EXP_SYNC;
> >> -		pr_info("%s: Testing expedited GPs.\n", __func__);
> >> +		pr_info("%s: Testing expedited GPs\n", __func__);
> >>  	} else if (gp_exp && !cur_ops->exp_sync) {
> >> -		pr_alert("%s: gp_exp without primitives.\n", __func__);
> >> +		pr_alert("%s: gp_exp without primitives\n", __func__);
> 
> Unlike some of the others, the one above is not a sentence, so it doesn't
> _need_ a period ... except for consistency.
> 
> But I don't care either way. :)

;-) ;-) ;-)

							Thanx, Paul

> >>  	}
> >>  	if (gp_normal1 && cur_ops->deferred_free) {
> >>  		synctype[nsynctypes++] = RTWS_DEF_FREE;
> >> -		pr_info("%s: Testing asynchronous GPs.\n", __func__);
> >> +		pr_info("%s: Testing asynchronous GPs\n", __func__);
> >>  	} else if (gp_normal && !cur_ops->deferred_free) {
> >> -		pr_alert("%s: gp_normal without primitives.\n", __func__);
> >> +		pr_alert("%s: gp_normal without primitives\n", __func__);
> >>  	}
> >>  	if (gp_sync1 && cur_ops->sync) {
> >>  		synctype[nsynctypes++] = RTWS_SYNC;
> >> -		pr_info("%s: Testing normal GPs.\n", __func__);
> >> +		pr_info("%s: Testing normal GPs\n", __func__);
> >>  	} else if (gp_sync && !cur_ops->sync) {
> >> -		pr_alert("%s: gp_sync without primitives.\n", __func__);
> >> +		pr_alert("%s: gp_sync without primitives\n", __func__);
> 
> 
> 
> 
> 
> 
> 
> 
> -- 
> ~Randy
> 
