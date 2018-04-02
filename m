Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeDBUID (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:08:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:32833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932228AbeDBUIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:08:01 -0400
Subject: Re: [PATCH v6 13/16] parisc: Switch to generic free_initrd_mem.
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org
References: <20180329113207.30674-1-shea@shealevy.com>
 <20180401145931.7932-1-shea@shealevy.com>
 <20180401145931.7932-13-shea@shealevy.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <267cfdc0-d905-1f3a-e4f2-16209605fca9@gmx.de>
Date: Mon, 2 Apr 2018 22:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180401145931.7932-13-shea@shealevy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mTJfkDHRlCghTunAGa8PKJv49Q2zolnIZeDbUXX4kB8/mAkMZKz
 uD/LZQWlcc9+piZn05xmC+543YmX3tKlktiR0rr8Ew8J6QpfBWUeDS1tNkEr0/RbBZdCEzj
 ojGIV6rz5pbtzGBQ8AN9J5T6Z/IdcOUNRbL8+GvTFWnnOQGqVbg8ClYdK1uJtk3GXHf3jnK
 wfgMgNMi47V/tCifl9X0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m61davdl6pQ=:d5jKHgx49e1qZQewBhMVmF
 pvmry83xpqT/gjWULMcBwW4RffJ96lrliGMEUxl1yLgQkwlrEIocRTCKU/rp04yFcFW1yipt5
 XR+K3X1HtdrSmBbaL9AYAVFqZflfv4zTOm+eC9rlnxXGg3WoM7J8lz4SZ4nzE/DE4OGtY77B8
 DlM93mSRBAw57eo2mbvbxNk9ydZtHrG0piEGxpPGs1RtT+eYElNIleEtCHIPV9gzOrNLqhtFL
 /70yojRG1liJk9b8JJortph6MtRdBBIbKwOUgYopVPQGT9WuGxkNk5n1lrcfk9SCjMV/ZsVjD
 tuHQQ2u5AjhnZ1NvOrjlE+QJoS+Z3jfnWXLp1Q2Ys0K9+yxE2AU9FPgLqQjCAa9oTAIzB1sNS
 E5VaelrjQuVqZwZPbg6A/6LhFsct8/n/NBjrnxEbeJJgj0FT76aD66yleN4NrPXNukKoQYZai
 T9rx8QvRcJCCyiFhLmjbzmCw4SIiofPxnUNUm/m7cGPIWms32XKvBABmBFfm/qT10AuZBi5++
 uRHY+oA/hiUsNnuCL5HWn22OY2wOpQXlInt7Sa7Zx1+mjk9L7sddzLQ7tDscYJkz8HcUUIg3g
 B5tyHTRUtVLS2FAGrlJVoh7rBZYPthg3iCn8W9w4gycfQfOzvfwr+IB7uvUHKsLUqrORIW9b5
 T8GeDP9USNRFhCshCau+W0RX3QWyLVoTalbJjAn99VpNJ9u3G0RYcoZCcbP2bUwEt1pvtCfsL
 ULUXdRxXzEhHNhcMPFgpKLB0B2P1Mf0HCI0a0nrxGduyQ96sxhnQ5Uf/OiLvreKTj84jqLEAa
 dkS1DEM0jm4TccHkxb+R25F+zLT95niKCvdOoykq26UImEOunUC7AUb7712snXOmgQ4FgJ7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.2018 16:59, Shea Levy wrote:
> The first patch in this series added a weakly-defined generic
> implementation, which is functionally identical to the
> architecture-specific one removed here.
> 
> Series boot-tested on RISC-V (which now uses the generic
> implementation) and x86_64 (which doesn't).
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>

Acked-by: Helge Deller <deller@gmx.de> # parisc

> ---
>  arch/parisc/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index cab32ee824d2..3643399230f3 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -932,10 +932,3 @@ void flush_tlb_all(void)
>  	spin_unlock(&sid_lock);
>  }
>  #endif
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> 
