Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeC1SRc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:17:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51515 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeC1SR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:17:29 -0400
Date: Wed, 28 Mar 2018 20:17:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: mike.travis@hpe.com
cc: Ingo Molnar <mingo@redhat.com>, Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/platform/UV: Fix critical UV MMR address error
In-Reply-To: <20180328174011.041801248@stormcage.americas.sgi.com>
Message-ID: <alpine.DEB.2.21.1803282007380.1496@nanos.tec.linutronix.de>
References: <20180328174010.882366342@stormcage.americas.sgi.com> <20180328174011.041801248@stormcage.americas.sgi.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, mike.travis@hpe.com wrote:

> A critical error was found testing the fixed UV4 HUB in that an MMR
> address was found to be incorrect.  This causes the virtual address
> space for accessing the MMIOH1 region to be allocated with the
> incorrect size.

Even if this is not intended for stable, despite the diff 

> --- linux-4.4.orig/arch/x86/include/asm/uv/uv_mmrs.h
> +++ linux-4.4/arch/x86/include/asm/uv/uv_mmrs.h

suggesting that this is against a kernel, which receives respiration
treatment, it would be appreciated if you could add a Fixes tag next time.

That spares me the time to figure out which commit introduced the wreckage
and therefore the scope of the fix. Added it myself.

Thanks,

	tglx

> @@ -3833,7 +3833,7 @@ union uvh_rh_gam_mmioh_overlay_config0_m
>  #define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
>  #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
>  #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x1603000UL
> -#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x483000UL
> +#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x484000UL
>  #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR (				\
>  	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
>  	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
> 
> -- 
> 
