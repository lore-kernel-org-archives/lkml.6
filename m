Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeE3L0M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:26:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36146 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeE3L0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:26:07 -0400
X-Google-Smtp-Source: ADUXVKIqrRlS57VBU41bGiXDjx4tNoo9fnIMMfcxULexoShCJI9bCIhJHI5eQ6I89E+ycM4t19txvQ==
Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
To: Lee Jones <lee.jones@linaro.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A47F0@SW-EX-MBX02.diasemi.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A4866@SW-EX-MBX02.diasemi.com>
 <3d81a469-e54f-953d-7600-7ddf3d026ca1@gmail.com> <20180529074659.GC4790@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a37242b5-e48c-970d-6de1-6d0a9fd3f15a@gmail.com>
Date: Wed, 30 May 2018 13:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529074659.GC4790@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 09:46 AM, Lee Jones wrote:
> On Thu, 24 May 2018, Marek Vasut wrote:
>> On 05/24/2018 02:32 PM, Steve Twiss wrote:
>>> On 24 May 2018 @ 12:49 Steve Twiss wrote:
> 
> [...]
> 
>>> static const struct regmap_irq da9063l_irqs[] = {
>>> 	/* DA9063 event A register */
>>> 	[DA9063L_IRQ_ONKEY] = {
>>> 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
>>> 		.mask = DA9063_M_ONKEY,
>>> 	},
> 
> [...]
> 
>>> 	[DA9063L_IRQ_GPI15] = {
>>> 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
>>> 		.mask = DA9063_M_GPI15,
>>> 	},
>>> };
>>
>> We can probably do the same trick with the regmaps and irqmaps as with
>> the rest, that is, reorder them and register only a smaller portion ?
> 
> Please also consider using REGMAP_IRQ_REG().

Done in a new separate patch with a simple sed oneliner

sed -i "/\[DA9063_IRQ_/
{N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.*
= \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c

-- 
Best regards,
Marek Vasut
