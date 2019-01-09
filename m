Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3667C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99592075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfAIVty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:49:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbfAIVty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:49:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LnS5D034827
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:49:53 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq4rneew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:49:52 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:49:51 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:49:46 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LnjNt9830516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:49:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EA41B2064;
        Wed,  9 Jan 2019 21:49:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2357B205F;
        Wed,  9 Jan 2019 21:49:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:49:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B69F516C63C3; Wed,  9 Jan 2019 13:49:44 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:49:44 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/10] Torture-test updates for v5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-0000038007E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144152; UDB=6.00595713; IPR=6.00924414;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:49:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-000047122E6E
Message-Id: <20190109214944.GA5610@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=835 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test updates:

1.	Record grace periods in forward-progress histogram.

2.	Explain and simplify odd "for" loop in mkinitrd.sh.

3.	Add grace period after CPU offline.

4.	Stop abusing IS_ENABLED().

5-9.	Fixes to nolibc, plus move it to somewhere less RCU-centric,
	courtesy of Willy Tarreau, who also stepped up to be maintainer.

10.	Remove section MODULE PARAMETERS from torture.txt in favor of
	the existing documentation in kernel-parameters.txt, courtesy
	of Junchang Wang.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/torture.txt                      |  169 ---------------------
 MAINTAINERS                                        |    6 
 include/linux/torture.h                            |    3 
 kernel/locking/locktorture.c                       |    2 
 kernel/rcu/rcuperf.c                               |    8 
 kernel/rcu/rcutorture.c                            |   40 +++-
 kernel/torture.c                                   |    6 
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |   27 ++-
 tools/testing/selftests/rcutorture/bin/nolibc.h    |  118 +++++++++++---
 9 files changed, 164 insertions(+), 215 deletions(-)

