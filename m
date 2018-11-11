Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C0AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E441D20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E441D20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeKLFpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:45:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbeKLFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:45:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs4LU066058
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:25 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npd76266a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:25 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:22 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJuIl027131972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5009FB2064;
        Sun, 11 Nov 2018 19:56:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BD72B205F;
        Sun, 11 Nov 2018 19:56:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 593E816C5D34; Sun, 11 Nov 2018 11:56:19 -0800 (PST)
Date:   Sun, 11 Nov 2018 11:56:19 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kernel-team@android.com
Subject: [PATCH tip/core/rcu 0/20] Documentation updates for v4.21/v5.0
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111119-0040-0000-0000-000004908941
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00577119; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0041-0000-0000-0000089991F1
Message-Id: <20181111195619.GA6958@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides documentation updates:

1.	Set down forward-progress requirements.

2.	Clarify RCU data-structure comment about rcu_tree fanout,
	courtesy of Joel Fernandes.

3.	Remove rcu_preempt_state reference in stallwarn, courtesy of
	Joel Fernandes.

4.	Update information about resched_cpu, courtesy of Joel Fernandes.

5.	Remove rcu_dynticks from Data-Structures, courtesy of Joel
	Fernandes.

6.	Update Data-Structures for RCU flavor consolidation, courtesy of
	Joel Fernandes.

7.	Better clarify the rcu_segcblist ->len field, courtesy of Joel
	Fernandes.

8. 	Update description of gp_seq fields in rcu_data, courtesy of
	Joel Fernandes.

9.	Document rcutorture forward-progress test kernel parameters.

10.	Update core and full API in whatisRCU, courtesy of Joel Fernandes.

11.	Add more rationale for using rcu_read_lock_sched() in checklist,
	courtesy of Joel Fernandes.

12.	Remove obsolete suggestion from checklist, courtesy of Joel
	Fernandes.

13.	Remove obsolete checklist item about synchronize_rcu() usage,
	courtesy of Joel Fernandes.

14.	Encourage use of rcu_barrier in checklist, courtesy of Joel
	Fernandes.

15.	Make reader aware of rcu_dereference_protected(), courtesy of
	Joel Fernandes.

16.	Remove obsolete (non-)requirement about disabling preemption,
	courtesy of Joel Fernandes.

17.	Make listing in RCU perf/scale requirements use rcu_assign_pointer(),
	courtesy of Joel Fernandes.

18.	RCU scheduler spinlock rcu_read_unlock() restriction remains.

19.	Correct the parameter in stallwarn, courtesy of Joel Fernandes.

20.	Fix "struction" typo in RCU memory-ordering documentation,
	courtesy of Joel Fernandes.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg                |  499 -----
 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg         |  695 --------
 Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg         |  741 --------
 b/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg     |  834 +++-------
 b/Documentation/RCU/Design/Data-Structures/Data-Structures.html                 |  177 --
 b/Documentation/RCU/Design/Data-Structures/blkd_task.svg                        |  676 ++------
 b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html |    6 
 b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html        |    2 
 b/Documentation/RCU/Design/Requirements/Requirements.html                       |  206 +-
 b/Documentation/RCU/checklist.txt                                               |   49 
 b/Documentation/RCU/stallwarn.txt                                               |    7 
 b/Documentation/RCU/whatisRCU.txt                                               |   70 
 b/Documentation/admin-guide/kernel-parameters.txt                               |   17 
 13 files changed, 823 insertions(+), 3156 deletions(-)

