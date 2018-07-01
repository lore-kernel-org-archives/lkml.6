Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E9C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FF12518D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yf02zuUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FF12518D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeGADUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 23:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeGADUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 23:20:40 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A3920647;
        Sun,  1 Jul 2018 03:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530415239;
        bh=qO7ZYrmElRkKt/I/6mJfxa8PC1qN9LKKD9ETP7h1iyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yf02zuUdWkPWGbIjUATLcJW1Z2gmkJHwzLuViQhfuGim2etmVmBMIZiAngW9BqTx6
         2cRbob69EhiSFvppbY2CH7Id95uedC7eGbuEHW0ZhcI2PxDDJxy+jWhCS+MAj3yMK/
         0SGjzLu58RUfF8sPAPIzzfNV253cB8VTXgySNigY=
Date:   Sun, 1 Jul 2018 11:20:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nick Dyer <nick@shmanahar.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH v5] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
Message-ID: <20180701032028.GF4348@dragon>
References: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
 <20180621181000.12687-1-nick@shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621181000.12687-1-nick@shmanahar.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:10:00PM +0100, Nick Dyer wrote:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
> 
> The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
> from the old vendor kernel.
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
> Cc: <stable@vger.kernel.org> # 4.15+
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Tested-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.

> ---
> Changes in v5:
> - Add tested by Chris Healy
> Changes in v4:
> - Add reviewed by Fabio

You do not have to send new version just for collecting review and test
tags.  I will do that when applying.

Shawn

> Changes in v3:
> - Update commit message to add source of 0x4 value, fixes tag and CC stable
> Changes in v2:
> - Use hex, only alter IRQ line config
> 
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index df9eca94d812..8a878687197b 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -770,7 +770,7 @@
>  
>  	pinctrl_ts: tsgrp {
>  		fsl,pins = <
> -			MX51_PAD_CSI1_D8__GPIO3_12		0x85
> +			MX51_PAD_CSI1_D8__GPIO3_12		0x04
>  			MX51_PAD_CSI1_D9__GPIO3_13		0x85
>  		>;
>  	};
> -- 
> 2.17.1
> 
