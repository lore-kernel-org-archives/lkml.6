Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377D6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F5A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfBKVNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:13:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbfBKVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:13:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BKxOrR047463
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:13:07 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qkf57m0mu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:13:07 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Feb 2019 21:13:06 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 21:13:03 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BLD2v318022632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 21:13:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2619FB2067;
        Mon, 11 Feb 2019 21:13:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0630EB205F;
        Mon, 11 Feb 2019 21:13:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Feb 2019 21:13:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 12E9B16C4066; Mon, 11 Feb 2019 13:13:02 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:13:02 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Clarify signed vs unsigned
Reply-To: paulmck@linux.ibm.com
References: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
 <20190211172800.GA2994@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211172800.GA2994@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19021121-0068-0000-0000-000003924103
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010578; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159668; UDB=6.00605192; IPR=6.00940214;
 MB=3.00025531; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-11 21:13:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021121-0069-0000-0000-000047797406
Message-Id: <20190211211302.GT4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=863 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:28:00PM +0000, Will Deacon wrote:
> On Mon, Feb 11, 2019 at 06:09:43PM +0100, Peter Zijlstra wrote:
> > 
> > Clarify the whole signed vs unsigned issue for atomic_t.
> > 
> > There has been enough confusion on this topic to warrant a few explicit
> > words I feel.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  Documentation/atomic_t.txt | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index 913396ac5824..dca3fb0554db 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -56,6 +56,23 @@ The 'full' API consists of (atomic64_ and atomic_long_ prefixes omitted for
> >    smp_mb__{before,after}_atomic()
> >  
> >  
> > +TYPES (signed vs unsigned)
> > +-----
> > +
> > +While atomic_t, atomic_long_t and atomic64_t use int, long and s64
> > +respectively (for hysterical raisins), the kernel uses -fno-strict-overflow
> > +(which implies -fwrapv) and defines signed overflow to behave like
> > +2s-complement.
> > +
> > +Therefore, an explicitly unsigned variant of the atomic ops is strictly
> > +unnecessary and we can simply cast, there is no UB.
> > +
> > +There was a bug in UBSAN prior to GCC-8 that would generate UB warnings for
> > +signed types.
> > +
> > +With this we also conform to the C/C++ _Atomic behaviour and things like
> > +P1236R1.
> > +
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Queued with Will's ack, thank you both!

								Thanx, Paul

