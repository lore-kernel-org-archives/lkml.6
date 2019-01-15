Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3820675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547566205;
	bh=+k0FJo+JNXZbwBB3lyj9KThyjwvBKhwxPyJOTr89ibI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wAXs8zQviIFUSbFhYrm9H6GHjlQZWy1Yv0yQvPFHyJ5vI5jfpDUJ7lBYv792iyId9
	 NfMKPFCjxMx/Xt2mL6xmcmelvFPe32UxgjJXWe1cAAnu5S9biSase2s4EOhzpDplyi
	 qux3Vm/GpJ77YBwTyfYIyV582VvD67yvouREkNeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfAOPaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfAOPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:30:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3EA920675;
        Tue, 15 Jan 2019 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547566203;
        bh=+k0FJo+JNXZbwBB3lyj9KThyjwvBKhwxPyJOTr89ibI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff+mV/wyZyhIlr9QuLQD/Wki0EwRUJIP7kZP/CofgF+xOhQpp+DmpcrE/heQGyUZu
         3b9P9if4bpAATfR4NEfusCAXDH3jpll1bO0I4Y2dD7Se3Pm/eCp+V3wyucqTzfCzGR
         008sFkjkzp3wA++02Wbiv0wdoZ5ETq47FjjsrF64=
Date:   Tue, 15 Jan 2019 16:30:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     thirtythreeforty@gmail.com
Cc:     devel@driverdev.osuosl.org, NeilBrown <neil@brown.name>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: Mediatek: Use individual config flags in
 Makefile
Message-ID: <20190115153000.GA15206@kroah.com>
References: <CACmrr9gHucWaWtz07kQms6AsquLKAHbK+_Q0kF=92RGo6HmAFA@mail.gmail.com>
 <20190111004337.7223-1-thirtythreeforty@gmail.com>
 <20190111004337.7223-2-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111004337.7223-2-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:43:37PM -0700, thirtythreeforty@gmail.com wrote:
> From: George Hilliard <thirtythreeforty@gmail.com>
> 
> These drivers are useful on other MT76xx SoCs, which have compatible
> peripherals.  The drivers are selectable in Kconfig, but they were
> quietly excluded from the build because the SOC_MT7621 chip was not
> selected.  So, make the main staging Makefile use the same flags as
> everything else for these drivers.
> 
> mt7621-dma and mt7621-dts are left alone because they truly do require
> that SoC.
> 
> I have personally confirmed that the mt7621-spi driver works on the
> MT7688, which was what prompted this change.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: NeilBrown <neil@brown.name>
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/staging/Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index e095f427177c..4b78ea2c7848 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -42,12 +42,12 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
>  obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
>  obj-$(CONFIG_PI433)		+= pi433/
>  obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
> -obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
> -obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
> +obj-$(CONFIG_PINCTRL_RT2880)	+= mt7621-pinctrl/
> +obj-$(CONFIG_SPI_MT7621)	+= mt7621-spi/
>  obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
> -obj-$(CONFIG_SOC_MT7621)	+= ralink-gdma/
> -obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
> -obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
> +obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
> +obj-$(CONFIG_MTK_MMC)		+= mt7621-mmc/
> +obj-$(CONFIG_NET_MEDIATEK_SOC_STAGING)	+= mt7621-eth/
>  obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
>  obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
>  obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/

This patch doesn't apply to my tree at all, can you rebase and resend?

thanks,

greg k-h
