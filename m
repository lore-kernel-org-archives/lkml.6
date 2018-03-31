Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeCaIgh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:36:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34148 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeCaIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:36:36 -0400
X-Google-Smtp-Source: AIpwx4/TLaktYokoqaFknhiFbHTYUH+2nREdg0bIhK+Whk1easyc0JYB5KXisrpv49gKq8XDfbHHfA==
Date: Sat, 31 Mar 2018 10:36:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: trim headers
Message-ID: <20180331083632.zufg2gzgjsyemcsq@gmail.com>
References: <20180313193410.GA12260@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313193410.GA12260@avx2>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> kernel.h is not needed, but compiler.h is.
> 
> mutex.h is not needed only a forward declaration.
> 
> spinlock.h is not needed, spinlock_types.h is enough.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  include/linux/refcount.h |    7 ++++---
>  lib/refcount.c           |    2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -3,9 +3,10 @@
>  #define _LINUX_REFCOUNT_H
>  
>  #include <linux/atomic.h>
> -#include <linux/mutex.h>
> -#include <linux/spinlock.h>
> -#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/spinlock_types.h>
> +
> +struct mutex;
>  
>  /**
>   * struct refcount_t - variant of atomic_t specialized for reference counts
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -35,7 +35,9 @@
>   *
>   */
>  
> +#include <linux/mutex.h>
>  #include <linux/refcount.h>
> +#include <linux/spinlock.h>
>  #include <linux/bug.h>

Doesn't build on x86-64 defconfig...

Thanks,

	Ingo
