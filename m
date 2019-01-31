Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B4C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C2C20989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfAaBou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:44:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbfAaBou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:44:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V1dBgX145447
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 20:44:48 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbjtykdep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 20:44:48 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 31 Jan 2019 01:44:48 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 01:44:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V1ihdL23920788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 01:44:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6122CB2064;
        Thu, 31 Jan 2019 01:44:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40959B2066;
        Thu, 31 Jan 2019 01:44:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.205.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 01:44:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0034616C69CE; Wed, 30 Jan 2019 17:44:42 -0800 (PST)
Date:   Wed, 30 Jan 2019 17:44:42 -0800
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
References: <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
 <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19013101-0040-0000-0000-000004BA0805
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154173; UDB=6.00593882; IPR=6.00934550;
 MB=3.00025361; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-31 01:44:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013101-0041-0000-0000-000008C51DC3
Message-Id: <20190131014442.GB4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:55:18AM +0100, Thomas Gleixner wrote:
> On Wed, 30 Jan 2019, Paul E. McKenney wrote:
> > On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> > > I might be wrong as usual, but this would definitely explain the fail very
> > > well.
> > 
> > On recent versions of GCC, the fix would be to put this between the two
> > stores that need ordering:
> > 
> > 	__atomic_thread_fence(__ATOMIC_RELEASE);
> > 
> > I must defer to Heiko on whether s390 GCC might tear the stores.  My
> > guess is "probably not".  ;-)
> 
> So I just checked the latest glibc code. It has:
> 
>             /* We must not enqueue the mutex before we have acquired it.
>                Also see comments at ENQUEUE_MUTEX.  */
>             __asm ("" ::: "memory");
>             ENQUEUE_MUTEX_PI (mutex);
>             /* We need to clear op_pending after we enqueue the mutex.  */
>             __asm ("" ::: "memory");
>             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> 
> 8f9450a0b7a9 ("Add compiler barriers around modifications of the robust mutex list.")
> 
> in the glibc repository, There since Dec 24 2016 ...
> 
> So the question is whether this is sufficient. That ordering only only
> matters vs. the thread itself and not for others.

Ah, in that case you can use __atomic_signal_fence(__ATOMIC_RELEASE)
instead of the __atomic_thread_fence(__ATOMIC_RELEASE).

The __atomic_thread_fence(__ATOMIC_RELEASE) provides ordering between
threads, but __atomic_signal_fence(__ATOMIC_RELEASE) only does so
within a thread.

							Thanx, Paul

