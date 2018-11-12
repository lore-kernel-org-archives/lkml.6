Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3138C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E302223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E302223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeKMCXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:23:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:51779 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbeKMCXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:23:07 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42tx693CVgz1qxl0;
        Mon, 12 Nov 2018 17:29:04 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42tx675wS5z1qr26;
        Mon, 12 Nov 2018 17:29:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id S_Mg0KhSw4ME; Mon, 12 Nov 2018 17:29:01 +0100 (CET)
X-Auth-Info: i2w8LpZW84h+6tk/cSnXNqGCLylluQU/meBMpA+pwZ4=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 12 Nov 2018 17:29:01 +0100 (CET)
Cc:     pn@denx.de, linus.walleij@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH v5 2/5] pinctrl: actions: define pad control configurtion
 to SoC specific
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
 <20180829082413.2512005-3-sravanhome@gmail.com>
 <20180829153214.GB21136@Mani-XPS-13-9360>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <84074dd8-5466-936e-7b81-52280b433ee0@denx.de>
Date:   Mon, 12 Nov 2018 17:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180829153214.GB21136@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/18 5:32 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 29, 2018 at 10:24:10AM +0200, Saravanan Sekar wrote:
>> pad control for s900 and s700 are differs in number of
>> pull control configuraions
>> s900 has 4 pull controls - high impedence, pull up, pull down, repeater
>> s700, s500 has 2 pull controls - pull up and pull down
>>
>> so pad control configuration has to SoC specific, moved out from pinctrl
>> common to s700, s900 specific.
>>
> 
> This patch is not adding anything for S700 so no need to mention it in
> last line.

Agreed!

> 
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   drivers/pinctrl/actions/pinctrl-owl.c  | 64 +++++----------------------------
>>   drivers/pinctrl/actions/pinctrl-owl.h  | 13 ++++---
>>   drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++++++++++-
>>   3 files changed, 79 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
>> index 9d18c02f192b..cc242d6a47c3 100644
>> --- a/drivers/pinctrl/actions/pinctrl-owl.c
>> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
>> @@ -246,60 +246,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
>>   	return 0;
>>   }
>>   
>> -static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
>> -				unsigned int param,
>> -				u32 *arg)
>> -{
>> -	switch (param) {
>> -	case PIN_CONFIG_BIAS_BUS_HOLD:
>> -		*arg = OWL_PINCONF_PULL_HOLD;
>> -		break;
>> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>> -		*arg = OWL_PINCONF_PULL_HIZ;
>> -		break;
>> -	case PIN_CONFIG_BIAS_PULL_DOWN:
>> -		*arg = OWL_PINCONF_PULL_DOWN;
>> -		break;
>> -	case PIN_CONFIG_BIAS_PULL_UP:
>> -		*arg = OWL_PINCONF_PULL_UP;
>> -		break;
>> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>> -		*arg = (*arg >= 1 ? 1 : 0);
>> -		break;
>> -	default:
>> -		return -ENOTSUPP;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
>> -				unsigned int param,
>> -				u32 *arg)
>> -{
>> -	switch (param) {
>> -	case PIN_CONFIG_BIAS_BUS_HOLD:
>> -		*arg = *arg == OWL_PINCONF_PULL_HOLD;
>> -		break;
>> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>> -		*arg = *arg == OWL_PINCONF_PULL_HIZ;
>> -		break;
>> -	case PIN_CONFIG_BIAS_PULL_DOWN:
>> -		*arg = *arg == OWL_PINCONF_PULL_DOWN;
>> -		break;
>> -	case PIN_CONFIG_BIAS_PULL_UP:
>> -		*arg = *arg == OWL_PINCONF_PULL_UP;
>> -		break;
>> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>> -		*arg = *arg == 1;
>> -		break;
>> -	default:
>> -		return -ENOTSUPP;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>>   				unsigned int pin,
>>   				unsigned long *config)
>> @@ -318,7 +264,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>>   
>>   	arg = owl_read_field(pctrl, reg, bit, width);
>>   
>> -	ret = owl_pad_pinconf_val2arg(info, param, &arg);
>> +	if (!pctrl->soc->padctl_val2arg)
>> +		return -ENOTSUPP;
>> +
>> +	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -349,7 +298,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
>>   		if (ret)
>>   			return ret;
>>   
>> -		ret = owl_pad_pinconf_arg2val(info, param, &arg);
>> +		if (!pctrl->soc->padctl_arg2val)
>> +			return -ENOTSUPP;
>> +
>> +		ret = pctrl->soc->padctl_arg2val(info, param, &arg);
>>   		if (ret)
>>   			return ret;
>>   
>> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
>> index 31cc33d7c4a5..dae2e8363fd5 100644
>> --- a/drivers/pinctrl/actions/pinctrl-owl.h
>> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
>> @@ -145,13 +145,6 @@
>>   		.shared_ctl_offset = _share,			\
>>   	}
>>   
>> -enum owl_pinconf_pull {
>> -	OWL_PINCONF_PULL_HIZ,
>> -	OWL_PINCONF_PULL_DOWN,
>> -	OWL_PINCONF_PULL_UP,
>> -	OWL_PINCONF_PULL_HOLD,
>> -};
>> -
>>   enum owl_pinconf_drv {
>>   	OWL_PINCONF_DRV_2MA,
>>   	OWL_PINCONF_DRV_4MA,
>> @@ -305,6 +298,12 @@ struct owl_pinctrl_soc_data {
>>   	unsigned int ngpios;
>>   	const struct owl_gpio_port *ports;
>>   	unsigned int nports;
>> +	int (*padctl_val2arg)(const struct owl_padinfo *padinfo,
>> +				unsigned int param,
>> +				u32 *arg);
>> +	int (*padctl_arg2val)(const struct owl_padinfo *info,
>> +				unsigned int param,
>> +				u32 *arg);
>>   };
>>   
>>   int owl_pinctrl_probe(struct platform_device *pdev,
>> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
>> index 0597009d8369..2e19fecbe5e9 100644
>> --- a/drivers/pinctrl/actions/pinctrl-s900.c
>> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pinctrl/pinctrl.h>
>> +#include <linux/pinctrl/pinconf-generic.h>
>>   #include "pinctrl-owl.h"
>>   
>>   /* Pinctrl registers offset */
>> @@ -1717,6 +1718,67 @@ static const struct owl_gpio_port s900_gpio_ports[] = {
>>   	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
>>   };
>>   
>> +enum owl_pinconf_pull {
> 
> Since this enum is SoC specific, it could be s900_pinconf_pull.

Agreed!

Thanks,
Parthi

> 
> Regards,
> Mani
> 
>> +	OWL_PINCONF_PULL_HIZ,
>> +	OWL_PINCONF_PULL_DOWN,
>> +	OWL_PINCONF_PULL_UP,
>> +	OWL_PINCONF_PULL_HOLD,
>> +};
>> +
>> +static int s900_pad_pinconf_arg2val(const struct owl_padinfo *info,
>> +				unsigned int param,
>> +				u32 *arg)
>> +{
>> +	switch (param) {
>> +	case PIN_CONFIG_BIAS_BUS_HOLD:
>> +		*arg = OWL_PINCONF_PULL_HOLD;
>> +		break;
>> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>> +		*arg = OWL_PINCONF_PULL_HIZ;
>> +		break;
>> +	case PIN_CONFIG_BIAS_PULL_DOWN:
>> +		*arg = OWL_PINCONF_PULL_DOWN;
>> +		break;
>> +	case PIN_CONFIG_BIAS_PULL_UP:
>> +		*arg = OWL_PINCONF_PULL_UP;
>> +		break;
>> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>> +		*arg = (*arg >= 1 ? 1 : 0);
>> +		break;
>> +	default:
>> +		return -ENOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int s900_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
>> +				unsigned int param,
>> +				u32 *arg)
>> +{
>> +	switch (param) {
>> +	case PIN_CONFIG_BIAS_BUS_HOLD:
>> +		*arg = *arg == OWL_PINCONF_PULL_HOLD;
>> +		break;
>> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>> +		*arg = *arg == OWL_PINCONF_PULL_HIZ;
>> +		break;
>> +	case PIN_CONFIG_BIAS_PULL_DOWN:
>> +		*arg = *arg == OWL_PINCONF_PULL_DOWN;
>> +		break;
>> +	case PIN_CONFIG_BIAS_PULL_UP:
>> +		*arg = *arg == OWL_PINCONF_PULL_UP;
>> +		break;
>> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>> +		*arg = *arg == 1;
>> +		break;
>> +	default:
>> +		return -ENOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>>   	.padinfo = s900_padinfo,
>>   	.pins = (const struct pinctrl_pin_desc *)s900_pads,
>> @@ -1727,7 +1789,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>>   	.ngroups = ARRAY_SIZE(s900_groups),
>>   	.ngpios = NUM_GPIOS,
>>   	.ports = s900_gpio_ports,
>> -	.nports = ARRAY_SIZE(s900_gpio_ports)
>> +	.nports = ARRAY_SIZE(s900_gpio_ports),
>> +	.padctl_arg2val = s900_pad_pinconf_arg2val,
>> +	.padctl_val2arg = s900_pad_pinconf_val2arg,
>>   };
>>   
>>   static int s900_pinctrl_probe(struct platform_device *pdev)
>> -- 
>> 2.14.4
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de
