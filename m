Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418791-2-4942344871124515506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418791; b=I7rqlQkPjZu8TlNf13vq9nFiX5zcj11TYW7jo4JIqAKbfnE
    OMgdY/pF7huiPmNLq7alHRBa2b1KAkbw+vOoTwK36/HEuT/Mc7KAcKa6M8S9i1bT
    EvnwPW7nMXrALYSvhF2g0VsB2lwYjeQ35SlJHf6YDy+ESeavf5FnVS9um6+sjTRz
    nQ7aNnym4K7H4N7GyoHZC3tDzd33ixaYxd2M/yjxDj8xXJ4it1gm5IJREHFmbfGh
    b2ygCC5bqwJYJSmaGafiyFXdCUFZxYQHs/L5YDg8flDWKrlpf5B5pN7sUUThkjZg
    fx4PFCkRuVZfW/M6ITlPLmjs42XTUrwZaB5bUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519418791; bh=w6BD1VeOtsXMMhdGMVnV47YaRQ
    wnfr19RvFLqleseg4=; b=JsdgAndP+tWIfBSVVW2lPCFASDGDjojvLSrijhyg5T
    5Mly55yNgM+Bm3OiRtwMWJH1gUJpUNsOp2xsILaI7YpyTawNIDKepDEFaAindibi
    CCT/pVOgVHjdJsaEiiCj7VptPqBy9rIHys6X6f3IQkf7djSZzBqU3AfmYk5t42gt
    8LfFyOPzVYoFnxireRgUQZGOrj4uSH/sIfxH232c5K4w/IAqt39/8IUYYb1MbE7d
    zO+ZGs3qQ8MxFW87A49SgHpf5kpsrPB+1dWfOjwMJxgryn8ybbN85ybYC2sz5nfU
    NI+kPZ+fZHO8TU1/oY+QoONxPT4ozeQgmQrel5PsYjog==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=d+C1jbcS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GGZ2rWbb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=d+C1jbcS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GGZ2rWbb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeBWUqN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:46:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54531 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeBWUqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 15:46:11 -0500
X-Google-Smtp-Source: AG47ELviaOMlGhJDsfvNo6zMd5eqZw6ABaW7SLmjnOvqTWNuhqkAnDZbrPO7DRoelgWYcytNmX0dQA==
Date: Fri, 23 Feb 2018 13:46:08 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com,
        syzbot <syzkaller@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 4.4 013/193] staging: android: ion: Add __GFP_NOWARN for
 system contig heap
Message-ID: <20180223204608.GA6714@flashbox>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170328.219713270@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223170328.219713270@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:24:06PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Laura Abbott <labbott@redhat.com>
> 
> commit 0c75f10312a35b149b2cebb1832316b35c2337ca upstream.
> 
> syzbot reported a warning from Ion:
> 
>   WARNING: CPU: 1 PID: 3485 at mm/page_alloc.c:3926
> 
>   ...
>    __alloc_pages_nodemask+0x9fb/0xd80 mm/page_alloc.c:4252
>   alloc_pages_current+0xb6/0x1e0 mm/mempolicy.c:2036
>   alloc_pages include/linux/gfp.h:492 [inline]
>   ion_system_contig_heap_allocate+0x40/0x2c0
>   drivers/staging/android/ion/ion_system_heap.c:374
>   ion_buffer_create drivers/staging/android/ion/ion.c:93 [inline]
>   ion_alloc+0x2c1/0x9e0 drivers/staging/android/ion/ion.c:420
>   ion_ioctl+0x26d/0x380 drivers/staging/android/ion/ion-ioctl.c:84
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>   SYSC_ioctl fs/ioctl.c:701 [inline]
>   SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> 
> This is a warning about attempting to allocate order > MAX_ORDER. This
> is coming from a userspace Ion allocation request. Since userspace is
> free to request however much memory it wants (and the kernel is free to
> deny its allocation), silence the allocation attempt with __GFP_NOWARN
> in case it fails.
> 
> Reported-by: syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/staging/android/ion/ion_system_heap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -336,7 +336,7 @@ static int ion_system_contig_heap_alloca
>  	if (align > (PAGE_SIZE << order))
>  		return -EINVAL;
>  
> -	page = alloc_pages(low_order_gfp_flags, order);
> +	page = alloc_pages(low_order_gfp_flags | __GFP_NOWARN, order);
>  	if (!page)
>  		return -ENOMEM;
>  
> 
>

This commit is not necessary as __GFP_NOWARN is still in the global
low_order_gfp_flags since commit d2805d7fff5b ("staging: ion: remove
__GFP_NOWARN when use low order gfp flags") did not show up until 4.9.
This also applies to 3.18.

Thanks!
Nathan
