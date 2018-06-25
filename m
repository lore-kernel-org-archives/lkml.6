Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7851EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C56F26240
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C56F26240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755016AbeFYWzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:55:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752330AbeFYWzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:55:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMpIpF003125
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:38 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96urq2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:38 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:55:37 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:55:31 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMtUuX13959460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:55:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E3FEB2064;
        Mon, 25 Jun 2018 18:55:25 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EC0BB2065;
        Mon, 25 Jun 2018 18:55:25 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:55:25 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8932216CA093; Mon, 25 Jun 2018 15:57:35 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:57:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] Pre-gp_seq torture-test changes for v4.19
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062522-0040-0000-0000-000004450D12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052304; UDB=6.00539450; IPR=6.00830229;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:55:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-0041-0000-0000-0000084B22C8
Message-Id: <20180625225735.GA11793@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following changes to torture-testing come before the infamous ->gp_seq
conversion:

1.	Use a single build directory for torture scenarios (currently
	there is one directory for each build within a given batch, which
	makes no sense given that all of these builds are serialized).

2.	Remove obsolete TREE08-T.boot file.  Use of the shiny new
	"--bootargs rcutree.rcu_fanout_exact=1" makes use of a separate
	file unnecesary.

3.	Make kvm-find-errors.sh find close calls as well as the usual
	hard errors.

4.	Make online/offline messages appear only for verbose=2.  This
	change is necessitated by the ability to make CPU-hotplug operations
	happen much more frequently than in the past.

5.	Keep old-school dmesg format while Joe Perches is changing the
	default format.  Later, rcutorture can move to the new format
	and at the same time update the analysis scripts.  (As opposed
	to having the analysis scripts just suddenly break when Joe's
	changes hit mainline.)

							Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/torture.h                                    |    2 
 b/kernel/locking/locktorture.c                               |    5 +-
 b/kernel/rcu/rcuperf.c                                       |    5 +-
 b/kernel/rcu/rcutorture.c                                    |    5 +-
 b/kernel/torture.c                                           |   15 +++---
 b/tools/testing/selftests/rcutorture/bin/configinit.sh       |   26 +++++------
 b/tools/testing/selftests/rcutorture/bin/kvm-build.sh        |   11 ++--
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh  |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh      |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh   |    5 +-
 b/tools/testing/selftests/rcutorture/bin/kvm.sh              |    2 
 b/tools/testing/selftests/rcutorture/bin/parse-console.sh    |    7 ++
 tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot |    1 
 13 files changed, 53 insertions(+), 33 deletions(-)

