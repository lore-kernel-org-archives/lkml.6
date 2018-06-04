Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeFDR6L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:58:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40954 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFDR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:57:03 -0400
X-Google-Smtp-Source: ADUXVKK8NPtvjtIww3bIsDw4jy15iOswhh344Be4ohk3XMFZSkq1HgeQBVIzyt+UvJmrvQTpXGsXkg==
Subject: Re: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
 <20180604122624.GB21163@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b3c9a486-002e-a63b-7d2d-2b51ce55b08f@gmail.com>
Date: Mon, 4 Jun 2018 18:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604122624.GB21163@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 02:26 PM, Lee Jones wrote:
> On Sat, 02 Jun 2018, Marek Vasut wrote:
> 
>> Convert the regmap_irq table to use REGMAP_IRQ_REG().
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V3: New patch
>> Note: A sed oneliner was used:
>>       sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
>> ---
>>  drivers/mfd/da9063-irq.c | 145 ++++++++++-------------------------------------
>>  1 file changed, 29 insertions(+), 116 deletions(-)
>>
>> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
>> index 207bbfe55449..5b406ecfc14a 100644
>> --- a/drivers/mfd/da9063-irq.c
>> +++ b/drivers/mfd/da9063-irq.c
>> @@ -28,125 +28,38 @@
>>  
>>  static const struct regmap_irq da9063_irqs[] = {
>>  	/* DA9063 event A register */
>> -	[DA9063_IRQ_ONKEY] = {
>> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> -		.mask = DA9063_M_ONKEY,
>> -	},
>> -	[DA9063_IRQ_ALARM] = {
>> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> -		.mask = DA9063_M_ALARM,
>> -	},
>> -	[DA9063_IRQ_TICK] = {
>> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> -		.mask = DA9063_M_TICK,
>> -	},
>> -	[DA9063_IRQ_ADC_RDY] = {
>> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> -		.mask = DA9063_M_ADC_RDY,
>> -	},
>> -	[DA9063_IRQ_SEQ_RDY] = {
>> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> -		.mask = DA9063_M_SEQ_RDY,
>> -	},
>> +	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_ALARM, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ALARM),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_TICK, DA9063_REG_EVENT_A_OFFSET, DA9063_M_TICK),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
> 
> Nice, but I think checkpatch.pl would complain.
> 
> Better to break after the first argument I think.

Doesn't really help the readability, but done.

-- 
Best regards,
Marek Vasut
