Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeEHJwa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:52:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54553 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeEHJw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:52:29 -0400
X-Google-Smtp-Source: AB8JxZrwQu0O8gHAwVJDs6p+r0ZljaOgP7tLrji32J6Pq05/HOQBK/OHJ4afLk+RLmCqwfaD0JIpPg==
Subject: Re: [RFC PATCH 2/3] arcnet: com20020: Fixup missing SLOWARB bit
To: "Tobin C. Harding" <tobin@apporbit.com>
Cc: m.grzeschik@pengutronix.de, Andrea Greco <a.greco@4sigma.it>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180505213754.8400-1-andrea.greco.gapmilano@gmail.com>
 <20180507025556.GG4197@eros>
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Message-ID: <f17492c1-8565-2a69-22a8-c3abde0c7283@gmail.com>
Date: Tue, 8 May 2018 11:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507025556.GG4197@eros>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 04:55 AM, Tobin C. Harding wrote:
> On Sat, May 05, 2018 at 11:37:54PM +0200, Andrea Greco wrote:
>> From: Andrea Greco <a.greco@4sigma.it>
>>
>> If com20020 clock is major of 40Mhz SLOWARB bit is requested.
>>
>> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
>> ---
>>   drivers/net/arcnet/com20020.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
>> index f09ea77dd6a8..abd32ed8ec9b 100644
>> --- a/drivers/net/arcnet/com20020.c
>> +++ b/drivers/net/arcnet/com20020.c
>> @@ -102,6 +102,10 @@ int com20020_check(struct net_device *dev)
>>   	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
>>   	lp->setup2 = (lp->clockm << 4) | 8;
>>   
>> +	// If clock is major of 40Mhz, SLOWARB bit must be set
> 
> /* C89 style comments please :) */
> 

Done

> 
> Hope this helps,
> Tobin.
>
