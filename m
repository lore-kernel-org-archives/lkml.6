Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430EC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E6E20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M05H5R2W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W+Yplae+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E6E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeILVwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:52:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeILVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:52:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37DD6606AC; Wed, 12 Sep 2018 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536770851;
        bh=YMmpXTSh/d4awGyY5iPadg4/lp3MS8RbUcT7OLNjdzk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M05H5R2WBQRvI05ehbWl60gNQ7tKVKb0oIkXWs8Ybt/n1MUiMLqjmnkqON3lJbI5G
         qp4WwdzEuDQNaAxyjZU/RfEOpcXkOzkOrfRs6GKXybCVMb5/wEIgUC6NWnEvg8EJg/
         ciM/z0a1a7JXaWdC1Fn4FByOiCnDvfXnVTezelzo=
Received: from [192.168.100.6] (unknown [183.83.160.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E2C5600ED;
        Wed, 12 Sep 2018 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536770850;
        bh=YMmpXTSh/d4awGyY5iPadg4/lp3MS8RbUcT7OLNjdzk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W+Yplae+rieopH4uRReRC1INPzwx1+4aehYvC4iXnc/H+0q/omziT5HAGCAqNopAS
         iTFpo7xNRO4Bvc/nVKw/ZFek74mdYEyVzEXGNNftLwFxbF8RtBv++c8gO0SaGXFtBQ
         Ujgn4wbbjxL9BK41iakvCyZIPncU7gfuwMgVRcG8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E2C5600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: max98927: Add reset-gpio support
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        dgreid@chromium.org, ryans.lee@maximintegrated.com
References: <20180912121955.33048-1-cychiang@chromium.org>
 <20180912121955.33048-2-cychiang@chromium.org>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <7aa3c049-5ba0-1db3-08c8-510da1cf779d@codeaurora.org>
Date:   Wed, 12 Sep 2018 22:17:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912121955.33048-2-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2018 5:49 PM, Cheng-Yi Chiang wrote:
> Toggle reset line in max98927_i2c_probe.
> Use a list to store max98927 instances so we do not toggle reset line
> again if more than one instances share the same reset line.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>

> ---
>   sound/soc/codecs/max98927.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/codecs/max98927.h |  2 ++
>   2 files changed, 80 insertions(+)
>
> diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
> index 941712058a8f5..789b27cdfd9e0 100644
> --- a/sound/soc/codecs/max98927.c
> +++ b/sound/soc/codecs/max98927.c
> @@ -11,6 +11,7 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/delay.h>
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/regmap.h>
> @@ -24,6 +25,11 @@
>   #include <sound/tlv.h>
>   #include "max98927.h"
>   
> +#define MAX98927_MIN_RESET_US 1
> +#define MAX98927_RELEASE_RESET_DELAY_US 500
> +
> +static LIST_HEAD(reset_list);
> +
>   static struct reg_default max98927_reg[] = {
>   	{MAX98927_R0001_INT_RAW1,  0x00},
>   	{MAX98927_R0002_INT_RAW2,  0x00},
> @@ -877,6 +883,54 @@ static void max98927_slot_config(struct i2c_client *i2c,
>   		max98927->i_l_slot = 1;
>   }
>   
> +static int max98927_i2c_toggle_reset(struct device *dev,
> +				     struct max98927_priv *max98927)
> +{
> +	/*
> +	 * If we do not have reset gpio, assume platform firmware
> +	 * controls the regulator and toggles it for us.
> +	 */
> +	if (!max98927->reset_gpio)
> +		return 0;
> +
> +	gpiod_set_value_cansleep(max98927->reset_gpio, 1);
> +
> +	/*
> +	 * We need to wait a bit before we are allowed to release reset GPIO.
> +	 */
> +	usleep_range(MAX98927_MIN_RESET_US, MAX98927_MIN_RESET_US + 5);
> +
> +	gpiod_set_value_cansleep(max98927->reset_gpio, 0);
> +
> +	/*
> +	 * We need to wait a bit before I2C communication is available.
> +	 */
> +	usleep_range(MAX98927_RELEASE_RESET_DELAY_US,
> +		     MAX98927_RELEASE_RESET_DELAY_US + 5);
> +
> +	/*
> +	 * Release reset GPIO because we are not going to use it.
> +	 */
> +	devm_gpiod_put(dev, max98927->reset_gpio);
> +
> +	return 0;
> +}
> +
> +static bool max98927_is_first_to_reset(struct max98927_priv *max98927)
> +{
> +	struct max98927_priv *p;
> +
> +	if (!max98927->reset_gpio)
> +		return false;
> +
> +	list_for_each_entry(p, &reset_list, list) {
> +		if (max98927->reset_gpio == p->reset_gpio)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int max98927_i2c_probe(struct i2c_client *i2c,
>   	const struct i2c_device_id *id)
>   {
> @@ -904,6 +958,28 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>   	} else
>   		max98927->interleave_mode = 0;
>   
> +	/* Gets optional GPIO for reset line. */
> +	max98927->reset_gpio = devm_gpiod_get_optional(
> +			&i2c->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(max98927->reset_gpio)) {
> +		ret = PTR_ERR(max98927->reset_gpio);
> +		dev_err(&i2c->dev, "error getting reset gpio: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Only toggle reset line for the first instance when the
> +	 * reset line is shared among instances. For example,
> +	 * left and right amplifier share the same reset line, and
> +	 * we should only toggle the reset line once.
> +	 */
> +	if (max98927_is_first_to_reset(max98927)) {
> +		dev_info(&i2c->dev, "%s: toggle reset line\n", __func__);
> +		ret = max98927_i2c_toggle_reset(&i2c->dev, max98927);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* regmap initialization */
>   	max98927->regmap
>   		= devm_regmap_init_i2c(i2c, &max98927_regmap);
> @@ -934,6 +1010,8 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>   	if (ret < 0)
>   		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
>   
> +	list_add(&max98927->list, &reset_list);
> +
>   	return ret;
>   }
>   
> diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
> index 538992a238b28..d48f61f6c3ba5 100644
> --- a/sound/soc/codecs/max98927.h
> +++ b/sound/soc/codecs/max98927.h
> @@ -275,5 +275,7 @@ struct max98927_priv {
>   	unsigned int master;
>   	unsigned int digital_gain;
>   	bool tdm_mode;
> +	struct gpio_desc *reset_gpio;
> +	struct list_head list;
>   };
>   #endif

