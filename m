Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id S1ViBeIXGVucVgAAmS7hNA
	; Thu, 07 Jun 2018 11:37:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E234608BA; Thu,  7 Jun 2018 11:37:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4360608B8;
	Thu,  7 Jun 2018 11:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4360608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeFGLhM convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 07:37:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753047AbeFGLhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:37:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57BYYmG048243
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 07:37:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf1yx5sc4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:37:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 12:37:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 12:37:04 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57Bb3FL30867672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 11:37:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47AE7A404D;
        Thu,  7 Jun 2018 12:28:03 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0D46A4055;
        Thu,  7 Jun 2018 12:28:02 +0100 (BST)
Received: from localhost (unknown [9.124.222.26])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 12:28:02 +0100 (BST)
Date: Thu, 07 Jun 2018 17:07:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812783350.10068.4690566636762511152.stgit@devbox>
In-Reply-To: <152812783350.10068.4690566636762511152.stgit@devbox>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18060711-4275-0000-0000-0000028B2493
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060711-4276-0000-0000-0000379232FF
Message-Id: <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> Don't call the ->break_handler() from the arm kprobes code,
					    ^^^ powerpc

> because it was only used by jprobes which got removed.
> 
> This also makes skip_singlestep() a static function since
> only ftrace-kprobe.c is using this function.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/include/asm/kprobes.h   |   10 ----------
>  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
>  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
>  3 files changed, 14 insertions(+), 43 deletions(-)

With 2 small comments...
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen

> 
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index 674036db558b..785c464b6588 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -102,16 +102,6 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>  extern int kprobe_handler(struct pt_regs *regs);
>  extern int kprobe_post_handler(struct pt_regs *regs);
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> -extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -			   struct kprobe_ctlblk *kcb);
> -#else
> -static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -				  struct kprobe_ctlblk *kcb)
> -{
> -	return 0;
> -}
> -#endif
>  #else
>  static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
>  static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index 1b316331c2d9..3869b0e5d5c7 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -26,8 +26,8 @@
>  #include <linux/ftrace.h>
> 
>  static nokprobe_inline
> -int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
> +int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> +		    struct kprobe_ctlblk *kcb, unsigned long orig_nip)
>  {
>  	/*
>  	 * Emulate singlestep (and also recover regs->nip)
> @@ -44,16 +44,6 @@ int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
>  	return 1;
>  }
> 
> -int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> -		    struct kprobe_ctlblk *kcb)
> -{
> -	if (kprobe_ftrace(p))
> -		return __skip_singlestep(p, regs, kcb, 0);
> -	else
> -		return 0;
> -}
> -NOKPROBE_SYMBOL(skip_singlestep);
> -
>  /* Ftrace callback handler for kprobes */
>  void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  			   struct ftrace_ops *ops, struct pt_regs *regs)
> @@ -82,7 +72,7 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  		__this_cpu_write(current_kprobe, p);
>  		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  		if (!p->pre_handler || !p->pre_handler(p, regs))
> -			__skip_singlestep(p, regs, kcb, orig_nip);
> +			skip_singlestep(p, regs, kcb, orig_nip);

We can probably get rid of skip_singlestep() completely along with 
orig_nip since instructions are always 4 bytes on powerpc. So, the 
changes we do to nip should help to recover the value automatically.

- Naveen
