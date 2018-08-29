Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2009A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1ZUHn8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2009A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeH2TS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:18:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35777 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeH2TS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:18:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id w8-v6so885326pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWpxfKnp+ikZtlaNARk7Z0gG3n7H1VwhxOomafjpHaM=;
        b=N1ZUHn8Nj2oL6EGy/HM3QsgKg98UhVJ8hNwbei7nSBw2uqnmTBaHnN0J3xCB4kR24o
         hgaJ5RHwDc6uYn6ziv51sYTi5zrYVL7aWDgk/sDzcO8uT04hxOIHZI+cZBA6X2gbXAh0
         397ylI1TCSuaF1YAvCutjPUhmMML31qrH/2RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWpxfKnp+ikZtlaNARk7Z0gG3n7H1VwhxOomafjpHaM=;
        b=dl9hFBnC/u+a2RvqVjycwsX7fbSIEE6QN0D1jdVRrLVnsD1CvFjA28HAP6hrPBgUn6
         Kf3lhZ4fUL9YjYNJuC8F74I7QYkph8q/yhoJYCX2M3hrpEgAzqAYEojIQpCvWQelaX/6
         7O6WkhO+QDD/VEhHRx+iRaPvxz9Un2brzY84u69/ENWY0hmoKEpQ5djN1+unwGSe+bxb
         nJBU5fHE/AY9YVqJz3DqO+fBfxa95Qf7bAs1iDMuzABzumA18xwMwWgQod2StdXevvZ8
         SgLmBqmCsNVZropxkLJ7Fc3iRCd5HD1sVqQ5CkHr8UVqr0HfJOj27djB6cOWNjxOUihQ
         YbqA==
X-Gm-Message-State: APzg51AD9+/dWfDpX9ks/FSyb1H5VBlIdn/EkPqICdPH7u0dZv5UQPnS
        qjGzTVqJEmVWLvtUkqxOzZ0r
X-Google-Smtp-Source: ANB0VdaULDYNXQzPsPOCFyFnpFDNujm9T/KBGJGRE4AI6a55sM80hqF0labLu4vMkyZ9Mte9IOxFqQ==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr6003712pga.353.1535556062021;
        Wed, 29 Aug 2018 08:21:02 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6384:6a6:70b9:a288:9cdc:3e44])
        by smtp.gmail.com with ESMTPSA id 83-v6sm10555247pft.40.2018.08.29.08.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:21:01 -0700 (PDT)
Date:   Wed, 29 Aug 2018 20:50:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH v5 1/5] pinctrl: actions: define constructor generic to
 Actions Semi SoC's
Message-ID: <20180829152049.GA21136@Mani-XPS-13-9360>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
 <20180829082413.2512005-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829082413.2512005-2-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

On Wed, Aug 29, 2018 at 10:24:09AM +0200, Saravanan Sekar wrote:
> Move generic defines common to the Owl family out of S900 driver.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.h  | 131 +++++++++++++++++++++++++++++++
>  drivers/pinctrl/actions/pinctrl-s900.c | 139 ++-------------------------------
>  2 files changed, 137 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index a724d1d406d4..31cc33d7c4a5 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -15,6 +15,136 @@
>  #define OWL_PINCONF_SLEW_SLOW 0
>  #define OWL_PINCONF_SLEW_FAST 1
>  
> +#define MUX_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.funcs = group_name##_funcs,				\
> +		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
> +		.mfpctl_reg  = MFCTL##reg,				\
> +		.mfpctl_shift = shift,					\
> +		.mfpctl_width = width,					\
> +		.drv_reg = -1,						\
> +		.drv_shift = -1,					\
> +		.drv_width = -1,					\
> +		.sr_reg = -1,						\
> +		.sr_shift = -1,						\
> +		.sr_width = -1,						\
> +	}
> +
> +#define DRV_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.mfpctl_reg  = -1,					\
> +		.mfpctl_shift = -1,					\
> +		.mfpctl_width = -1,					\
> +		.drv_reg = PAD_DRV##reg,				\
> +		.drv_shift = shift,					\
> +		.drv_width = width,					\
> +		.sr_reg = -1,						\
> +		.sr_shift = -1,						\
> +		.sr_width = -1,						\
> +	}
> +
> +#define SR_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.mfpctl_reg  = -1,					\
> +		.mfpctl_shift = -1,					\
> +		.mfpctl_width = -1,					\
> +		.drv_reg = -1,						\
> +		.drv_shift = -1,					\
> +		.drv_width = -1,					\
> +		.sr_reg = PAD_SR##reg,					\
> +		.sr_shift = shift,					\
> +		.sr_width = width,					\
> +	}
> +
> +#define FUNCTION(fname)					\
> +	{						\
> +		.name = #fname,				\
> +		.groups = fname##_groups,		\
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +/* PAD PULL UP/DOWN CONFIGURES */
> +#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)	\
> +	{						\
> +		.reg = PAD_PULLCTL##pull_reg,		\
> +		.shift = pull_sft,			\
> +		.width = pull_wdt,			\
> +	}
> +
> +#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
> +	struct owl_pullctl pad_name##_pullctl_conf			\
> +		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
> +
> +#define ST_CONF(st_reg, st_sft, st_wdt)			\
> +	{						\
> +		.reg = PAD_ST##st_reg,			\
> +		.shift = st_sft,			\
> +		.width = st_wdt,			\
> +	}
> +
> +#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)	\
> +	struct owl_st pad_name##_st_conf		\
> +		= ST_CONF(st_reg, st_sft, st_wdt)
> +
> +#define PAD_INFO(name)					\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = NULL,			\
> +		.st = NULL,				\
> +	}
> +
> +#define PAD_INFO_ST(name)				\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = NULL,			\
> +		.st = &name##_st_conf,			\
> +	}
> +
> +#define PAD_INFO_PULLCTL(name)				\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = &name##_pullctl_conf,	\
> +		.st = NULL,				\
> +	}
> +
> +#define PAD_INFO_PULLCTL_ST(name)			\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = &name##_pullctl_conf,	\
> +		.st = &name##_st_conf,			\
> +	}
> +
> +#define OWL_GPIO_PORT_A		0
> +#define OWL_GPIO_PORT_B		1
> +#define OWL_GPIO_PORT_C		2
> +#define OWL_GPIO_PORT_D		3
> +#define OWL_GPIO_PORT_E		4
> +#define OWL_GPIO_PORT_F		5
> +
> +#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat, _intc_ctl,\
> +			_intc_pd, _intc_msk, _intc_type, _share)	\
> +	[OWL_GPIO_PORT_##port] = {				\
> +		.offset = base,					\
> +		.pins = count,					\
> +		.outen = _outen,				\
> +		.inen = _inen,					\
> +		.dat = _dat,					\
> +		.intc_ctl = _intc_ctl,				\
> +		.intc_pd = _intc_pd,				\
> +		.intc_msk = _intc_msk,				\
> +		.intc_type = _intc_type,			\
> +		.shared_ctl_offset = _share,			\

Above member addition is not related to this patch. What is the purpose
of this? Either move this to a separate commit if it is needed by S700
or justify in this patch itself.

Btw, this patch is not applying cleanly.

> +	}
> +
>  enum owl_pinconf_pull {
>  	OWL_PINCONF_PULL_HIZ,
>  	OWL_PINCONF_PULL_DOWN,
> @@ -148,6 +278,7 @@ struct owl_gpio_port {
>  	unsigned int intc_pd;
>  	unsigned int intc_msk;
>  	unsigned int intc_type;
> +	u8 shared_ctl_offset;

Same as above.

Regards,
Mani

>  };
>  
>  /**
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index ea67b14ef93b..0597009d8369 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -33,13 +33,6 @@
>  #define PAD_SR1			(0x0274)
>  #define PAD_SR2			(0x0278)
>  
> -#define OWL_GPIO_PORT_A		0
> -#define OWL_GPIO_PORT_B		1
> -#define OWL_GPIO_PORT_C		2
> -#define OWL_GPIO_PORT_D		3
> -#define OWL_GPIO_PORT_E		4
> -#define OWL_GPIO_PORT_F		5
> -
>  #define _GPIOA(offset)		(offset)
>  #define _GPIOB(offset)		(32 + (offset))
>  #define _GPIOC(offset)		(64 + (offset))
> @@ -892,55 +885,6 @@ static unsigned int i2c2_sr_pads[]		= { I2C2_SCLK, I2C2_SDATA };
>  static unsigned int sensor0_sr_pads[]		= { SENSOR0_PCLK,
>  						    SENSOR0_CKOUT };
>  
> -#define MUX_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.funcs = group_name##_funcs,				\
> -		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
> -		.mfpctl_reg  = MFCTL##reg,				\
> -		.mfpctl_shift = shift,					\
> -		.mfpctl_width = width,					\
> -		.drv_reg = -1,						\
> -		.drv_shift = -1,					\
> -		.drv_width = -1,					\
> -		.sr_reg = -1,						\
> -		.sr_shift = -1,						\
> -		.sr_width = -1,						\
> -	}
> -
> -#define DRV_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.mfpctl_reg  = -1,					\
> -		.mfpctl_shift = -1,					\
> -		.mfpctl_width = -1,					\
> -		.drv_reg = PAD_DRV##reg,				\
> -		.drv_shift = shift,					\
> -		.drv_width = width,					\
> -		.sr_reg = -1,						\
> -		.sr_shift = -1,						\
> -		.sr_width = -1,						\
> -	}
> -
> -#define SR_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.mfpctl_reg  = -1,					\
> -		.mfpctl_shift = -1,					\
> -		.mfpctl_width = -1,					\
> -		.drv_reg = -1,						\
> -		.drv_shift = -1,					\
> -		.drv_width = -1,					\
> -		.sr_reg = PAD_SR##reg,					\
> -		.sr_shift = shift,					\
> -		.sr_width = width,					\
> -	}
>  
>  /* Pinctrl groups */
>  static const struct owl_pingroup s900_groups[] = {
> @@ -1442,13 +1386,6 @@ static const char * const sirq2_groups[] = {
>  	"sirq2_dummy",
>  };
>  
> -#define FUNCTION(fname)					\
> -	{						\
> -		.name = #fname,				\
> -		.groups = fname##_groups,		\
> -		.ngroups = ARRAY_SIZE(fname##_groups),	\
> -	}
> -
>  static const struct owl_pinmux_func s900_functions[] = {
>  	[S900_MUX_ERAM] = FUNCTION(eram),
>  	[S900_MUX_ETH_RMII] = FUNCTION(eth_rmii),
> @@ -1500,28 +1437,6 @@ static const struct owl_pinmux_func s900_functions[] = {
>  	[S900_MUX_SIRQ1] = FUNCTION(sirq1),
>  	[S900_MUX_SIRQ2] = FUNCTION(sirq2)
>  };
> -/* PAD PULL UP/DOWN CONFIGURES */
> -#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)			\
> -	{								\
> -		.reg = PAD_PULLCTL##pull_reg,				\
> -		.shift = pull_sft,					\
> -		.width = pull_wdt,					\
> -	}
> -
> -#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
> -	struct owl_pullctl pad_name##_pullctl_conf			\
> -		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
> -
> -#define ST_CONF(st_reg, st_sft, st_wdt)					\
> -	{								\
> -		.reg = PAD_ST##st_reg,					\
> -		.shift = st_sft,					\
> -		.width = st_wdt,					\
> -	}
> -
> -#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)			\
> -	struct owl_st pad_name##_st_conf				\
> -		= ST_CONF(st_reg, st_sft, st_wdt)
>  
>  /* PAD_PULLCTL0 */
>  static PAD_PULLCTL_CONF(ETH_RXER, 0, 18, 2);
> @@ -1639,34 +1554,6 @@ static PAD_ST_CONF(SPI0_SS, 1, 2, 1);
>  static PAD_ST_CONF(I2S_BCLK0, 1, 1, 1);
>  static PAD_ST_CONF(I2S_MCLK0, 1, 0, 1);
>  
> -#define PAD_INFO(name)							\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = NULL,					\
> -		.st = NULL,						\
> -	}
> -
> -#define PAD_INFO_ST(name)						\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = NULL,					\
> -		.st = &name##_st_conf,					\
> -	}
> -
> -#define PAD_INFO_PULLCTL(name)						\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = &name##_pullctl_conf,			\
> -		.st = NULL,						\
> -	}
> -
> -#define PAD_INFO_PULLCTL_ST(name)					\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = &name##_pullctl_conf,			\
> -		.st = &name##_st_conf,					\
> -	}
> -
>  /* Pad info table */
>  static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>  	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
> @@ -1821,27 +1708,13 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>  	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
>  };
>  
> -#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat,		\
> -			_intc_ctl, _intc_pd, _intc_msk, _intc_type)	\
> -	[OWL_GPIO_PORT_##port] = {					\
> -		.offset = base,						\
> -		.pins = count,						\
> -		.outen = _outen,					\
> -		.inen = _inen,						\
> -		.dat = _dat,						\
> -		.intc_ctl = _intc_ctl,					\
> -		.intc_pd = _intc_pd,					\
> -		.intc_msk = _intc_msk,					\
> -		.intc_type = _intc_type,				\
> -	}
> -
>  static const struct owl_gpio_port s900_gpio_ports[] = {
> -	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240),
> -	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C),
> -	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238),
> -	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234),
> -	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230),
> -	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178)
> +	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240, 0),
> +	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C, 0),
> +	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238, 0),
> +	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234, 0),
> +	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230, 0),
> +	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
>  };
>  
>  static struct owl_pinctrl_soc_data s900_pinctrl_data = {
> -- 
> 2.14.4
> 
