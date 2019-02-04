Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3573C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E72082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfBDMXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14841 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbfBDMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:23:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2551A37EE7;
        Mon,  4 Feb 2019 12:23:50 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 889E491F95;
        Mon,  4 Feb 2019 12:23:45 +0000 (UTC)
Subject: Re: [PATCH] vfio: platform: reset: fix up include directives to
 remove ccflags-y
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1548816751-32068-1-git-send-email-yamada.masahiro@socionext.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <650a11f0-e591-427a-ad29-c72ae0e1fe11@redhat.com>
Date:   Mon, 4 Feb 2019 13:23:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548816751-32068-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 04 Feb 2019 12:23:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 1/30/19 3:52 AM, Masahiro Yamada wrote:
> For the include directive with double-quotes "", the preprocessor
> searches the header in the relative path to the current file.
> 
> Fix them up, and remove the header search path option.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
> 
>  drivers/vfio/platform/reset/Makefile                     | 2 --
>  drivers/vfio/platform/reset/vfio_platform_amdxgbe.c      | 2 +-
>  drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c    | 2 +-
>  drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 2 +-
>  4 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
> index 57abd4f..7294c5e 100644
> --- a/drivers/vfio/platform/reset/Makefile
> +++ b/drivers/vfio/platform/reset/Makefile
> @@ -2,8 +2,6 @@
>  vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
>  vfio-platform-amdxgbe-y := vfio_platform_amdxgbe.o
>  
> -ccflags-y += -Idrivers/vfio/platform
> -
>  obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
>  obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
>  obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> index bcd419c..3ddb270 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> @@ -25,7 +25,7 @@
>  #include <uapi/linux/mdio.h>
>  #include <linux/delay.h>
>  
> -#include "vfio_platform_private.h"
> +#include "../vfio_platform_private.h"
>  
>  #define DMA_MR			0x3000
>  #define MAC_VR			0x0110
> diff --git a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> index d45c3be..16165a6 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> @@ -23,7 +23,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  
> -#include "vfio_platform_private.h"
> +#include "../vfio_platform_private.h"
>  
>  /* FlexRM configuration */
>  #define RING_REGS_SIZE					0x10000
> diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> index 49e5df6..e0356de 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> @@ -24,7 +24,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  
> -#include "vfio_platform_private.h"
> +#include "../vfio_platform_private.h"
>  
>  #define DRIVER_VERSION  "0.1"
>  #define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
> 
