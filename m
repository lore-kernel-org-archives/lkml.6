Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2748CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA9F206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfAIV2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:28:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbfAIV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIhB2133678
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:28:24 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwrhys0y1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:24 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:28:22 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:28:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LSG5A20512850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:28:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8E4EB2065;
        Wed,  9 Jan 2019 21:28:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98F7AB2067;
        Wed,  9 Jan 2019 21:28:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:28:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6734916C63D3; Wed,  9 Jan 2019 13:28:16 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:28:16 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] Forward-progress changes for v5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010921-0060-0000-0000-000002F64003
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144145; UDB=6.00595709; IPR=6.00924407;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:28:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0061-0000-0000-000047DC70F5
Message-Id: <20190109212816.GA32282@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains commits that improve RCU's ability to make forward
progress on grace periods:

1.	Accommodate zero jiffies_till_first_fqs and kthread kicking.

2-6.	Move per-CPU variables to rcu_data structure, now that rcu_data
	is strictly per-CPU itself due to there only being one flavor.
	Also remove rcu_cpu_kthread_loops and rcu_cpu_kthread_cpu,
	which are unused.

7.	Update outdated NOCB comments.

8.	Improve diagnostics for failed RCU grace-period start.

9.	Protect rcu_check_gp_kthread_starvation() access to ->gp_flags.

10.	Add sysrq rcu_node-dump capability to assist with debugging of
	forward-progress issues.

11.	Do RCU GP kthread self-wakeup from softirq and interrupt, thus
	fixing a grace-period hang, courtesy of Jun Zhang.

12.	Prevent needless ->gp_seq_needed update in __note_gp_changes(),
	courtesy of Jun Zhang.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    5 +
 kernel/rcu/tree.c                               |  106 ++++++++++++++++--------
 kernel/rcu/tree.h                               |   19 ++--
 kernel/rcu/tree_plugin.h                        |   68 ++++++---------
 4 files changed, 117 insertions(+), 81 deletions(-)

