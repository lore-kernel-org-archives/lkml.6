Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeEPGCY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:02:24 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:47648 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeEPGCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:02:23 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4G62JsN023268
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: AB8JxZq7PiPZTW/0pnPyD5thDWQNj1uORadLBBatwd18eGvF3seVfPBMeOfXTbGaLZc8YB5rvKcWV1kFX0yupo4VICg=
MIME-Version: 1.0
In-Reply-To: <20180515155038.7387bf2c@canb.auug.org.au>
References: <20180515155038.7387bf2c@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 16 May 2018 15:01:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNMZbz=re1sRzh8Ffkt8g78=ddV7d_TZm4MVq1+JS-hA@mail.gmail.com>
Message-ID: <CAK7LNASNMZbz=re1sRzh8Ffkt8g78=ddV7d_TZm4MVq1+JS-hA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,


2018-05-15 14:50 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> modules_install) failed like this:
>
> Usage: scripts/depmod.sh /sbin/depmod <kernelrelease> <symbolprefix>
> Makefile:1314: recipe for target '_modinst_post' failed
>
> Caused by commit
>
>   ea7ad9856a2c ("depmod.sh: remove symbol prefix support")
>
> I added the following fix for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 May 2018 15:47:33 +1000
> Subject: [PATCH] depmod.sh: fix syntax check and uage message
>
> fixes: ea7ad9856a2c ("depmod.sh: remove symbol prefix support")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---


Thanks for catching this.

How should I handle your fix-up?

May I squash into the original one if you ack to do it,
or is it better to keep it as a separate patch?




>  scripts/depmod.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 421d1aa01304..1a6f85e0e6e1 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -3,8 +3,8 @@
>  #
>  # A depmod wrapper used by the toplevel Makefile
>
> -if test $# -ne 3; then
> -       echo "Usage: $0 /sbin/depmod <kernelrelease> <symbolprefix>" >&2
> +if test $# -ne 2; then
> +       echo "Usage: $0 /sbin/depmod <kernelrelease>" >&2
>         exit 1
>  fi
>  DEPMOD=$1
> --
> 2.17.0
>
> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
