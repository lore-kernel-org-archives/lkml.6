Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeBHH55 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:57:57 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32925 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:57:56 -0500
X-Google-Smtp-Source: AH8x227bNCXaf2m6yERkoQcoT+54B2EsjqiM69klNd/Eh1brq6uxzYwd9NmWTbcouMkUpub75Myigw==
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
To: Jia He <hejianet@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <39b1c62f-8784-e55a-3db0-5e7909031b65@linaro.org>
Date: Thu, 8 Feb 2018 08:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 05:11, Jia He wrote:
> In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
> probing"), iort entries was removed in vmlinux.lds.h. But in
> commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
> this line was back incorrectly.
> 
> It does no harm except for adding some useless symbols, so fix it.
> 
> Signed-off-by: Jia He <hejianet@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  include/asm-generic/vmlinux.lds.h | 1 -
>  1 file changed, 1 deletion(-)
> 
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

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
