Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C58C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491AF24736
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491AF24736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeGCVmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:42:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753076AbeGCVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:42:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63LeGwN060110
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 17:42:09 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpk02eh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 17:42:08 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 17:42:07 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 17:42:05 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63Lg47O10944788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 21:42:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2922CB2064;
        Tue,  3 Jul 2018 17:41:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B131B2065;
        Tue,  3 Jul 2018 17:41:48 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 17:41:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9C6AB16CA3A3; Tue,  3 Jul 2018 14:44:18 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:44:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE() in process_one_work()?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180620192901.GA9956@linux.vnet.ibm.com>
 <20180702210540.GL533219@devbig577.frc2.facebook.com>
 <20180703040518.GV3593@linux.vnet.ibm.com>
 <20180703164044.GA400@linux.vnet.ibm.com>
 <20180703201205.GA72677@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703201205.GA72677@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070321-2213-0000-0000-000002C50A4B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009303; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056119; UDB=6.00541739; IPR=6.00834042;
 MB=3.00021981; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 21:42:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070321-2214-0000-0000-00005AB445F8
Message-Id: <20180703214418.GF3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:12:05PM -0700, Tejun Heo wrote:
> Hello, Paul.
> 
> On Tue, Jul 03, 2018 at 09:40:44AM -0700, Paul E. McKenney wrote:
> > > I will apply this, but be advised that I have not seen that WARN_ON_ONCE()
> > > trigger since.  :-/
> > 
> > But I get a build error:
> > 
> > kernel/workqueue.o: In function `worker_attach_to_pool':
> > workqueue.c:(.text+0x63c): undefined reference to `cpuhp_target_state'
> > workqueue.c:(.text+0x647): undefined reference to `cpuhp_current_state'
> > /home/paulmck/public_git/linux-rcu/Makefile:1015: recipe for target 'vmlinux' failed
> > 
> > My guess is that the worker_attach_to_pool() code needs to change so
> > as to invoke cpuhp_current_state() and cpuhp_target_state() only in
> > CONFIG_HOTPLUG_CPU=y kernels, but I figured I should defer to you.
> 
> Just to clarify, the bug happened on a kernel with cpuhp enabled,
> right?

It seems to be a bit more complicated than that, despite my initial
confidence that I knew what was going on.  The build failed for these
rcutorture scenarios:

SRCU-N: (No idea!)

	CONFIG_RCU_TRACE=n
	CONFIG_SMP=y
	CONFIG_NR_CPUS=4
	CONFIG_HOTPLUG_CPU=y
	CONFIG_PREEMPT_NONE=y
	CONFIG_PREEMPT_VOLUNTARY=n
	CONFIG_PREEMPT=n

SRCU-t:  (Expected, CONFIG_SMP=n)
SRCU-u:  (Expected, CONFIG_SMP=n)
TASKS02:  (Expected, CONFIG_SMP=n)
TASKS03:  (Expected, CONFIG_HOTPLUG_CPU=n)
TINY01:  (Expected, CONFIG_SMP=n)
TINY02:  (Expected, CONFIG_SMP=n)
TREE01:  (No idea!)

	CONFIG_SMP=y
	CONFIG_PREEMPT_NONE=n
	CONFIG_PREEMPT_VOLUNTARY=n
	CONFIG_PREEMPT=y
	CONFIG_HZ_PERIODIC=n
	CONFIG_NO_HZ_IDLE=y
	CONFIG_NO_HZ_FULL=n
	CONFIG_RCU_FAST_NO_HZ=y
	CONFIG_RCU_TRACE=y
	CONFIG_HOTPLUG_CPU=y
	CONFIG_MAXSMP=y
	CONFIG_CPUMASK_OFFSTACK=y
	CONFIG_RCU_NOCB_CPU=y
	CONFIG_DEBUG_LOCK_ALLOC=n
	CONFIG_RCU_BOOST=n
	CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
	CONFIG_RCU_EXPERT=y

TREE02 didn't fail despite having CONFIG_HOTPLUG_CPU=n!
TREE03:  (Expected, CONFIG_HOTPLUG_CPU=n)
TREE04:  (Expected, CONFIG_HOTPLUG_CPU=n)

TREE07:  (No idea!)

	CONFIG_NR_CPUS=16
	CONFIG_PREEMPT_NONE=y
	CONFIG_PREEMPT_VOLUNTARY=n
	CONFIG_PREEMPT=n
	CONFIG_HZ_PERIODIC=n
	CONFIG_NO_HZ_IDLE=n
	CONFIG_NO_HZ_FULL=y
	CONFIG_RCU_FAST_NO_HZ=n
	CONFIG_RCU_TRACE=y
	CONFIG_HOTPLUG_CPU=y
	CONFIG_RCU_FANOUT=2
	CONFIG_RCU_FANOUT_LEAF=2
	CONFIG_DEBUG_LOCK_ALLOC=n
	CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
	CONFIG_RCU_EXPERT=y

TREE08:  (Expected, CONFIG_HOTPLUG_CPU=n)
TREE09:  (Expected, CONFIG_SMP=n)

Thoughts?

							Thanx, Paul

