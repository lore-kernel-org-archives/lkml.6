Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA404C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAD02073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwZG+k0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAD02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIDXIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:08:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52320 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIDXIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:08:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so5435250wmc.2;
        Tue, 04 Sep 2018 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LJLGISOTBQoTnwlbKU3xx0t2fRN1JQmgwGb6cXA/LXc=;
        b=bwZG+k0g4Bb7KvDcK1quOQYyCTnMZVNYPkahNAdGNM7yUMz2ro3BbJXE2rfkGMcIWe
         7XLwjAX72gOCR5CtNFXAf3wwlLdQa3tkyAUcnLkXi8K6X0uUF8MexIsRQZ77uLbBjlpv
         8xIDXqz2WXNhGk4ky5SKVvQo/x2JkeL6Ckdn8Tktap1KNKdFbfGuX24JCD+4YXEp7/U9
         OCVq/ylIFxK7HkMM7iN3YOKrLP+qTnpoKeJcnPWrGvV+LVROnDK8Q1UV3A8W/17WG+tH
         Jd1pOeb0uAkauNXAmwNtKKvqTkeZknFDgnSnf1rELiJ+2gewuktvKHHuJOE+X3P3MaBv
         ml0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJLGISOTBQoTnwlbKU3xx0t2fRN1JQmgwGb6cXA/LXc=;
        b=Ts5g567df2Bxuri5bQjUkebqi46qzJd8CriOG7ZDg1Tar09/6sy+ZPz3t1d2lRohwU
         UlDzkHQvHn0Vhr6hJMywXX2zpGrfFgPrKjovlXG2dMTuiVR3EcYJyqJguq3PyZfoHH7X
         nZ0BT65Q69GOtjmYBjucl7hDh8TGp0xglTPmcE2gVjoQfgyd4JhUJ8Wu098AFqrJsqyB
         cze1yTu+4j3PbNsd+qiplyS5gdr+hvYynpINMKwN8iYKfgxIzAArwy2bMY8+FxHI8Jet
         ibJM6LTWjkaziYIZouI/g4jA/Gy1m7jT4t6JEe3wWXaLmh+Ngb6F+Adu4stxWINac+vI
         Y2eA==
X-Gm-Message-State: APzg51A6cQjgmxQADUP8Mt+cVgmqq87AeShBkUomcoUOVuYcHoWMtkSK
        agwm1OKvv/M0fwgB7g+Decg=
X-Google-Smtp-Source: ANB0VdbJVjCbbs21uDFrOPk9kvEq3DV2hOKAZKOr6wGk3qVXoXZrvIDMm6heN8bL16W9NSKQRK6tBQ==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr8960346wma.101.1536086540117;
        Tue, 04 Sep 2018 11:42:20 -0700 (PDT)
Received: from [192.168.0.103] (p5B3F702C.dip0.t-ipconnect.de. [91.63.112.44])
        by smtp.gmail.com with ESMTPSA id j6-v6sm19494696wrq.25.2018.09.04.11.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:42:19 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] pinctrl: actions: define constructor generic to
 Actions Semi SoC's
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
References: <20180829082413.2512005-1-sravanhome@gmail.com>
 <20180829082413.2512005-2-sravanhome@gmail.com>
 <20180829152049.GA21136@Mani-XPS-13-9360>
From:   Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <7fc376ac-5998-57b6-8989-908d7a0abfd0@gmail.com>
Date:   Tue, 4 Sep 2018 20:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829152049.GA21136@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/18 17:20, Manivannan Sadhasivam wrote:
> Hi Saravanan,
> 
> On Wed, Aug 29, 2018 at 10:24:09AM +0200, Saravanan Sekar wrote:
>> Move generic defines common to the Owl family out of S900 driver.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   drivers/pinctrl/actions/pinctrl-owl.h  | 131 +++++++++++++++++++++++++++++++
>>   drivers/pinctrl/actions/pinctrl-s900.c | 139 ++-------------------------------
>>   2 files changed, 137 insertions(+), 133 deletions(-)
>>
>> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
>> index a724d1d406d4..31cc33d7c4a5 100644
>> --- a/drivers/pinctrl/actions/pinctrl-owl.h
>> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
>> @@ -15,6 +15,136 @@
>>   #define OWL_PINCONF_SLEW_SLOW 0
>>   #define OWL_PINCONF_SLEW_FAST 1
>>   
>> +#define MUX_PG(group_name, reg, shift, width)				\
>> +	{								\
>> +		.name = #group_name,					\
>> +		.pads = group_name##_pads,				\
>> +		.npads = ARRAY_SIZE(group_name##_pads),			\
>> +		.funcs = group_name##_funcs,				\
>> +		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
>> +		.mfpctl_reg  = MFCTL##reg,				\
>> +		.mfpctl_shift = shift,					\
>> +		.mfpctl_width = width,					\
>> +		.drv_reg = -1,						\
>> +		.drv_shift = -1,					\
>> +		.drv_width = -1,					\
>> +		.sr_reg = -1,						\
>> +		.sr_shift = -1,						\
>> +		.sr_width = -1,						\
>> +	}
>> +
>> +#define DRV_PG(group_name, reg, shift, width)				\
>> +	{								\
>> +		.name = #group_name,					\
>> +		.pads = group_name##_pads,				\
>> +		.npads = ARRAY_SIZE(group_name##_pads),			\
>> +		.mfpctl_reg  = -1,					\
>> +		.mfpctl_shift = -1,					\
>> +		.mfpctl_width = -1,					\
>> +		.drv_reg = PAD_DRV##reg,				\
>> +		.drv_shift = shift,					\
>> +		.drv_width = width,					\
>> +		.sr_reg = -1,						\
>> +		.sr_shift = -1,						\
>> +		.sr_width = -1,						\
>> +	}
>> +
>> +#define SR_PG(group_name, reg, shift, width)				\
>> +	{								\
>> +		.name = #group_name,					\
>> +		.pads = group_name##_pads,				\
>> +		.npads = ARRAY_SIZE(group_name##_pads),			\
>> +		.mfpctl_reg  = -1,					\
>> +		.mfpctl_shift = -1,					\
>> +		.mfpctl_width = -1,					\
>> +		.drv_reg = -1,						\
>> +		.drv_shift = -1,					\
>> +		.drv_width = -1,					\
>> +		.sr_reg = PAD_SR##reg,					\
>> +		.sr_shift = shift,					\
>> +		.sr_width = width,					\
>> +	}
>> +
>> +#define FUNCTION(fname)					\
>> +	{						\
>> +		.name = #fname,				\
>> +		.groups = fname##_groups,		\
>> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
>> +	}
>> +
>> +/* PAD PULL UP/DOWN CONFIGURES */
>> +#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)	\
>> +	{						\
>> +		.reg = PAD_PULLCTL##pull_reg,		\
>> +		.shift = pull_sft,			\
>> +		.width = pull_wdt,			\
>> +	}
>> +
>> +#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
>> +	struct owl_pullctl pad_name##_pullctl_conf			\
>> +		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
>> +
>> +#define ST_CONF(st_reg, st_sft, st_wdt)			\
>> +	{						\
>> +		.reg = PAD_ST##st_reg,			\
>> +		.shift = st_sft,			\
>> +		.width = st_wdt,			\
>> +	}
>> +
>> +#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)	\
>> +	struct owl_st pad_name##_st_conf		\
>> +		= ST_CONF(st_reg, st_sft, st_wdt)
>> +
>> +#define PAD_INFO(name)					\
>> +	{						\
>> +		.pad = name,				\
>> +		.pullctl = NULL,			\
>> +		.st = NULL,				\
>> +	}
>> +
>> +#define PAD_INFO_ST(name)				\
>> +	{						\
>> +		.pad = name,				\
>> +		.pullctl = NULL,			\
>> +		.st = &name##_st_conf,			\
>> +	}
>> +
>> +#define PAD_INFO_PULLCTL(name)				\
>> +	{						\
>> +		.pad = name,				\
>> +		.pullctl = &name##_pullctl_conf,	\
>> +		.st = NULL,				\
>> +	}
>> +
>> +#define PAD_INFO_PULLCTL_ST(name)			\
>> +	{						\
>> +		.pad = name,				\
>> +		.pullctl = &name##_pullctl_conf,	\
>> +		.st = &name##_st_conf,			\
>> +	}
>> +
>> +#define OWL_GPIO_PORT_A		0
>> +#define OWL_GPIO_PORT_B		1
>> +#define OWL_GPIO_PORT_C		2
>> +#define OWL_GPIO_PORT_D		3
>> +#define OWL_GPIO_PORT_E		4
>> +#define OWL_GPIO_PORT_F		5
>> +
>> +#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat, _intc_ctl,\
>> +			_intc_pd, _intc_msk, _intc_type, _share)	\
>> +	[OWL_GPIO_PORT_##port] = {				\
>> +		.offset = base,					\
>> +		.pins = count,					\
>> +		.outen = _outen,				\
>> +		.inen = _inen,					\
>> +		.dat = _dat,					\
>> +		.intc_ctl = _intc_ctl,				\
>> +		.intc_pd = _intc_pd,				\
>> +		.intc_msk = _intc_msk,				\
>> +		.intc_type = _intc_type,			\
>> +		.shared_ctl_offset = _share,			\
> 
> Above member addition is not related to this patch. What is the purpose
> of this? Either move this to a separate commit if it is needed by S700
> or justify in this patch itself.
>

This is introduced for S700 as registers are shared, it is not case in
S900. There is impact on S900 also, which needs another seperate patch
which is unlikely as we cleaning S700 related stuffs here

> Btw, this patch is not applying cleanly.
> 
>> +	}
>> +
>>   enum owl_pinconf_pull {
>>   	OWL_PINCONF_PULL_HIZ,
>>   	OWL_PINCONF_PULL_DOWN,
>> @@ -148,6 +278,7 @@ struct owl_gpio_port {
>>   	unsigned int intc_pd;
>>   	unsigned int intc_msk;
>>   	unsigned int intc_type;
>> +	u8 shared_ctl_offset;
> 
> Same as above.
> 
> Regards,
> Mani
> 
>>   };
>>   
>>   /**
>> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
>> index ea67b14ef93b..0597009d8369 100644
>> --- a/drivers/pinctrl/actions/pinctrl-s900.c
>> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
>> @@ -33,13 +33,6 @@
>>   #define PAD_SR1			(0x0274)
>>   #define PAD_SR2			(0x0278)
>>   
>> -#define OWL_GPIO_PORT_A		0
>> -#define OWL_GPIO_PORT_B		1
>> -#define OWL_GPIO_PORT_C		2
>> -#define OWL_GPIO_PORT_D		3
>> -#define OWL_GPIO_PORT_E		4
>> -#define OWL_GPIO_PORT_F		5
>> -
>>   #define _GPIOA(offset)		(offset)
>>   #define _GPIOB(offset)		(32 + (offset))
>>   #define _GPIOC(offset)		(64 + (offset))
>> @@ -892,55 +885,6 @@ static unsigned int i2c2_sr_pads[]		= { I2C2_SCLK, I2C2_SDATA };
>>   static unsigned int sensor0_sr_pads[]		= { SENSOR0_PCLK,
>>   						    SENSOR0_CKOUT };
>>   
>> -#define MUX_PG(group_name, reg, shift, width)				\
>> -	{								\
>> -		.name = #group_name,					\
>> -		.pads = group_name##_pads,				\
>> -		.npads = ARRAY_SIZE(group_name##_pads),			\
>> -		.funcs = group_name##_funcs,				\
>> -		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
>> -		.mfpctl_reg  = MFCTL##reg,				\
>> -		.mfpctl_shift = shift,					\
>> -		.mfpctl_width = width,					\
>> -		.drv_reg = -1,						\
>> -		.drv_shift = -1,					\
>> -		.drv_width = -1,					\
>> -		.sr_reg = -1,						\
>> -		.sr_shift = -1,						\
>> -		.sr_width = -1,						\
>> -	}
>> -
>> -#define DRV_PG(group_name, reg, shift, width)				\
>> -	{								\
>> -		.name = #group_name,					\
>> -		.pads = group_name##_pads,				\
>> -		.npads = ARRAY_SIZE(group_name##_pads),			\
>> -		.mfpctl_reg  = -1,					\
>> -		.mfpctl_shift = -1,					\
>> -		.mfpctl_width = -1,					\
>> -		.drv_reg = PAD_DRV##reg,				\
>> -		.drv_shift = shift,					\
>> -		.drv_width = width,					\
>> -		.sr_reg = -1,						\
>> -		.sr_shift = -1,						\
>> -		.sr_width = -1,						\
>> -	}
>> -
>> -#define SR_PG(group_name, reg, shift, width)				\
>> -	{								\
>> -		.name = #group_name,					\
>> -		.pads = group_name##_pads,				\
>> -		.npads = ARRAY_SIZE(group_name##_pads),			\
>> -		.mfpctl_reg  = -1,					\
>> -		.mfpctl_shift = -1,					\
>> -		.mfpctl_width = -1,					\
>> -		.drv_reg = -1,						\
>> -		.drv_shift = -1,					\
>> -		.drv_width = -1,					\
>> -		.sr_reg = PAD_SR##reg,					\
>> -		.sr_shift = shift,					\
>> -		.sr_width = width,					\
>> -	}
>>   
>>   /* Pinctrl groups */
>>   static const struct owl_pingroup s900_groups[] = {
>> @@ -1442,13 +1386,6 @@ static const char * const sirq2_groups[] = {
>>   	"sirq2_dummy",
>>   };
>>   
>> -#define FUNCTION(fname)					\
>> -	{						\
>> -		.name = #fname,				\
>> -		.groups = fname##_groups,		\
>> -		.ngroups = ARRAY_SIZE(fname##_groups),	\
>> -	}
>> -
>>   static const struct owl_pinmux_func s900_functions[] = {
>>   	[S900_MUX_ERAM] = FUNCTION(eram),
>>   	[S900_MUX_ETH_RMII] = FUNCTION(eth_rmii),
>> @@ -1500,28 +1437,6 @@ static const struct owl_pinmux_func s900_functions[] = {
>>   	[S900_MUX_SIRQ1] = FUNCTION(sirq1),
>>   	[S900_MUX_SIRQ2] = FUNCTION(sirq2)
>>   };
>> -/* PAD PULL UP/DOWN CONFIGURES */
>> -#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)			\
>> -	{								\
>> -		.reg = PAD_PULLCTL##pull_reg,				\
>> -		.shift = pull_sft,					\
>> -		.width = pull_wdt,					\
>> -	}
>> -
>> -#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
>> -	struct owl_pullctl pad_name##_pullctl_conf			\
>> -		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
>> -
>> -#define ST_CONF(st_reg, st_sft, st_wdt)					\
>> -	{								\
>> -		.reg = PAD_ST##st_reg,					\
>> -		.shift = st_sft,					\
>> -		.width = st_wdt,					\
>> -	}
>> -
>> -#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)			\
>> -	struct owl_st pad_name##_st_conf				\
>> -		= ST_CONF(st_reg, st_sft, st_wdt)
>>   
>>   /* PAD_PULLCTL0 */
>>   static PAD_PULLCTL_CONF(ETH_RXER, 0, 18, 2);
>> @@ -1639,34 +1554,6 @@ static PAD_ST_CONF(SPI0_SS, 1, 2, 1);
>>   static PAD_ST_CONF(I2S_BCLK0, 1, 1, 1);
>>   static PAD_ST_CONF(I2S_MCLK0, 1, 0, 1);
>>   
>> -#define PAD_INFO(name)							\
>> -	{								\
>> -		.pad = name,						\
>> -		.pullctl = NULL,					\
>> -		.st = NULL,						\
>> -	}
>> -
>> -#define PAD_INFO_ST(name)						\
>> -	{								\
>> -		.pad = name,						\
>> -		.pullctl = NULL,					\
>> -		.st = &name##_st_conf,					\
>> -	}
>> -
>> -#define PAD_INFO_PULLCTL(name)						\
>> -	{								\
>> -		.pad = name,						\
>> -		.pullctl = &name##_pullctl_conf,			\
>> -		.st = NULL,						\
>> -	}
>> -
>> -#define PAD_INFO_PULLCTL_ST(name)					\
>> -	{								\
>> -		.pad = name,						\
>> -		.pullctl = &name##_pullctl_conf,			\
>> -		.st = &name##_st_conf,					\
>> -	}
>> -
>>   /* Pad info table */
>>   static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>>   	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
>> @@ -1821,27 +1708,13 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>>   	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
>>   };
>>   
>> -#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat,		\
>> -			_intc_ctl, _intc_pd, _intc_msk, _intc_type)	\
>> -	[OWL_GPIO_PORT_##port] = {					\
>> -		.offset = base,						\
>> -		.pins = count,						\
>> -		.outen = _outen,					\
>> -		.inen = _inen,						\
>> -		.dat = _dat,						\
>> -		.intc_ctl = _intc_ctl,					\
>> -		.intc_pd = _intc_pd,					\
>> -		.intc_msk = _intc_msk,					\
>> -		.intc_type = _intc_type,				\
>> -	}
>> -
>>   static const struct owl_gpio_port s900_gpio_ports[] = {
>> -	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240),
>> -	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C),
>> -	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238),
>> -	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234),
>> -	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230),
>> -	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178)
>> +	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240, 0),
>> +	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C, 0),
>> +	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238, 0),
>> +	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234, 0),
>> +	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230, 0),
>> +	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
>>   };
>>   
>>   static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>> -- 
>> 2.14.4
>>
