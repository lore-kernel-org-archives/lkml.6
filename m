Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D8E24F11
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D8E24F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbeGCEDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:03:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753345AbeGCEDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:03:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w633wlVb067656
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 00:03:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jywrp7btp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:03:07 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 00:03:07 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 00:03:06 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63435Mc15073542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 04:03:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE038B2067;
        Tue,  3 Jul 2018 00:02:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D98CB2068;
        Tue,  3 Jul 2018 00:02:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.226.134])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 00:02:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5782B16CA393; Mon,  2 Jul 2018 21:05:18 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:05:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE() in process_one_work()?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180620192901.GA9956@linux.vnet.ibm.com>
 <20180702210540.GL533219@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702210540.GL533219@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070304-0040-0000-0000-00000448BB9D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009298; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055767; UDB=6.00541527; IPR=6.00833689;
 MB=3.00021970; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 04:03:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070304-0041-0000-0000-0000084ED80E
Message-Id: <20180703040518.GV3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:05:40PM -0700, Tejun Heo wrote:
> Hello, Paul.
> 
> Sorry about the late reply.
> 
> On Wed, Jun 20, 2018 at 12:29:01PM -0700, Paul E. McKenney wrote:
> > I have hit this WARN_ON_ONCE() in process_one_work:
> > 
> > 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> > 		     raw_smp_processor_id() != pool->cpu);
> > 
> > This looks like it is my rcu_gp workqueue (see splat below), and it
> > appears to be intermittent.  This happens on rcutorture scenario SRCU-N,
> > which does random CPU-hotplug operations (in case that helps).
> > 
> > Is this related to the recent addition of WQ_MEM_RECLAIM?  Either way,
> > what should I do to further debug this?
> 
> Hmm... I checked the code paths but couldn't spot anything suspicious.
> Can you please apply the following patch and see whether it triggers
> before hitting the warn and if so report what it says?

I will apply this, but be advised that I have not seen that WARN_ON_ONCE()
trigger since.  :-/

							Thanx, Paul

> Thanks.
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 0db8938fbb23..81caab9643b2 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -79,6 +79,15 @@ static struct lockdep_map cpuhp_state_up_map =
>  static struct lockdep_map cpuhp_state_down_map =
>  	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-down", &cpuhp_state_down_map);
> 
> +int cpuhp_current_state(int cpu)
> +{
> +	return per_cpu_ptr(&cpuhp_state, cpu)->state;
> +}
> +
> +int cpuhp_target_state(int cpu)
> +{
> +	return per_cpu_ptr(&cpuhp_state, cpu)->target;
> +}
> 
>  static inline void cpuhp_lock_acquire(bool bringup)
>  {
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 78b192071ef7..365cf6342808 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1712,6 +1712,9 @@ static struct worker *alloc_worker(int node)
>  	return worker;
>  }
> 
> +int cpuhp_current_state(int cpu);
> +int cpuhp_target_state(int cpu);
> +
>  /**
>   * worker_attach_to_pool() - attach a worker to a pool
>   * @worker: worker to be attached
> @@ -1724,13 +1727,20 @@ static struct worker *alloc_worker(int node)
>  static void worker_attach_to_pool(struct worker *worker,
>  				   struct worker_pool *pool)
>  {
> +	int ret;
> +
>  	mutex_lock(&wq_pool_attach_mutex);
> 
>  	/*
>  	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>  	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>  	 */
> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	ret = set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	if (ret && pool->cpu >= 0 && worker->rescue_wq)
> +		printk("XXX rescuer failed to attach: ret=%d pool=%d this_cpu=%d target_cpu=%d cpuhp_state=%d chuhp_target=%d\n",
> +		       ret, pool->id, raw_smp_processor_id(), pool->cpu,
> +		       cpuhp_current_state(pool->cpu),
> +		       cpuhp_target_state(pool->cpu));
> 
>  	/*
>  	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
> 

