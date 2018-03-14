Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeCNScl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:32:41 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44616 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeCNScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:36 -0400
X-Google-Smtp-Source: AG47ELt6/zftP1gQ8frVkKhQpPTtYBc0crMppPCDAI0bgkVwwabpIASuli5ABdHJm3+yRzv4p0akDA==
Date: Wed, 14 Mar 2018 14:32:33 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] kbuild: hide CONFIG_TRIM_UNUSED_KSYMS code from
 external module building
In-Reply-To: <1521045861-22418-6-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1803141419550.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com> <1521045861-22418-6-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Masahiro Yamada wrote:

> If CONFIG_TRIM_UNUSED_KYMS is enabled, KBUILD_MODULES is set.  

Not when you do "make vmlinux" though.

> This code is unneeded for external module building because 
> KBUILD_MODULES is always set.  Move this code inside "ifeq 
> ($(KBUILD_EXTMOD),)" conditional.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> 
>  Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index decc870..e60b16f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -603,13 +603,6 @@ else
>  include/config/auto.conf: ;
>  endif # $(dot-config)
>  
> -# For the kernel to actually contain only the needed exported symbols,
> -# we have to build modules as well to determine what those symbols are.
> -# (this can be evaluated only once include/config/auto.conf has been included)
> -ifdef CONFIG_TRIM_UNUSED_KSYMS
> -  KBUILD_MODULES := 1
> -endif
> -
>  # The all: target is the default when no target is given on the
>  # command line.
>  # This allow a user to issue only 'make' to build a kernel including modules
> @@ -1010,6 +1003,13 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
>  	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
>  endif
>  
> +# For the kernel to actually contain only the needed exported symbols,
> A+# we have to build modules as well to determine what those symbols 
are.
> +# (this can be evaluated only once include/config/auto.conf has been included)
> +ifdef CONFIG_TRIM_UNUSED_KSYMS
> +  KBUILD_MODULES := 1
> +endif
> +
>  autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
>  
>  $(autoksyms_h):
> -- 
> 2.7.4
> 
> 
