Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E892C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ADE21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfA2JBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:01:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfA2JBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:01:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T8sA8S048013
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:01:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qagxm23ru-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:01:16 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 29 Jan 2019 09:01:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 09:01:11 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0T91AdM9568760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 09:01:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 774C55204F;
        Tue, 29 Jan 2019 09:01:10 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2A3FF5207C;
        Tue, 29 Jan 2019 09:01:10 +0000 (GMT)
Date:   Tue, 29 Jan 2019 10:01:08 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19012909-0020-0000-0000-0000030D353E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012909-0021-0000-0000-0000215E377E
Message-Id: <20190129090108.GA26906@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:53:19PM +0100, Thomas Gleixner wrote:
> On Mon, 28 Jan 2019, Peter Zijlstra wrote:
> > On Mon, Jan 28, 2019 at 02:44:10PM +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:
> > > 
> > > > And indeed, if I run only this test case in an endless loop and do
> > > > some parallel work (like kernel compile) it currently seems to be
> > > > possible to reproduce the warning:
> > > > 
> > > > while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> > > > 
> > > > within the build directory of glibc (2.28).
> > > 
> > > Right; so that reproduces for me.
> > > 
> > > After staring at all that for a while; trying to remember how it all
> > > worked (or supposed to work rather), I became suspiscous of commit:
> > > 
> > >   56222b212e8e ("futex: Drop hb->lock before enqueueing on the rtmutex")
> > > 
> > > And indeed, when I revert that; the above reproducer no longer works (as
> > > in, it no longer triggers in minutes and has -- so far -- held up for an
> > > hour+ or so).
> 
> Right after staring long enough at it, the commit simply forgot to give
> __rt_mutex_start_proxy_lock() the same treatment as it gave to
> rt_mutex_wait_proxy_lock().
> 
> Patch below cures that.

With your patch the kernel warning doesn't occur anymore. So if this
is supposed to be the fix feel free to add:

Tested-by: Heiko Carstens <heiko.carstens@de.ibm.com>


However now I see every now and then the following failure from the
same test case:

tst-robustpi8: ../nptl/pthread_mutex_lock.c:425: __pthread_mutex_lock_full: Assertion `INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust' failed.

		/* ESRCH can happen only for non-robust PI mutexes where
		   the owner of the lock died.	*/
		assert (INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust);

I just verified that this happened also without your patch, I just
didn't see it since I started my tests with panic_on_warn=1 and the
warning triggered always earlier.
So, this seems to be something different.

