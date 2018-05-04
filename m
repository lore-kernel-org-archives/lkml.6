Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeEDEeg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 00:34:36 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37822 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEDEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 00:34:35 -0400
X-Google-Smtp-Source: AB8JxZry4n1q7mM8jk8ltoMEDrgjIFHAhBrL9g0PKCNvHoyLczteybqewVDE4r3kEGWjyvVjRNK4f2dp3POWrwyGnrU=
MIME-Version: 1.0
In-Reply-To: <20180504011345.63937-1-andriy.shevchenko@linux.intel.com>
References: <20180504011345.63937-1-andriy.shevchenko@linux.intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 3 May 2018 21:34:33 -0700
X-Google-Sender-Auth: mUwUElSp7cDLuSiLx9l-MJbqWME
Message-ID: <CAGXu5j+p=ngqY_3oqMn83YMjjomKeQSs3Akk7+YfY5sPmcxw+g@mail.gmail.com>
Subject: Re: [PATCH v1] lib/string_helpers: Add missed declaration of struct task_struct
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 6:13 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Starting from the commit 0d0443288f22 the new function has been
> introduced which takes struct task_struct as a parameter. Though,
> compiler doesn't know where to get information about it at this stage.
>
> Add missed declaration of struct task_struct to satisfy compiler.
>
> Fixes: 0d0443288f22 ("string_helpers: add kstrdup_quotable_cmdline")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: James Morris <james.l.morris@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Kees Cook <keescook@chromium.org>

I'm not sure who should carry this. You're welcome to put it in your tree?

-Kees

> ---
>  include/linux/string_helpers.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 4397c52ec4a4..d23c5030901a 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>
>  struct file;
> +struct task_struct;
>
>  /* Descriptions of the types of units to
>   * print in */
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
