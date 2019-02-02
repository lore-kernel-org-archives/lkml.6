Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF67C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69DF217D6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 11:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfBBLUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 06:20:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfBBLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 06:20:17 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x12BDW28085345
        for <linux-kernel@vger.kernel.org>; Sat, 2 Feb 2019 06:20:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qd88c4ck2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 06:20:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 2 Feb 2019 11:20:13 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 2 Feb 2019 11:20:10 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x12BK8Be49283230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 2 Feb 2019 11:20:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 878924204D;
        Sat,  2 Feb 2019 11:20:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36C1842049;
        Sat,  2 Feb 2019 11:20:08 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  2 Feb 2019 11:20:08 +0000 (GMT)
Date:   Sat, 2 Feb 2019 12:20:06 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
 <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de>
 <20190201161227.GG3770@osiris>
 <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de>
 <20190202091043.GA3381@osiris>
 <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19020211-0020-0000-0000-00000310A41E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020211-0021-0000-0000-00002161AA36
Message-Id: <20190202112006.GB3381@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=740 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902020092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 11:14:27AM +0100, Thomas Gleixner wrote:
> On Sat, 2 Feb 2019, Heiko Carstens wrote:
> So after the unlock @timestamp 337.215675 the kernel does not deal with
> that futex at all until the failed lock attempt where it rightfully rejects
> the attempt due to the alleged owner being gone.
> 
> So this looks more like user space doing something stupid...
> 
> As we talked about the missing barriers before, I just looked at
> pthread_mutex_trylock() and that does still:
> 
> 	if (robust)
>           {
>             ENQUEUE_MUTEX_PI (mutex);
>             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
>           }
> 
> So it's missing the barriers which pthread_mutex_lock() has. Grasping for
> straws obviously....

Excellent! Taking a look into the disassembly of nptl/pthread_mutex_trylock.o
reveals this part:

140:   a5 1b 00 01             oill    %r1,1
144:   e5 48 a0 f0 00 00       mvghi   240(%r10),0   <--- THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
14a:   e3 10 a0 e0 00 24       stg     %r1,224(%r10) <--- last THREAD_SETMEM of ENQUEUE_MUTEX_PI

I added a barrier between those two and now the code looks like this:

140:   a5 1b 00 01             oill    %r1,1
144:   e3 10 a0 e0 00 24       stg     %r1,224(%r10)
14a:   e5 48 a0 f0 00 00       mvghi   240(%r10),0

Looks like this was a one instruction race...

I'll try to reproduce with the patch below (sprinkling compiler
barriers just like the other files have).

diff --git a/nptl/pthread_mutex_trylock.c b/nptl/pthread_mutex_trylock.c
index 7de61f4f68..3b093cb09c 100644
--- a/nptl/pthread_mutex_trylock.c
+++ b/nptl/pthread_mutex_trylock.c
@@ -116,8 +116,12 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 	      mutex->__data.__count = 1;
 	      /* But it is inconsistent unless marked otherwise.  */
 	      mutex->__data.__owner = PTHREAD_MUTEX_INCONSISTENT;
-
+	      /* We must not enqueue the mutex before we have acquired it.
+		 Also see comments at ENQUEUE_MUTEX.  */
+	      __asm ("" ::: "memory");
 	      ENQUEUE_MUTEX (mutex);
+	      /* We need to clear op_pending after we enqueue the mutex.  */
+	      __asm ("" ::: "memory");
 	      THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 
 	      /* Note that we deliberately exist here.  If we fall
@@ -177,7 +181,12 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 	}
       while ((oldval & FUTEX_OWNER_DIED) != 0);
 
+      /* We must not enqueue the mutex before we have acquired it.
+         Also see comments at ENQUEUE_MUTEX.  */
+      __asm ("" ::: "memory");
       ENQUEUE_MUTEX (mutex);
+      /* We need to clear op_pending after we enqueue the mutex.  */
+      __asm ("" ::: "memory");
       THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 
       mutex->__data.__owner = id;
@@ -279,7 +288,11 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 	    /* But it is inconsistent unless marked otherwise.  */
 	    mutex->__data.__owner = PTHREAD_MUTEX_INCONSISTENT;
 
+	    /* We must not enqueue the mutex before we have acquired it.
+	       Also see comments at ENQUEUE_MUTEX.  */
+	    __asm ("" ::: "memory");
 	    ENQUEUE_MUTEX (mutex);
+	    __asm ("" ::: "memory");
 	    THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 
 	    /* Note that we deliberately exit here.  If we fall
@@ -308,7 +321,12 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 
 	if (robust)
 	  {
+	    /* We must not enqueue the mutex before we have acquired it.
+	       Also see comments at ENQUEUE_MUTEX.  */
+	    __asm ("" ::: "memory");
 	    ENQUEUE_MUTEX_PI (mutex);
+	    /* We need to clear op_pending after we enqueue the mutex.  */
+	    __asm ("" ::: "memory");
 	    THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 	  }
 

