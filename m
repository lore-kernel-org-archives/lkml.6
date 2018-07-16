Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B76ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE1208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CE1208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGPSb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:31:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbeGPSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:31:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxE5O027772
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:03:26 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8w0tgrsp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:03:26 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:24 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 14:03:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6GI3HLu5636582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 18:03:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDCCB205F;
        Mon, 16 Jul 2018 14:03:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B1C4B2067;
        Mon, 16 Jul 2018 14:03:10 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 14:03:10 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9E36216C3EC6; Mon, 16 Jul 2018 11:05:40 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:05:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, palmer@sifive.com,
        sj38.park@gmail.com, mark.rutland@arm.com, j.neuschaefer@gmx.net,
        yauheni.kaliuta@redhat.com
Subject: [PATCH memory-model 0/14] Updates to the formal memory model
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071618-0060-0000-0000-0000028D0980
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009375; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061729; UDB=6.00545095; IPR=6.00839634;
 MB=3.00022159; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 18:03:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071618-0061-0000-0000-000045D1E24F
Message-Id: <20180716180540.GA14222@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains updates to the Linux kernel's formal memory model
in tools/memory-model, along with corresponding changes in documentation
and Linux-kernel code.  These patches are ready for inclusion into -tip.

1.	Add a litmus test for full multi-copy atomicity.

2.	Fix the name of the ISA2+pooncelock+pooncelock+pombonce litmus test.

3.	Add Daniel Lustig as an LKMM reviewer, with focus on RISC-V,
	courtesy of Palmer Dabbelt.

4.	Update Korean translation to fix broken DMA vs. MMIO ordering
	example, courtesy of SeongJae Park with edits suggested by
	Byungchul Park.

5-6.	Remove the now-obsolete ACCESS_ONCE() from recipes and the model
	itself, courtesy of Mark Rutland.

7.	Make regression-test scripts executable.

8.	Describe atomic_set as a write operation, courtesy of Jonathan
	Neuschäfer.

9.	Add informal LKMM documentation to MAINTAINERS.

10.	Use smp_mb() in wake_woken_function(), courtesy of Andrea Parri.

11.	Clarify requirements for smp_mb__after_spinlock(), courtesy of
	Andrea Parri.

12.	Update wake_up() and friends' memory-barrier guarantees,
	courtesy of Andrea Parri.

13.	Fix "smb_wmb()" typo (should be "smp_wmb()"), courtesy of
	Yauheni Kaliuta.

14.	Rename litmus tests to comply to norm7, courtesy of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/core-api/atomic_ops.rst                                                      |    2 
 Documentation/memory-barriers.txt                                                          |   43 +++---
 Documentation/translations/ko_KR/memory-barriers.txt                                       |   22 +--
 MAINTAINERS                                                                                |    6 
 include/linux/sched.h                                                                      |    4 
 include/linux/spinlock.h                                                                   |   53 +++++--
 kernel/sched/completion.c                                                                  |    8 -
 kernel/sched/core.c                                                                        |   71 ++++------
 kernel/sched/wait.c                                                                        |   55 +++----
 tools/memory-model/Documentation/explanation.txt                                           |    2 
 tools/memory-model/Documentation/recipes.txt                                               |   12 -
 tools/memory-model/README                                                                  |   20 +-
 tools/memory-model/linux-kernel.bell                                                       |    2 
 tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus                      |    2 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus                 |    2 
 tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus                     |    2 
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus                |    2 
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus                                  |    2 
 tools/memory-model/litmus-tests/README                                                     |   25 ++-
 tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus                    |    2 
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus                                 |    2 
 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus                          |   32 ++++
 tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus             |    2 
 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus |    2 
 tools/memory-model/scripts/checkalllitmus.sh                                               |    2 
 tools/memory-model/scripts/checklitmus.sh                                                  |    2 
 26 files changed, 223 insertions(+), 156 deletions(-)

