Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2448136-1520529124-2-10932233909621016909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520529124; b=s4ZZpBSFbN2EU831zY3zrSdiNlDW8Iwp9jAcxA1G0gQjfeC
    emzCJkf+4kH5xAJPuiAnewvINsH89esU3ii/Ak3Kh6uOqyCK1mMT+EX4+fVbQqC5
    QlBpCSQUFcSb/20mS5DXTTa8RiGJev4KsS2ml6GH/25njx6pee4CLCOWpYV72c0l
    PfO+gOvipX3IMkvPez6r+qpeZX49gY+d3PyAXbqj0Iw1l1rq7xezH/+MFkqeazVU
    WQjff4sGvmMdm1rlJSiPOtkDT+M10Ss8/Cn5sK8kwqe41SZZxR1AjZNnKx0PvUex
    noyA96GvtcIeN9MvLUydqp3HgBcUd9q1YykPj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520529124; bh=jYwqRVm4aIf0AUxGq9Te9bR3DD
    YXwJRWr7VD4Ez9hzo=; b=veLGpeErFvVWj+CmyafCLnlfojLva9y6IeRjHSYz4U
    9bbGwQF+f49pJUp08Zm74d28LUnL6UegTaDB7vGI5hW9MtpyjQMYtsDifkGoOG/3
    SbigUPynVZz0DbCIYFe2eardir4lDtSkBLEsQivp/OmaUJXyCtwIK74bpBlQc7Df
    IPwIdy/AG1tl2e+BYHNOltNCSt5IMq8oH2YiSPAZZPVGsyS/62kmvlVXtM/pVQX/
    lxzP0zxim9yBUTpxsr5HDPOfcL1LKhtR+5YXzj8GTmMyTcT+efZvO16U1po6rrE5
    gyyMHrkA4TOdAidd/XUAPDJ3o/RhFyT6QmBZyGeXSaiQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeCHRLr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 12:11:47 -0500
Received: from foss.arm.com ([217.140.101.70]:41152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932100AbeCHRLp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 8 Mar 2018 12:11:45 -0500
Date: Thu, 8 Mar 2018 17:11:50 +0000
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        arnd@arndb.de
Subject: Re: [PATCH v2 1/3] signal: Add FPE_FLTUNK si_code for undiagnosable
 fp exceptions
Message-ID: <20180308171149.GC14918@arm.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
 <1519926248-12591-2-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519926248-12591-2-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dave,

On Thu, Mar 01, 2018 at 05:44:06PM +0000, Dave Martin wrote:
> Some architectures cannot always report accurately what kind of
> floating-point exception triggered a floating-point exception trap.
> 
> This can occur with fp exceptions occurring on lanes in a vector
> instruction on arm64 for example.
> 
> Rather than have every architecture come up with its own way of
> describing such a condition, this patch adds a common FPE_FLTUNK
> si_code value to report that an fp exception caused a trap but we
> cannot be certain which kind of fp exception it was.

This looks straightforward to me, but I'll need Acks for the x86 and uapi
changes if I'm to take this via arm64. I've added some others to CC and
kept the patch intact below.

Cheers,

Will

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> --
> 
> Changes since v1:
> 
> Reported by James Morse:
> 
>  * Bump NSIGFPE BUILD_BUG_ON() check for x86 compat.
> 
>    FPE_FLTUNK does not current have any implications for x86, since it
>    is not currently used and has no implications for the way siginfo
>    is populated.
> ---
>  arch/x86/kernel/signal_compat.c    | 2 +-
>  include/uapi/asm-generic/siginfo.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index ac057f9..954ad99 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -26,7 +26,7 @@ static inline void signal_compat_build_tests(void)
>  	 * new fields are handled in copy_siginfo_to_user32()!
>  	 */
>  	BUILD_BUG_ON(NSIGILL  != 11);
> -	BUILD_BUG_ON(NSIGFPE  != 13);
> +	BUILD_BUG_ON(NSIGFPE  != 14);
>  	BUILD_BUG_ON(NSIGSEGV != 4);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 4);
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 85dc965..10304de 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -229,7 +229,8 @@ typedef struct siginfo {
>  # define __FPE_INVASC	12	/* invalid ASCII digit */
>  # define __FPE_INVDEC	13	/* invalid decimal digit */
>  #endif
> -#define NSIGFPE		13
> +#define FPE_FLTUNK	14	/* undiagnosed floating-point exception */
> +#define NSIGFPE		14
>  
>  /*
>   * SIGSEGV si_codes
> -- 
> 2.1.4
> 
