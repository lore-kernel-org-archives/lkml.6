Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1551978-1522893198-2-3809336757648300514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522893197; b=V6QNlsPkI6u4qhoppba2f+IdqfBVLdBZ9wyTtXPGidTQrzSep/
    7LMzBI/rvXtGkZql9A8jKDJD8uBibPQz9iG3oiRh2NseIWy1I7AYnJRpDHiPWy/u
    070mHq3/RzqZKf5u+s8PsgHiDAsrZLNxVoaevBi9Viho/SEtU9cQakWs6hiikPpm
    bW2KFoG1xZLA7uh8vODRBsJqWzTyfanJfADXibtyVvI6EuQ58/4zJEuEssxb5qYz
    kYgwg0wm1tD7oQbLQIdlUDHLTp6MSb5ebo2qPlYqhmUGK1gjjDXeF28opSKRY4Hw
    +tIhgAQw7n+JPtMtS9IWAJE13zKuY5l/g3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522893197; bh=R5lPxYN3uiqmed0+uG//QmouQDGONZ
    2KqTTZ9U/RiFk=; b=gfnwO0olhqcibCUPKYha+b8+729xJ1mLzGQ5vPmNw15vuJ
    Gijnag0z3nU5MbSOupuigLl0LT95oWBne5QN1slPhhRtDVt4+a6PQr3PQps6n9xG
    dRmBOx5nqcp5wEQjgLxFgQMhxJ16kGh9tqfSbtnfqocuYVAw3ViFhF4WB+KxMYDn
    RNaYT5YRLsWUhprcyXfOCEpzmLaLlcl+L9MGFzY6LGkTHKAgBL6KgxTiVVIXywEG
    DQK8ETTDOwYuiGCD72OhOf/NeYhP5u86BuHKgEzwSVMcO+KRB4T216rTRZ9n7Q+e
    c4pZbwPLqupf41iezTzLv6mTOvj3bEqhERbh+IzQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM2BcQRm5gum0DSyeNcSV3gNOgnYzFOB+tTUvvlGZnGZXz1ixzAls0XwM0FhDiBTUO64l3a5pmxoqO9j4tu+JcPHa8S+dwyHtvN3xBck+dVGfVX994M5
    tmI9m3k8LEn0jz6+pvKhTAi313YdV0eSG2sYsKmStU95FCeMGJysHUut1Upmxc630WoHwYMaaVhFg2KRg/g72bT0Wi3r1V3ogoSfBVRBkB+g42I+7qbfClKQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=07d9gI8wAAAA:8 a=JfrnYn6hAAAA:8
    a=lAgNKBcoAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8
    a=VaCiqS1i1BvNcJAF4TAA:9 a=HE5xhckoLaZSiVvS:21 a=l1iBJj3XOFhG2CHn:21
    a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=drE6d5tx1tjNRBs8zHOc:22 a=AjGcO6oz07-iQ99wixmX:22
    a=cQPPKAXgyycSBL8etih5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeDEBxP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:53:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752642AbeDEBxO (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 21:53:14 -0400
Date: Thu, 5 Apr 2018 04:53:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
Message-ID: <20180405045231-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522431382-4232-1-git-send-email-mst@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 08:37:45PM +0300, Michael S. Tsirkin wrote:
> get_user_pages_fast is supposed to be a faster drop-in equivalent of
> get_user_pages. As such, callers expect it to return a negative return
> code when passed an invalid address, and never expect it to
> return 0 when passed a positive number of pages, since
> its documentation says:
> 
>  * Returns number of pages pinned. This may be fewer than the number
>  * requested. If nr_pages is 0 or negative, returns 0. If no pages
>  * were pinned, returns -errno.
> 
> Unfortunately this is not what the implementation does: it returns 0 if
> passed a kernel address, confusing callers: for example, the following
> is pretty common but does not appear to do the right thing with a kernel
> address:
> 
>         ret = get_user_pages_fast(addr, 1, writeable, &page);
>         if (ret < 0)
>                 return ret;
> 
> Change get_user_pages_fast to return -EFAULT when supplied a
> kernel address to make it match expectations.
> 
> __get_user_pages_fast does not seem to be used like this, but let's
> change __get_user_pages_fast as well for consistency and to match
> documentation.
> 
> Lightly tested.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: stable@vger.kernel.org
> Fixes: 5b65c4677a57 ("mm, x86/mm: Fix performance regression in get_user_pages_fast()")
> Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Any feedback on this? As this fixes a bug in vhost, I'll merge
through the vhost tree unless someone objects.

> ---
>  mm/gup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 6afae32..5642521 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1749,6 +1749,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long flags;
>  	int nr = 0;
>  
> +	if (nr_pages <= 0)
> +		return 0;
> +
>  	start &= PAGE_MASK;
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> @@ -1756,7 +1759,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  
>  	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
>  					(void __user *)start, len)))
> -		return 0;
> +		return -EFAULT;
>  
>  	/*
>  	 * Disable interrupts.  We use the nested form as we can already have
> @@ -1806,9 +1809,12 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;
>  
> +	if (nr_pages <= 0)
> +		return 0;
> +
>  	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
>  					(void __user *)start, len)))
> -		return 0;
> +		return -EFAULT;
>  
>  	if (gup_fast_permitted(start, nr_pages, write)) {
>  		local_irq_disable();
> -- 
> MST
