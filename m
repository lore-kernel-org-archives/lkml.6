Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeB0USd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:18:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeB0USc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:18:32 -0500
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
To: Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20180227194828.GA29918@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org>
Date: Tue, 27 Feb 2018 12:18:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227194828.GA29918@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 11:48 AM, Matthew Wilcox wrote:
> 
> Don't use __attribute__((indirect_branch)) if we're compiling with
> sparse.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index e2c7f4369eff..b6be4cc25e9d 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -93,7 +93,7 @@
>  #define __weak		__attribute__((weak))
>  #define __alias(symbol)	__attribute__((alias(#symbol)))
>  
> -#ifdef RETPOLINE
> +#if defined(RETPOLINE) && !defined(__CHECKER__)
>  #define __noretpoline __attribute__((indirect_branch("keep")))
>  #endif
>  
> 

I don't mind the patch, but I did send a patch for this attribute on Feb. 13, 2018,
to the sparse mailing list.

-- 
~Randy
