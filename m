Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeDIQkk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:40:40 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60912 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeDIQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:40:39 -0400
Subject: Re: [PATCH v6 04/16] arc: Switch to generic free_initrd_mem.
To: Shea Levy <shea@shealevy.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
References: <20180329113207.30674-1-shea@shealevy.com>
 <20180401145931.7932-1-shea@shealevy.com>
 <20180401145931.7932-4-shea@shealevy.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <319c8fd1-28f7-4319-6a07-789054c17e14@synopsys.com>
Date: Mon, 9 Apr 2018 09:40:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180401145931.7932-4-shea@shealevy.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2018 08:00 AM, Shea Levy wrote:
> The first patch in this series added a weakly-defined generic
> implementation, which is functionally identical to the
> architecture-specific one removed here.
>
> Series boot-tested on RISC-V (which now uses the generic
> implementation) and x86_64 (which doesn't).
>
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>   arch/arc/mm/init.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index ba145065c579..7bcf23ab1756 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>   {
>   	free_initmem_default(-1);
>   }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif

LGTM.

Acked-by: Vineet Gupta <vgupta@synopsys.com>

-Vineet
