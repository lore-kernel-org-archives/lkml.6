Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932467AbeBUSyX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:54:23 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46060 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeBUSyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:54:18 -0500
X-Google-Smtp-Source: AH8x227frkkIKBeu4XqWp26bfZi1VSSncTbNwcu0CjkhYcvsezasUKy/WscvamUiz1hIiAVR/WqsJiL9JcqMefFldOc=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_5N3bTAasc5Gt0pTo-s3mMdqmvt-C=GM0ACkkptyrN-Q@mail.gmail.com>
References: <20180220090827.913-1-ard.biesheuvel@linaro.org>
 <20180220090827.913-3-ard.biesheuvel@linaro.org> <CAHp75VeUJpXLpL55erp+uoMH4jqppoG5zTt1DcffqNYPsJMdUQ@mail.gmail.com>
 <CAKv+Gu8A1YKr5t0B=Fe2sF6+QT9iCVeRW+99K37g22viEoismA@mail.gmail.com>
 <CAHp75Vd=dww8AQM4tC5Z38i4PNaV4vxMFsTf=ozJ1Yw3Gd9DWg@mail.gmail.com> <CAKv+Gu_5N3bTAasc5Gt0pTo-s3mMdqmvt-C=GM0ACkkptyrN-Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 20:54:16 +0200
Message-ID: <CAHp75VepC+gch+st16FA8Bzisg7+X_oZg2Ua83QpHyZ43Pd5ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 8:20 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 20 February 2018 at 19:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Tue, Feb 20, 2018 at 8:04 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 20 February 2018 at 14:02, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

>>>>> +               ret = device_property_read_u32(&pdev->dev,
>>>>> +                                              "socionext,pclk-rate",
>>>>> +                                              &i2c->clkrate);
>>>>
>>>> I suppose for ACPI we just register a fixed rate clock and use it in
>>>> the driver in the same way as in OF case.
>>>> I guess at some point we even can provide a generic clock provider for
>>>> ACPI based on rate property.
>>
>>> Is there a question here? Do you want me to change anything?
>>
>> Is it opener for discussion. At least in the drivers we have done for
>> x86 we do the way I described.
>>
>> See, for example, drivers/mfd/intel-lpss.c

> OK, I see what you mean now. But for this driver, creating a fixed
> rate clock with no controls whatsoever, only to interrogate it for its
> rate (which we retrieved from the ACPI device node in the first place)
> seems rather pointless to me. Am I missing something here?

Somehow you are right. That's why I'm thinking that we need to provide
a generic clock provider for such cases.
It's really not a driver business to know the details of resource provider.

-- 
With Best Regards,
Andy Shevchenko
