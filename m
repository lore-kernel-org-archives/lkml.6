Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC3F2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IfBDhHkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC3F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeIEWtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:49:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40874 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeIEWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:49:36 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w85IIAgA051030;
        Wed, 5 Sep 2018 13:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536171490;
        bh=SWJ/zg50Cl/Rklso3yyezyPjS/hlkRRpZRf/fSvJT8Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IfBDhHkV/kXElkztfq2UYiGgoT5hQV9OnHfYcaqNXlYeYedX5CVjmjPhqQOiJq5LU
         ESLY3aEAMSJtIZ07QVybh9rNFUhvD3TKltkShadJeSt/STj4LTBGxwXjwAt8nYuzxY
         zTwR3WCqbhiPK1QjGk9dB1mtDHL860227x1Nnxrw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85IIAuV031176;
        Wed, 5 Sep 2018 13:18:10 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 5 Sep
 2018 13:18:09 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 5 Sep 2018 13:18:09 -0500
Received: from [172.22.166.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85II9xZ014064;
        Wed, 5 Sep 2018 13:18:09 -0500
Subject: Re: [PATCH v5 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180817151528.21623-1-dmurphy@ti.com>
 <20180817151528.21623-2-dmurphy@ti.com> <20180824100549.GC4045@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a0651696-2cea-a96f-d1f1-b02c39ae187c@ti.com>
Date:   Wed, 5 Sep 2018 13:18:08 -0500
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

Pavel

On 08/24/2018 05:05 AM, Pavel Machek wrote:
> Hi!
> 

I am going to go ahead and update this code anyway and if we get the ti-lmu
code in then we can adapt this code to use that framework

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

ACK

> 
>> +	ret = regmap_write(led->priv->regmap, brt_msb_reg, brt_val);
>> +	if (ret) {
>> +		dev_err(&led->priv->client->dev, "Cannot write MSB\n");
>> +		goto out;
>> +	}
>> +out:
> 
> I'd avoid this goto.

Ack

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

Not always there can be a situation where all HVLEDs can be configured
for control bank B

> 
>> +	for (i = 0; i < LM3697_MAX_LED_STRINGS; i++) {
>> +		if (led->hvled_strings[i] == LM3697_HVLED_ASSIGNMENT)
>> +			control_bank_config |= 1 << i;
>> +	}
> 
> Extra {}s.

Ack

> 
>> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
>> +	if (IS_ERR(priv->regulator))
>> +		priv->regulator = NULL;
> 
> If vled regulator is specified in dt and _get fails, is it worth a
> warning?

Hmmm.  That would be annoying on boot to have a warning on an optional
parameter.  But if we need it I can add it.

Dan

> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
