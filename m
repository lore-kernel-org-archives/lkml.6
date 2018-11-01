Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142BCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85C920820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rJeqMJOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85C920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeKARoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:44:01 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6369 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeKARoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:44:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bdabc490000>; Thu, 01 Nov 2018 01:41:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 01 Nov 2018 01:41:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 01 Nov 2018 01:41:58 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 1 Nov
 2018 08:41:58 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id AE9E3F80143; Thu,  1 Nov 2018 10:41:52 +0200 (EET)
Date:   Thu, 1 Nov 2018 10:41:52 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] clk: tegra: ignore unused vfir clock shared with
 uartb
Message-ID: <20181101084152.GS7636@tbergstrom-lnx.Nvidia.com>
References: <20181101015230.27310-1-marcel@ziswiler.com>
 <20181101015230.27310-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181101015230.27310-3-marcel@ziswiler.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541061705; bh=8EcqfMJMdhYlS+RS+ewflCAkYqdCMm1kTNSMo6nVSuo=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=rJeqMJObir49oe77o2u8FCM2x54UJJm4R8NZXpTSvp1L1ZpDsJpockSXqpZY+kFkP
         MZ6r0RPmaNQElPBIE/oWjnCgiYTUvg6EhmL42AVQF89CcjepRJp9CfUth/Y60zHdiG
         HGe2Zyg5Gf2d6wHuGzDpv8EsuJxBdrHxJZkVW8/FWmUNalOOoufqdbJztxTB/LNUpG
         mhckVVtbZmyIw/WulqONI77y72TZd31Xl6L343HCnA+hLCoRNJCK+wZ3jopFdYuhjs
         GQEMG+WR0iSS6LYc8xUHnSFsQ6PdyadDHv9OBgUSaZ8YQb8muZ4Df1jZXP9SpjWcyW
         KCnwYzvmj+thg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:52:29AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> As UARTB and VFIR share their clock enable bit it is rather unwise for
> the kernel to turn off the VFIR one should that be unused (and
> potentially vice versa but so far there anyway is no VFIR driver).
> 
> Without this patch trying to use UARTB with the regular 8250 driver
> will freeze as soon as ttyS1 is accessed after boot. Luckily, using the
> high-speed Tegra serial driver won't exhibit the issue as clocks are
> dynamically enabled/disabled on every access.
> 
> This has been reproduced both on Apalis T30 as well as Apalis TK1 but
> may be an issue on all Tegra UARTB's which share the clock enable with
> VFIR.
> 

Ah.. the correct fix for this is to initialize the enable_refcnt based on the
hw state. This is done in 9619dba8325fce098bbc9ee2911d1b0150fec0c9 for
periph gate clocks, but obviously also applies to normal periph clocks.

Peter.

> Reported-by: Kory Swain <kory.swain@trapezegroup.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/clk/tegra/clk-tegra-periph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> index cc5275ec2c01..116c74340fb7 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -668,7 +668,7 @@ static struct tegra_periph_init_data periph_clks[] = {
>  	MUX("hda", mux_pllp_pllc_clkm, CLK_SOURCE_HDA, 125, TEGRA_PERIPH_ON_APB, tegra_clk_hda_8),
>  	MUX("hda2codec_2x", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_HDA2CODEC_2X, 111, TEGRA_PERIPH_ON_APB, tegra_clk_hda2codec_2x),
>  	MUX8("hda2codec_2x", mux_pllp_pllc_plla_clkm, CLK_SOURCE_HDA2CODEC_2X, 111, TEGRA_PERIPH_ON_APB, tegra_clk_hda2codec_2x_8),
> -	MUX("vfir", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VFIR, 7, TEGRA_PERIPH_ON_APB, tegra_clk_vfir),
> +	MUX_FLAGS("vfir", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VFIR, 7, TEGRA_PERIPH_ON_APB, tegra_clk_vfir, CLK_IGNORE_UNUSED),
>  	MUX("sdmmc1", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC1, 14, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc1),
>  	MUX("sdmmc2", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC2, 9, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc2),
>  	MUX("sdmmc3", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC3, 69, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc3),
> -- 
> 2.14.5
> 
