Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E432206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E432206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeLDQgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:36:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52875 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbeLDQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:36:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB4GYGwi025279
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 11:36:47 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p5vrj1hd8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:36:47 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 4 Dec 2018 16:36:45 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Dec 2018 16:36:40 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB4Gad1Q19267586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 16:36:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7CDBB2067;
        Tue,  4 Dec 2018 16:36:39 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 806F2B2066;
        Tue,  4 Dec 2018 16:36:39 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Dec 2018 16:36:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 35CAC16C6035; Tue,  4 Dec 2018 08:36:40 -0800 (PST)
Date:   Tue, 4 Dec 2018 08:36:40 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Subject: Re: [PATCH memory-model 0/3] Updates to the formal memory model
Reply-To: paulmck@linux.ibm.com
References: <20181203230411.GA27476@linux.ibm.com>
 <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
 <20181203235127.GS4170@linux.ibm.com>
 <fbd7b1ed-7a4f-b877-e2f0-8dafca817f68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd7b1ed-7a4f-b877-e2f0-8dafca817f68@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120416-0060-0000-0000-000002DE6609
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010170; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01126922; UDB=6.00585298; IPR=6.00907056;
 MB=3.00024444; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-04 16:36:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120416-0061-0000-0000-0000476C070A
Message-Id: <20181204163640.GX4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:40:01AM +0900, Akira Yokosawa wrote:
> On 2018/12/03 15:51:27 -0800, Paul E. McKenney wrote:
> > On Tue, Dec 04, 2018 at 08:28:03AM +0900, Akira Yokosawa wrote:
> >> On 2018/12/03 15:04:11 -0800, Paul E. McKenney wrote:
> >>> Hello, Ingo!
> >>>
> >>> This series contains updates to the Linux kernel's formal memory model
> >>> in tools/memory-model.  These patches are ready for inclusion into -tip.
> >>>
> >>> 1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.
> >>>
> >>> 2.	Add scripts to check github litmus tests.
> >>>
> >>> 3.	Make scripts take "-j" abbreviation for "--jobs".
> >>>
> >>> There is another series in preparation to model SRCU, but this series
> >>> requires hot-off-the presses changes to the herd tool that have not yet
> >>> been released.  This SRCU series is therefore targeting the merge window
> >>> after the upcoming one.  People wishing to experiment with the prototype
> >>> SRCU model may obtain it from my -rcu tree at branch "dev", and use
> >>> a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
> >>> version 7.51+2(dev), which is (commit 10403b24070c) or later.
> >>
> >> On the master branch of herdtools7, SRCU support was added in version
> >> 7.51+4(dev), which is commit 6ec9da1f4d58, or later.
> > 
> > It has been working for me with version 7.51+2(dev), but perhaps I
> > have just been getting lucky.  It wouldn't be the first time!  ;-)
> 
> Sounds like you've been at the HEAD of topic branch "srcu".

You are quite right.  And this situation does confirm the wisdom of
waiting until a herd release containing the SRCU support.  ;-)

							Thanx, Paul

>         Thanks, Akira
> > 
> > 							Thanx, Paul
> > 
> >>         Thanks, Akira
> >>
> >>>
> >>> 							Thanx, Paul
> >>>
> >>> ------------------------------------------------------------------------
> >>>
> >>>  .gitignore                 |    1 
> >>>  README                     |    2 
> >>>  linux-kernel.bell          |    3 
> >>>  linux-kernel.cat           |    4 -
> >>>  linux-kernel.def           |    1 
> >>>  scripts/README             |   70 ++++++++++++++++++++++
> >>>  scripts/checkalllitmus.sh  |   53 +++++++----------
> >>>  scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
> >>>  scripts/checklitmus.sh     |   74 +++--------------------
> >>>  scripts/checklitmushist.sh |   60 +++++++++++++++++++
> >>>  scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
> >>>  scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
> >>>  scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
> >>>  scripts/newlitmushist.sh   |   61 +++++++++++++++++++
> >>>  scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
> >>>  scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
> >>>  16 files changed, 757 insertions(+), 97 deletions(-)
> >>>
> >>
> > 
> 

