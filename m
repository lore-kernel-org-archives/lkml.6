Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeC2Jwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:52:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38448 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeC2Jwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:52:51 -0400
X-Google-Smtp-Source: AIpwx48724I2JQD48+K8EdIE/FLmC6b/kSrXei2al+jsPegUvHuSUwX26O8vgFClGLwxy6nvY3gWgg==
Subject: Re: [PATCH v4 02/16] riscv: Use generic free_initrd_mem.
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
 <20180328203659.18692-3-shea@shealevy.com>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <7fa4f27c-d421-38cd-aa16-445b364ed9eb@linaro.org>
Date: Thu, 29 Mar 2018 10:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328203659.18692-3-shea@shealevy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/18 21:36, Shea Levy wrote:
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>   arch/riscv/mm/init.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c77df8142be2..36f83fe8a726 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -62,9 +62,3 @@ void free_initmem(void)
>   {
>   	free_initmem_default(0);
>   }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -}
> -#endif /* CONFIG_BLK_DEV_INITRD */

This looks like a change of behavior since the weakly defined code does 
not implement a nop.

I'm not saying the change is wrong, but if this is a deliberate bug fix 
then we need more than an empty commit message to explain what is 
happening here.


Daniel.
