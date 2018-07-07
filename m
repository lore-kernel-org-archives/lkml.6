Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FCCC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43B622AC6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43B622AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeGGAPo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932463AbeGGAPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:15:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w670EAp3059916
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 20:15:42 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k2dryh6v9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 20:15:41 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 20:15:40 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 20:15:36 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w670FaTm18284602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 7 Jul 2018 00:15:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D743EB2065;
        Fri,  6 Jul 2018 20:15:14 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5C77B2064;
        Fri,  6 Jul 2018 20:15:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 20:15:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E2DBF16C0489; Fri,  6 Jul 2018 17:17:51 -0700 (PDT)
Date:   Fri, 6 Jul 2018 17:17:51 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        npiggin@gmail.com, peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com, dlustig@nvidia.com
Subject: LKMM patch scorecard for v4.19 merge window
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
 <20180628152140.GK3593@linux.vnet.ibm.com>
 <1b382e0f-bfa8-8465-ba88-3a1431beefde@gmail.com>
 <20180629030524.GT3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629030524.GT3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070700-0068-0000-0000-00000314815C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009321; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057611; UDB=6.00542634; IPR=6.00835531;
 MB=3.00022034; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-07 00:15:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070700-0069-0000-0000-000044F0C878
Message-Id: <20180707001751.GA4336@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807070001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here is the updated scorecard:

e9ff68680cd4 tools/memory-model: Add litmus test for full multicopy atomicity
c21fcc6594f1 tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
2f5a1b9b74a2 MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
e1c071fab8e1 locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
b95546bdac98 tools/memory-model: Remove ACCESS_ONCE() from recipes
a1e5fd06bb6b tools/memory-model: Remove ACCESS_ONCE() from model
a54df4f2be14 tools/memory-model: Make scripts executable
c6b04f78bf25 docs: atomic_ops: Describe atomic_set as a write operation
36853a86cf04 tools/memory-model: Add informal LKMM documentation to MAINTAINERS
950ba9d5bb8f sched: Use smp_mb() in wake_woken_function()
c7af75d2ba8b locking: Clarify requirements for smp_mb__after_spinlock()
bc8209732066 doc: Update wake_up() & co. memory-barrier guarantees

	All of these are ready for the upcoming merge window,
	thanks everyone!

473fd6e42ddc tools/memory-model: Rename litmus tests to comply to norm7

	This one still needs an ack.

820d0072320d EXP tools/memory-model: Add litmus-test naming scheme

	This one still requires me to apply feedback.

a713319eb9c5 EXP tools/memory-model: Add .cfg and .cat files for s390

	This one is a not-for-mainline placeholder.

							Thanx, Paul

On Thu, Jun 28, 2018 at 08:05:24PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 29, 2018 at 07:22:22AM +0900, Akira Yokosawa wrote:
> > On 2018/06/28 08:21:40 -0700, Paul E. McKenney wrote:
> > [...]
> > > 
> > > While I am at it, here is the current scorecard:
> > > 
> > > e9ff68680cd4 tools/memory-model: Add litmus test for full multicopy atomicity
> > > c21fcc6594f1 tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
> > > aa838e0b70e1 MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
> > > 3cb0d7701c4c locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
> > > 0bde941f3629 tools/memory-model: Remove ACCESS_ONCE() from recipes
> > > 80b7b05c3aa0 tools/memory-model: Remove ACCESS_ONCE() from model
> > > 
> > > 	The above patches are ready for the upcoming merge window because
> > > 	each has at least one Acked-by or Reviewed-by.
> > > 
> > > 6098ce88bc4d tools/memory-model: Make scripts executable
> > 
> > In this commit, "Usage:" in the header of scripts/checklitmus.sh should
> > also be updated.
> > 
> > When it is fixed,
> > 
> > Acked-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Done, applied, and thank you!
> 
> 							Thanx, Paul
> 
> >       Thanks, Akira
> > 
> > > 5bb22d0126f9 tools/memory-model: Rename litmus tests to comply to norm7
> > > 1bc179880fba docs: atomic_ops: Describe atomic_set as a write operation
> > > 
> > > 	The above patches need at least one additional Acked-by
> > > 	or Reviewed-by.  If any of you gets a chance, please do
> > > 	look them over.
> > > 
> > > 51b0a8985c5a EXP tools/memory-model: Add litmus-test naming scheme
> > > 
> > > 	This patch needs me to get Will Deacon's feedback applied.  :-/
> > > 
> > > 06e99a0d9662 EXP tools/memory-model: Add .cfg and .cat files for s390
> > > 
> > > 	This is a placeholder, and probably won't ever go upstream
> > > 	into the Linux kernel.  (Maybe someday into herd where the
> > > 	other architecture-specific .cat files live.)
> > > 
> > > 							Thanx, Paul
> > > 
> > >> Cheers,
> > >>   Andrea
> > >>
> > >>
> > >>>
> > >>>  tools/memory-model/Documentation/recipes.txt | 4 ++--
> > >>>  tools/memory-model/linux-kernel.bell         | 2 +-
> > >>>  2 files changed, 3 insertions(+), 3 deletions(-)
> > >>>
> > >>> -- 
> > >>> 2.11.0
> > >>>
> > >>
> > > 
> > 

