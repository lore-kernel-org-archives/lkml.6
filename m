Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42D2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9C20855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA9C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeKJM26 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 07:28:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:37145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbeKJM26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 07:28:58 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx024.server.lan (via HTTP); Sat, 10 Nov 2018 03:45:14 +0100
MIME-Version: 1.0
Message-ID: <trinity-d366cf7f-4a38-4193-a636-b695d34d6c47-1541817914119@msvc-mesg-gmx024>
From:   "Qian Cai" <cai@gmx.us>
To:     "Ard Biesheuvel" <ard.biesheuvel@linaro.org>
Cc:     linux-mm@kvack.org, linux-efi@vger.kernel.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] efi: permit calling efi_mem_reserve_persistent from
 atomic context
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Nov 2018 03:45:14 +0100
In-Reply-To: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
References: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:JiJGWbcCf1w0o9nAvdOo8cAcysh3dnfNeg/CKhKB9tl5YriK/ekpGcdsw3Cju5eqa9YFx
 9yytoTKzWUQ0C8ido/GLxgE1EnpfbiqeFACOOJj/nPmkrIv+tkBL9UBq7IfXpjSvGjDSpehY20hR
 dSEwNOaWEjRh+3y6eWMDMOhec5Slfnxzk2Ku0RfrrWA09dK2/nHm6Kpuy7uooOA3QH0UBfKHaira
 aoQwalfYZ8ZnWNjfB3Mdo71wSY4lkzcfAK5BUTbPXLfB6L8ZRMNuYc/QcTgkOMhbQRdwuRhvikcv
 Fgwqvw0jMxqT+2VQZfSSTEW
X-UI-Out-Filterresults: notjunk:1;V01:K0:JBGAhmLXjOg=:rJSbGaa56t+CWZe+3Hm3sD
 i18CEH+DGpqCtPBQEA9iJpejPVDGPRUHEwX6sm3i6w8mwLUf+OG3o48tKRhsiA311s5TDfB2u
 XRn53SCs4s+mV9DhDUcqKTiuWP54j/gQiRg6e+P36ERAnd2gjf1hpbRBhmoXr6W3bWber8K3F
 Sk0gGwybpnDv7hzNig8rdGtxHqi/G7ptziqeI4nXXDoqLrJp/fB9jEek+nvA9N1cLGr3vkr06
 kq/7085oXJva/00rTESe3+D68vRL1B3iiDu/7SYvltLljceCSr5MU0iVrHRFJ1sma9G4uKCI3
 2oJZa17/eBRga6A2uq4t5LamkXM9asmkv8jNmYmt6RIuSNO79YwrRAK8FTOWcgfTk9KQPoD8s
 zyKNeFSIumpVLcColhxq/YhFTjeNwhfrFk/nTyQWsupsnvar71pjzFYSQfhXsD6Vx6t9iza9s
 Mpj6niBGlZLS0cv5TmQWbwOvxBPFVF6kxe4sEZ8BxBljrK1uaW4m3Euh61NuazojG7nxWIcQj
 rHQpYeCtzzWHNFoIg5XKNcWCoe4Mxh8lqNTaDIF+n+74YOxpmfXztEc+OqMIUFrp2LnfgsuAW
 woORSRc2K1SWcvuqJJQV4joLq+cSgd43sg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/18 at 1:05 PM, Ard Biesheuvel wrote:

> Currently, efi_mem_reserve_persistent() may not be called from atomic
> context, since both the kmalloc() call and the memremap() call may
> sleep.
> 
> The kmalloc() call is easy enough to fix, but the memremap() call
> needs to be moved into an init hook since we cannot control the
> memory allocation behavior of memremap() at the call site.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 249eb70691b0..cfc876e0b67b 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -963,36 +963,43 @@ bool efi_is_table_address(unsigned long phys_addr)
>  }
>  
>  static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
>  
>  int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  {
> -	struct linux_efi_memreserve *rsv, *parent;
> +	struct linux_efi_memreserve *rsv;
>  
> -	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
> +	if (!efi_memreserve_root)
>  		return -ENODEV;
>  
> -	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
> +	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
>  	if (!rsv)
>  		return -ENOMEM;
>  
> -	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
> -	if (!parent) {
> -		kfree(rsv);
> -		return -ENOMEM;
> -	}
> -
>  	rsv->base = addr;
>  	rsv->size = size;
>  
>  	spin_lock(&efi_mem_reserve_persistent_lock);
> -	rsv->next = parent->next;
> -	parent->next = __pa(rsv);
> +	rsv->next = efi_memreserve_root->next;
> +	efi_memreserve_root->next = __pa(rsv);
>  	spin_unlock(&efi_mem_reserve_persistent_lock);
>  
> -	memunmap(parent);
> +	return 0;
> +}
>  
> +static int __init efi_memreserve_root_init(void)
> +{
> +	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
> +		return -ENODEV;
> +
> +	efi_memreserve_root = memremap(efi.mem_reserve,
> +				       sizeof(*efi_memreserve_root),
> +				       MEMREMAP_WB);
> +	if (!efi_memreserve_root)
> +		return -ENOMEM;
>  	return 0;
>  }
> +early_initcall(efi_memreserve_root_init);
>  
>  #ifdef CONFIG_KEXEC
>  static int update_efi_random_seed(struct notifier_block *nb,
> -- 
> 2.19.1
BTW, I won’t be able to apply this patch on top of this series [1]. After applied that series, the original BUG sleep from atomic is gone as well as two other GIC warnings. Do you think a new patch is needed here?

[1] https://www.spinics.net/lists/arm-kernel/msg685751.html
