Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CED218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbfAaQwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:52:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733267AbfAaQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:52:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VGmxfG111560
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:52:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qc4sjre55-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:52:34 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 31 Jan 2019 16:52:33 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 16:52:31 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VGqTuH40763504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 16:52:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB55052059;
        Thu, 31 Jan 2019 16:52:29 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6D4E25204F;
        Thu, 31 Jan 2019 16:52:29 +0000 (GMT)
Date:   Thu, 31 Jan 2019 17:52:28 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19013116-0008-0000-0000-000002B96ECD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013116-0009-0000-0000-000022257265
Message-Id: <20190131165228.GA32680@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:27:25AM +0100, Thomas Gleixner wrote:
> On Thu, 31 Jan 2019, Thomas Gleixner wrote:
> 
> > On Wed, 30 Jan 2019, Paul E. McKenney wrote:
> > > On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> > > > I might be wrong as usual, but this would definitely explain the fail very
> > > > well.
> > > 
> > > On recent versions of GCC, the fix would be to put this between the two
> > > stores that need ordering:
> > > 
> > > 	__atomic_thread_fence(__ATOMIC_RELEASE);
> > > 
> > > I must defer to Heiko on whether s390 GCC might tear the stores.  My
> > > guess is "probably not".  ;-)
> > 
> > So I just checked the latest glibc code. It has:
> > 
> >             /* We must not enqueue the mutex before we have acquired it.
> >                Also see comments at ENQUEUE_MUTEX.  */
> >             __asm ("" ::: "memory");
> >             ENQUEUE_MUTEX_PI (mutex);
> >             /* We need to clear op_pending after we enqueue the mutex.  */
> >             __asm ("" ::: "memory");
> >             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> > 
> > 8f9450a0b7a9 ("Add compiler barriers around modifications of the robust mutex list.")
> > 
> > in the glibc repository, There since Dec 24 2016 ...
> 
> And of course, I'm using the latest greatest glibc for testing that, so I'm
> not at all surprised that it just does not reproduce on my tests.

As discussed on IRC: I used plain vanilla glibc version 2.28 for my
tests. This version already contains the commit you mentioned above.

> I just hacked the ordering and restarted the test. If the theory holds,
> then this should die sooner than later.

...nevertheless Stefan and I looked through the lovely disassembly of
_pthread_mutex_lock_full() to verify if the compiler barriers are
actually doing what they are supposed to do. The generated code
however does look correct.
So, it must be something different.

