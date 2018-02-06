Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeBFMg0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:36:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeBFMgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:36:16 -0500
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com,
        stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com,
        schwidefsky@de.ibm.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <49ef903a791cbca658194c68932eb90450027774.1517508744.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c4acb3f9-2b91-0ec4-7e76-028a8ecec1d0@redhat.com>
Date: Tue, 6 Feb 2018 13:36:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <49ef903a791cbca658194c68932eb90450027774.1517508744.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2018 19:41, Farhan Ali wrote:
> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> "Graphics support" menu for S390. But if we enable VT layer for S390,
> we would also need to enable the dummy console. So let's remove the
> HAS_IOMEM dependency.
> 
> Move this dependency to Opencores framebuffer driver which would fail to build
> with CONFIG_HAS_IOMEM disabled:
> 
> ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/video/Kconfig       | 1 -
>  drivers/video/fbdev/Kconfig | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3c20af9..41e7ba9 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -3,7 +3,6 @@
>  #
>  
>  menu "Graphics support"
> -	depends on HAS_IOMEM
>  
>  config HAVE_FB_ATMEL
>  	bool
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 2f615b7..ec9c9ce 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -966,7 +966,7 @@ config FB_PVR2
>  
>  config FB_OPENCORES
>  	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> -	depends on FB && HAS_DMA
> +	depends on FB && HAS_DMA && HAS_IOMEM
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
