Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B671DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8D218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbeLUOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:23:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733305AbeLUOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:23:24 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBLEJ3Hr089271
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:23:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ph1h51bbq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:23:22 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 21 Dec 2018 14:23:21 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Dec 2018 14:23:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBLENGsk14418124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Dec 2018 14:23:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D875BB2068;
        Fri, 21 Dec 2018 14:23:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5D48B2064;
        Fri, 21 Dec 2018 14:23:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Dec 2018 14:23:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6DD9116C20FC; Fri, 21 Dec 2018 06:23:23 -0800 (PST)
Date:   Fri, 21 Dec 2018 06:23:23 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Reply-To: paulmck@linux.ibm.com
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
 <20181218000800.GB25620@tassilo.jf.intel.com>
 <20181218091824.GI2218@hirez.programming.kicks-ass.net>
 <20181218100014.GA16284@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218100014.GA16284@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18122114-0052-0000-0000-0000036B5E2A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010261; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01134977; UDB=6.00590153; IPR=6.00915149;
 MB=3.00024785; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-21 14:23:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122114-0053-0000-0000-00005F2FE03E
Message-Id: <20181221142323.GO4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:00:14AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 18, 2018 at 10:18:24AM +0100, Peter Zijlstra wrote:
> > In particular turning an address-dependency into a control-dependency,
> > which is something allowed by the C language, since it doesn't recognise
> > these concepts as such.
> > 
> > The 'optimization' is allowed currently, but LTO will make it much more
> > likely since it will have a much wider view of things. Esp. when combined
> > with PGO.
> > 
> > Specifically; if you have something like:
> > 
> > int idx;
> > struct object objs[2];
> > 
> > the statement:
> > 
> >   val = objs[idx & 1].ponies;
> > 
> > which you 'need' to be translated like:
> > 
> >   struct object *obj = objs;
> >   obj += (idx & 1);
> >   val = obj->ponies;
> > 
> > Such that the load of obj->ponies depends on the load of idx. However
> > our dear compiler is allowed to make it:
> > 
> >   if (idx & 1)
> >     obj = &objs[1];
> >   else
> >     obj = &objs[0];
> > 
> >   val = obj->ponies;
> > 
> > Because C doesn't recognise this as being different. However this is
> > utterly broken, because in this translation we can speculate the load
> > of obj->ponies such that it no longer depends on the load of idx, which
> > breaks RCU.

Hence the following in Documentation/RCU/rcu_dereference.txt:

	You are only permitted to use rcu_dereference on pointer values.
	The compiler simply knows too much about integral values to
	trust it to carry dependencies through integer operations.

I got rid of the carrying of dependencies via non-pointers in 2014.
You are telling me that they have crept back?  Sigh!!!  :-/

							Thanx, Paul

> > Note that further 'optimization' is possible and the compiler could even
> > make it:
> > 
> >   if (idx & 1)
> >     val = objs[1].ponies;
> >   else
> >     val = objs[0].ponies;
> 
> A variant that is actually broken on x86 too (due to issuing the loads
> in the 'wrong' order):
> 
>   val = objs[0].ponies;
>   if (idx & 1)
>     val = objs[1].ponies;
> 
> Which is a translation that makes sense if we either marked
> unlikely(idx & 1) or if PGO found the same.
> 
> > Now, granted, this is a fairly artificial example, but it does
> > illustrate the exact problem.
> > 
> > The more the compiler can see of the complete program, the more likely
> > it can make inferrences like this, esp. when coupled with PGO.
> > 
> > Now, we're (usually) very careful to wrap things in READ_ONCE() and
> > rcu_dereference() and the like, which makes it harder on the compiler
> > (because 'volatile' is special), but nothing really stops it from doing
> > this.
> > 
> > Paul has been trying to beat clue into the language people, but given
> > he's been at it for 10 years now, and there's no resolution, I figure we
> > ought to get compiler implementations to give us a knob.
> 

