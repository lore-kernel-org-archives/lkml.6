Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbeDBIEv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 04:04:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:39011 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754288AbeDBIEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 04:04:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,394,1517904000";
   d="scan'208";a="30329792"
Message-ID: <1522685086.2498.24.camel@intel.com>
Subject: Re: [PATCH v6 11/16] nios2: Switch to generic free_initrd_mem.
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: nios2-dev@lists.rocketboards.org
Date: Tue, 03 Apr 2018 00:04:46 +0800
In-Reply-To: <20180401145931.7932-11-shea@shealevy.com>
References: <20180329113207.30674-1-shea@shealevy.com>
         <20180401145931.7932-1-shea@shealevy.com>
         <20180401145931.7932-11-shea@shealevy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-01 at 10:59 -0400, Shea Levy wrote:
> The first patch in this series added a weakly-defined generic
> implementation, which is functionally identical to the
> architecture-specific one removed here.
> 
> Series boot-tested on RISC-V (which now uses the generic
> implementation) and x86_64 (which doesn't).
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> ---
>  arch/nios2/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
> index c92fe4234009..3df75ff8c768 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -82,13 +82,6 @@ void __init mmu_init(void)
>         flush_tlb_all();
>  }
> 
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -       free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> -
>  void __ref free_initmem(void)
>  {
>         free_initmem_default(-1);
> --
> 2.16.2
