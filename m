Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FCBECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC620818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECC620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKIDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:12:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbeKIDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:12:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8HSsLo007870
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 12:35:29 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmqtq5m7h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:35:29 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Nov 2018 17:35:29 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 17:35:26 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8HZPTL47251662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 17:35:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9518DB205F;
        Thu,  8 Nov 2018 17:35:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 744C2B2064;
        Thu,  8 Nov 2018 17:35:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.215.156])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 17:35:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0936016C2A72; Thu,  8 Nov 2018 09:35:25 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:35:25 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: rcu: Merge RCU-bh into RCU-preempt
Reply-To: paulmck@linux.ibm.com
References: <20181101231804.GA11280@linux.ibm.com>
 <20181108160256.xpawe65h5lm65soi@linutronix.de>
 <20181108164247.GL4170@linux.ibm.com>
 <20181108171516.axwvjtgay4zolc56@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108171516.axwvjtgay4zolc56@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110817-0052-0000-0000-00000352BE3E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114540; UDB=6.00577845; IPR=6.00894638;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 17:35:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110817-0053-0000-0000-00005EB31127
Message-Id: <20181108173525.GO4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 06:15:16PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-08 08:42:47 [-0800], Paul E. McKenney wrote:
> > On Thu, Nov 08, 2018 at 05:02:57PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2018-11-01 16:18:04 [-0700], Paul E. McKenney wrote:
> > > > The need for this goes away as of the current merge window because
> > > > RCU-bh has gone away.  (Aside from still being able to do things
> > > > like rcu_read_lock_bh() as a documentation device.)
> > > 
> > > So in -RT rcu_read_lock_bh() does
> > >  { local_bh_disable() ;  rcu_read_lock() }
> > > 
> > > So you are saying that this is also the case in v4.20?
> > 
> > No, rcu_read_lock_bh() and rcu_read_unlock_bh() are unchanged in v4.20.
> > With the new RCU grace-period mechanism, local_bh_disable() blocks future
> > grace periods on its own.
> > 
> > Unless I am missing something (quite probable, actually), the v4.20
> > definitions of rcu_read_lock_bh() and rcu_read_unlock_bh() should work
> > as-is for -rt.
> 
> I *think* tglx made this patch, then you somehow reverted it partly [0]
> and the final piece we need for RT is this gem:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/rcu-Eliminate-softirq-processing-from-rcutree.patch?h=linux-4.19.y-rt-patches
> 
> [0] rcu: Make ksoftirqd do RCU quiescent states
>     https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/patch-to-introduce-rcu-bh-qs-where-safe-from-softirq.patch?h=linux-4.19.y-rt-patches

I agree that tglx's patch is needed for 4.19 and earlier.  Just not for
4.20 and later.

Or am I still missing your point?

							Thanx, Paul

