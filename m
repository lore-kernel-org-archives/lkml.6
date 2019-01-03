Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028682073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfACKpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:45:30 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46639 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfACKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:45:29 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so10779962uap.13;
        Thu, 03 Jan 2019 02:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6b5bnPCnQXCsVXcWoxqB9zy7YX5yza5nymdDa8uLzg=;
        b=UDCDuxH5L1yWMBrNT4EAuvtO/rObLUxiWlEJb9imiLFjiAH8HcuwaQFjREH49QVf8a
         AJQtpe3N3fupwxZBidXbrwajOoshGlxMI+xrtt4jT24tdmKwhjslwzlU3xn3GNZyKTNR
         1zTWdGcqwuI1kKtmq2CPnZQl4sGGsdda5JXDhJdMvKICielGIDK8gGIPf7IKY+kvX4vK
         qGPc9VvJUNVFt/tbxnewkD75GoHzfWHjAEvX/68Dc8CmcFVpy1kkGt4NvdFvmleIwZSD
         dybTMaEAngOsTJUVoOPZOzf7Y/rWT1NrBfzcspJrsBuP0/Pwlg58UozSMqjYXfbe3uPF
         PHnQ==
X-Gm-Message-State: AJcUukfGn2bvYYrl8Jf/oxcitFmf78NktEspaDmUoYTXpu4tYogzU6up
        Xf8BZ76PzEHpRy384F0VKmT2zRZgayDY2vJmnjVBvjJ4
X-Google-Smtp-Source: ALg8bN5CZUyzxXxvFgW7HK19+ZDpO11uCTH6n8E2iwBXfLsR6Tvw/x/eFgNMZ/RPNDgJhLcPcKZXSySbCF5m5EGfj/4=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr18113701uap.0.1546512328415;
 Thu, 03 Jan 2019 02:45:28 -0800 (PST)
MIME-Version: 1.0
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org> <1546442319-20461-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442319-20461-2-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Jan 2019 11:45:17 +0100
Message-ID: <CAMuHMdXD5PpF0VswotPP=DQUZ6Rcx0jUq1Czo_WFdGAUrkddyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: remove nargs from __SYSCALL
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

Thanks for your patch!

On Wed, Jan 2, 2019 at 4:19 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the

name,

> system call.
>
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither

Argument nargs

> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will

implementation

> unifies the implementation with some other architetures

unify
architectures

> too.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/kernel/syscalls/syscalltbl.sh | 4 ++--
>  arch/m68k/kernel/syscalltable.S         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
> index 85d78d9..904b8e6 100644
> --- a/arch/m68k/kernel/syscalls/syscalltbl.sh
> +++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
> @@ -13,10 +13,10 @@ emit() {
>         t_entry="$3"
>
>         while [ $t_nxt -lt $t_nr ]; do
> -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"

Please keep the space after the comma.

>                 t_nxt=$((t_nxt+1))
>         done
> -       printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
> +       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"

Idem ditto.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
