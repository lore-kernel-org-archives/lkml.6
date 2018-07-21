Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDE42064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqXTqobj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDE42064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeGUQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:29:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33584 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbeGUQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:29:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so9196223pgv.0;
        Sat, 21 Jul 2018 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUNIMITNEMPND9L/exZheJEomP6Hb47+3IW6UOzknnk=;
        b=MqXTqobjcjIFi4JEIViQdrtJoOrzw+0VrUsyh8UoM8uaCnrDxhkWmqGGZjqN71Xu4B
         JKXremTKvvPecWCro9JriH1YXqKXhXSTMR0vo6BMa2Sf3aqAww6h4hR+VqFPxvHgNVZD
         AlntUEwn9rwFBq4PjF+kAq2BIDFTXS9azBt4DYvETlUc2VF58y3awcPLT2meSTbcis8J
         pcsbBu3NFFzNiIg6+On8HYH7RB770OhH+vQBVZ7Z6YpI71D4AAOnt0daxguEprpKc3Xv
         v5RYHOwqtsEWbw7sQZzKkADPh7GrFjIbFAh5b28RGGVC+15wQzDNb/w9gyw/dLCbAFjA
         YGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUNIMITNEMPND9L/exZheJEomP6Hb47+3IW6UOzknnk=;
        b=evAadsXxVJiNXIjJdgHyaqd5Li1t1H9HCnobgwjb7l/FhwcWVZAdyZcKkz3QP46LIl
         KvGxxhVqN+c64Lg28BgbdC24GJP0uGQW3QiJnv7R6MsBFeGpVaZcLxEcV7WNRDLnr8vd
         Qv0M/tt5BBLOaIIVEHZ7rF/k9ZgnLzLXad10kc+3MfRwGR/BdEU1n6njWF48j9jPN3ie
         IIPc0xj7ezSDbOt1LvNWhCGsnCfXnLL19jiNmKlFhNYCN4v3sbSmi8hTp7MEYwdBqi/3
         YFaRjfJbhvrPSUwaw9vwA2wzVIV2GGZBNHmf3xbYHKzjE2gby+ocVLtQPyxjOkZYH+/3
         MoQA==
X-Gm-Message-State: AOUpUlF0ENOxVl2AVQmcqah5LhFEM9i3jbuBVKotlzUHiv5/Jiyj1/Je
        b5R2FleEXjG3RACj7PPXWlo=
X-Google-Smtp-Source: AAOMgpeXtqECkX44W34dd80lpe7V1En/lxMJMXw4dc23KKDKMMr9u20VIeXFYPhdSMXNL/PaJk4ZvQ==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr5919962pgb.408.1532187378408;
        Sat, 21 Jul 2018 08:36:18 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id t186-v6sm7257073pgd.77.2018.07.21.08.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 08:36:17 -0700 (PDT)
Date:   Sat, 21 Jul 2018 21:06:08 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180721153607.GA11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721161934.75066d97@archlinux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Himanshu,
> 
> This was close to the point where I'd take it and make the few remaining
> fixes myself.  I'm still bothered however by the fact the casts in the
> various calibration functions are still not all justified so please take
> another look at that.  Frankly it looks like the original author
> threw in casts because they didn't want to have to think about which ones
> actually do anything!

Ok. I will remove the ones mentioned below.

> Few other things to fix up for v5 as well.

I will send the fixes in an hour.

> Jonathan
> 
> 
> > +#define   BME680_NB_CONV_MASK			GENMASK(3, 0)
> > +#define	    BME680_RUN_GAS_EN_BIT		BIT(4)
> 
> odd looking spacing above.

I don't know why this is showing like that in the diff output, but I
have checked the code by apllying to my test tree(git am <patch>) and
there was no such spurious spacing!

> > +/*
> > + * Taken from Bosch BME680 API:
> > + * https://github.com/BoschSensortec/BME680_driver/blob/63bb5336/bme680.c#L937
> > + *
> > + * Returns humidity measurement in percent, resolution is 0.001 percent. Output
> > + * value of "43215" represents 43.215 %rH.
> > + */
> > +static u32 bme680_compensate_humid(struct bme680_data *data,
> > +				   u16 adc_humid)
> > +{
> > +	struct bme680_calib *calib = &data->bme680;
> > +	s32 var1, var2, var3, var4, var5, var6, temp_scaled, calc_hum;
> > +
> There is still substantial over the top casting in here.
> 
> data->t_fine is already a 32 bit integer for example.

Will do.

> > +	temp_scaled = (((s32) data->t_fine * 5) + 128) >> 8;
> > +	var1 = (adc_humid - ((s32) ((s32) calib->par_h1 * 16))) -
> 
> the outer s32 looks like it won't do anything to me as the inner bit
> will already be an s32.

OK.

> > +			(((temp_scaled * (s32) calib->par_h3) / 100) >> 1);
> > +	var2 = ((s32) calib->par_h2 * (((temp_scaled * (s32) calib->par_h4) /
> > +			((s32) 100)) + (((temp_scaled * ((temp_scaled *
> > +			(s32) calib->par_h5) / 100)) >> 6) / 100) +
> > +			(s32) (1 << 14))) >> 10;
> 
> Lots more casts of dubious merit in here..

Ok.

> > +	var3 = var1 * var2;
> > +	var4 = (s32) calib->par_h6 << 7;
> > +	var4 = (var4 + ((temp_scaled * (s32) calib->par_h7) / 100)) >> 4;
> > +	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
> > +	var6 = (var4 * var5) >> 1;
> > +	calc_hum = (((var3 + var6) >> 10) * 1000) >> 12;
> > +
> > +	if (calc_hum > 100000) /* Cap at 100%rH */
> > +		calc_hum = 100000;
> > +	else if (calc_hum < 0)
> > +		calc_hum = 0;
> > +
> > +	return calc_hum;
> > +}
> > +static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
> > +				 u8 gas_range)
> > +{
> > +	struct bme680_calib *calib = &data->bme680;
> > +	s64 var1;
> > +	u64 var2;
> > +	s64 var3;
> > +	u32 calc_gas_res;
> > +
> > +	/* Look up table 1 for the possible gas range values */
> > +	u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> > +				2147483647u, 2147483647u, 2126008810u,
> > +				2147483647u, 2130303777u, 2147483647u,
> > +				2147483647u, 2143188679u, 2136746228u,
> > +				2147483647u, 2126008810u, 2147483647u,
> > +				2147483647u};
> > +	/* Look up table 2 for the possible gas range values */
> > +	u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> > +				512000000u, 255744255u, 127110228u, 64000000u,
> > +				32258064u, 16016016u, 8000000u, 4000000u,
> > +				2000000u, 1000000u, 500000u, 250000u, 125000u};
> 
> You can mark these two arrays as const I think.

Sure.

> > +
> > +	var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
> > +			((s64) lookupTable1[gas_range])) >> 16;
> > +	var2 = (((s64) ((s64) gas_res_adc << 15) - 16777216) + var1);
> 
> Unless something odd is going on the outer cast just casts the bit
> that has already been forced to s64 to s64 so is pointless.

Ok.

> > +	var3 = (((s64) lookupTable2[gas_range] * (s64) var1) >> 9);
> > +	calc_gas_res = (u32) ((var3 + ((s64) var2 >> 1)) / (s64) var2);
> 
> 64 bit division, does that need to be do_div so as to support 32 bit
> platforms? Also, why does var 2 want to be cast to a 64 bit?
> You'll need to go back to 32 bit anyway to use do_div.

I will change to do_div().

> > +
> > +	if ((check & BME680_GAS_STAB_BIT) == 0) {
> > +	/*
> > +	 * occurs if either the gas heating duration was insuffient
> > +	 * to reach the target heater temperature or the target
> > +	 * heater temperature was too high for the heater sink to
> > +	 * reach.
> > +	 */
> 
> Odd comment indenting. I would move it before the if to make it
> more 'natural'.  Still clearly applies to this block without looking 'odd'.

Will do.

> > +static int bme680_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		switch (chan->type) {
> > +		case IIO_TEMP:
> > +			return bme680_read_temp(data, val, val2);
> > +		case IIO_PRESSURE:
> > +			return bme680_read_press(data, val, val2);
> > +		case IIO_HUMIDITYRELATIVE:
> > +			return bme680_read_humid(data, val, val2);
> > +		case IIO_RESISTANCE:
> > +			return bme680_read_gas(data, val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		switch (chan->type) {
> > +		case IIO_TEMP:
> > +			*val = 1 << data->oversampling_temp;
> > +			return IIO_VAL_INT;
> > +		case IIO_PRESSURE:
> > +			*val = 1 << data->oversampling_press;
> > +			return IIO_VAL_INT;
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = 1 << data->oversampling_humid;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> 
> Don't think you can get here so this code should not be here.

Ok.

> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> 
> You can't get here so no point in having this return. I'll delete it.

OK.

> > +	ret = devm_add_action(dev, bme680_core_remove, indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to register remove action\n");
> > +		return ret;
> > +	}
> 
> I think this is logically in the wrong place.  The things it's actually
> doing is unwinding the register below, but at this stage you haven't
> performed that registration.
> 
> If this is all I fine, I 'might' move it and apply anyway.
> 
> I'm assuming that there will shortly be more in there than a simple
> unregister (otherwise you could just have used devm_iio_device_register...
> 
> I'd prefer that for now you just use devm_iio_device_register
> and drop this until you need it.

OK.

> > +
> > +	ret = regmap_write(regmap, BME680_REG_SOFT_RESET_I2C,
> > +			   BME680_CMD_SOFTRESET);
> > +	if (ret < 0)
> 
> It's not something I'm that bothered by, but you are a little random
> in whether a given error outputs a debug message or not...

I missed this.
Will fix.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
