Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1655FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D940721773
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLWT3f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 14:29:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbeLWT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 14:29:35 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBNJSxiN048421
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 14:29:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pj3k200as-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 14:29:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sun, 23 Dec 2018 19:29:32 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Dec 2018 19:29:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBNJTRpA5112290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Dec 2018 19:29:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCE6D42041;
        Sun, 23 Dec 2018 19:29:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8414F4203F;
        Sun, 23 Dec 2018 19:29:27 +0000 (GMT)
Received: from osiris (unknown [9.145.43.33])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 23 Dec 2018 19:29:27 +0000 (GMT)
Date:   Sun, 23 Dec 2018 20:29:26 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] timer fix
References: <20181221123453.GA102366@gmail.com>
In-Reply-To: <20181221123453.GA102366@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18122319-0028-0000-0000-0000032E945E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122319-0029-0000-0000-000023EB02EC
Message-Id: <20181223192926.GA3728@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:34:53PM +0100, Ingo Molnar wrote:
> Linus,
> 
> Please pull the latest timers-urgent-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus
> 
>    # HEAD: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 posix-timers: Fix division by zero bug
> 
> Fix a division by zero crash in the posix-timers code.
> 
>  Thanks,
> 
> 	Ingo
> 
> ------------------>
> Thomas Gleixner (1):
>       posix-timers: Fix division by zero bug
> 
> 
>  kernel/time/posix-timers.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index bd62b5eeb5a0..31f49ae80f43 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -289,9 +289,6 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
>  {
>  	struct hrtimer *timer = &timr->it.real.timer;
>  
> -	if (!timr->it_interval)
> -		return;
> -
>  	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
>  					    timr->it_interval);
>  	hrtimer_restart(timer);
> @@ -317,7 +314,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
>  	if (!timr)
>  		return;
>  
> -	if (timr->it_requeue_pending == info->si_sys_private) {
> +	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
>  		timr->kclock->timer_rearm(timr);

FWIW, with this patch the vanilla glibc 2.28 self tests
rt/tst-cputimer1, rt/tst-cputimer2, and rt/tst-cputimer3
start to fail on s390:

rt/tst-cputimer1.out:
clock_gettime returned timespec = { 0, 117181 }
clock_getres returned timespec = { 0, 1 }
Timed out: killed the child process
rt/tst-cputimer1.test-result:
FAIL: rt/tst-cputimer1
original exit status 1

rt/tst-cputimer2.out:
clock_gettime returned timespec = { 0, 9686 }
clock_getres returned timespec = { 0, 1 }
Timed out: killed the child process
rt/tst-cputimer2.test-result:
FAIL: rt/tst-cputimer2
original exit status 1

rt/tst-cputimer3.out:
clock_gettime returned timespec = { 0, 0 }
clock_getres returned timespec = { 0, 1 }
Timed out: killed the child process
rt/tst-cputimer3.test-result:
FAIL: rt/tst-cputimer3
original exit status 1

I haven't looked any further into this, just reporting.. otherwise the
test systems seem to be healthy.

