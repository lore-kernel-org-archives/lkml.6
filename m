Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDMOXX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:23:23 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:58114 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeDMOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:23:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3DEN0YE003068
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AIpwx49b4pNMSEL8OwqgEdWwtji3vT5BxTwhhbuKVPZyASJ5Rv/tTXMdFZn+/L4I6m3aNFd0iqDIueEyiJcgmCqLnm0=
MIME-Version: 1.0
In-Reply-To: <20180411181525.23902-1-javierm@redhat.com>
References: <20180411181525.23902-1-javierm@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 13 Apr 2018 23:22:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROirdNKSFD-X9vBr5nJ4Ys7rn4H-0UF8+p6CR8PqqkfA@mail.gmail.com>
Message-ID: <CAK7LNAROirdNKSFD-X9vBr5nJ4Ys7rn4H-0UF8+p6CR8PqqkfA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: use kernel-install as a fallback for new-kernel-pkg
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-12 3:15 GMT+09:00 Javier Martinez Canillas <javierm@redhat.com>:
> The new-kernel-pkg script is only present when grubby is installed, but it
> may not always be the case. So if the script isn't present, attempt to use
> the kernel-install script as a fallback instead.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> ---
>

Applied to linux-kbuild.  Thanks!


>  scripts/package/mkspec | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 61427c6f2209..e05646dc24dc 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -118,6 +118,8 @@ $S$M        ln -sf /usr/src/kernels/$KERNELRELEASE source
>         %preun
>         if [ -x /sbin/new-kernel-pkg ]; then
>         new-kernel-pkg --remove $KERNELRELEASE --rminitrd --initrdfile=/boot/initramfs-$KERNELRELEASE.img
> +       elif [ -x /usr/bin/kernel-install ]; then
> +       kernel-install remove $KERNELRELEASE
>         fi
>
>         %postun
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
