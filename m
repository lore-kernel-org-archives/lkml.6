Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68B6214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68B6214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeKLFSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:18:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbeKLFSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:18:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJNwPB072342
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:28:45 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdv7rf46-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:28:45 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:28:44 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:28:39 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJSc2U56754202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:28:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EEF6B2066;
        Sun, 11 Nov 2018 19:28:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C082B2064;
        Sun, 11 Nov 2018 19:28:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:28:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 43EBC16C5D59; Sun, 11 Nov 2018 11:28:39 -0800 (PST)
Date:   Sun, 11 Nov 2018 11:28:39 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/14] Miscellaneous fixes for v4.21/v5.0
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111119-2213-0000-0000-00000315A740
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116014; UDB=6.00578729; IPR=6.00896114;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:28:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-2214-0000-0000-00005C386693
Message-Id: <20181111192839.GA32144@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Stop expedited grace periods from relying on stop-machine.

2.	Update IBM maintainers' email addresses from @linux.vnet.ibm.com
	to @linux.ibm.com.

3.	Avoid double multiply by HZ in rcu_check_gp_start_stall().

4.	Parameterize rcu_check_gp_start_stall() to allow common code
	between RCU CPU stall warnings and warnings about slow-to-start
	grace periods.

5.	Add state name to show_rcu_gp_kthreads() output.

6.	Add jiffies-since-GP-activity to show_rcu_gp_kthreads().

7.	Adjust the comment of function rcu_is_watching, courtesy of
	Zhouyi Zhou.

8.	Trace end of grace period before end of grace period.

9.	Speed up expedited GPs when interrupting RCU reader.

10.	Replace this_cpu_ptr() with __this_cpu_read() in
	rcu_preempt_need_deferred_qs()

11.	Avoid signed integer overflow in rcu_preempt_deferred_qs().

12.	Add Joel Fernandes as RCU reviewer in MAINTAINERS file.

13.	Create table of obsolete APIs in checkpatch.pl and apply to RCU,
	courtesy of Joe Perches.

14.	Make checkpatch.pl suggest lockdep instead of asserting
	!spin_is_locked().

							Thanx, Paul

------------------------------------------------------------------------

 MAINTAINERS              |   73 +++++++++++++++++++++--------------------------
 include/linux/sched.h    |    4 +-
 kernel/rcu/tree.c        |   53 ++++++++++++++++++----------------
 kernel/rcu/tree_exp.h    |   10 ++++--
 kernel/rcu/tree_plugin.h |   37 ++++++++++++++++-------
 scripts/checkpatch.pl    |   35 ++++++++++++++++++++++
 6 files changed, 132 insertions(+), 80 deletions(-)

