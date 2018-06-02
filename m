Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFBKAQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:00:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36739 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:00:13 -0400
X-Google-Smtp-Source: ADUXVKI+fkJB7LlcTFALw36gu18PHRYkO63WwTnwlhMLOsx7YqEfEUSOg3LnobLRtOhuO7Cy2tw28w==
Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
To: Steve Twiss <stwiss.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A47F0@SW-EX-MBX02.diasemi.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A4866@SW-EX-MBX02.diasemi.com>
 <3d81a469-e54f-953d-7600-7ddf3d026ca1@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A4F93@SW-EX-MBX02.diasemi.com>
 <aae63779-75eb-a860-3aa5-bb7eb67d3ef3@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A7D74@SW-EX-MBX02.diasemi.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1ca6afef-e55b-e659-3f5f-a98b09b8539e@gmail.com>
Date: Sat, 2 Jun 2018 11:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941A7D74@SW-EX-MBX02.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 02:45 PM, Steve Twiss wrote:
> On 30 May 2018 12:25 Marek Vasut wrote:
> 
>> Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
>> On 05/24/2018 07:30 PM, Steve Twiss wrote:
>>> On 24 May 2018 15:51 Marek Vasut wrote:
>>>
>>> Hi Marek,
>>>
>>>> Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
>>>>
>>>> On 05/24/2018 02:32 PM, Steve Twiss wrote:
>>>>> On 24 May 2018 @ 12:49 Steve Twiss wrote:
>>>>>>> On 23 May 2018 12:43 Marek Vasut wrote,
>>>>>>>
>>>>>>> To: linux-kernel@vger.kernel.org
>>>>>>> Subject: [PATCH 6/6] mfd: da9063: Add DA9063L support
>>>>>>>
>>>>>>> Add support for DA9063L, which is a reduced variant of the DA9063 with less regulators and without RTC.
>>>>>>>
>>>>>>
>>>>>> There's potentially more to this file. Without an RTC the regmap
>>>>>> access tables would change and the usual DA9063 (BB silicon) tables would become invalid.
>>>>>> The tables for da9063_bb_readable_ranges, da9063_bb_writeable_ranges,
>>>>>> da9063_bb_volatile_ranges, would need to be updated for DA9063L, if a new chip model was needed.
>>>>>>
>>>>>> The new ranges would be this (see below), and would remove any RTC accesses in the new chip model.
>>>>>>
>>>>>> static const struct regmap_range da9063l_bb_readable_ranges[] = {
>>>>>> 	{
>>>>>> 		.range_min = DA9063_REG_PAGE_CON,
>>>>>> 		.range_max = DA9063_REG_MON_A10_RES,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_SEQ,
>>>>>> 		.range_max = DA9063_REG_ID_32_31,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_SEQ_A,
>>>>>> 		.range_max = DA9063_REG_AUTO3_LOW,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_T_OFFSET,
>>>>>> 		.range_max = DA9063_BB_REG_GP_ID_19,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_CHIP_ID,
>>>>>> 		.range_max = DA9063_REG_CHIP_VARIANT,
>>>>>> 	},
>>>>>> };
>>>>>>
>>>>>> static const struct regmap_range da9063l_bb_writeable_ranges[] = {
>>>>>> 	{
>>>>>> 		.range_min = DA9063_REG_PAGE_CON,
>>>>>> 		.range_max = DA9063_REG_PAGE_CON,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_FAULT_LOG,
>>>>>> 		.range_max = DA9063_REG_VSYS_MON,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_SEQ,
>>>>>> 		.range_max = DA9063_REG_ID_32_31,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_SEQ_A,
>>>>>> 		.range_max = DA9063_REG_AUTO3_LOW,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_CONFIG_I,
>>>>>> 		.range_max = DA9063_BB_REG_MON_REG_4,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_BB_REG_GP_ID_0,
>>>>>> 		.range_max = DA9063_BB_REG_GP_ID_19,
>>>>>> 	},
>>>>>> };
>>>>>>
>>>>>> static const struct regmap_range da9063l_bb_volatile_ranges[] = {
>>>>>> 	{
>>>>>> 		.range_min = DA9063_REG_PAGE_CON,
>>>>>> 		.range_max = DA9063_REG_EVENT_D,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_CONTROL_A,
>>>>>> 		.range_max = DA9063_REG_CONTROL_B,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_CONTROL_E,
>>>>>> 		.range_max = DA9063_REG_CONTROL_F,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_BCORE2_CONT,
>>>>>> 		.range_max = DA9063_REG_LDO11_CONT,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_DVC_1,
>>>>>> 		.range_max = DA9063_REG_ADC_MAN,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_ADC_RES_L,
>>>>>> 		.range_max = DA9063_REG_MON_A10_RES,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_SEQ,
>>>>>> 		.range_max = DA9063_REG_SEQ,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_REG_EN_32K,
>>>>>> 		.range_max = DA9063_REG_EN_32K,
>>>>>> 	}, {
>>>>>> 		.range_min = DA9063_BB_REG_MON_REG_5,
>>>>>> 		.range_max = DA9063_BB_REG_MON_REG_6,
>>>>>> 	},
>>>>>> };
>>>>>>
>>>>>> However this is a larger and more wide-ranging change compared to the
>>>>>> one proposed by Marek, and would require other alterations to fit
>>>>>> this in. Also I'm undecided to what it would really add apart from a
>>>>>> new chip model: I have been told accessing the DA9063 RTC register locations
>>>>>> has no effect in the DA9063L.
>>>>>
>>>>> Looking at this further, there is also a new IRQ regmap.
>>>>> Again this comes down to whether a full chip model is needed or not.
>>>>> If not, then the IRQ map does not need to be changed as given. Otherwise the
>>>>> removal of the following:
>>>>>
>>>>> 	[DA9063_IRQ_ALARM] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>>>>> 		.mask = DA9063_M_ALARM,
>>>>> 	},
>>>>> 	[DA9063_IRQ_TICK] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>>>>> 		.mask = DA9063_M_TICK,
>>>>> 	},
>>>>>
>>>>> prior to registering the IRQs in the chip model would be needed.
>>>>> The new regmap_irq would be:
>>>>>
>>>>> static const struct regmap_irq da9063l_irqs[] = {
>>>>> 	/* DA9063 event A register */
>>>>> 	[DA9063L_IRQ_ONKEY] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>>>>> 		.mask = DA9063_M_ONKEY,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_ADC_RDY] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>>>>> 		.mask = DA9063_M_ADC_RDY,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_SEQ_RDY] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>>>>> 		.mask = DA9063_M_SEQ_RDY,
>>>>> 	},
>>>>> 	/* DA9063 event B register */
>>>>> 	[DA9063L_IRQ_WAKE] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_WAKE,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_TEMP] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_TEMP,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_COMP_1V2] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_COMP_1V2,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_LDO_LIM] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_LDO_LIM,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_REG_UVOV] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_UVOV,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_DVC_RDY] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_DVC_RDY,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_VDD_MON] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_VDD_MON,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_WARN] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
>>>>> 		.mask = DA9063_M_VDD_WARN,
>>>>> 	},
>>>>> 	/* DA9063 event C register */
>>>>> 	[DA9063L_IRQ_GPI0] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI0,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI1] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI1,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI2] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI2,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI3] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI3,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI4] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI4,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI5] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI5,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI6] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI6,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI7] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
>>>>> 		.mask = DA9063_M_GPI7,
>>>>> 	},
>>>>> 	/* DA9063 event D register */
>>>>> 	[DA9063L_IRQ_GPI8] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI8,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI9] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI9,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI10] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI10,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI11] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI11,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI12] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI12,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI13] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI13,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI14] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI14,
>>>>> 	},
>>>>> 	[DA9063L_IRQ_GPI15] = {
>>>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>>>> 		.mask = DA9063_M_GPI15,
>>>>> 	},
>>>>> };
>>>>
>>>> We can probably do the same trick with the regmaps and irqmaps as with the
>>>> rest, that is, reorder them and register only a smaller portion ?
>>>
>>> I like the "reorder and only register a smaller portion" trick. But it wouldn't work
>>> with what I gave earlier today, without some modification.
>>> For instance, the first register readable entry range in the  DA9063 BB is:
>>>
>>> static const struct regmap_range da9063_bb_readable_ranges[] = {
>>> 	{
>>> 		.range_min = DA9063_REG_PAGE_CON,
>>> 		.range_max = DA9063_BB_REG_SECOND_D,
>>> 	}, {
>>>
>>> But for the DA9063L, this first range entry would be changed, not removed:
>>>
>>> static const struct regmap_range da9063l_bb_readable_ranges[] = {
>>> 	{
>>> 		.range_min = DA9063_REG_PAGE_CON,
>>> 		.range_max = DA9063_REG_MON_A10_RES,
>>> 	}, {
>>>
>>> So it's not all-or-nothing. But possibly it could be made to work if those ranges were split
>>> into two pieces.
>>>
>>> However, it might get messy to maintain in future -- sometimes register ranges need to be
>>> updated with new components or if a new feature is added -- usually I need to work it
>>> all out on paper with the full register map. Splitting up ranges might make it a little
>>> messier. But, it's not impossible.
>>>
>>> For the DA9062 and DA9061 this was done using separate ranges and using the macro
>>> regmap_reg_range(). It's not that messy to read, e.g.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mfd/da9062-core.c?h=next-20180517#n367
>>
>> Hum, can you point me to the datasheet sections so I can check this
>> difference please ? I think I have the rest of the feedback addressed,
>> so I want to check this one before submitting the next version.
> 
> Hi Marek,

Hi,

> My apologies for the time taken to respond. I have been travelling.

No worries

> Datasheets are found on the Dialog company website.
> End of the page, look for Resources > Datasheets.
> 
> https://www.dialog-semiconductor.com/products/da9061
> https://www.dialog-semiconductor.com/products/da9062
> https://www.dialog-semiconductor.com/products/da9063
> https://www.dialog-semiconductor.com/products/da9063L

I found those, but they even list the RTC block in the register list .

> The chip model {readable, writable, volatile} register definitions are given clearly in the device
> drivers. At least they will match what is expected by the Linux device driver. There is no easy
> chip model list found in the datasheets.

Well, let me resend what I have and let's see where this gets us.

-- 
Best regards,
Marek Vasut
