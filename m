Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCPPHu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:07:50 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10441 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:07:49 -0400
Subject: Re: [v2] ARM: davinci: fix the GPIO lookup for omapl138-hawk
To: David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180301103448.27233-1-brgl@bgdev.pl>
 <2641a421-9823-c0bb-93d9-ca0c64060c51@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <e0cad8b8-c2fe-0a66-411f-d478e145ade4@ti.com>
Date: Fri, 16 Mar 2018 20:35:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2641a421-9823-c0bb-93d9-ca0c64060c51@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 March 2018 10:05 PM, David Lechner wrote:
> On 03/01/2018 04:34 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
>> mmc can correctly lookup the wp and cp gpios.
>>
>> Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc
>> pins")
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> v1 -> v2:
>> - added the Fixes: tag
>>
>>   arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> index a3e78074be70..62eb7d668890 100644
>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> @@ -127,8 +127,8 @@ static struct gpiod_lookup_table mmc_gpios_table = {
>>       .dev_id = "da830-mmc.0",
>>       .table = {
>>           /* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
>> -        GPIO_LOOKUP("davinci_gpio.1", 28, "cd", GPIO_ACTIVE_LOW),
>> -        GPIO_LOOKUP("davinci_gpio.1", 29, "wp", GPIO_ACTIVE_LOW),
>> +        GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
>> +        GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),
>>       },
>>   };
>>  
> 
> Does board-da830-evm.c need the same fix? It also uses "davinci_gpio.1".

Yes. looks like fixes are needed here and other places. I will send
patches since I have ability to test them.

Thanks,
Sekhar
