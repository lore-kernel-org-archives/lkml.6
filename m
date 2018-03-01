Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031170AbeCAOJD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:09:03 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36663 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030992AbeCAOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:09:02 -0500
X-Google-Smtp-Source: AG47ELtXchzraw8LpmY0jfZAtSVnX0UfwLyyKMc33SI1XLHRHCYVTsTw/s6gr45EpFJdVTsWDSoRzxeCKye+y1Lx/6M=
MIME-Version: 1.0
In-Reply-To: <20180301140351.gokvstohs3mghz5q@lakrids.cambridge.arm.com>
References: <20180301135806.19982-1-benjamin.gaignard@st.com>
 <20180301135806.19982-2-benjamin.gaignard@st.com> <20180301140351.gokvstohs3mghz5q@lakrids.cambridge.arm.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 1 Mar 2018 15:09:00 +0100
Message-ID: <CA+M3ks5mWgJRL=PeCrQK6PBmCzhjwuPHUQFS5JGUiVHxWqmBoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: stm32: Add bindings for Extended
 TrustZone Protection
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Loic PALLARDY <loic.pallardy@st.com>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 15:03 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Mar 01, 2018 at 02:58:05PM +0100, Benjamin Gaignard wrote:
>> Extended TrustZone Protection driver is very basic and only needs
>> to know where are the registers (no clock, no interrupt)
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       | 25 ++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt b/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>> new file mode 100644
>> index 000000000000..9407e37f7d15
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>> @@ -0,0 +1,25 @@
>> +STMicroelectronics STM32 Extended TrustZone Protection driver
>> +
>> +Required properties:
>> + - compatible : value should be "st,stm32mp1-etzpc"
>> + - reg : physical base address of the IP registers and length of memory
>> +      mapped region.
>> + - protected-devices: list of phandle of devices protected by etzpc.
>> +                   Because etzpc driver rely on the phandle index in
>> +                   the list, holes must be filled with a disabled node.
>
> ... where the index corresponds to what, exactly?

to the offset of the status bits in the register

>
> Padding with a disabled node seems very hacky.

If a device node doesn't exist in the DT I need to fill the hole by something
to keep the index valid.

>
> Thanks,
> Mark.
>
>> +
>> +Example for stm32mp1:
>> +
>> +reserved: disabled_node {
>> +     status = "disabled";
>> +};
>> +
>> +etzpc: etzpc@5c007000 {
>> +     compatible = "st,stm32mp1-etzpc";
>> +     reg = <0x5c007000 0x400>;
>> +             protected-devices = <&usart1>,
>> +                                 <&spi6>,
>> +                                 <&i2c4>,
>> +                                 <&reserved>,
>> +                                 <&rng1>;
>> +};
>> --
>> 2.15.0
>>
