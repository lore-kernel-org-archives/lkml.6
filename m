Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD68C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6B220700
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ke2HFn5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfBLR1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:27:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42280 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfBLR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4qRPk2mO4HOuqi7gK96QPC0khLRra82LJpcTGMdunHM=; b=ke2HFn5EBlrR1+QlpbpRQYPJX
        Tr1oZjA51fxrk9hvsf6bSTpPgOiEAjbueMvlz+5K6/BLKQY2LUbFCAZxyrnT2AkSmOa5+/rOrfgbS
        SpayKvqMFhh8nGJJ4RMyCsp+1SRULJQ84hhRAF3w7a4cnJy+Xot7Q8Me/Vfau68BCl97Q=;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36728)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gtbps-0006uu-8q; Tue, 12 Feb 2019 17:27:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gtbpl-0002C3-0Q; Tue, 12 Feb 2019 17:27:01 +0000
Date:   Tue, 12 Feb 2019 17:27:00 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm: use memblocks_present
Message-ID: <20190212172700.xwtomhb3qahyxugx@shell.armlinux.org.uk>
References: <20190211131602.3294-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211131602.3294-1-peng.fan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:04:59PM +0000, Peng Fan wrote:
> arm_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks good, please put it in the patch system, thanks.  Details in
my signature.

> ---
>  arch/arm/mm/init.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 478ea8b7db87..6c50dd407ba8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
>  
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg)
> -		memory_present(0, memblock_region_memory_base_pfn(reg),
> -			       memblock_region_memory_end_pfn(reg));
> -}
> -#endif
> -
>  static bool arm_memblock_steal_permitted = true;
>  
>  phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> @@ -292,7 +277,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>  	 * so must be done after the fixed reservations
>  	 */
> -	arm_memory_present();
> +	memblocks_present();
>  
>  	/*
>  	 * sparse_init() needs the bootmem allocator up and running.
> -- 
> 2.16.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
