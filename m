Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC4C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEAB20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBlNQbcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEAB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeICGpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeICGpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:45:51 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F342077C;
        Mon,  3 Sep 2018 02:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535941671;
        bh=A8wBDKv/mbVz64I+eVHE9UITtlZaJ2EabeLrLm3pGdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBlNQbcwlaLl9ZExleDIVQWgXGzBSJuSXLe27aoZEBjd2naMQKryLXg5RyBDm5v6O
         2w0aeTonO0LNSglqEdGjQYHfJxDyl4nSR5WGe3qen9Na4b0UyM+6epFDhkZwzPbMcM
         QwLRpWJGa7XcsMNi0U+9sjNw0WSfrUDkvKmHEvrc=
Date:   Mon, 3 Sep 2018 10:26:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6ull: update iomux header
Message-ID: <20180903022642.GE3850@dragon>
References: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sébastien for a cross check.

Shawn

On Thu, Aug 30, 2018 at 01:20:05PM +0800, Anson Huang wrote:
> Update i.MX6ULL iomux header according to latest reference
> manual Rev.1, 11/2017.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ull-pinfunc.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
> index 3c12a6f..a282a31 100644
> --- a/arch/arm/boot/dts/imx6ull-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
> @@ -27,10 +27,25 @@
>  #define MX6UL_PAD_CSI_DATA02__UART5_DCE_RTS                      0x01EC 0x0478 0x0640 0x8 0x7
>  
>  /* signals for i.MX6ULL only */
> +#define MX6ULL_PAD_UART1_TX_DATA__UART5_DCE_TX                    0x0084 0x0310 0x0000 0x9 0x0
>  #define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
>  #define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
> -#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
> -#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
> +#define MX6ULL_PAD_UART1_RX_DATA__UART5_DTE_TX                    0x0088 0x0314 0x0000 0x9 0x0
> +#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_CTS                     0x008C 0x0318 0x0000 0x9 0x0
> +#define MX6ULL_PAD_UART1_CTS_B__UART5_DTE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
> +#define MX6ULL_PAD_UART1_RTS_B__UART5_DCE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
> +#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_CTS                     0x0090 0x031C 0x0000 0x9 0x0
> +#define MX6ULL_PAD_UART4_RX_DATA__EPDC_PWRCTRL01                  0x00B8 0x0344 0x0000 0x9 0x0
> +#define MX6ULL_PAD_UART5_TX_DATA__EPDC_PWRCTRL02                  0x00BC 0x0348 0x0000 0x9 0x0
> +#define MX6ULL_PAD_UART5_RX_DATA__EPDC_PWRCTRL03                  0x00C0 0x034C 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_RX_DATA0__EPDC_SDCE04                    0x00C4 0x0350 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_RX_DATA1__EPDC_SDCE05                    0x00C8 0x0354 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_RX_EN__EPDC_SDCE06                       0x00CC 0x0358 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_TX_DATA0__EPDC_SDCE07                    0x00D0 0x035C 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_TX_DATA1__EPDC_SDCE08                    0x00D4 0x0360 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_TX_EN__EPDC_SDCE09                       0x00D8 0x0364 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_TX_CLK__EPDC_SDOED                       0x00DC 0x0368 0x0000 0x9 0x0
> +#define MX6ULL_PAD_ENET1_RX_ER__EPDC_SDOEZ                        0x00E0 0x036C 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
> @@ -57,6 +72,8 @@
>  #define MX6ULL_PAD_LCD_DATA16__EPDC_GDCLK                         0x0158 0x03E4 0x0000 0x9 0x0
>  #define MX6ULL_PAD_LCD_DATA17__EPDC_GDSP                          0x015C 0x03E8 0x0000 0x9 0x0
>  #define MX6ULL_PAD_LCD_DATA21__EPDC_SDCE1                         0x016C 0x03F8 0x0000 0x9 0x0
> +#define MX6ULL_PAD_LCD_DATA22__EPDC_SDCE02                        0x0170 0x03FC 0x0000 0x9 0x0
> +#define MX6ULL_PAD_LCD_DATA23__EPDC_SDCE03                        0x0174 0x0400 0x0000 0x9 0x0
>  #define MX6ULL_PAD_CSI_MCLK__ESAI_TX3_RX2                         0x01D4 0x0460 0x0000 0x9 0x0
>  #define MX6ULL_PAD_CSI_PIXCLK__ESAI_TX2_RX3                       0x01D8 0x0464 0x0000 0x9 0x0
>  #define MX6ULL_PAD_CSI_VSYNC__ESAI_TX4_RX1                        0x01DC 0x0468 0x0000 0x9 0x0
> -- 
> 2.7.4
> 
