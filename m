Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10409C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1C321871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Ifof17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfADC6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:58:42 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33163 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfADC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:58:42 -0500
Received: by mail-yw1-f65.google.com with SMTP id p65so12904611ywe.0;
        Thu, 03 Jan 2019 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnZyZxInsEGzw3p+CHzSj/KoRA1xvwNXjnGuZgXYi7w=;
        b=L4Ifof17nm6xvC3XORaZeQ1faFZUC8b2yS4lCzUyfN/2LV/Ob0Ig2f6da1cVmbaGOb
         aygrZpYqYCaxIFG2Dc1yMnz09BFnMk9ISS5sd1M7Zl2x5/XLnKDVfuEjXaxCUAA+Gc75
         TjR5VCCbkf8TyKmEaVZsA/Ajweu8nwALF/AjjjOOmlPVwm/wU6HrXVslwP8efInc3RpX
         7uZCHZ1J3dYk9/2DswIf3Ed55wdDgmpJPr3PGDqMg24l1psgL03cTgWozodg60wWt72e
         3znvkJahNhVH5xEdcjbBFR09/EyoMkbZjIDWY6knd1/2n6NOfmsnOCJjEZraoOOG06Ao
         9Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnZyZxInsEGzw3p+CHzSj/KoRA1xvwNXjnGuZgXYi7w=;
        b=Lj3ApC0q6xVtza/Z7WW3ufY+yxDaooz6Sx+N4MY4vzYUYOQQ/os5uNYgfwM/QF/NMO
         iNDDmvVy2hj9ce5QgK/9f92pLTIMy38laqxkIPDX/AY04DIe5aUdZLgVIWxu0DpgjeK7
         IewH/Wb9QOaqgJXMTj8LivtWuTedxZoaY64i/wpAl1i/Zns2rmq9tM3TXBpsKmyrP7EB
         52Q7+M8zkbbBrDw+aIu+q5VwbumYIj8w6ShECjxStcpb/k8Ejqqc8mHMaaZRw54DOFyA
         46FlQhVqKoDxyoj1Y2td6P0c9+8VAD00W/c0cEdU1Z5ME/+HyNnIAH8YWTvb7LL4PQVG
         wAiQ==
X-Gm-Message-State: AA+aEWajc4jmlkBm3h4Q6MSK3e1GvlYoZCHQpGI9eYuJ8NAvXgg+TWSa
        Sv8D3bkqIcBDz/u4eZNeNFUZxRZ7nMgHD3ob/jU=
X-Google-Smtp-Source: AFSGD/Vjt3da+whuxko6oezo2HlJlcblHdgng+bblVqF3B4AK6yrO1RTKMr4i5GEuGKBpriGlX91Q2rRrk79PDyLwxo=
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr50777073ywe.496.1546570721432;
 Thu, 03 Jan 2019 18:58:41 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org> <1546442912-20818-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442912-20818-2-git-send-email-firoz.khan@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Jan 2019 18:58:30 -0800
Message-ID: <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the
> system call.
>
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will
> unifies the implementation with some other architetures
> too.

Perhaps "This will help unify the implementation with other architectures"?

> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/xtensa/kernel/syscall.c              | 2 +-
>  arch/xtensa/kernel/syscalls/syscalltbl.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
> index 2c415fc..0665339 100644
> --- a/arch/xtensa/kernel/syscall.c
> +++ b/arch/xtensa/kernel/syscall.c
> @@ -31,7 +31,7 @@
>  syscall_t sys_call_table[__NR_syscalls] /* FIXME __cacheline_aligned */= {
>         [0 ... __NR_syscalls - 1] = (syscall_t)&sys_ni_syscall,
>
> -#define __SYSCALL(nr, entry, nargs)[nr] = (syscall_t)entry,
> +#define __SYSCALL(nr, entry)[nr] = (syscall_t)entry,
>  #include <asm/syscall_table.h>
>  #undef __SYSCALL
>  };
> diff --git a/arch/xtensa/kernel/syscalls/syscalltbl.sh b/arch/xtensa/kernel/syscalls/syscalltbl.sh
> index 85d78d9..904b8e6 100644
> --- a/arch/xtensa/kernel/syscalls/syscalltbl.sh
> +++ b/arch/xtensa/kernel/syscalls/syscalltbl.sh
> @@ -13,10 +13,10 @@ emit() {
>         t_entry="$3"
>
>         while [ $t_nxt -lt $t_nr ]; do
> -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"

Please add space after the comma.

>                 t_nxt=$((t_nxt+1))
>         done
> -       printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
> +       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"

Ditto.

>  }
>
>  grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> --
> 1.9.1

With the above changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
