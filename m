Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C480AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6120874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBYX5Qxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbeL1ROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:14:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbeL1ROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:14:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so19182389ljh.13;
        Fri, 28 Dec 2018 09:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=566hZhuAjbeY3XLbVQ1wabEXQO9Q8dL+oVgToWxRkFA=;
        b=IBYX5QxuOCUcXQUGu7Vvo9OBvWFMBYCNb4UoROJXsR6zfjXsSiGMun72FpbB7mdzzr
         l2khsV2k9IrD24szFr1GFbI7fc2gWz8OCj7EEC4ltX2qTotVh+Vkl0j/BlDY3G5pMwvI
         A2VYY1T72GHGXIqtj1Z9HZE1f6oc8vDyubnjszBzrEbsc0ZjWeQKIAs63pZUkHMohT/E
         e4vsSThhqYz8oiy6GiuhsX02CiycYXlRbbjxMu3y7IROXYpjFZgrkjSCB7irHAOHSGKW
         FL4tJNsDomQFjoYcwdHVeWoMU7zGNXNTttXyHEmNfE8egJHWcgXJRg5yjKcSekgUB4M0
         Gh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=566hZhuAjbeY3XLbVQ1wabEXQO9Q8dL+oVgToWxRkFA=;
        b=D3dBoR/uoEhnjqKcxEekXPK7jKhAxPZxjnLmwbCBN4gz/bffwONVg0HLvXFAffx7Nu
         00/s7tKMBkJDNYnkZjolYQdw5YD8jMSsouf6VG77hrml0i2o6SMl5KLfeBVuiAmN+5Cb
         bunfgRrPjL4RrDUNIPqZPTWG7PoDpujioALMTSexgfulvf97H5SCbZl0nGVDRPzUbc9F
         Qx0oMNxUzs3LcckJ4ip+rLMlKvLYkgLtf9igg6zFmDScosRApkQnpZvV8u+42tXGfAbD
         TC/AxTxcx9PdRd54cVYajf/j4w8RBReSjntTmQVjRoHR4setutf7gVue5zJh+6OVO/FA
         HJsg==
X-Gm-Message-State: AJcUukcIOxH5z75aoUqg6J31VkDuc8DaLs7k43vqZxFkFWWom2Mfo1NZ
        ewSqWXyE+LrE0FNpom5mTWe87F14
X-Google-Smtp-Source: ALg8bN5Kn6/+B6YdWh3j8ClB1vOfbkbzAQsZo5hM/v8Mzh4VR1fQZUONxuQj4BcCzk8CbHZoX22eEg==
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr16095886ljf.47.1546017249300;
        Fri, 28 Dec 2018 09:14:09 -0800 (PST)
Received: from [192.168.1.18] (dkv156.neoplus.adsl.tpnet.pl. [83.24.25.156])
        by smtp.gmail.com with ESMTPSA id y24-v6sm8589669ljd.20.2018.12.28.09.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 09:14:08 -0800 (PST)
Subject: Re: leds/lm3642: simplify error handling, remove user-triggerable
 errors
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181227195552.GB12008@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5f819f02-bcdf-76b4-0621-35d3f0efc28a@gmail.com>
Date:   Fri, 28 Dec 2018 18:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181227195552.GB12008@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thank you for the patch.

On 12/27/18 8:55 PM, Pavel Machek wrote:
> Doing goto just to return is unneccessarily complex, simplify code a
> bit.
> 
> Drop dev_err()s that can be triggered by user.
> 
>      
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/leds/leds-lm3642.c b/drivers/leds/leds-lm3642.c
> index cada084..62fc752 100644
> --- a/drivers/leds/leds-lm3642.c
> +++ b/drivers/leds/leds-lm3642.c
> @@ -110,7 +110,7 @@ static int lm3642_control(struct lm3642_chip_data *chip,
>   	ret = regmap_read(chip->regmap, REG_FLAG, &chip->last_flag);
>   	if (ret < 0) {
>   		dev_err(chip->dev, "Failed to read REG_FLAG Register\n");
> -		goto out;
> +		return ret;
>   	}
>   
>   	if (chip->last_flag)
> @@ -150,11 +150,11 @@ static int lm3642_control(struct lm3642_chip_data *chip,
>   		break;
>   
>   	default:
> -		return ret;
> +		return -EINVAL;
>   	}
>   	if (ret < 0) {
>   		dev_err(chip->dev, "Failed to write REG_I_CTRL Register\n");
> -		goto out;
> +		return ret;
>   	}
>   
>   	if (chip->tx_pin)
> @@ -163,13 +163,12 @@ static int lm3642_control(struct lm3642_chip_data *chip,
>   	ret = regmap_update_bits(chip->regmap, REG_ENABLE,
>   				 MODE_BITS_MASK << MODE_BITS_SHIFT,
>   				 opmode << MODE_BITS_SHIFT);

s/ret =/return/

> -out:
>   	return ret;
>   }
>   
>   /* torch */
>   
> -/* torch pin config for lm3642*/
> +/* torch pin config for lm3642 */
>   static ssize_t lm3642_torch_pin_store(struct device *dev,
>   				      struct device_attribute *attr,
>   				      const char *buf, size_t size)
> @@ -182,7 +181,7 @@ static ssize_t lm3642_torch_pin_store(struct device *dev,
>   
>   	ret = kstrtouint(buf, 10, &state);
>   	if (ret)
> -		goto out_strtoint;
> +		return ret;
>   	if (state != 0)
>   		state = 0x01 << TORCH_PIN_EN_SHIFT;
>   
> @@ -190,16 +189,12 @@ static ssize_t lm3642_torch_pin_store(struct device *dev,
>   	ret = regmap_update_bits(chip->regmap, REG_ENABLE,
>   				 TORCH_PIN_EN_MASK << TORCH_PIN_EN_SHIFT,
>   				 state);
> -	if (ret < 0)
> -		goto out;
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s:i2c access fail to register\n", __func__);
> +		return ret;
> +	}
>   
>   	return size;
> -out:
> -	dev_err(chip->dev, "%s:i2c access fail to register\n", __func__);
> -	return ret;
> -out_strtoint:
> -	dev_err(chip->dev, "%s: fail to change str to int\n", __func__);
> -	return ret;
>   }
>   
>   static DEVICE_ATTR(torch_pin, S_IWUSR, NULL, lm3642_torch_pin_store);
> @@ -233,7 +228,7 @@ static ssize_t lm3642_strobe_pin_store(struct device *dev,
>   
>   	ret = kstrtouint(buf, 10, &state);
>   	if (ret)
> -		goto out_strtoint;
> +		return ret;
>   	if (state != 0)
>   		state = 0x01 << STROBE_PIN_EN_SHIFT;
>   
> @@ -241,16 +236,12 @@ static ssize_t lm3642_strobe_pin_store(struct device *dev,
>   	ret = regmap_update_bits(chip->regmap, REG_ENABLE,
>   				 STROBE_PIN_EN_MASK << STROBE_PIN_EN_SHIFT,
>   				 state);
> -	if (ret < 0)
> -		goto out;
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s:i2c access fail to register\n", __func__);
> +		return ret;
> +	}
>   
>   	return size;
> -out:
> -	dev_err(chip->dev, "%s:i2c access fail to register\n", __func__);
> -	return ret;
> -out_strtoint:
> -	dev_err(chip->dev, "%s: fail to change str to int\n", __func__);
> -	return ret;
>   }
>   
>   static DEVICE_ATTR(strobe_pin, S_IWUSR, NULL, lm3642_strobe_pin_store);
> 

While we are at it I'd also switch to device managed LED registration
API.

-- 
Best regards,
Jacek Anaszewski
