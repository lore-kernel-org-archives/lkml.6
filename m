Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB00C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7C208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeKKIvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:51:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbeKKIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:51:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAAN3oiL114224
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 18:04:41 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nnvsen2xf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 18:04:41 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 10 Nov 2018 23:04:40 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 10 Nov 2018 23:04:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAAN4aRR36176106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 10 Nov 2018 23:04:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1FA6B2067;
        Sat, 10 Nov 2018 23:04:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B0DB205F;
        Sat, 10 Nov 2018 23:04:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 10 Nov 2018 23:04:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F1B4316C1168; Sat, 10 Nov 2018 15:04:36 -0800 (PST)
Date:   Sat, 10 Nov 2018 15:04:36 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Reply-To: paulmck@linux.ibm.com
References: <20181110214659.GA96924@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110214659.GA96924@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111023-0052-0000-0000-00000353DA46
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010023; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01115607; UDB=6.00578486; IPR=6.00895706;
 MB=3.00024106; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-10 23:04:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111023-0053-0000-0000-00005EB90B10
Message-Id: <20181110230436.GL4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-10_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=839 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811100183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 01:46:59PM -0800, Joel Fernandes wrote:
> Hi Paul and everyone,
> 
> I was tracing/studying the RCU code today in paul/dev branch and noticed that
> for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
> corresponding to the leaf node for the idle CPU, and reporting a QS on their
> behalf.
> 
> rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
> rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
> rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0
> 
> That's all good but I was wondering if we can do better for the idle CPUs if
> we can some how not set the qsmask of the node in the first place. Then no
> reporting would be needed of quiescent state is needed for idle CPUs right?
> And we would also not need to acquire the rnp lock I think.
> 
> At least for a single node tree RCU system, it seems that would avoid needing
> to acquire the lock without complications. Anyway let me know your thoughts
> and happy to discuss this at the hallways of the LPC as well for folks
> attending :)

We could, but that would require consulting the rcu_data structure for
each CPU while initializing the grace period, thus increasing the number
of cache misses during grace-period initialization and also shortly after
for any non-idle CPUs.  This seems backwards on busy systems where each
CPU will with high probability report its own quiescent state before three
jiffies pass, in which case the cache misses on the rcu_data structures
would be wasted motion.

Now, this does increase overhead on mostly idle systems, but the theory
is that mostly idle systems are most able to absorb this extra overhead.

Thoughts?

							Thanx, Paul

