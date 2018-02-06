Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeBFNJG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:09:06 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40177 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:09:00 -0500
X-Google-Smtp-Source: AH8x224pM3llkivoLqfFMiKDBqSY82as37GkRbRiqZSw2xAQMs+tMCYllZT5nWFf8Wy3g32C4h6Oskr66ifhrHTkT+c=
MIME-Version: 1.0
In-Reply-To: <3f171f6a-bcea-65ec-d56d-f6ae24660f34@ti.com>
References: <20180205155222.22189-1-brgl@bgdev.pl> <3f171f6a-bcea-65ec-d56d-f6ae24660f34@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 6 Feb 2018 14:08:58 +0100
Message-ID: <CAMpxmJUDbwkcJt_kx9GX+qY10xiGAp-j3+kXM-q3WP1VGwr0UQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: da850-evm: add clock properties to the nand node
To: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-06 12:07 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Monday 05 February 2018 09:22 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Make nand work with the common clock framework by specifying which
>> clock should be used and what name to look up.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850-evm.dts | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>> index a86a8a1816f2..2602ad8e99ee 100644
>> --- a/arch/arm/boot/dts/da850-evm.dts
>> +++ b/arch/arm/boot/dts/da850-evm.dts
>> @@ -296,6 +296,9 @@
>>                       reg = <0 0x02000000 0x02000000
>>                              1 0x00000000 0x00008000>;
>>
>> +                     clocks = <&psc0 3>;
>> +                     clock-names = "aemif";
>
> Looks like this is being added only to satisfy the devm_clk_get() call
> in nand_davinci_probe() which I think is superfluous since we also
> enable the same clock in aemif_probe().
>
> Perhaps the better solution is to drip the clk code in
> drivers/mtd/nand/davinci_nand.c and shift legacy code to start using
> drivers/memory/aemif.c as well? This way we can also drop
> arch/arm/mach-davinci/aemif.c
>
> Thanks,
> Sekhar

Yes, this sounds good, but I think we should leave it for later as an
additional improvement, once everything else is in place. I think
these patches should be applied together with David's series in order
to not break the support on davinci boards and the aemif work would go
in later as a follow-up. How about that?

Also: I don't have any keystone board to test whether such changes
don't break the nand support there. Would you be able to test this?

Thanks,
Bartosz
