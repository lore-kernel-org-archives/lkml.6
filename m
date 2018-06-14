Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AFD69C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43E208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43E208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935774AbeFNBZx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:25:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754498AbeFNBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:25:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5E1NfNm098172
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 21:25:51 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jk9y19tc5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 21:25:51 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 21:25:51 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 21:25:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5E1Pkiw56492260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 01:25:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95CA7B2064;
        Wed, 13 Jun 2018 21:25:43 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D37B205F;
        Wed, 13 Jun 2018 21:25:43 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.142.64])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 21:25:43 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A9D1D16C400F; Wed, 13 Jun 2018 18:27:42 -0700 (PDT)
Date:   Wed, 13 Jun 2018 18:27:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        bigeasy@linutronix.de, oleg@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180612083449.100099222@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612083449.100099222@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061401-0052-0000-0000-000002FE7524
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009186; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046610; UDB=6.00536032; IPR=6.00825585;
 MB=3.00021633; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-14 01:25:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061401-0053-0000-0000-00005D028361
Message-Id: <20180614012742.GP3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:34:49AM +0200, Peter Zijlstra wrote:
> As mentioned by Linus, swait is exclusive mode and had better behave like it
> and be named like it.
> 
> Make it so.

Cool!

When I tried testing it on x86 against recent mainline, I got:

"WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder."

But when I tested on recent mainline without your patches:

	4597fcff0704 "Merge tag 'for-4.18/dm-changes-v2' of
	git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm"

I get the same warning.  Trying again on today's mainline, but in the
meantime, is anyone else seeing this?

							Thanx, Paul

> ---
>  arch/mips/kvm/mips.c         |  4 ++--
>  arch/powerpc/kvm/book3s_hv.c |  6 +++---
>  arch/s390/kvm/interrupt.c    |  2 +-
>  arch/x86/kernel/kvm.c        |  4 ++--
>  arch/x86/kvm/lapic.c         |  2 +-
>  include/linux/swait.h        | 36 ++++++++++++++++++------------------
>  kernel/power/suspend.c       |  4 ++--
>  kernel/rcu/srcutiny.c        |  4 ++--
>  kernel/rcu/tree.c            |  8 ++++----
>  kernel/rcu/tree_exp.h        |  4 ++--
>  kernel/rcu/tree_plugin.h     | 12 ++++++------
>  kernel/sched/swait.c         | 32 ++++++++++++++++++++++----------
>  virt/kvm/arm/arm.c           |  4 ++--
>  virt/kvm/arm/psci.c          |  2 +-
>  virt/kvm/async_pf.c          |  2 +-
>  virt/kvm/kvm_main.c          |  4 ++--
>  16 files changed, 71 insertions(+), 59 deletions(-)
> 
> 

