Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBEF20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfBUPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:46:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbfBUPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LFk6eq180656
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:46:08 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qswk34h7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:46:06 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Feb 2019 15:45:35 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 15:45:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LFjWlC23920870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:45:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C63B2065;
        Thu, 21 Feb 2019 15:45:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E17EB2067;
        Thu, 21 Feb 2019 15:45:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.207.192])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 15:45:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DE74C16C63FE; Thu, 21 Feb 2019 07:45:31 -0800 (PST)
Date:   Thu, 21 Feb 2019 07:45:31 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Liu Song <fishland@aliyun.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [PATCH] rcu: module param kthread_prio should set to read-only
 under sysfs
Reply-To: paulmck@linux.ibm.com
References: <20190221141327.3058-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221141327.3058-1-fishland@aliyun.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022115-0052-0000-0000-0000038DF8F1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010638; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164312; UDB=6.00608004; IPR=6.00944897;
 MB=3.00025682; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-21 15:45:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022115-0053-0000-0000-00005FEC40D3
Message-Id: <20190221154531.GY11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:13:27PM +0800, Liu Song wrote:
> kthread_prio used to set prio for boost thread
> which spawn at the very beginning. We can see
> kthread_prio under sysfs, and it could be set
> to a new value. But boost thread's prio can not
> updated by this opreation. However, user can
> change boost thread prio by chrt.
> 
> We better make kthread_prio read-only under
> sysfs, which can avoid user invalid operation.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 121f833acd04..38faef424a99 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -157,7 +157,7 @@ static void sync_sched_exp_online_cleanup(int cpu);
> 
>  /* rcuc/rcub kthread realtime priority */
>  static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
> -module_param(kthread_prio, int, 0644);
> +module_param(kthread_prio, int, 0444);
> 
>  /* Delay in jiffies for grace-period initialization delays, debug only. */

Good catch!  I applied this with the commit log updated as shown below.
Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit c6e26d5eaa5794ae32b38cb1ced9495b07af4ff5
Author: Liu Song <fishland@aliyun.com>
Date:   Thu Feb 21 22:13:27 2019 +0800

    rcu: Set rcutree.kthread_prio sysfs access to read-only
    
    The rcutree.kthread_prio kernel-boot parameter is used to set the
    priority for boost (rcub), per-CPU (rcuc), and grace-period (rcu_preempt
    or rcu_sched) kthreads.  It is also used by rcutorture to check whether
    it is possible to meaningfully test RCU priority boosting.  However,
    all of these cases will either ignore or be confused by any post-boot
    changes to rcutree.kthread_prio.
    
    Note that the user really can change the priorities of all of these
    kthreads using chrt, given sufficient privileges.  Therefore, the
    read-write nature of sysfs access to rcutree.kthread_prio is thus at
    best an attractive nuisance.
    
    This commit therefore changes sysfs access to rcutree.kthread_prio to
    be read-only.
    
    Signed-off-by: Liu Song <liu.song11@zte.com.cn>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 24b07cf84161..7273ef0c278d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -143,7 +143,7 @@ static void sync_sched_exp_online_cleanup(int cpu);
 
 /* rcuc/rcub kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
-module_param(kthread_prio, int, 0644);
+module_param(kthread_prio, int, 0444);
 
 /* Delay in jiffies for grace-period initialization delays, debug only. */
 

