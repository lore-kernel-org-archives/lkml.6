Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528A7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1599720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1599720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeLKD4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:56:13 -0500
Received: from anchovy1.45ru.net.au ([203.30.46.145]:55834 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbeLKD4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:56:12 -0500
Received: (qmail 11471 invoked by uid 5089); 11 Dec 2018 03:56:10 -0000
Received: by simscan 1.2.0 ppid: 11326, pid: 11328, t: 0.0472s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 11 Dec 2018 03:56:10 -0000
Subject: Re: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
To:     Anson Huang <anson.huang@nxp.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
 <1544498291-2716-2-git-send-email-Anson.Huang@nxp.com>
 <d07b5970-5825-2ea6-9e27-538386927923@electromag.com.au>
 <DB3PR0402MB39161ED492C863BB48D48E2FF5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <0b08c0d1-afe2-5ade-9333-2eb7d57d4db6@electromag.com.au>
Date:   Tue, 11 Dec 2018 11:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39161ED492C863BB48D48E2FF5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Anson,

Just pulled up the datasheet for this chip.

The absolute max for Vdda is speced as Vddd +/-0.5
With a note that Vdda should be externally shorted to Vddd.


On 11/12/2018 11:43 am, Anson Huang wrote:
> Hi, Phil
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Phil Reid [mailto:preid@electromag.com.au]
>> Sent: 2018年12月11日 11:36
>> To: Anson Huang <anson.huang@nxp.com>; jic23@kernel.org;
>> knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net;
>> robh+dt@kernel.org; mark.rutland@arm.com; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> festevam@gmail.com
>> Cc: dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
>> regulator operation support
>>
>> On 11/12/2018 11:24 am, Anson Huang wrote:
>>> The light sensor's power supply could be controlled by regulator on
>>> some platforms, such as i.MX6Q-SABRESD board, the light sensor
>>> isl29023's power supply is controlled by a GPIO fixed regulator, need
>>> to make sure the regulator is enabled before any operation of sensor,
>>> this patch adds optional vdd/vdda regulator operation support.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>> ChangeLog since V3:
>>> 	- improve the error handling of devm_regulator_get_optional;
>>> 	- make sure regulators are disabled in error path.
>>> ---
>>>    drivers/iio/light/isl29018.c | 83
>> ++++++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 80 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/isl29018.c
>>> b/drivers/iio/light/isl29018.c index b45400f..a21652b 100644
>>> --- a/drivers/iio/light/isl29018.c
>>> +++ b/drivers/iio/light/isl29018.c
>>> @@ -23,6 +23,7 @@
>>>    #include <linux/mutex.h>
>>>    #include <linux/delay.h>
>>>    #include <linux/regmap.h>
>>> +#include <linux/regulator/consumer.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/iio/iio.h>
>>>    #include <linux/iio/sysfs.h>
>>> @@ -95,6 +96,8 @@ struct isl29018_chip {
>>>    	struct isl29018_scale	scale;
>>>    	int			prox_scheme;
>>>    	bool			suspended;
>>> +	struct regulator	*vdd_reg;
>>> +	struct regulator	*vdda_reg;
>>>    };
>>>
>>>    static int isl29018_set_integration_time(struct isl29018_chip *chip,
>>> @@ -735,6 +738,34 @@ static int isl29018_probe(struct i2c_client
>>> *client,
>>>
>>>    	mutex_init(&chip->lock);
>>>
>>> +	chip->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
>>> +	if (!IS_ERR(chip->vdd_reg)) {
>>> +		err = regulator_enable(chip->vdd_reg);
>>> +		if (err) {
>>> +			dev_err(&client->dev, "failed to enable VDD regulator\n");
>>> +			return err;
>>> +		}
>>> +	} else {
>>> +		err = PTR_ERR(chip->vdd_reg);
>>> +		if (err != -ENODEV)
>>> +			return err;
>>> +	}
>>> +
>>> +	chip->vdda_reg = devm_regulator_get_optional(&client->dev, "vdda");
>>> +	if (!IS_ERR(chip->vdda_reg)) {
>>> +		err = regulator_enable(chip->vdda_reg);
>>> +		if (err) {
>>> +			dev_err(&client->dev, "failed to enable VDDA regulator\n");
>>> +			if (!IS_ERR(chip->vdd_reg))
>>> +				regulator_disable(chip->vdd_reg);
>>> +			return err;
Not sure about this case at the call to enable failed so I think
you only want the first one to be disabled.
You could add another goto statement thou, see below.


>>> +		}
>>> +	} else {
>>> +		err = PTR_ERR(chip->vdda_reg);
>>> +		if (err != -ENODEV)
>>> +			return err;
>> maybe goto disable_regulators; to disable vdd.
> 
> Agree, I will use " goto disable_regulators;" in both here and upper regulator enable fail case.
> Please help review V5, thanks.

Here its safe to call both as vdda_reg will be an error ptr.

> 
> Anson
> 
>>
>>> +	}
>>> +
>>>    	chip->type = dev_id;
>>>    	chip->calibscale = 1;
>>>    	chip->ucalibscale = 0;
>>> @@ -747,12 +778,12 @@ static int isl29018_probe(struct i2c_client *client,
>>>    	if (IS_ERR(chip->regmap)) {
>>>    		err = PTR_ERR(chip->regmap);
>>>    		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
>>> -		return err;
>>> +		goto disable_regulators;
>>>    	}
>>>
>>>    	err = isl29018_chip_init(chip);
>>>    	if (err)
>>> -		return err;
>>> +		goto disable_regulators;
>>>
>>>    	indio_dev->info = isl29018_chip_info_tbl[dev_id].indio_info;
>>>    	indio_dev->channels = isl29018_chip_info_tbl[dev_id].channels;
>>> @@ -761,13 +792,24 @@ static int isl29018_probe(struct i2c_client *client,
>>>    	indio_dev->dev.parent = &client->dev;
>>>    	indio_dev->modes = INDIO_DIRECT_MODE;
>>>
>>> -	return devm_iio_device_register(&client->dev, indio_dev);
>>> +	err = devm_iio_device_register(&client->dev, indio_dev);
>>> +	if (!err)
>>> +		return 0;
>>> +
>>> +disable_regulators:
>>> +	if (!IS_ERR(chip->vdd_reg))
>>> +		regulator_disable(chip->vdd_reg);
>>> +	if (!IS_ERR(chip->vdda_reg))
>>> +		regulator_disable(chip->vdda_reg);
>>> +
eg: extra label here.
Order is changed thou, which may be a problem.
It's in the reverse order to the enable, which is usually what you want but the
datasheet concerns above may be an issue.


disable_regulators:
	if (!IS_ERR(chip->vdda_reg))
		regulator_disable(chip->vdda_reg);
disable_regulator_vdd:
	if (!IS_ERR(chip->vdd_reg))
		regulator_disable(chip->vdd_reg);

>>> +	return err;
>>>    }
>>>
>> [snip]
>>



-- 
Regards
Phil
