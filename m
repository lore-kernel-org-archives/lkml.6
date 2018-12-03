Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E825C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8920851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE8920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLCXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:04:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbeLCXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:04:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3N3n7W082514
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 18:04:14 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p5d3m1j2s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 18:04:14 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Dec 2018 23:04:14 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 23:04:09 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3N49Yo15335516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 23:04:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03011B206A;
        Mon,  3 Dec 2018 23:04:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85D6B2064;
        Mon,  3 Dec 2018 23:04:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Dec 2018 23:04:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DE7D616C1BF4; Mon,  3 Dec 2018 15:04:11 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:04:11 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH memory-model 0/3] Updates to the formal memory model
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120323-0072-0000-0000-000003D36257
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010166; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01126570; UDB=6.00582089; IPR=6.00906705;
 MB=3.00024430; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-03 23:04:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120323-0073-0000-0000-00004A5216AD
Message-Id: <20181203230411.GA27476@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This series contains updates to the Linux kernel's formal memory model
in tools/memory-model.  These patches are ready for inclusion into -tip.

1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.

2.	Add scripts to check github litmus tests.

3.	Make scripts take "-j" abbreviation for "--jobs".

There is another series in preparation to model SRCU, but this series
requires hot-off-the presses changes to the herd tool that have not yet
been released.  This SRCU series is therefore targeting the merge window
after the upcoming one.  People wishing to experiment with the prototype
SRCU model may obtain it from my -rcu tree at branch "dev", and use
a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
version 7.51+2(dev), which is (commit 10403b24070c) or later.

							Thanx, Paul

------------------------------------------------------------------------

 .gitignore                 |    1 
 README                     |    2 
 linux-kernel.bell          |    3 
 linux-kernel.cat           |    4 -
 linux-kernel.def           |    1 
 scripts/README             |   70 ++++++++++++++++++++++
 scripts/checkalllitmus.sh  |   53 +++++++----------
 scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
 scripts/checklitmus.sh     |   74 +++--------------------
 scripts/checklitmushist.sh |   60 +++++++++++++++++++
 scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
 scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
 scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
 scripts/newlitmushist.sh   |   61 +++++++++++++++++++
 scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
 scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
 16 files changed, 757 insertions(+), 97 deletions(-)

