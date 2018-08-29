Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E077C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B8F20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B8F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH3BqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:46:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbeH3BqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcr6O111453
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:29 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615ddvhp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:29 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:28 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:23 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlMAl46792726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58A6FB2065;
        Wed, 29 Aug 2018 17:46:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38AA0B2064;
        Wed, 29 Aug 2018 17:46:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9D7A816C3063; Wed, 29 Aug 2018 14:47:22 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:47:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/17] Torture-test changes for v4.20/v5.0
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082921-2213-0000-0000-000002E5049E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860712;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-2214-0000-0000-00005B601526
Message-Id: <20180829214722.GA23411@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=750 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test changes that can be reasonably
separated from the RCU flavor consolidation and cleanup:

1.	Stop overwriting Make.out file with obsolete version.

2.	Force occasional reader waits to increase the probability
	of quiescent states interacting with RCU's scheduler hooks.

3-4.	Warn on bad torture type for built-in tests.

5.	Remove TREE06 and TREE08 from the default test list, as they
	are redundant after RCU flavor consolidation.

6.	Add RCU-reader forward-progress tests for RCU grace periods.

7.	Also use grace-period sequence numbers to judge forward progress.

8.	Avoid forward-progress no-test complaint if too few
	forward-progress tries.

9.	Vary forward-progress test interval in order to exercise RCU's
	varied forward-progress mechanisms.

10.	Add self-propagating callback to forward-progress testing in
	order to ensure that there is a reason for grace periods to
	exist in the first place, let alone make forward progress.

11.	Increase rcu_read_delay() longdelay_ms in order to exercise
	RCU's forward-progress machinery that kicks into gear at
	about 100 milliseconds into the grace period.

12.	Limit reader duration if irq or bh disabled to avoid triggering
	-rt bh-disabling complaints.

13.	Reduce priority of forward-progress testing for !SMP kernels
	and for PREEMPT kernels without RCU priority boosting.

14.	Adjust number of reader kthreads per CPU-hotplug operations.
	After all, having 32 readers is a great thing for a 32-CPU
	system, but not so much if 31 of the CPUs has been offlined.

15.	Print forward-progress test interval on error.

16.	Check grace-period completion at stutter end:  If the system is
	idle, grace periods should complete quickly.

17.	Maintain self-propagating CB only during forward-progress test.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcutiny.h                                  |    1 
 include/linux/torture.h                                  |    2 
 kernel/rcu/rcuperf.c                                     |    1 
 kernel/rcu/rcutorture.c                                  |  188 +++++++++++++--
 kernel/rcu/update.c                                      |    1 
 kernel/torture.c                                         |    3 
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh |    1 
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST    |    2 
 8 files changed, 172 insertions(+), 27 deletions(-)

