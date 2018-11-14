Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09CEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9532B22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9532B22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbeKOCNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:13:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbeKOCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:13:48 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAEG7pcP042138
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:09:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nrmd0s6tf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:09:50 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 14 Nov 2018 16:09:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Nov 2018 16:09:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAEG9dJP60686522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 16:09:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111BCA4067;
        Wed, 14 Nov 2018 16:09:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7384A405C;
        Wed, 14 Nov 2018 16:09:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Nov 2018 16:09:31 +0000 (GMT)
Date:   Wed, 14 Nov 2018 08:09:28 -0800
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     riel@redhat.com, linux@rasmusvillemoes.dk, keescook@chromium.org,
        viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org, tglx@linutronix.de,
        mingo@kernel.org, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, pasha.tatashin@oracle.com,
        ard.biesheuvel@linaro.org, luto@amacapital.net, wad@chromium.org,
        mhocko@kernel.org, riel@surriel.com, ebiederm@xmission.com,
        kirill.shutemov@linux.intel.com, guro@fb.com,
        marcos.souza.org@gmail.com, zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] fork: Fix some -Wmissing-prototypes warnings
References: <1542170087-23645-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542170087-23645-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18111416-0028-0000-0000-00000319E50B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111416-0029-0000-0000-000023D6510E
Message-Id: <20181114160927.GA12756@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:34:47PM +0800, Yi Wang wrote:
> We get a warning when building kernel with W=1:
> kernel/fork.c:167:13: warning: no previous prototype for ‘arch_release_thread_stack’ [-Wmissing-prototypes]
> kernel/fork.c:779:13: warning: no previous prototype for ‘fork_init’ [-Wmissing-prototypes]
> 
> Add the missing declaration in head file to fix this.
> 
> Also, remove arch_release_thread_stack() completely because no
> arch seems to implement it since bb9d81264 (arch: remove tile port).
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2: remove arch_release_thread_stack(). Thanks to Rasmus.
> ---
>  include/linux/sched/task.h | 2 ++
>  init/main.c                | 1 -
>  kernel/fork.c              | 5 -----
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 108ede9..44c6f15 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -39,6 +39,8 @@
>  
>  extern void proc_caches_init(void);
>  
> +extern void fork_init(void);
> +
>  extern void release_task(struct task_struct * p);
>  
>  #ifdef CONFIG_HAVE_COPY_THREAD_TLS
> diff --git a/init/main.c b/init/main.c
> index ee14710..8feda42 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -105,7 +105,6 @@
>  static int kernel_init(void *);
>  
>  extern void init_IRQ(void);
> -extern void fork_init(void);
>  extern void radix_tree_init(void);
>  
>  /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff..c6d02be 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -164,10 +164,6 @@ static inline void free_task_struct(struct task_struct *tsk)
>  }
>  #endif
>  
> -void __weak arch_release_thread_stack(unsigned long *stack)
> -{
> -}
> -
>  #ifndef CONFIG_ARCH_THREAD_STACK_ALLOCATOR
>  
>  /*
> @@ -417,7 +413,6 @@ static void release_task_stack(struct task_struct *tsk)
>  		return;  /* Better to leak the stack than to free prematurely */
>  
>  	account_kernel_stack(tsk, -1);
> -	arch_release_thread_stack(tsk->stack);
>  	free_thread_stack(tsk);
>  	tsk->stack = NULL;
>  #ifdef CONFIG_VMAP_STACK
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.

