Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACF7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130220894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEcCNjcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A130220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbeHAKlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:41:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34735 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbeHAKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:41:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so13239652wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JbDpIApprizuDcfEpXony7ZE2rARHON8ut5DBgcNtbE=;
        b=VEcCNjcxgsAmsjKWQv8UFby/spTo7Qnly4O4fjA9uvDbne/BsW+6L3eshel/ehCSHM
         uzNATu13DsZ20EWvYgH3dhh+ROu5cv4hQABl4cD0XFwhRzWzB6iZmX8rfoUWvHb7eQny
         rqpzFLqfJhCsZLUGbxeJzifIzaxrUC8Fljo+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JbDpIApprizuDcfEpXony7ZE2rARHON8ut5DBgcNtbE=;
        b=FRWB8Msi35T1q9/kZhEuiZ6d1CHhRh/koQt18N3BKEZYwMjR8r0JrX2IbzPAg3N3SG
         hRdhT85pef7UMpe/NYgGExQg5m2I8vFkvUJZmhhx4RvPwGuoxPq9wzQO+pkB0ZwVyAF/
         DRjpVmI0qAbbctXim4mVrc9l2C4Cc2InxnvBqbGMOPB+MofLNuS+16DO8ke6QpuAOHPW
         n38k2YhBoQTFjhILXaIrZGKDf/+sovPj+1dCxQ5trQd/ITCenYQa3R8CbT1+J/+zLIG5
         adzZjGiZfWMXM9ANx+Yb0J2QJ079Oh28A8eGyicD9CkoaMfhV7jqqMo1524FUm9l+/Ee
         UNzA==
X-Gm-Message-State: AOUpUlFYSFlOUinQ92CbTscvb6tOIGPV8h7rK68CD7Ci7FtGp3y0pY6N
        0Kon+DMJibh8LrA4R0pu0csz4g==
X-Google-Smtp-Source: AAOMgpc8F2Jiz+vlw39jrniTDQOhRPKUz+3sCW8iI4drOfTJglZfJ5y/JUpwW4af+omqd04ldaWNzA==
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr2203514wmc.138.1533113827133;
        Wed, 01 Aug 2018 01:57:07 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x7-v6sm30041847wrr.95.2018.08.01.01.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:57:06 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core
To:     Vinod <vkoul@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
 <20180730041223.GD3661@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0bde4c75-b7d4-aa85-3037-79c2aa0e961c@linaro.org>
Date:   Wed, 1 Aug 2018 09:57:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180730041223.GD3661@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing,

On 30/07/18 05:12, Vinod wrote:
> On 27-07-18, 13:17, Srinivas Kandagatla wrote:
>> +obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
>> +wcd9335-objs			:= wcd9335-core.o
>> +
> 
> no slimbus objs?
> 
Yep, I will try to tidy this up a bit in next version.
>> +static int wcd9335_bring_up(struct wcd9335 *wcd)
>> +{
>> +	struct regmap *rm = wcd->regmap;
>> +	int val, byte0;
>> +	int ret = 0;
>> +
>> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
>> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
>> +
>> +	if ((val < 0) || (byte0 < 0)) {
>> +		dev_err(wcd->dev, "wcd9335 codec version detection fail!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (byte0 == 0x1) {
>> +		dev_info(wcd->dev, "wcd9335 codec version is v2.0\n");
>> +		wcd->version = WCD9335_VERSION_2_0;
>> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
>> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
>> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
>> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
>> +	} else {
>> +		dev_err(wcd->dev, "wcd9335 codec version not supported\n");
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
> 
> we can do return 0 and remove the variable as it is not used anywhere
> else.
Yes, it makes sense!


Thanks,
srini
