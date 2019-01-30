Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A37C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE91E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfA3XgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:36:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbfA3XgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:36:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UNY3hj035302
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:36:03 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbnmvg73v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:36:02 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 30 Jan 2019 23:36:02 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 23:35:59 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UNZvlL18874456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 23:35:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A1E0B2066;
        Wed, 30 Jan 2019 23:35:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE38CB2064;
        Wed, 30 Jan 2019 23:35:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 23:35:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0FE1E16C69B0; Wed, 30 Jan 2019 15:35:57 -0800 (PST)
Date:   Wed, 30 Jan 2019 15:35:57 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
Reply-To: paulmck@linux.ibm.com
References: <20190129171653.ycl64psq2liy5o5c@linutronix.de>
 <20190130094913.GC5299@osiris>
 <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
 <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19013023-0072-0000-0000-000003F26274
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010506; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154130; UDB=6.00601769; IPR=6.00934507;
 MB=3.00025361; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-30 23:36:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013023-0073-0000-0000-00004B00DBEC
Message-Id: <20190130233557.GA4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> On Wed, 30 Jan 2019, Sebastian Sewior wrote:
> 
> > On 2019-01-30 18:56:54 [+0100], Thomas Gleixner wrote:
> > > TBH, no clue. Below are some more traceprintks which hopefully shed some
> > > light on that mystery. See kernel/futex.c line 30  ...
> > 
> > The robust list it somehow buggy. In the last trace we had the
> > handle_futex_death() of uaddr 3ff9e880140 as the last action. That means
> > it was an entry in 56496's ->list_op_pending entry. This makes sense
> > because it tried to acquire the lock, failed, got killed.
> 
> The robust list of the failing task seems to be correct. 
> 
> > According to uaddr pid 56956 is the owner. So 56956 invoked one of
> > pthread_mutex_lock() / pthread_mutex_timedlock() /
> > pthread_mutex_trylock() and should have obtained the lock in userland.
> > Depending on where it got killed, that mutex should be either recorded in
> > ->list_op_pending or the robust_list (or both if it didn't clear
> > ->list_op_pending yet). But it is not.
> > Similar for pthread_mutex_unlock().
> 
> > We don't have a trace_point if we abort processing the list.
> 
> The only reason why it would abort is due a page fault because that cannot
> be handled in the exit code anymore.
> 
> > On the other hand, it didn't trigger on x86 for hours. Could the atomic
> 
> s/hours/days/ ....
> 
> > ops be the culprit?
> 
> The glibc code does:
> 
>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending,
>        		     (void *) (((uintptr_t) &mutex->__data.__list.__next)
>                                    | 1));
> 
>        ....
>        lock in user space
> 
>        or
> 
>        lock in kernel space
> 
>        ENQUEUE_MUTEX_PI (mutex);
>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> 
>        ENQUEUE_MUTEX_PI() resolves to a THREAD_GETMEM() which reads the
>        list head from TLS, some list manipulation operations and the final
>        THREAD_SETMEM() which stores the new list head
> 
> Now on x86 THREAD_GETMEM() and THREAD_SETMEM() are resolving to
> 
>     asm volatile ("movX .....")
> 
> on s390 they are
> 
>    descr->member
> 
> based operations.
> 
> Now the important part of the robust list is the store sequence, i.e. the
> list head and final update to the TLS visible part need to come _before_
> list_op_pending is cleared.
> 
> I might be missing something, but there is no compiler barrier in that code
> which would prevent the compiler from reordering the stores. It can
> rightfully do so because there is no compiler visible dependency of these
> two operations.
> 
> On x8664 the asm volatile might prevent it by chance, but it does not have
> a 'memory' specified which would guarantee a compiler barrier.
> 
> On s390 there is certainly nothing.
> 
> So assumed that clearing list_op_pending comes before the list head update,
> then the robust exit code in the kernel will fail to see either of
> them. FAIL.
> 
> I might be wrong as usual, but this would definitely explain the fail very
> well.

On recent versions of GCC, the fix would be to put this between the two
stores that need ordering:

	__atomic_thread_fence(__ATOMIC_RELEASE);

I must defer to Heiko on whether s390 GCC might tear the stores.  My
guess is "probably not".  ;-)

							Thanx, Paul

