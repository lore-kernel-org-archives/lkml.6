Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9345EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611F12084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBLB3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:29:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726253AbfBLB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:29:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C1Suc9072356
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 20:29:13 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkfw52a62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 20:29:12 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 12 Feb 2019 01:29:12 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 01:29:09 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1C1T8dL22610058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 01:29:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44182B2064;
        Tue, 12 Feb 2019 01:29:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23822B205F;
        Tue, 12 Feb 2019 01:29:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.186.208])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Feb 2019 01:29:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DEC1116C4205; Mon, 11 Feb 2019 17:29:07 -0800 (PST)
Date:   Mon, 11 Feb 2019 17:29:07 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Clarify signed vs unsigned
Reply-To: paulmck@linux.ibm.com
References: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
 <20190212010355.GA11137@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212010355.GA11137@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19021201-0072-0000-0000-000003F891D6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010579; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159753; UDB=6.00605244; IPR=6.00940299;
 MB=3.00025535; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-12 01:29:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021201-0073-0000-0000-00004B26D7F5
Message-Id: <20190212012907.GY4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:03:55AM +0800, Boqun Feng wrote:
> On Mon, Feb 11, 2019 at 06:09:43PM +0100, Peter Zijlstra wrote:
> > 
> > Clarify the whole signed vs unsigned issue for atomic_t.
> > 
> > There has been enough confusion on this topic to warrant a few explicit
> > words I feel.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> FWIW
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Applied, thank you!

							Thanx, Paul

> Regards,
> Boqun
> 
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
> >  
> >  SEMANTICS
> >  ---------


