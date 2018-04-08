Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeDHBbg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 21:31:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeDHBbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 21:31:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDFC660540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date: Sat, 7 Apr 2018 20:31:30 -0500
From: Richard Kuo <rkuo@codeaurora.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hexagon: add memset_io() helper
Message-ID: <20180408013130.GC3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de>
 <20180406142832.2243021-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406142832.2243021-2-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:28:22PM +0200, Arnd Bergmann wrote:
> We already have memcpy_toio(), but not memset_io(), so let's
> add the obvious version to allow building an allmodconfig kernel
> without errors like
> 
> drivers/gpu/drm/ttm/ttm_bo_util.c: In function 'ttm_bo_move_memcpy':
> drivers/gpu/drm/ttm/ttm_bo_util.c:390:3: error: implicit declaration of function 'memset_io' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/include/asm/io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 9e8621d94ee9..e17262ad125e 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -216,6 +216,12 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
>  	memcpy((void *) dst, src, count);
>  }
>  
> +static inline void memset_io(volatile void __iomem *addr, int value,
> +			     size_t size)
> +{
> +	memset((void __force *)addr, value, size);
> +}
> +
>  #define PCI_IO_ADDR	(volatile void __iomem *)
>  
>  /*

Acked-by: Richard Kuo <rkuo@codeaurora.org>



-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
