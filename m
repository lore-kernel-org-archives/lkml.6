Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488B42077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488B42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeKICq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:46:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbeKICq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:46:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8HA20g041391
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 12:10:29 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmrq99su8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:10:29 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Nov 2018 17:10:28 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 17:10:26 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8HAP3G45482048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 17:10:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C223B2067;
        Thu,  8 Nov 2018 17:10:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE172B2066;
        Thu,  8 Nov 2018 17:10:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.215.156])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 17:10:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8C92216C34DA; Thu,  8 Nov 2018 09:10:24 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:10:24 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: srcu: use cpu_online() instead custom check
Reply-To: paulmck@linux.ibm.com
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108163850.sjedoaom64tzvqgc@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110817-0052-0000-0000-00000352BC12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114532; UDB=6.00577840; IPR=6.00894630;
 MB=3.00024076; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 17:10:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110817-0053-0000-0000-00005EB30477
Message-Id: <20181108171024.GM4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:38:51PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-01 16:12:28 [-0700], Paul E. McKenney wrote:
> > > The current check via srcu_online is slightly racy because after looking
> > > at srcu_online there could be an interrupt that interrupted us long
> > > enough until the CPU we checked against went offline.
> > 
> > I don't see how this can happen, even in -rt.  The call to
> > srcu_offline_cpu() happens very early in the CPU removal process,
> > which means that the synchronize_rcu_mult(call_rcu, call_rcu_sched)
> > in sched_cpu_deactivate() would wait for the interrupt to complete.
> > And for the enclosing preempt_disable region to complete.
> 
> Is this again a hidden RCU detail that preempt_disable() on CPU4 is
> enough to ensure that CPU2 does not get marked offline between?

The call_rcu_sched parameter to synchronize_rcu_mult() makes this work.
This synchronize_rcu_mult() call is in sched_cpu_deactivate(), so it
is a hidden sched/RCU detail, I guess.

Or am I missing the point of your question?

> > Or is getting rid of that preempt_disable region the real reason for
> > this change?
> 
> Well, that preempt_disable() + queue_(delayed_)work() does not work -RT.
> But looking further, that preempt_disable() while looking at online CPUs
> didn't look good.

That is why it is invoked from the very early CPU-hotplug notifier.  That
early in the process, the preempt_disable() does prevent the current CPU
from being taken offline twice:  Once due to synchronize_rcu_mult(), and
once due to the stop-machine call.

> > > An alternative would be to hold the hotplug rwsem (so the CPUs don't
> > > change their state) and then check based on cpu_online() if we queue it
> > > on a specific CPU or not. queue_work_on() itself can handle if something
> > > is enqueued on an offline CPU but a timer which is enqueued on an offline
> > > CPU won't fire until the CPU is back online.
> > > 
> > > I am not sure if the removal in rcu_init() is okay or not. I assume that
> > > SRCU won't enqueue a work item before SRCU is up and ready.
> > 
> > That was the case before the current merge window, but use of call_srcu()
> > by tracing means that SRCU needs to be able to deal with call_srcu()
> > long before any initialization has happened.  The actual callbacks
> > won't be invoked until much later, after the scheduler and workqueues
> > are completely up and running, but call_srcu() can be invoked very early.
> > 
> > But I am not seeing any removal in rcu_init() in this patch, so I might
> > be missing something.
> 
> The description is not up-to-date. There was this hunk:
> |@@ -4236,8 +4232,6 @@ void __init rcu_init(void)
> |       for_each_online_cpu(cpu) {
> |               rcutree_prepare_cpu(cpu);
> |               rcu_cpu_starting(cpu);
> |-              if (IS_ENABLED(CONFIG_TREE_SRCU))
> |-                      srcu_online_cpu(cpu);
> |       }
> | }
> 
> which got removed in v4.16.

Ah!  Here is the current rcu_init() code:

	for_each_online_cpu(cpu) {
		rcutree_prepare_cpu(cpu);
		rcu_cpu_starting(cpu);
		rcutree_online_cpu(cpu);
	}

And rcutree_online_cpu() calls srcu_online_cpu() when CONFIG_TREE_SRCU
is enabled, so no need for the direct call from rcu_init().

							Thanx, Paul

