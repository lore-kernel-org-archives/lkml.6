Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbeCPChb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:37:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33443 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeCPCh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:37:29 -0400
X-Google-Smtp-Source: AG47ELu/x/iwNFgkRGBvZV9o4mawRWzeuZ1Lv8GtXoSI1ik/UdztneKAANdg3Ig/IglFeLPXx5PpZg==
Date: Thu, 15 Mar 2018 22:37:27 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] kbuild: clear LDFLAGS in the top Makefile
In-Reply-To: <1521166725-24157-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1803152237070.28583@knanqh.ubzr>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com> <1521166725-24157-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Masahiro Yamada wrote:

> Currently LDFLAGS is not cleared, so same flags are accumulated in
> LDFLAGS when the top Makefile is recursively invoked.
> 
> I found unneeded rebuild for ARCH=arm64 when CONFIG_TRIM_UNUSED_KSYMS
> is enabled.  If include/generated/autoksyms.h is updated, the top
> Makefile is recursively invoked, then arch/arm64/Makefile adds one
> more '-maarch64linux'.  Due to the command line change, modules are
> rebuilt needlessly.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> 
> Changes in v2: None
> 
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index d9bb6dd6..ac8755d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -437,6 +437,7 @@ KBUILD_CFLAGS_KERNEL :=
>  KBUILD_AFLAGS_MODULE  := -DMODULE
>  KBUILD_CFLAGS_MODULE  := -DMODULE
>  KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
> +LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>  
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
> -- 
> 2.7.4
> 
> 
