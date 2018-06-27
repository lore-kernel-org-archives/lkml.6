Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F9C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ECA25914
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ECA25914
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965753AbeF0Uqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:46:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965010AbeF0Uqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:46:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RKehoj146641
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 16:46:36 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvh5nsw74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 16:46:35 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 16:46:34 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 16:46:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RKkTWB7274934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 20:46:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91959B2064;
        Wed, 27 Jun 2018 16:46:20 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A90FB2065;
        Wed, 27 Jun 2018 16:46:20 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 16:46:20 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8131916C4293; Wed, 27 Jun 2018 13:48:35 -0700 (PDT)
Date:   Wed, 27 Jun 2018 13:48:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC tip/core/rcu 0/2] RCU consolidation patches
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062720-0072-0000-0000-000003761CFF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009265; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053221; UDB=6.00540000; IPR=6.00831145;
 MB=3.00021889; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 20:46:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062720-0073-0000-0000-000048829DD2
Message-Id: <20180627204835.GA25456@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series is a sneak preview of a pair of patches that does the actual
consolidation of RCU-bh and RCU-sched functionality into RCU-preempt.
This does pass some light rcutorture testing, but left unattended will
no doubt do unspeakable things to your pets, your loved ones, and your
household devices.  Once fully debugged, this patch set will be followed
up with a cleanup series that actually removes RCU-bh and RCU-sched.
In the meantime:

1.	Make RCU-preempt treat disabling of interrupts, preemption,
	and/or softirq as read-side critical sections.	Most of the
	complexity deals with composite read-side critical sections in
	which sometimes preemption is disabled, other times there is an
	rcu_read_lock() in force, yet other times interrupts are disabled,
	and so on.

2.	Make the "rcu" torture type create composite read-side critical
	sections in order to test #1 above.

There is some faint hope of these going into the next merge window,
but it is far more likely that bug fixing will take longer than that,
pushing them into the merge window following the next one.  Furthermore,
without the cleanup patches, the actual goal of having only one flavor
of RCU is not met.  Besides, given the large number of patches already
slated for the next merge window, deferring any additional patches might
not be such a bad idea anyway.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.html |   50 ++---
 include/linux/rcutiny.h                                 |    5 
 kernel/rcu/rcutorture.c                                 |    1 
 kernel/rcu/tree.c                                       |    9 +
 kernel/rcu/tree.h                                       |    3 
 kernel/rcu/tree_exp.h                                   |   71 ++++++--
 kernel/rcu/tree_plugin.h                                |  138 +++++++++++-----
 7 files changed, 200 insertions(+), 77 deletions(-)

