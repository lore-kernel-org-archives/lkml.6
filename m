Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeDKPwR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:52:17 -0400
Received: from www381.your-server.de ([78.46.137.84]:53258 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeDKPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:52:00 -0400
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
Date: Wed, 11 Apr 2018 17:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 05:43 PM, Andrew F. Davis wrote:
> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>> This is a current sense amplifier from Analog Devices.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/iio/afe/Kconfig              |  3 +-
>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>> index 642ce4eb12a6..0e10fe8f459a 100644
>> --- a/drivers/iio/afe/Kconfig
>> +++ b/drivers/iio/afe/Kconfig
>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>  	depends on OF || COMPILE_TEST
>>  	help
>>  	  Say yes here to build support for the IIO unit converter
>> -	  that handles voltage dividers and current sense shunts.
>> +	  that handles voltage dividers, current sense shunts and
>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
> 
> Could work better to split these out into separate drivers. Maybe a
> iio-shunt-resistor.c that does just voltage->current with the
> appropriate scaling. Then make a a separate lt6106.c.

I don't think we need a separate driver here. There are tons of circuits
that all work the same way and all require the same properties. If we'd add
a driver for each of them we'd get buried in boilerplate code.
