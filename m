Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756922AbeBPAxd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:53:33 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46777 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756908AbeBPAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:53:31 -0500
X-Google-Smtp-Source: AH8x227nfUZrgcdljOo5mwoh22zWTOnzvOa7pqook1uB2WhOA/3Z4GgJbWU4OfmYpTI/XiBGB4dIB7A58Wrrbs4begA=
MIME-Version: 1.0
In-Reply-To: <20180214081935.GA17157@avx2>
References: <20180214063033.GA15579@avx2> <20180214081935.GA17157@avx2>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Feb 2018 16:53:29 -0800
X-Google-Sender-Auth: bvVcvoLnUwSzwGxIyCKbfCIGJnw
Message-ID: <CAGXu5jKv5EehXn7tNc9n=Zd_tT5AcNeQm5_rT81m6OAWXXpMYQ@mail.gmail.com>
Subject: Re: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:19 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> The more the merrier.

What made you choose this structure, BTW?

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  fs/proc/internal.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -177,7 +177,7 @@ struct pde_opener {
>         struct list_head lh;
>         bool closing;
>         struct completion *c;
> -};
> +} __randomize_layout;
>  extern const struct inode_operations proc_link_inode_operations;
>
>  extern const struct inode_operations proc_pid_link_inode_operations;

-Kees

-- 
Kees Cook
Pixel Security
