Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEHLkT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:40:19 -0400
Received: from out2-4.antispamcloud.com ([185.201.17.4]:41246 "EHLO
        out2-4.antispamcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeEHLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:40:17 -0400
Subject: Re: [PATCH] i2c-mux-pca954x: Force reset on probe if available
To: Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
 <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <350e9638-1127-c0e5-290b-9d04725c1b8e@topic.nl>
Date: Tue, 8 May 2018 10:06:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5kff78GQ2dm+dtVswiS7xj5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOzJhQy2NDFGsix86toyVARW12I64/euOWoYaRdUZk/FrBwefi0WOKb4AQAQbeIc48YiV
 9sWmsIC3ZKongzWBR5l8LN00Y2guNhbTSbk1sIe8sxU0alJN8Y+Bl/gqiQIMUzHUm0lJbYkeZwLL
 yB+ImZP3v5bFq1kV5Dm1eZbZ64/5yTYeHGzfo9M4riUkxDEBCeJWpqZnwzbogARaL7Y5zHUqrD2H
 h0PgN4CWVaxBDBCsUq/ts5X+VOOIoWbZgu14buioDYSM7BP/T+iyRkhWETdUlUP9KMdHy6A+AXAC
 hWVcFH81NtRjycgUFQO/43UBzZANJ1ObAEQEIjYWPINVnHx8uNFFxCRwPG/5Ix4UZh/3U3JFpO2+
 hqJR1ejSjXiONziVSGV4bErVxdg/cKJHDVO6CT9M1stWoUTybRqU5J7031/E3ahF5MMcDI7KdpjQ
 KdaTqzXGcmYQIgNNcKSD7+YhEWyJzIkwSFAW0Pw8uiKe79Ir/Me7RAJ5cVVkcq6aIt2zYvPTd+DT
 pPBZoZwGv5FNt788cua0rXdHmSXTDWpZ077qdJpX6gYgMjbQL07AHOTwwuxo5FQjTor5cZsOzt1v
 T/FFd4XwrbZZ2PROSnBqU7iHsZt7y5STv39682PeyRrtz0kWtl+UH6z76SGp53IXjVmRL8Ub6tnz
 DXC+MEASrFforEA8S32jXIGkcSEmdhSz3VORPhMVvRNiu1/gdeEM09UW0zdwIQBgzumUacr24sMh
 oZLb2Pf3I93/xU1mGSG7X+t1TW39Ja77LGPpOwDuKj1v8GygT97cRB7OREWWgXQb9W4Kqgrdo/ql
 HQwR13y8PA9Lp4X/t4iYwnhqk8Dz5sxganERTDb5w3Vi3NQvJBPvPDjBPaowofdkfHH45mUVrBsP
 GnNiJ83AD/4JscB0VTS+bY/ezHW1Vxxj2dVmij+LWN5wSjEXHInOcrrTK6FoDhG9UZ8skhW6R1E8
 jSo=
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 08-05-18 08:36, Peter Rosin wrote:
> On 2018-05-01 13:42, Mike Looijmans wrote:
>> Instead of just hogging the reset GPIO into deactivated state, activate and
>> then de-activate the reset. This allows for better recovery if the CPU was
>> reset halfway through an I2C transaction for example.
> 
> I can't see any problems with this, and a reset at load time can certainly
> be a benefit. Some questions below though...
> 
> Cheers,
> Peter
> 
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> index 09bafd3..13e10d0 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> @@ -36,6 +36,7 @@
>>    */
>>   
>>   #include <linux/device.h>
>> +#include <linux/delay.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/i2c.h>
>>   #include <linux/i2c-mux.h>
>> @@ -389,10 +390,17 @@ static int pca954x_probe(struct i2c_client *client,
>>   	i2c_set_clientdata(client, muxc);
>>   	data->client = client;
>>   
>> -	/* Get the mux out of reset if a reset GPIO is specified. */
>> -	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
>> +	/* Reset the mux if a reset GPIO is specified. */
>> +	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(gpio))
>>   		return PTR_ERR(gpio);
>> +	if (gpio) {
>> +		/* Datasheet specifies a 4 ns reset-low time */
>> +		udelay(1);
> 
> ndelay(4) ?
> 

I have several reasons for making it much much longer:
- A true 4ns pulse might not make it through the GPIO controller (on some 
chips, the GPIO controller runs at 1/10th of the CPU speed or even less)
- Board designers tend to treat RESET signals as "DC", so a 250MHz pulse might 
not make it through. There may be level converters and open-drain drives in 
the signal path as well.
- I've only looked it op on a few chips, others may have different values

I think best is to just remove the comment line, it doesn't really help.

>> +		gpiod_set_value_cansleep(gpio, 0);
>> +		/* Datasheet specifies a 500 ns reset recovery time */
>> +		udelay(1);
> 
> ndelay(500) ?

Similar reasons as above.

> 
>> +	}
>>   
>>   	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>>   	if (match)
>>
> 



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
