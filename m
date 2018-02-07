Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeBGLlM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:41:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49702 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753736AbeBGLlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:41:10 -0500
Date: Wed, 7 Feb 2018 11:41:04 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jia He <hejianet@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
Message-ID: <20180207114104.GA22549@e107981-ln.cambridge.arm.com>
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 08:11:34PM -0800, Jia He wrote:
> In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
> probing"), iort entries was removed in vmlinux.lds.h. But in
> commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
> this line was back incorrectly.
> 
> It does no harm except for adding some useless symbols, so fix it.
> 
> Signed-off-by: Jia He <hejianet@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Who is picking this up ?

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1ab0e52..58b1dab 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -589,7 +589,6 @@
>  	IRQCHIP_OF_MATCH_TABLE()					\
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(timer)						\
> -	ACPI_PROBE_TABLE(iort)						\
>  	EARLYCON_TABLE()
>  
>  #define INIT_TEXT							\
> -- 
> 2.7.4
> 
