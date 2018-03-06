Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1230003-1520366582-2-17028561608437271812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520366581; b=QCvWy+ekc8+wJH5thDIBDX21qtRvlH1IaTJBOeD2eaqA3aQ
    VS365B9VrAfI7Htp1J4lVeHE6AXfP5Gj3cMMSxhvce5yJcIzx7RM9gpgpWisHOUY
    gK7v6R2bHMedGefxZfZ3cajIEQSpemH8PlwC0nJQx+mhm2hwJeErNy6qldMJq50U
    d9tpp/1cCnZiJGhKs9zSodUchhOyOHPlEwk2rzdvZhulkeSS6PlB/Dvga+hUGUMy
    3QbGyas2GejPLWrVLEMkRSaxGEW43EIHR4JGok3cg/ybBVSKzigUYm8UMMIZa50g
    gcPvlopYepUu+ea9KkqB0DGUG1IyX4eAwAuKHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520366581; bh=oR4KTKI2uqUwYY3PwkYgfYCEE29t/4QtNU+IJTRNN04=; b=L
    CMHhGonHOCbQixRdLZ7mFzxqfAGI+oBhfBdpwNW+i+Mr6FYVqlwPLyqlD0uN/O0G
    F68ePZqRn11tGBaYtGmESYADiMZqy2NndwKK9aqoqjTpk4BChJOqn1IyBnai676D
    OAFqBwyB8SjdWh/Sr4RrocULAXYMUcH/FiWEJbt/+cmcHMpwT2o+R/teueNu5lfb
    ahfRqEdZuYA8bZOowgTWZJAGiOZ/HhirZ9LK3csXNTYcexcarFqMkBw8LL3u5RM2
    nuNIi79EJT2S5ifgtBB1hFTDfZ645dEwjSgBKMZuVcKyya+q8S/+DjK05xzY5FyT
    N/DILtyB65K/6yO2zLpDw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NpXlGm3V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NpXlGm3V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeCFUC6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 15:02:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeCFUC5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 15:02:57 -0500
Subject: Re: [PATCH] kernel/sys_ni: sort cond_syscall() entries
To: Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: torvalds@linux-foundation.org, luto@amacapital.net,
        mingo@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        ak@linux.intel.com, x86@kernel.org
References: <20180306185301.GA31061@light.dominikbrodowski.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3d7b7278-e849-2673-564e-10a65774ee58@infradead.org>
Date: Tue, 6 Mar 2018 12:02:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306185301.GA31061@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/06/2018 10:53 AM, Dominik Brodowski wrote:

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

                                                                        obsolete

> + * system calls.
> + */

> 


-- 
~Randy
