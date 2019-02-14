Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E3C21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLNuSdIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfBNTpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:45:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34815 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfBNTpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:45:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id a15so4362325qkc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QYZ2Bb0L/vinD9OMYr4/d7xZm3AtLR3vGv+RjH7D2ro=;
        b=aLNuSdIVy/OLYuugKEqrUHhzKIq56irPfjTjJvdLUOatY/wqjJCVsOuFEHgDcUmxqj
         aDWWei5g1CKn4cbc294wzeOFBAZnVnHOLmCwdyx/klhWcy0j3zaSnYHhZjhT7Fu1DaKr
         oAJCQJ4N5sBAPMkveiYzbRJtxMEyfShlL0rCSEvtDDSSXT19ONtSeFUpbKfeBgeZWHyV
         pf5Iti+GPv/HmWQmlP1z/69WHITGepOYuTizcX1qj5K/FgTRKC3kQ4mi56svX3AkilGL
         JWZCWDpA1MjBxzH3rigLo+YsJi6o+Z6PpJG7r+BXKIEvMnPfOXnut6ZIrXUaHQhk5+nO
         weVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QYZ2Bb0L/vinD9OMYr4/d7xZm3AtLR3vGv+RjH7D2ro=;
        b=Na0Ru6Q6hOarqHsSVFDKYUfh55FyXGKIQpVpAA3BrbohhKkM1Erjghel2ZBLB5fzx0
         1NJ6Ep5yN3w9PrUnY1A/Ow/VWdRsHuGShmo6bYKb+0hAjD5ykp4WxF+2wgKM4Fnm3/58
         4la9XIQPu8HBd3lz1qDwvYDTV9+b4ndcfMmUhNZb1Sc4CAnHyqQAKaqLRJWJTES3wV7T
         pqNHxqgRGCVjqBcH+e+0wWj1OjbeEmFqesax/01B3ncU8yMsiKOsI5oO46803QEMDAPW
         lNNdPVTHZhYEGdlWDrvFf0ZGE5thJ2HkYN56Ztcnzu/lg7GYo5n4oHDpXx0SQWV1Zv8B
         438A==
X-Gm-Message-State: AHQUAubA0FyyqaUrNouOMxj3UmyXOzgIZIhEjzZ/9RVNf0eFmSaDvKd6
        t/Kz5NYyMYccg4tr9l3OMbItGQ==
X-Google-Smtp-Source: AHgI3Iaenueob/ySXAtqTMYRrl5JMf70JGFTxShUveLFpAiDRYsEPxr2FAy1apN9PhO778Wq1Z2p9Q==
X-Received: by 2002:a37:d649:: with SMTP id t70mr4299954qki.44.1550173541476;
        Thu, 14 Feb 2019 11:45:41 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d67sm1733801qkf.76.2019.02.14.11.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:45:41 -0800 (PST)
Date:   Thu, 14 Feb 2019 14:45:40 -0500
From:   Joel Fernandes <joelaf@google.com>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/7] binder: create userspace-to-binder-buffer copy
 function
Message-ID: <20190214194540.GA185075@google.com>
References: <20190208183520.30886-1-tkjos@google.com>
 <20190208183520.30886-2-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208183520.30886-2-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todd,

One quick question:

On Fri, Feb 08, 2019 at 10:35:14AM -0800, Todd Kjos wrote:
> The binder driver uses a vm_area to map the per-process
> binder buffer space. For 32-bit android devices, this is
> now taking too much vmalloc space. This patch removes
> the use of vm_area when copying the transaction data
> from the sender to the buffer space. Instead of using
> copy_from_user() for multi-page copies, it now uses
> binder_alloc_copy_user_to_buffer() which uses kmap()
> and kunmap() to map each page, and uses copy_from_user()
> for copying to that page.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
> v2: remove casts as suggested by Dan Carpenter
> 
>  drivers/android/binder.c       |  29 +++++++--
>  drivers/android/binder_alloc.c | 113 +++++++++++++++++++++++++++++++++
>  drivers/android/binder_alloc.h |   8 +++
>  3 files changed, 143 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 5f6ef5e63b91e..ab0b3eec363bc 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3078,8 +3078,12 @@ static void binder_transaction(struct binder_proc *proc,
>  				      ALIGN(tr->data_size, sizeof(void *)));
>  	offp = off_start;
>  
> -	if (copy_from_user(t->buffer->data, (const void __user *)(uintptr_t)
> -			   tr->data.ptr.buffer, tr->data_size)) {
> +	if (binder_alloc_copy_user_to_buffer(
> +				&target_proc->alloc,
> +				t->buffer, 0,
> +				(const void __user *)
> +					(uintptr_t)tr->data.ptr.buffer,
> +				tr->data_size)) {
>  		binder_user_error("%d:%d got transaction with invalid data ptr\n",
>  				proc->pid, thread->pid);
>  		return_error = BR_FAILED_REPLY;
> @@ -3087,8 +3091,13 @@ static void binder_transaction(struct binder_proc *proc,
>  		return_error_line = __LINE__;
>  		goto err_copy_data_failed;
>  	}
> -	if (copy_from_user(offp, (const void __user *)(uintptr_t)
> -			   tr->data.ptr.offsets, tr->offsets_size)) {
> +	if (binder_alloc_copy_user_to_buffer(
> +				&target_proc->alloc,
> +				t->buffer,
> +				ALIGN(tr->data_size, sizeof(void *)),
> +				(const void __user *)
> +					(uintptr_t)tr->data.ptr.offsets,
> +				tr->offsets_size)) {
>  		binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
>  				proc->pid, thread->pid);
>  		return_error = BR_FAILED_REPLY;
> @@ -3217,6 +3226,8 @@ static void binder_transaction(struct binder_proc *proc,
>  			struct binder_buffer_object *bp =
>  				to_binder_buffer_object(hdr);
>  			size_t buf_left = sg_buf_end - sg_bufp;
> +			binder_size_t sg_buf_offset = (uintptr_t)sg_bufp -
> +				(uintptr_t)t->buffer->data;
>  
>  			if (bp->length > buf_left) {
>  				binder_user_error("%d:%d got transaction with too large buffer\n",
> @@ -3226,9 +3237,13 @@ static void binder_transaction(struct binder_proc *proc,
>  				return_error_line = __LINE__;
>  				goto err_bad_offset;
>  			}
> -			if (copy_from_user(sg_bufp,
> -					   (const void __user *)(uintptr_t)
> -					   bp->buffer, bp->length)) {
> +			if (binder_alloc_copy_user_to_buffer(
> +						&target_proc->alloc,
> +						t->buffer,
> +						sg_buf_offset,
> +						(const void __user *)
> +							(uintptr_t)bp->buffer,
> +						bp->length)) {
>  				binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
>  						  proc->pid, thread->pid);
>  				return_error_param = -EFAULT;
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 022cd80e80cc3..94c0d85c4e75b 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -29,6 +29,8 @@
>  #include <linux/list_lru.h>
>  #include <linux/ratelimit.h>
>  #include <asm/cacheflush.h>
> +#include <linux/uaccess.h>
> +#include <linux/highmem.h>
>  #include "binder_alloc.h"
>  #include "binder_trace.h"
>  
> @@ -1053,3 +1055,114 @@ int binder_alloc_shrinker_init(void)
>  	}
>  	return ret;
>  }
> +
> +/**
> + * check_buffer() - verify that buffer/offset is safe to access
> + * @alloc: binder_alloc for this proc
> + * @buffer: binder buffer to be accessed
> + * @offset: offset into @buffer data
> + * @bytes: bytes to access from offset
> + *
> + * Check that the @offset/@bytes are within the size of the given
> + * @buffer and that the buffer is currently active and not freeable.
> + * Offsets must also be multiples of sizeof(u32). The kernel is

In all callers of binder_alloc_copy_user_to_buffer, the alignment of offsets
is set to sizeof(void *). Then shouldn't this function check for sizeof(void *)
alignment instead of u32?

thanks,

 - Joel
 
