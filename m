Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3836EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6D620850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO/uxlZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6D620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeH2Sxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeH2Sxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:53:32 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F4A2083D;
        Wed, 29 Aug 2018 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535554572;
        bh=wTikBZwSkJY5jJbp9lBc7gUjD2qGe20PHcODpVt5txE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IO/uxlZt1iNACy5/mDfBk1hoeeMrKyPJ6Czt5Dh7zjL/jVinJ+KvASHkxtQwX0wzL
         j5H+4Byv3BM3IlRF8NoGFO9m5JpqbCMCxkRCZU9JocKE/PVU8rn7FHP7VedEAdFwsH
         AXPrZ+FWu8Vk8ZZgbE1xW2inVSD93ik/F/kCILHI=
Date:   Wed, 29 Aug 2018 22:55:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Make usbnet drivers builtin
 for boot
Message-ID: <20180829145511.GQ3850@dragon>
References: <ab02224d560e09e96af2e41fbfa155e40e8bbb75.1535373073.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab02224d560e09e96af2e41fbfa155e40e8bbb75.1535373073.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 03:32:39PM +0300, Leonard Crestez wrote:
> Chips such as imx6sll and imx7ulp have no ethernet support so the common
> development usecase of nfs boot is supported via usb ethernet dongles.
> 
> Add drivers for additional usbnet device directly into the kernel image
> image produced by the imx defconfig.
  ^^^^^

Redundant 'image'.  I fixed it up and applied the patch.

Shawn

> 
> This list is based on the usbnet devices supported by uboot.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> This is not a very pretty solution but very convenient.
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index e2c127608bcc..7474bb5b3a6f 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -147,13 +147,16 @@ CONFIG_SMSC911X=y
>  CONFIG_AT803X_PHY=y
>  CONFIG_MICREL_PHY=y
>  CONFIG_SMSC_PHY=y
>  CONFIG_USB_PEGASUS=m
>  CONFIG_USB_RTL8150=m
> -CONFIG_USB_RTL8152=m
> +CONFIG_USB_RTL8152=y
> +CONFIG_USB_LAN78XX=y
>  CONFIG_USB_USBNET=y
>  CONFIG_USB_NET_CDC_EEM=m
> +CONFIG_USB_NET_SMSC95XX=y
> +CONFIG_USB_NET_MCS7830=y
>  CONFIG_BRCMFMAC=m
>  CONFIG_MWIFIEX=m
>  CONFIG_MWIFIEX_SDIO=m
>  CONFIG_MWIFIEX_PCIE=m
>  CONFIG_WL12XX=m
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
