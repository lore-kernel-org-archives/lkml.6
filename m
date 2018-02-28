Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeB1FPm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:15:42 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38132 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeB1FPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:15:40 -0500
X-Google-Smtp-Source: AG47ELvaTAxF+h2RR4bILNq3spPH9a2VZGjOP0D0us2HEd3qTf0B0JY6ZUu2ZE6bdGE8Ut4JkFVNng==
Date: Wed, 28 Feb 2018 06:15:25 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Marc Herbert <marc.herbert@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] kconfig: invoke oldconfig instead of
 silentoldconfig from local*config
Message-ID: <20180228051525.a2vouqs6djnd2cnf@huvuddator>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
 <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 09:15:25AM +0900, Masahiro Yamada wrote:
> The purpose of local{yes,mod}config is to arrange the .config file
> based on actually loaded modules.  It is unnecessary to update
> include/generated/autoconf.h and include/config/* stuff here.
> 
> They will be automatically updated during the build.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - newly added
> 
>  scripts/kconfig/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index c5d1d1a..bf9289a 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -49,11 +49,11 @@ localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf

(Unrelated: $(obj)/streamline_config.pl is a checked-in file, so I
wonder if there's any point to having it as a prerequisite of the phony
targets local{yes,mod}config.)

>  			cmp -s .tmp.config .config ||			\
>  			(mv -f .config .config.old.1;			\
>  			 mv -f .tmp.config .config;			\
> -			 $(obj)/conf $(silent) --silentoldconfig $(Kconfig); \
> +			 $(obj)/conf $(silent) --oldconfig $(Kconfig); \

Maybe add extra space to keep \ aligned.

>  			 mv -f .config.old.1 .config.old)		\
>  	else								\
>  			mv -f .tmp.config .config;			\
> -			$(obj)/conf $(silent) --silentoldconfig $(Kconfig); \
> +			$(obj)/conf $(silent) --oldconfig $(Kconfig); \

Ditto here.

>  	fi
>  	$(Q)rm -f .tmp.config
>  
> -- 
> 2.7.4
> 

I'm not an expert on the Makefiles, but seems reasonable to me.

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Cheers,
Ulf
