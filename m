Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2421836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544951713;
	bh=XHnqJFO3m08OorIoFYzDH/5DyUHP264p43PG/ku/Rcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zdey8Qkq+8TFWQzgfe9WV8qoH1BgB92P5DxcPPdEciCB6CzZTQUEKF142S8k2BRTN
	 /bbPnP7/4+u6hAp3jTkh8yDF1bJ3MYl+j//rS95MyH1AQAfsu2Z4BYVGwVa2wzpVrz
	 EzUFOrRLfXhTMckgMbWhPb6mL6ipt6RCgBUdcsNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeLPJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbeLPJPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 04:15:12 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877BA2084D;
        Sun, 16 Dec 2018 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544951711;
        bh=XHnqJFO3m08OorIoFYzDH/5DyUHP264p43PG/ku/Rcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQnh9xezErZzbMJIxF3oRxKsHzhufUKLnnIn10mhZaGiOQr/UN5m/8oU9CJACS/uJ
         WywXU7+t70EKmPY7HyhJ1QqsUz9GP4z+InR4B+1nmmDN3fGu2aMUykzXY9q3hpElga
         OxkWHcQvaetTTwGqxMdijJhaD2STGkxFF2d4iwYs=
Date:   Sun, 16 Dec 2018 17:14:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v5 1/6] arm64: add basic Kconfig symbols for i.MX8
Message-ID: <20181216091405.GK13243@dragon>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
 <1544365552-30270-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544365552-30270-2-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 02:26:06PM +0000, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Add basic Kconfig symbols to make the MXC architecture available
> in the ARM64 world.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm64/Kconfig.platforms | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 28f0521..7e1545a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -142,6 +142,20 @@ config ARCH_MVEBU
>  	   - Armada 7K SoC Family
>  	   - Armada 8K SoC Family
>  
> +config ARCH_MXC
> +	bool "ARMv8 based NXP i.MX SoC family"
> +	help
> +	  This enables support for the ARMv8 based SoCs in the
> +	  NXP i.MX family.
> +
> +config SOC_IMX8MQ
> +	bool "i.MX8MQ support"
> +	depends on ARCH_MXC
> +	select ARM64_ERRATUM_843419
> +	select ARM64_ERRATUM_845719
> +	help
> +	  This enables support for the i.MX8MQ SoC.
> +

As we agreed in principle that option SOC_IMX8MQ should be drop from
ARM64 platform.  I updated the patch as below.

---8<-----------------

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..3e177a332b92 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -142,6 +142,14 @@ config ARCH_MVEBU
           - Armada 7K SoC Family
           - Armada 8K SoC Family
 
+config ARCH_MXC
+       bool "ARMv8 based NXP i.MX SoC family"
+       select ARM64_ERRATUM_843419
+       select ARM64_ERRATUM_845719
+       help
+         This enables support for the ARMv8 based SoCs in the
+         NXP i.MX family.
+
 config ARCH_QCOM
        bool "Qualcomm Platforms"
        select GPIOLIB


