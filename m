Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-108815-1520459316-2-12550519381746607711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520459316; b=nbWbRel+hy2rfm1deH06+z5IEQ8PDyfEi+ZEz2NadiJl17x
    Rsmx+PIz+BicTaUvql6wsJjXp11eIYV7AjPetPI6l5Ot8SjWpz35qq4ddAoa1BW2
    qf2kcyvTBnBVLn8eCbR14U0z2iAqUJ+vc2dEW/9Lv7bQefxuaKbdntbz8mJnRS/5
    wU5d6kNxsHOWOnYd4TeNYdF5nirHe5hW4jdbE+W0amL4NOiZaIJSNP/ia7fkjG8J
    MkTb5M4SX8+niqueLtmE1ctBtLyHMBOjmYk7h7tPQ5ANwepms7gbYvywbjEKPiaA
    cKNyc04Up8vxgV05+haLabwGCvSpDng5pgn7Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520459316; bh=CYhyqNJqpkCg/+y9HKfpmy6b8a
    0heO16vxDUe/rIBx8=; b=s6XGhPe5qB1WXOkWeZQ7UiBDe4dmwDsgEZBBAIZHSk
    521acrpp2MwgPHTzmdCLjgWFVrCMlgNzz062jw2OFxcuFZBNoB3yCSUQALNam/Ij
    +ed/BIEEthz0JTG/Uwa99g/PpbPgV8gXsCdY1cY4cZ+5pj9lN0/y2rQRnYBHRiKr
    kq0DuO3PQ3/uNGrkhCF70CfMhC4yCln0tGjKZ8eqrR5xN5ImqmOks3uB0gKgYRFZ
    4cgBFydfkzUr2N3HU2r0vo0yCrB+V8wMXRD79DuLiH+goJ+cbgmLkMzhRt0pfm69
    FZw8lLqxDDSnAL1aJWHWoKfLY7RdcVZiTPydn4q8farw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DoR3yrFx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W4cZjs4b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DoR3yrFx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W4cZjs4b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933706AbeCGVse (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 16:48:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33804 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933674AbeCGVse (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 16:48:34 -0500
X-Google-Smtp-Source: AG47ELvUtY2PuGyA9bEjbr/6c/VhYUtLueApPMESIbUv9mObt0UYddJ7lv88WYWICvd0uVpOGNsBsA==
Date: Wed, 7 Mar 2018 14:48:29 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Paul Lawrence <paullawrence@google.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: android: ashmem: Remove deadlock
Message-ID: <20180307214829.GA15587@flashbox>
References: <20180307214042.135109-1-paullawrence@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307214042.135109-1-paullawrence@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 01:40:30PM -0800, Paul Lawrence wrote:
> Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652
> ("staging: android: ashmem: Fix a race condition in pin ioctls")
> causing deadlock.
> 
> No need to hold ashmem_mutex while copying from user
> 
> Stacks are:
> 
> ashmem_mmap+0x53/0x400 drivers/staging/android/ashmem.c:379
> mmap_region+0x7dd/0xfd0 mm/mmap.c:1694
> do_mmap+0x57b/0xbe0 mm/mmap.c:1473
> 
> and
> 
> lock_acquire+0x12e/0x410 kernel/locking/lockdep.c:3756
> __might_fault+0x14a/0x1d0 mm/memory.c:4014
> copy_from_user arch/x86/include/asm/uaccess.h:705 [inline]
> ashmem_pin_unpin drivers/staging/android/ashmem.c:719 [inline]
> 
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> Cc: <stable@vger.kernel.org> # 4.9.x
> Cc: <stable@vger.kernel.org> # 4.4.x
> Cc: <stable@vger.kernel.org> # 3.18.x: ce8a3a9e76d01
> Cc: <stable@vger.kernel.org> # 3.18.x
> Cc: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/staging/android/ashmem.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 6dbba5aff191..8c55706c2cfa 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
>  	size_t pgstart, pgend;
>  	int ret = -EINVAL;
>  
> +	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
> +		return -EFAULT;
> +
>  	mutex_lock(&ashmem_mutex);
>  
>  	if (unlikely(!asma->file))
>  		goto out_unlock;
>  
> -	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
> -		ret = -EFAULT;
> -		goto out_unlock;
> -	}
> -
>  	/* per custom, you can pass zero for len to mean "everything onward" */
>  	if (!pin.len)
>  		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
> -- 
> 2.16.2.395.g2e18187dfd-goog
>

Hey Paul,

Looks like this same patch is already in Greg's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=740a5759bf222332fbb5eda42f89aa25ba38f9b2

Cheers!
Nathan Chancellor
