Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF98C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4BA20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlHH1HtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4BA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLIE0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:26:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32811 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLIE0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:26:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so3794435pfb.0;
        Sat, 08 Dec 2018 20:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G1PmgWULHeqgE3piJ2tx/wp+P8OL0THtcYt1s2gTQFc=;
        b=FlHH1HtLRX960Xzwz3CbsOKziLm3xPyHpjzinudgzpslgk3/UJ+KBX/qJTSP9SvSGw
         sNfmVKJVVf8IryuSuA+Jv/6aXbu7SzRZCo9YLcJpMfp2j7HUyudLvmA4rWSx7EzJFGrS
         sByvu1uJLhd8d15kNFopu3PYNmY+D8P8sLTy09jQ1Xl9aoz8G0e5XSj5D9AseRDBxMY6
         6ngmMePX5xaorpV+9dLE+dPehdO5rMEqEzMmHBNnS4f5GHLbWtTZHtNy+9mQGiFCUFmK
         x67QqB7hh/NOi6+NFcIF+9c6IU6wLEIFSagKqJbRczKxshOPuJVvHKu6ZOCmefie5bhf
         cteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G1PmgWULHeqgE3piJ2tx/wp+P8OL0THtcYt1s2gTQFc=;
        b=jaOKDbIj8PXB7XzPGD4dnVOeiH2sR1IiMC+haGHYyC0mB+ZCGbN53GqEYCU6v6KFg0
         ZyQcp9P4S5GpyHvO8qA+Oh7frGneKfSJ39/5iZ0r/+fpRhz8NTIAEV+OpLtHjPKwRt6k
         QniYpR2PcNV6YBbA0FQ3P6hWbyuLg0iGjRqdM5TqTDtZNfQl29KpCj6slcrqvLiQRNOh
         XGQznkRFHyBKxnxo6cKNktFFYbIbRKYIwFmDtEflGHIuDnawil+sKTWdEIJsNjxZhA/u
         UBwa0UVH2Hje5io1BErfanS8quOZfubwlETjkJev5W0KtOqo/48bYoxhUIRBXYfA2ku8
         DcFg==
X-Gm-Message-State: AA+aEWaKGBo5ffmNVpL3JW+jkqzoip3rNJ4LG2mH/Y42qOIybHfHuKe7
        7eo18CSdfi9Tki3LCJxoSfo=
X-Google-Smtp-Source: AFSGD/VCLH9luYtFV/clJURCOy5NnMJBSpcox6ONt1E79RY0J8nD21iNwpejVF+HUfyDEqlhrSaJ1g==
X-Received: by 2002:a62:6408:: with SMTP id y8mr7792499pfb.202.1544329576207;
        Sat, 08 Dec 2018 20:26:16 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q75sm10363705pfa.38.2018.12.08.20.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:26:15 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:26:12 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for  optional
 regulators
Message-ID: <20181209042612.GD211094@dtor-ws>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 03:28:55PM +0100, Paweł Chmiel wrote:
> This patch adds optional regulators, which can be used to power
> up touchscreen. After enabling regulators, we need to wait 150msec.
> This value is taken from official driver.
> 
> It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Fix checkpatch issues
>   - Drop sentence punctuation from subject of one of patches
> 
> Changes from v2:
>   - Move code enabling regulators into separate method,
>     to make code more readable.
> 
> Changes from v1:
>   - Enable regulators only if reset_gpio is present.
>   - Switch from devm_regulator_get_optional to devm_regulator_get
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d3aacd534e9c..1dc8ad0da5af 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  #include <asm/unaligned.h>
> @@ -194,10 +195,10 @@ enum t100_type {
>  
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> -#define MXT_RESET_GPIO_TIME	20	/* msec */
>  #define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
> +#define MXT_REGULATOR_DELAY	150	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> @@ -323,6 +324,8 @@ struct mxt_data {
>  	struct t7_config t7_cfg;
>  	struct mxt_dbg dbg;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator *vdd_reg;
> +	struct regulator *avdd_reg;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -3038,6 +3041,38 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
>  	{ }
>  };
>  
> +static int mxt_regulator_enable(struct mxt_data *data)
> +{
> +	int error;
> +
> +	if (data->reset_gpio) {
> +		error = regulator_enable(data->vdd_reg);
> +		if (error) {
> +			dev_err(&data->client->dev,
> +				"Failed to enable vdd regulator: %d\n", error);
> +			return error;
> +		}
> +
> +		error = regulator_enable(data->avdd_reg);
> +		if (error) {
> +			dev_err(&data->client->dev,
> +				"Failed to enable avdd regulator: %d\n", error);

This leaves vdd regulator enabled.

Thanks.

-- 
Dmitry
