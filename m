Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeECPtA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:49:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeECPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:48:58 -0400
Subject: Re: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend on
 OF
To: Anders Roxell <anders.roxell@linaro.org>, tomi.valkeinen@ti.com,
        b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180420112551.27027-1-anders.roxell@linaro.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <16e74acc-1265-faec-0c36-49681a7760e4@infradead.org>
Date: Thu, 3 May 2018 08:48:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420112551.27027-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 04:25 AM, Anders Roxell wrote:
> Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
> COMPILE_TEST") broke compilation without CONFIG_OF selected.
>   CC      drivers/video/fbdev/core/fbmem.o
> drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function ‘omapdss_update_prop’:
> drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error: implicit declaration of function ‘of_update_property’; did you mean ‘of_get_property’? [-Werror=implicit-function-declaration]
>   of_update_property(node, prop);
>   ^~~~~~~~~~~~~~~~~~
>   of_get_property
> cc1: some warnings being treated as errors
> scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o' failed
> make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o] Error 1
> scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss' failed
> make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
> make[6]: *** Waiting for unfinished jobs....
> 
> Add OF dependency in order to make all configurations work again.
> 
> of_update_property() has no inline stub, and that that could be added as
> an alternative.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/video/fbdev/omap2/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
> index 82008699d253..4de381f2452e 100644
> --- a/drivers/video/fbdev/omap2/Kconfig
> +++ b/drivers/video/fbdev/omap2/Kconfig
> @@ -1,4 +1,4 @@
> -if ARCH_OMAP2PLUS || COMPILE_TEST
> +if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
>  
>  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
>  
> 

Hi,

This patch certainly fixes the build errors that I have been seeing in
linux-next for several days now, so:

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

OTOH, I would rather see the Kconfig dependencies all expressed in
drivers/video/fbdev/omap2/omapfb/Kconfig instead of them being split
between 2 Kconfig files.

thanks,
-- 
~Randy
