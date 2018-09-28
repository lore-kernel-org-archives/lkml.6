Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A405C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17682173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE0iNqgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17682173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeI1PH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbeI1PH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:07:59 -0400
Received: from dragon (unknown [45.56.155.164])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E6D2170E;
        Fri, 28 Sep 2018 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538124316;
        bh=AzUHFJy5soOos4ZJhUsrc5gOnhFrrrBnnD18iXiFV+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GE0iNqgud/DsJuytswh8M1AjP9i9nZS83nmY4TVPuC3Jq7Ry0UiKI8nhd3VkQbhwe
         Vp7BH6KMsPCqDJiTpXPK5B4Wyv63vecKxImYANpnTHW0zPoG33SUxt0mm96QaURRYO
         8MAgGaJVynCs69DsEApObNpvm/FHozM0NutpJo9U=
Date:   Fri, 28 Sep 2018 16:44:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        ping.bai@nxp.com, Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
Message-ID: <20180928084452.GH26692@dragon>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
 <1537337088-28819-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1537337088-28819-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:04:45PM +0800, Anson Huang wrote:
> The i.MX 6ULZ processor is a high-performance, ultra
> cost-efficient consumer Linux processor featuring an
> advanced implementation of a single Arm® Cortex®-A7 core,
> which operates at speeds up to 900 MHz.
> 
> This patch adds basic MSL support for i.MX6ULZ, the
> i.MX6ULZ has same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6]
> is to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means
> i.MX6ULZ and 1'b0 means i.MX6ULL.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/anatop.c      | 20 ++++++++++++++++++++
>  arch/arm/mach-imx/cpu.c         |  3 +++
>  arch/arm/mach-imx/mach-imx6ul.c |  1 +
>  arch/arm/mach-imx/mxc.h         |  7 +++++++
>  arch/arm/mach-imx/pm-imx6.c     |  4 ++--
>  5 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> index 61f3d94..45d618a 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -31,6 +31,8 @@
>  #define ANADIG_DIGPROG_IMX6SL	0x280
>  #define ANADIG_DIGPROG_IMX7D	0x800
>  
> +#define SRC_SBMR2		0x1c
> +
>  #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
>  #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
>  #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
> @@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
>  		major_part = (digprog >> 8) & 0xf;
>  		minor_part = digprog & 0xf;
>  		revision = ((major_part + 1) << 4) | minor_part;
> +
> +		if ((digprog >> 16) == MXC_CPU_IMX6ULL) {
> +			void __iomem *src_base;
> +			u32 sbmr2;
> +
> +			np = of_find_compatible_node(NULL, NULL,
> +						     "fsl,imx6ul-src");
> +			src_base = of_iomap(np, 0);
> +			WARN_ON(!src_base);
> +			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
> +			iounmap(src_base);
> +
> +			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
> +			if (sbmr2 & (1 << 6)) {
> +				digprog &= ~(0xff << 16);
> +				digprog |= (MXC_CPU_IMX6ULZ << 16);
> +			}
> +		}
>  	}
>  
>  	mxc_set_cpu_type(digprog >> 16 & 0xff);
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index c6b1bf9..c73593e 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
>  	case MXC_CPU_IMX6ULL:
>  		soc_id = "i.MX6ULL";
>  		break;
> +	case MXC_CPU_IMX6ULZ:
> +		soc_id = "i.MX6ULZ";
> +		break;
>  	case MXC_CPU_IMX6SLL:
>  		soc_id = "i.MX6SLL";
>  		break;
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> index 6cb8a22..4ffe3c8 100644
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -90,6 +90,7 @@ static void __init imx6ul_init_late(void)
>  static const char * const imx6ul_dt_compat[] __initconst = {
>  	"fsl,imx6ul",
>  	"fsl,imx6ull",
> +	"fsl,imx6ulz",

Can we have "fsl,imx6ull" on the DT compatible, so that we can save the
changes on kernel side, like this and the clock driver update (patch #2)?

  compatible = "fsl,imx6ull", "fsl,imx6ulz";

I'm not sure if there is any problem with this approach.  But you can
think about it.

Shawn

>  	NULL,
>  };
>  
> diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> index 026e2ca..b130a53 100644
> --- a/arch/arm/mach-imx/mxc.h
> +++ b/arch/arm/mach-imx/mxc.h
> @@ -40,6 +40,8 @@
>  #define MXC_CPU_IMX6Q		0x63
>  #define MXC_CPU_IMX6UL		0x64
>  #define MXC_CPU_IMX6ULL		0x65
> +/* virtual cpu id for i.mx6ulz */
> +#define MXC_CPU_IMX6ULZ		0x6b
>  #define MXC_CPU_IMX6SLL		0x67
>  #define MXC_CPU_IMX7D		0x72
>  
> @@ -80,6 +82,11 @@ static inline bool cpu_is_imx6ull(void)
>  	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
>  }
>  
> +static inline bool cpu_is_imx6ulz(void)
> +{
> +	return __mxc_cpu_type == MXC_CPU_IMX6ULZ;
> +}
> +
>  static inline bool cpu_is_imx6sll(void)
>  {
>  	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index 529f4b5..87f45b9 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -313,7 +313,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
>  		if (cpu_is_imx6sl())
>  			val |= BM_CLPCR_BYPASS_PMIC_READY;
>  		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
> -		    cpu_is_imx6ull() || cpu_is_imx6sll())
> +		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
>  			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
>  		else
>  			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
> @@ -331,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
>  		if (cpu_is_imx6sl() || cpu_is_imx6sx())
>  			val |= BM_CLPCR_BYPASS_PMIC_READY;
>  		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
> -		    cpu_is_imx6ull() || cpu_is_imx6sll())
> +		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
>  			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
>  		else
>  			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
> -- 
> 2.7.4
> 
