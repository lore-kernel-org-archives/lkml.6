Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A645206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfAIVlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:41:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfAIVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:41:23 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Ld7Mg027090
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:41:21 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwru0rnmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:41:21 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:41:20 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:41:16 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LfFYo23855212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:41:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D24A6B2066;
        Wed,  9 Jan 2019 21:41:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2966B2065;
        Wed,  9 Jan 2019 21:41:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:41:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 88EE316C63D3; Wed,  9 Jan 2019 13:41:15 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:41:15 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kernel-team@android.com
Subject: [PATCH tip/core/rcu 0/8] Miscellaneous fixes for v5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010921-0040-0000-0000-000004AF3786
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144149; UDB=6.00593882; IPR=6.00924412;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:41:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0041-0000-0000-000008BA3C14
Message-Id: <20190109214115.GA2835@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Add docbook for rcu_head_init() and rcu_head_after_call_rcu().

2.	Rename rcu_check_callbacks() to rcu_sched_clock_irq().

3.	Rename rcu_process_callbacks() to rcu_core() for Tree RCU.

4.	Remove preemption disabling from expedited CPU selection.

5.	Repair rcu_nmi_exit() docbook header.

6.	Fix obsolete DYNTICK_IRQ_NONIDLE comment.

7.	Add sparse check to rcu_assign_pointer(), courtesy of Joel
	Fernandes.

8.	Move CONTEXT_TRACKING Kconfig option to kernel/time/Kconfig.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html   |    6 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg |    2 
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg                  |    8 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg                  |    6 +-
 include/linux/rcupdate.h                                                 |   21 +++----
 kernel/rcu/Kconfig                                                       |   30 ----------
 kernel/rcu/rcu.h                                                         |    2 
 kernel/rcu/tiny.c                                                        |    2 
 kernel/rcu/tree.c                                                        |   29 ++++-----
 kernel/rcu/tree.h                                                        |    2 
 kernel/rcu/tree_exp.h                                                    |    2 
 kernel/rcu/tree_plugin.h                                                 |   24 +++-----
 kernel/time/Kconfig                                                      |   29 +++++++++
 kernel/time/timer.c                                                      |    2 
 14 files changed, 77 insertions(+), 88 deletions(-)

