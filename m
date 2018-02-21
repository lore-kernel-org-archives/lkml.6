Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeBUWih (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:38:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:58353 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBUWif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:38:35 -0500
Subject: Re: [PATCH v2 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
 <20180221160044.15089-9-manivannan.sadhasivam@linaro.org>
 <CAHp75VfLkmZp7HwX-du4EYdtJ8h=y59OrSbu53Ltf-_kFfpczg@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <aa4ce18d-fd83-c7f1-22fc-59538881ea51@suse.de>
Date: Wed, 21 Feb 2018 23:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfLkmZp7HwX-du4EYdtJ8h=y59OrSbu53Ltf-_kFfpczg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.02.2018 um 20:13 schrieb Andy Shevchenko:
> On Wed, Feb 21, 2018 at 6:00 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
>> controlling the gpio shares the same register range with pinctrl block.
>>
>> GPIO registers are organized as 6 banks and each bank controls the
>> maximum of 32 gpios.
> 
>> +static void owl_gpio_set_reg(void __iomem *base, unsigned int pin, int flag)
>> +{
>> +       u32 val;
>> +
>> +       if (flag) {
>> +               val = readl(base);
>> +               val |= BIT(pin);
>> +               writel(val, base);
>> +       } else {
>> +               val = readl(base);
>> +               val &= ~BIT(pin);
>> +               writel(val, base);
>> +       }
>> +}
> 
> Why not to use the same pattern as below?
> 
> readl()
> if ()
>  ...
> else
> ...
> writel()
> 
> ?

And shouldn't that be readl_relaxed() and writel_relaxed()?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
