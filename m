Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6BEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00702084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00702084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeKZJ1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:27:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbeKZJ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:27:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAPMYMo8011833
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 17:35:14 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nymdu8hsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 17:35:14 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 25 Nov 2018 22:35:13 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 25 Nov 2018 22:35:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAPMZA111769860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 22:35:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D15CB2066;
        Sun, 25 Nov 2018 22:35:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E416B205F;
        Sun, 25 Nov 2018 22:35:09 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.199.91])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 25 Nov 2018 22:35:09 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1BB9916C0890; Sun, 25 Nov 2018 14:35:13 -0800 (PST)
Date:   Sun, 25 Nov 2018 14:35:13 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Corcodel Marian <corcodel.marian@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org
Subject: Re: Function rcu_dynticks_eqs_exit spent more cycles to processor
Reply-To: paulmck@linux.ibm.com
References: <1543174886.3486.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543174886.3486.4.camel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112522-2213-0000-0000-0000031F1E24
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010120; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01122737; UDB=6.00582779; IPR=6.00902858;
 MB=3.00024326; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-25 22:35:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112522-2214-0000-0000-00005C61E958
Message-Id: <20181125223513.GE4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-25_20:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811250141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 09:41:26PM +0200, Corcodel Marian wrote:
> Hi below , in modified func from kernel/rcu/tree.c and not stall proc,
> run perf for more info.
> Item type atomic_t dynticks from rcu_dynticks stucture can bee replaced
> with u8 type, because Intel guarrantee atomic operations to byte.
>  Eg, rtdp->dynticks = ~RCU_DYNTICK_CTRL_MASK;

I am not clear on exactly what change you are suggesting.  But regardless,
this is core code, so it must run on all CPUs that the Linux kernel
supports, not just Intel x86.  Furthermore, a straight store of
~RCU_DYNTICK_CTRL_MASK would be rather destructive in this function,
if that is what you are getting at with your assignment statement above.
So again, I am not clear on exactly what change you are suggesting, but
whatever it is, it must build and run on all architectures.

Adding LKML on CC, develop in the open and all that.

							Thanx, Paul

> static void rcu_dynticks_eqs_exit(void)
> {
> 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> 
> 	/*
> 	 * CPUs seeing atomic_add_return() must see prior idle
> sojourns,
> 	 * and we also must force ordering with the next RCU read-side
> 	 * critical section.
> 	 */
> 		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdtp->dynticks);
> 		smp_mb__after_atomic(); /* _exit after clearing mask.
> */
> 		/* Prefer duplicate flushes to losing a flush. */
> 		rcu_eqs_special_exit();
> }
> 

