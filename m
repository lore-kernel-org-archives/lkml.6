Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E35CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627521567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j1LZneEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5627521567
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeHXPdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:33:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47056 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeHXPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:33:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7OBwlce063728;
        Fri, 24 Aug 2018 06:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535111927;
        bh=eBmvkdUMPo1o30DqvZgRB1b8zSSc4DCy+QnXS93KUfY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=j1LZneEXaH4xPKnDqjhLX+oAK2Rx5Zho+5K/FP+2ydDocEjcPVHaSZMIw5rAXGfYu
         1IyBUcPfWEET+MSYoQgtIuQN92E27mq6Zug/62nulfbRjlEuL2VeRZJvgogIZGqrw/
         z63zVJL6kr6eaJrA5QATOUcp8F1embp01nURyZmM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7OBwlOl002372;
        Fri, 24 Aug 2018 06:58:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 24
 Aug 2018 06:58:47 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 24 Aug 2018 06:58:47 -0500
Received: from [172.22.190.165] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7OBwkp7018695;
        Fri, 24 Aug 2018 06:58:46 -0500
Subject: Re: [PATCH v5 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180817151528.21623-1-dmurphy@ti.com>
 <20180817151528.21623-2-dmurphy@ti.com> <20180824100549.GC4045@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e5abd336-9861-66f3-3991-40cf1302ce8d@ti.com>
Date:   Fri, 24 Aug 2018 06:58:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824100549.GC4045@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 08/24/2018 05:05 AM, Pavel Machek wrote:
> Hi!
> 
>> +/**
>> + * struct lm3697 -
>> + * @enable_gpio - Hardware enable gpio
>> + * @regulator - LED supply regulator pointer
>> + * @client - Pointer to the I2C client
>> + * @regmap - Devices register map
>> + * @dev - Pointer to the devices device struct
>> + * @lock - Lock for reading/writing the device
>> + * @leds - Array of LED strings.
>> + */
> 
> extra .
> 
>> +	ret = regmap_write(led->priv->regmap, brt_msb_reg, brt_val);
>> +	if (ret) {
>> +		dev_err(&led->priv->client->dev, "Cannot write MSB\n");
>> +		goto out;
>> +	}
>> +out:
> 
> I'd avoid this goto.
> 
>> +static int lm3697_set_control_bank(struct lm3697 *priv)
>> +{
>> +	u8 control_bank_config = 0;
>> +	struct lm3697_led *led;
>> +	int ret, i;
>> +
>> +	led = &priv->leds[0];
>> +	if (led->control_bank == LM3697_CONTROL_A)
>> +		led = &priv->leds[1];
> 
> I'd expect CONTROL_A to correspond to leds[0]...?
> 
>> +	for (i = 0; i < LM3697_MAX_LED_STRINGS; i++) {
>> +		if (led->hvled_strings[i] == LM3697_HVLED_ASSIGNMENT)
>> +			control_bank_config |= 1 << i;
>> +	}
> 
> Extra {}s.
> 
>> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
>> +	if (IS_ERR(priv->regulator))
>> +		priv->regulator = NULL;
> 
> If vled regulator is specified in dt and _get fails, is it worth a
> warning?
> 
> 									Pavel
> 

Do you want v6 or a new patch on top?

Dan

-- 
------------------
Dan Murphy
