Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCNRlD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:41:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42532 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeCNRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:41:02 -0400
X-Google-Smtp-Source: AG47ELsERzJeUfSF+xIHN79tvss2JKReWI4to/lajM+STbvaPoCRChwDtVBdZdRU7eeRTjjrCidScQ==
Date: Wed, 14 Mar 2018 10:41:01 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Trung Tran <trung.tran@ettus.com>, Moritz Fischer <mdf@kernel.org>,
        Michael J Clark <mjc@sifive.com>
Subject: Re: [PATCH] RISC-V: Rename CONFIG_CMDLINE_OVERRIDE to
 CONFIG_CMDLINE_FORCE
Message-ID: <20180314174101.4aq4kz2coohijhtl@us-aus-ras-130-164-29-23.amer.corp.natinst.com>
References: <20180314164143.11898-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314164143.11898-1-palmer@sifive.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Mar 14, 2018 at 09:41:43AM -0700, Palmer Dabbelt wrote:
> The device tree code looks for CONFIG_CMDLINE_FORCE, but we were using
> CONFIG_CMDLINE_OVERRIDE.  It looks like this was just a hold over from
> before our device tree conversion -- in fact, we'd already removed the
> support for CONFIG_CMDLINE_OVERRIDE from our arch-specific code so it
> didn't even work any more.
> 
> Thanks to Mortiz and Trung for finding the original bug, and for Michael

Nit: s/Mortiz/Moritz/g ;-)
> for suggeting a better fix.
> 
> CC: Trung Tran <trung.tran@ettus.com>
> CC: Moritz Fischer <mdf@kernel.org>
> CC: Michael J Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  arch/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 04807c7f64cc..992412dda60c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -281,7 +281,7 @@ config CMDLINE_BOOL
>  	  in CONFIG_CMDLINE.
>  
>  	  The built-in options will be concatenated to the default command
> -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> +	  line if CMDLINE_FORCE is set to 'N'. Otherwise, the default
>  	  command line will be ignored and replaced by the built-in string.
>  
>  config CMDLINE
> @@ -291,7 +291,7 @@ config CMDLINE
>  	help
>  	  Supply command-line options at build time by entering them here.
>  
> -config CMDLINE_OVERRIDE
> +config CMDLINE_FORCE
>  	bool "Built-in command line overrides bootloader arguments"
>  	depends on CMDLINE_BOOL
>  	help
> -- 
> 2.16.1
> 

Cheers,

Moritz
