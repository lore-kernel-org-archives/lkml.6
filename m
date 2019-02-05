Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCEE2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfBEUib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:38:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfBEUia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:38:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 694502CE979;
        Tue,  5 Feb 2019 20:38:30 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A55A516900;
        Tue,  5 Feb 2019 20:38:21 +0000 (UTC)
Date:   Tue, 5 Feb 2019 13:38:21 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] vfio: platform: reset: fix up include directives to
 remove ccflags-y
Message-ID: <20190205133821.2317c88a@w520.home>
In-Reply-To: <1548816751-32068-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548816751-32068-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 05 Feb 2019 20:38:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 11:52:31 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> For the include directive with double-quotes "", the preprocessor
> searches the header in the relative path to the current file.
> 
> Fix them up, and remove the header search path option.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/vfio/platform/reset/Makefile                     | 2 --
>  drivers/vfio/platform/reset/vfio_platform_amdxgbe.c      | 2 +-
>  drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c    | 2 +-
>  drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 2 +-
>  4 files changed, 3 insertions(+), 5 deletions(-)

Applied with Eric's Ack to the vfio next branch for v5.1.  Thanks,

Alex

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

