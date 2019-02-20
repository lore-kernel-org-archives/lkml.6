Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B09C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6A20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="O+BvS77W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBTQX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:23:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:26601 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550679803;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=O07ZxjVgpuIglyl3pOabgdicnKW+A/xs5dSBikGYWm4=;
        b=O+BvS77WeKx17fnoBYD2fGUmHSQuIzPV1tPYcGl0almMlh4MBABERtJVX5vEa13YmL
        kedVe9PK99ZpGUiSBTtf3KdykpflQSXowlUWCEeUHi8MU6ZtFpv/wB/mDsV80eJoDLri
        1P7l7wu5E9zSWeF5MEz+DEQ2CffnFydcerHwLWaSS24Ft5tl7vVwVK2biXXCASed8IfQ
        64YzIWkDvdvfUHlYvm1LIKrYOETx9VPlLyQcdTpkr4N6LV80jsIsgZM0xFpYguA7oinX
        NVR7xwTmfvEVcwTAtWRWVqnW4JZgnCCD4Sbqbf6EgnnCN11PgDOFjkvCh1lAJ1RcNFJc
        FXrQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KGNLFd2
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:23:21 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 5/9] iio: accel: bma180: convert to devm
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220161828.0c6fcd8e@archlinux>
Date:   Wed, 20 Feb 2019 17:23:18 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EF8A39BC-4BA9-4BBE-9AE7-8B0FE4440B13@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com> <900f59b94ef2e1b5559b363c0d1af4fefccd0366.1550671256.git.hns@goldelico.com> <20190220161828.0c6fcd8e@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 20.02.2019 um 17:18 schrieb Jonathan Cameron <jic23@kernel.org>:
> 
> On Wed, 20 Feb 2019 15:00:52 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> 
>> This simplifies the code a little.
> It does, but at the cost of introducing potential race conditions.
> Please don't do this.  See below for why and a suggestion on how
> to resolve things if you want to make this change safely.

Ok, I see. I just was working on that driver and thought that introducing
devm is a good idea here.

But since it does not improve any function (contrary to the mount-matrix
patches), let's drop it for the moment.

BR and thanks,
Nikolaus

> 
> Jonathan
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/iio/accel/bma180.c | 56 ++++++++++++++------------------------
>> 1 file changed, 21 insertions(+), 35 deletions(-)
>> 
>> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
>> index 248be67e4f41..3f5ee2d495d3 100644
>> --- a/drivers/iio/accel/bma180.c
>> +++ b/drivers/iio/accel/bma180.c
>> @@ -738,7 +738,7 @@ static int bma180_probe(struct i2c_client *client,
>> 
>> 	ret = data->part_info->chip_config(data);
>> 	if (ret < 0)
>> -		goto err_chip_disable;
>> +		goto err;
>> 
>> 	mutex_init(&data->mutex);
>> 	indio_dev->dev.parent = &client->dev;
>> @@ -748,12 +748,25 @@ static int bma180_probe(struct i2c_client *client,
>> 	indio_dev->modes = INDIO_DIRECT_MODE;
>> 	indio_dev->info = &bma180_info;
>> 
>> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
>> +			bma180_trigger_handler, NULL);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
>> +		goto err;
>> +	}
>> +
>> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "unable to register iio device\n");
>> +		goto err;
>> +	}
>> +
>> 	if (client->irq > 0) {
>> -		data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
>> -			indio_dev->id);
>> +		data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
>> +			indio_dev->name, indio_dev->id);
>> 		if (!data->trig) {
>> 			ret = -ENOMEM;
>> -			goto err_chip_disable;
>> +			goto err;
>> 		}
>> 
>> 		ret = devm_request_irq(&client->dev, client->irq,
>> @@ -761,7 +774,7 @@ static int bma180_probe(struct i2c_client *client,
>> 			"bma180_event", data->trig);
>> 		if (ret) {
>> 			dev_err(&client->dev, "unable to request IRQ\n");
>> -			goto err_trigger_free;
>> +			goto err;
>> 		}
>> 
>> 		data->trig->dev.parent = &client->dev;
>> @@ -769,34 +782,14 @@ static int bma180_probe(struct i2c_client *client,
>> 		iio_trigger_set_drvdata(data->trig, indio_dev);
>> 		indio_dev->trig = iio_trigger_get(data->trig);
>> 
>> -		ret = iio_trigger_register(data->trig);
>> +		ret = devm_iio_trigger_register(&client->dev, data->trig);
>> 		if (ret)
>> -			goto err_trigger_free;
>> -	}
>> -
>> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> -			bma180_trigger_handler, NULL);
>> -	if (ret < 0) {
>> -		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
>> -		goto err_trigger_unregister;
>> -	}
>> -
>> -	ret = iio_device_register(indio_dev);
>> -	if (ret < 0) {
>> -		dev_err(&client->dev, "unable to register iio device\n");
>> -		goto err_buffer_cleanup;
>> +			goto err;
>> 	}
>> 
>> 	return 0;
>> 
>> -err_buffer_cleanup:
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -err_trigger_unregister:
>> -	if (data->trig)
>> -		iio_trigger_unregister(data->trig);
>> -err_trigger_free:
>> -	iio_trigger_free(data->trig);
>> -err_chip_disable:
>> +err:
>> 	data->part_info->chip_disable(data);
>> 
>> 	return ret;
>> @@ -807,13 +800,6 @@ static int bma180_remove(struct i2c_client *client)
>> 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> 	struct bma180_data *data = iio_priv(indio_dev);
>> 
>> -	iio_device_unregister(indio_dev);
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -	if (data->trig) {
>> -		iio_trigger_unregister(data->trig);
>> -		iio_trigger_free(data->trig);
>> -	}
>> -
> Now we disable the device before removing it's userspace interface.
> Not a good idea.
> 
> Generally I will insist on the remove order always being the precise
> opposite of probe simply because it is obviously correct.
> That includes cases which can be simply argued to be fine (not
> this one which isn't). The reason is readability trumps saving
> a few lines of code and it's a lot easier to check a probe and
> remove function against each other if the order is maintained.
> 
> Of course, there are ways to do this by making all the unwind
> managed, but you haven't done this here.
> devm_add_action_or_reset is handy for this if you want to do it.
> 
>> 	mutex_lock(&data->mutex);
>> 	data->part_info->chip_disable(data);
>> 	mutex_unlock(&data->mutex);
> 

