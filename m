Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751116-1520411179-2-17030573536764535235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520411178; b=ff+uYDA5BMIRo34R75/WNQxrqjO9M88+Te5PEQtY0iYaOJ/
    PUjJB6LKCkOl+bu8kUUchvXrmxYKyc/1+xn/46K/EJNF3gFfKCatkFbHUmqaS7U7
    AG9T0S4wQ9Evs2HQO2QjdmAfdw10UT5tmwS7f9ptxrl+H3FWipoeHSQZ7ZAi7Rym
    L7+0GICUuN4q59bjXGrAdGa4pV3SWQxXCyVao1UXP54yfP8vVlxABKD/rSqV701a
    twPHm5ytW29n4y3DrK5i361zHI3jqqavwIDRChvhRui3JvGRnSn7tuDTZV7sFmZU
    VMS5bijv8nHoaK0dJbhe/CrSwHYNLZynFMRkUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520411178; bh=VYimZG9gL5gFuOOJ27DGLgfch+
    WRxbUXxLpB4+NKzcQ=; b=LzsIwnTT4Y1nHF1zQCaB0QHDQQAX3S7znoMyCemh5L
    FswvlxEvaShKw9UrgJeCLeg9CBIyOCRYcgs6LFqFZUtU0CzjyIAXfSCjod+qnwTv
    RMQS3knfL2FfpmYPLSK0NEseoFDYieGG25eId3/k9YOUYcKBM385WGZUat3cHf+Z
    mzu74mDEoWlfXqPuF/HlR44Iu87ecXN1RVSuhTm8LmRGlZ6iSpwL0znBPdVk2JjC
    ZSOlz1b+hwZTldyCy9KS/4vduyxWX0/oEpsyqBIQuwrWa6Em9wlGvsuwE7cSITY1
    AqMhqn5jltucEIsHgxYWAYNqiotKvyb7GcvKHa+J422g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oH+wpLGE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RkoNO3yP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oH+wpLGE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RkoNO3yP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeCGI0R (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:26:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33289 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeCGI0Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Mar 2018 03:26:16 -0500
X-Google-Smtp-Source: AG47ELtnhWAhV8C1Y1qXYjXoG0YH+6vFDTOnBrDnDOJpeE+7wJsHjd5CFUOAIqRNHA4eQ7SlkiDBdQ==
Date: Wed, 7 Mar 2018 09:26:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, luto@amacapital.net,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, ak@linux.intel.com,
        x86@kernel.org
Subject: Re: [PATCH] kernel/sys_ni: sort cond_syscall() entries
Message-ID: <20180307082612.tveaovxhhtvyu5dj@gmail.com>
References: <20180306185301.GA31061@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306185301.GA31061@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Shuffle the cond_syscall() entries in kernel/sys_ni.c around so that they
> are kept in the same order as in include/uapi/asm-generic/unistd.h. For
> better structuring, add the same comments as in that file, but keep a few
> additional comments and extend the commentary where it seems useful.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index b5189762d275..44c65e4d2528 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -17,245 +17,403 @@ asmlinkage long sys_ni_syscall(void)
>  	return -ENOSYS;
>  }
>  
> -cond_syscall(sys_quotactl);
> -cond_syscall(sys32_quotactl);
> -cond_syscall(sys_acct);
> +/*
> + * This list is kept in the same order as include/uapi/asm-generic/unistd.h.
> + * Architecture specific entries go below, then follow deprecated or obsolote
> + * system calls.

That's both a typo and wrong: 'follow' in this context means the exact opposite 
ordering.

I think this is more accurate:

    * Architecture specific entries go below, followed by deprecated or obsolete
    * system calls.

Thanks,

	Ingo
