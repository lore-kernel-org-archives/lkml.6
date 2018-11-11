Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0CCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2348214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2348214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeKLFag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:30:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbeKLFag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:30:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJcrU6036136
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:41:10 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npd3ut5t5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:41:09 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:41:09 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:41:04 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJf3HL21102702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:41:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D44CBB2064;
        Sun, 11 Nov 2018 19:41:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BCFCB205F;
        Sun, 11 Nov 2018 19:41:03 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:41:03 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C68C316C5D59; Sun, 11 Nov 2018 11:41:04 -0800 (PST)
Date:   Sun, 11 Nov 2018 11:41:04 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kernel-team@android.com
Subject: [PATCH tip/core/rcu 0/41] More RCU flavor consolidation cleanup for
 v4.21/v5.0
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111119-0064-0000-0000-000003722E85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116018; UDB=6.00577118; IPR=6.00896118;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:41:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0065-0000-0000-00003B4D405E
Message-Id: <20181111194104.GA4787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series does additional cleanup for the RCU flavor consolidation,
focusing primarily on uses of old API members, for example, so that
call_rcu_bh() becomes call_rcu().  There are also a few straggling
internal-to-RCU cleanups.

1.	Remove unused rcu_state externs, courtesy of Joel Fernandes.

2.	Fix rcu_{node,data} comments about gp_seq_needed, courtesy of
	Joel Fernandes.

3.	Eliminate synchronize_rcu_mult() and its sole caller.

4.	Consolidate the RCU update functions invoked by sync.c.

5-41.	Replace old flavorful RCU API calls with the corresponding
	vanilla calls.

							Thanx, Paul

------------------------------------------------------------------------

 arch/powerpc/mm/hugetlbpage.c                                             |    2 
 arch/s390/mm/pgalloc.c                                                    |    2 
 arch/sparc/oprofile/init.c                                                |    2 
 crypto/pcrypt.c                                                           |    2 
 drivers/char/ipmi/ipmi_si_intf.c                                          |    2 
 drivers/cpufreq/cpufreq_governor.c                                        |    2 
 drivers/cpufreq/intel_pstate.c                                            |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                             |    6 +-
 drivers/net/ethernet/realtek/8139too.c                                    |    2 
 drivers/net/ethernet/realtek/r8169.c                                      |    4 -
 drivers/net/ethernet/sis/sis190.c                                         |    2 
 drivers/vhost/net.c                                                       |    2 
 fs/file.c                                                                 |    2 
 include/linux/percpu-rwsem.h                                              |    2 
 include/linux/rcupdate_wait.h                                             |   17 -------
 include/linux/tracepoint.h                                                |    2 
 include/linux/types.h                                                     |    4 -
 init/main.c                                                               |    6 +-
 kernel/cgroup/cgroup.c                                                    |    2 
 kernel/events/core.c                                                      |    2 
 kernel/kprobes.c                                                          |   10 ++--
 kernel/livepatch/patch.c                                                  |    4 -
 kernel/livepatch/transition.c                                             |    4 -
 kernel/locking/lockdep.c                                                  |    2 
 kernel/module.c                                                           |   14 ++---
 kernel/rcu/sync.c                                                         |   12 ++---
 kernel/rcu/tree.h                                                         |   15 ------
 kernel/rcu/update.c                                                       |    6 --
 kernel/sched/core.c                                                       |    2 
 kernel/sched/cpufreq.c                                                    |    4 -
 kernel/sched/cpufreq_schedutil.c                                          |    2 
 kernel/sched/membarrier.c                                                 |    6 +-
 kernel/trace/ftrace.c                                                     |   24 +++++-----
 kernel/trace/ring_buffer.c                                                |   12 ++---
 kernel/trace/trace.c                                                      |   10 ++--
 kernel/trace/trace_events_filter.c                                        |    4 -
 kernel/trace/trace_kprobe.c                                               |    2 
 kernel/tracepoint.c                                                       |    4 -
 kernel/workqueue.c                                                        |    8 +--
 lib/percpu-refcount.c                                                     |    2 
 mm/mmu_gather.c                                                           |    2 
 mm/slab.c                                                                 |    4 -
 mm/slab_common.c                                                          |    6 +-
 net/bridge/br_mdb.c                                                       |    2 
 net/bridge/br_multicast.c                                                 |   14 ++---
 net/core/netpoll.c                                                        |    4 -
 net/core/skmsg.c                                                          |    2 
 net/decnet/af_decnet.c                                                    |    2 
 net/ipv4/netfilter/ipt_CLUSTERIP.c                                        |    6 +-
 net/netfilter/ipset/ip_set_hash_gen.h                                     |    4 -
 net/netfilter/nfnetlink_log.c                                             |    2 
 net/netfilter/xt_hashlimit.c                                              |    4 -
 net/sched/sch_api.c                                                       |    2 
 net/sched/sch_generic.c                                                   |    8 +--
 tools/include/linux/kernel.h                                              |    2 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h |    4 -
 56 files changed, 126 insertions(+), 156 deletions(-)

