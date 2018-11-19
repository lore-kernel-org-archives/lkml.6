Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF2CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE43320851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="JAile/Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE43320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeKSX4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:56:08 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:58422 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbeKSX4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:56:08 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 593A15C20F0;
        Mon, 19 Nov 2018 14:32:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542634347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14AVCgmSKG/SqwXW0CDNZzMZQNwzS1o59KOamYQJjEQ=;
        b=JAile/XruzEE3dYA5qSFKFmXyT4gK9ehrOzd37L3zrUvHC4f1y8RvM4taGnOsMxK3BkvIe
        ZA4NzK/HFdZobVNjAkG/HpkgeWfOteIaDjZVNy0mCcDaBGfTDEB1SN2/48dMa6k+WGafKe
        7vXJgh/KExzLZhWfxc6DPD50zo3shhE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Nov 2018 14:32:27 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
In-Reply-To: <20181119102528.2830-1-dev@pschenker.ch>
References: <20181119102528.2830-1-dev@pschenker.ch>
Message-ID: <f603bcb612866bf68fa8ad00ad70a4df@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2018 11:25, Philippe Schenker wrote:
> Move defines that are ADC related to the header of the overlying mfd,
> so they can be used from multiple sub-devices.

Looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v2:
>  - This is a new added commit. Separate commit for moving the defines out of
>    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device
> drivers/mfd/stmpe.c
>  - Pre-fix defines with STMPE_
> 
>  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
>  include/linux/mfd/stmpe.h            | 11 +++++++++
>  2 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c
> b/drivers/input/touchscreen/stmpe-ts.c
> index 2a78e27b4495..c5d9006588a2 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -49,17 +49,6 @@
>  
>  #define STMPE_IRQ_TOUCH_DET		0
>  
> -#define SAMPLE_TIME(x)			((x & 0xf) << 4)
> -#define MOD_12B(x)			((x & 0x1) << 3)
> -#define REF_SEL(x)			((x & 0x1) << 1)
> -#define ADC_FREQ(x)			(x & 0x3)
> -#define AVE_CTRL(x)			((x & 0x3) << 6)
> -#define DET_DELAY(x)			((x & 0x7) << 3)
> -#define SETTLING(x)			(x & 0x7)
> -#define FRACTION_Z(x)			(x & 0x7)
> -#define I_DRIVE(x)			(x & 0x1)
> -#define OP_MODE(x)			((x & 0x7) << 1)
> -
>  #define STMPE_TS_NAME			"stmpe-ts"
>  #define XY_MASK				0xfff
>  
> @@ -213,9 +202,10 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  		return ret;
>  	}
>  
> -	adc_ctrl1 = SAMPLE_TIME(ts->sample_time) | MOD_12B(ts->mod_12b) |
> -		REF_SEL(ts->ref_sel);
> -	adc_ctrl1_mask = SAMPLE_TIME(0xff) | MOD_12B(0xff) | REF_SEL(0xff);
> +	adc_ctrl1 = STMPE_SAMPLE_TIME(ts->sample_time) |
> +		    STMPE_MOD_12B(ts->mod_12b) | STMPE_REF_SEL(ts->ref_sel);
> +	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
> +			 STMPE_REF_SEL(0xff);
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
>  			adc_ctrl1_mask, adc_ctrl1);
> @@ -225,15 +215,17 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
> -			ADC_FREQ(0xff), ADC_FREQ(ts->adc_freq));
> +			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(ts->adc_freq));
>  	if (ret) {
>  		dev_err(dev, "Could not setup ADC\n");
>  		return ret;
>  	}
>  
> -	tsc_cfg = AVE_CTRL(ts->ave_ctrl) | DET_DELAY(ts->touch_det_delay) |
> -			SETTLING(ts->settling);
> -	tsc_cfg_mask = AVE_CTRL(0xff) | DET_DELAY(0xff) | SETTLING(0xff);
> +	tsc_cfg = STMPE_AVE_CTRL(ts->ave_ctrl) |
> +		  STMPE_DET_DELAY(ts->touch_det_delay) |
> +		  STMPE_SETTLING(ts->settling);
> +	tsc_cfg_mask = STMPE_AVE_CTRL(0xff) | STMPE_DET_DELAY(0xff) |
> +		       STMPE_SETTLING(0xff);
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CFG, tsc_cfg_mask, tsc_cfg);
>  	if (ret) {
> @@ -242,14 +234,14 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_FRACTION_Z,
> -			FRACTION_Z(0xff), FRACTION_Z(ts->fraction_z));
> +			STMPE_FRACTION_Z(0xff), STMPE_FRACTION_Z(ts->fraction_z));
>  	if (ret) {
>  		dev_err(dev, "Could not config touch\n");
>  		return ret;
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_I_DRIVE,
> -			I_DRIVE(0xff), I_DRIVE(ts->i_drive));
> +			STMPE_I_DRIVE(0xff), STMPE_I_DRIVE(ts->i_drive));
>  	if (ret) {
>  		dev_err(dev, "Could not config touch\n");
>  		return ret;
> @@ -263,7 +255,7 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CTRL,
> -			OP_MODE(0xff), OP_MODE(OP_MOD_XYZ));
> +			STMPE_OP_MODE(0xff), STMPE_OP_MODE(OP_MOD_XYZ));
>  	if (ret) {
>  		dev_err(dev, "Could not set mode\n");
>  		return ret;
> diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> index 4a827af17e59..c0353f6431f9 100644
> --- a/include/linux/mfd/stmpe.h
> +++ b/include/linux/mfd/stmpe.h
> @@ -10,6 +10,17 @@
>  
>  #include <linux/mutex.h>
>  
> +#define STMPE_SAMPLE_TIME(x)	((x & 0xf) << 4)
> +#define STMPE_MOD_12B(x)	((x & 0x1) << 3)
> +#define STMPE_REF_SEL(x)	((x & 0x1) << 1)
> +#define STMPE_ADC_FREQ(x)	(x & 0x3)
> +#define STMPE_AVE_CTRL(x)	((x & 0x3) << 6)
> +#define STMPE_DET_DELAY(x)	((x & 0x7) << 3)
> +#define STMPE_SETTLING(x)	(x & 0x7)
> +#define STMPE_FRACTION_Z(x)	(x & 0x7)
> +#define STMPE_I_DRIVE(x)	(x & 0x1)
> +#define STMPE_OP_MODE(x)	((x & 0x7) << 1)
> +
>  struct device;
>  struct regulator;
