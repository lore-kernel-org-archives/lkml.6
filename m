Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeCQB4c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 21:56:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42559 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeCQB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 21:56:30 -0400
X-Google-Smtp-Source: AG47ELvTsqH3dsj2kILg5Z01sMS02XOkFEJjIsdoU5WIGcpbCDyak3ZKCp9GfhGRQrPbJID8E2E4uw==
Subject: Re: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180316133703.GA31029@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f3d913af-a396-ccdf-105f-c4e64397cbff@roeck-us.net>
Date: Fri, 16 Mar 2018 18:56:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316133703.GA31029@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 06:37 AM, Marcus Folkesson wrote:
> Hi,
> 
> Am I supposed to do something more to make this patchset picked up?
> 

Did you check linux-next ?

Guenter

> Thanks,
> Marcus Folkesson
> 
> On Sun, Feb 11, 2018 at 09:08:41PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> Following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt to make use of
>> the parameter logic.
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> ---
>>
>> Notes:
>>      v3:
>>      	- Use wdd->timeout instead of wdt_timeout when print out
>>      	  timout in probe function.
>>
>>   drivers/watchdog/sama5d4_wdt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>> index 0ae947c3d7bc..255169916dbb 100644
>> --- a/drivers/watchdog/sama5d4_wdt.c
>> +++ b/drivers/watchdog/sama5d4_wdt.c
>> @@ -33,7 +33,7 @@ struct sama5d4_wdt {
>>   	unsigned long		last_ping;
>>   };
>>   
>> -static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
>> +static int wdt_timeout;
>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>>   
>>   module_param(wdt_timeout, int, 0);
>> @@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	wdd = &wdt->wdd;
>> -	wdd->timeout = wdt_timeout;
>> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
>>   	wdd->info = &sama5d4_wdt_info;
>>   	wdd->ops = &sama5d4_wdt_ops;
>>   	wdd->min_timeout = MIN_WDT_TIMEOUT;
>> @@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, wdt);
>>   
>>   	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
>> -		 wdt_timeout, nowayout);
>> +		 wdd->timeout, nowayout);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.15.1
>>
