Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D817C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9498B208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxthP0bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9498B208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeHXXJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:09:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37098 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHXXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:09:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so2663266wmc.2;
        Fri, 24 Aug 2018 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SgdN0194gl2jUH5e4wQyKUS8HGlkXv6G3gfIntW/6Bk=;
        b=fxthP0bgG4zxWsyf9B3XmL0QlgOf2BBJl4sBCf0ru5NjXx6Cmpp5V5YHs333fx9vga
         kZ+h4iDvIqpg5zFCXPfQgQ9CutMJ9FwSi6ZXPTqKg4gsNC0sCzqUNVUtTCRr+1fzl8KO
         bd6yOdzj6QDip2WrKE/W/jRnfDG9k7v/TbD4SEveAl7KMB+UnhfM6V3y3fVIP4GBQ2GS
         Qn5dAdGNpR+RiKp5/xv+WKVrN/DT7mRXx2e3AmhJ2iX+nM/O559WZAs43c6F9WktGQfO
         8/xmJhzc+wPRcYKTyC5Xrl+VrEUANAWojMqItCqhB8vK99XOoiDUxshyLEqD5QSpE+eR
         BLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SgdN0194gl2jUH5e4wQyKUS8HGlkXv6G3gfIntW/6Bk=;
        b=sc40uaB+4vzMYCUXP+MDw11W6jNa/eiGAukOXn3ZjWMrlW5DeiiZdWY+s57V/SQv8f
         yaB5PSGwWDmI8ycIecsjdBV0+Tt/zCQ7aLR1DykHnpAyBclX0KFplgEmLkt6xOdj89ws
         OEP032fYLfrBsWw1vEzmBYRsqdXBCOl0sYMyrtmLcomr0SwlRaZUgvjBIxY/qwNAA/2/
         NzDA2ZVRYXgJcoTJdGL8txfj2Wf8r65S/dJPYio3AWj20EcLVH52e3+6Fri/Esqp6OxE
         EJkPn3S8gy17dUjC2vfWQEfp2uIGZZP5dBsNFSF5+KNiButXt5zjSLRNRQKYdLkEHcBt
         bS7A==
X-Gm-Message-State: APzg51A53RNKDKbbID4faJ1LhxWoxJrQcaIcqPl+XO73volc5hNaRrws
        G5Q97StuZDxpN3YgbKIRLfPe7WUg
X-Google-Smtp-Source: ANB0VdYchWMhIi+RtvoXmxBEEXWFhILE1+bzywyevOXT2i5erLecVPLs95HLTmxowffZZWvXCzPdVw==
X-Received: by 2002:a1c:f001:: with SMTP id a1-v6mr2353968wmb.160.1535139226615;
        Fri, 24 Aug 2018 12:33:46 -0700 (PDT)
Received: from [192.168.1.18] (bga163.neoplus.adsl.tpnet.pl. [83.28.64.163])
        by smtp.gmail.com with ESMTPSA id 1-v6sm3854526wmf.47.2018.08.24.12.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 12:33:45 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180817151528.21623-1-dmurphy@ti.com>
 <20180817151528.21623-2-dmurphy@ti.com> <20180824100549.GC4045@amd>
 <e5abd336-9861-66f3-3991-40cf1302ce8d@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <586dc4fb-ebdf-ba8a-8a1e-ad49c80a1157@gmail.com>
Date:   Fri, 24 Aug 2018 21:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5abd336-9861-66f3-3991-40cf1302ce8d@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 08/24/2018 01:58 PM, Dan Murphy wrote:
> Jacek
> 
> On 08/24/2018 05:05 AM, Pavel Machek wrote:
>> Hi!
>>
>>> +/**
>>> + * struct lm3697 -
>>> + * @enable_gpio - Hardware enable gpio
>>> + * @regulator - LED supply regulator pointer
>>> + * @client - Pointer to the I2C client
>>> + * @regmap - Devices register map
>>> + * @dev - Pointer to the devices device struct
>>> + * @lock - Lock for reading/writing the device
>>> + * @leds - Array of LED strings.
>>> + */
>>
>> extra .
>>
>>> +	ret = regmap_write(led->priv->regmap, brt_msb_reg, brt_val);
>>> +	if (ret) {
>>> +		dev_err(&led->priv->client->dev, "Cannot write MSB\n");
>>> +		goto out;
>>> +	}
>>> +out:
>>
>> I'd avoid this goto.
>>
>>> +static int lm3697_set_control_bank(struct lm3697 *priv)
>>> +{
>>> +	u8 control_bank_config = 0;
>>> +	struct lm3697_led *led;
>>> +	int ret, i;
>>> +
>>> +	led = &priv->leds[0];
>>> +	if (led->control_bank == LM3697_CONTROL_A)
>>> +		led = &priv->leds[1];
>>
>> I'd expect CONTROL_A to correspond to leds[0]...?
>>
>>> +	for (i = 0; i < LM3697_MAX_LED_STRINGS; i++) {
>>> +		if (led->hvled_strings[i] == LM3697_HVLED_ASSIGNMENT)
>>> +			control_bank_config |= 1 << i;
>>> +	}
>>
>> Extra {}s.
>>
>>> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
>>> +	if (IS_ERR(priv->regulator))
>>> +		priv->regulator = NULL;
>>
>> If vled regulator is specified in dt and _get fails, is it worth a
>> warning?
>>
>> 									Pavel
>>
> 
> Do you want v6 or a new patch on top?

Please submit v6.

-- 
Best regards,
Jacek Anaszewski
