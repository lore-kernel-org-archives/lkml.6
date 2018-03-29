Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeC2FBt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:01:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38086 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeC2FBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:01:47 -0400
X-Google-Smtp-Source: AIpwx4+aI2BSb9BPpXK9Y3TvZlhxG8BRV9C5jZ//TbOBZUQ6RhduExuculs7elKjD3e8kcIYwvwGKA==
Date: Thu, 29 Mar 2018 14:01:44 +0900
From: Stafford Horne <shorne@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/8] openrisc: Set CONFIG_MULTI_IRQ_HANDLER
Message-ID: <20180329050144.GD2836@lianli.shorne-pla.net>
References: <20180327161911.14086-1-palmer@sifive.com>
 <20180327161911.14086-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327161911.14086-3-palmer@sifive.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 09:19:05AM -0700, Palmer Dabbelt wrote:
> arm has an optional MULTI_IRQ_HANDLER, which openrisc copied but didn't
> make optional.  I'm converting this to generic code, but in order to
> ensure everything stays bisectable I want this defined on openrisc for
> now.  This will go away by the end of the patch set.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Hi Palmer,
Thanks for doing this work, its always nice to see generic code pulled out of
architecture ports.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 339df7324e9c..9ecad05bfc73 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -27,6 +27,7 @@ config OPENRISC
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_SMP_IDLE_THREAD
>  	select MODULES_USE_ELF_RELA
> +	select MULTI_IRQ_HANDLER
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> @@ -68,6 +69,9 @@ config STACKTRACE_SUPPORT
>  config LOCKDEP_SUPPORT
>  	def_bool  y
>  
> +config MULTI_IRQ_HANDLER
> +	def_bool y
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> -- 
> 2.16.1
> 
