Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030705AbeBNOXW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:23:22 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42510 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030419AbeBNOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:23:19 -0500
X-Google-Smtp-Source: AH8x226Ei1xq4aCDTDwXgkjO4ORj8fOLO359IWsyC5AIraYEBpXYvMIX63U6uimKJPb0MD3A3H6gy7uUgxZfEyxRMeI=
MIME-Version: 1.0
In-Reply-To: <fa1d8118-6879-a984-4cd9-0e0da98c467b@st.com>
References: <1516114580-2424-1-git-send-email-ludovic.Barre@st.com> <fa1d8118-6879-a984-4cd9-0e0da98c467b@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:23:17 +0100
X-Google-Sender-Auth: V0v1d01aeku3pY6ALq9am_E3yR4
Message-ID: <CAK8P3a16=B9g1cBxOfecgkt2KWthGLJOhg1AkrGEnxjZ-euLQA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] ARM: stm32: add initial STM32MPU support
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Ludovic Barre <ludovic.Barre@st.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:05 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Arnd,
>
> On 01/16/2018 03:56 PM, Ludovic Barre wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch series extends the existing STM32 microcontrollers (MCUs)
>> family to microprocessors (MPUs). The MPU platform (based on
>> Arm Cortex-A) is a continuation of the MCU one (based on Arm
>> Cortex-M) in that it shares a wide number of hardware blocks.
>>
>> change v5:
>> -fix serial3 aliases by serial0
>>   change v4:
>> -Add all available uarts in stm32mp157c
>> -Move uart aliases to board files
>>
>> change v3:
>> -Remove bootargs
>> -Remove armv7m_restart and Share stm32_compat for mcu/mpu
>> -Modify stm32 kconfig with Arnd template
>> -Remove patch below (Linus W: Patch applied)
>>   devicetree: bindings: Document supported STM32 SoC family
>>   pinctrl: stm32: Add STM32MP157 MPU support
>>
>> change V2:
>> -Add stm32 documentation in this serie to avoid merge conflict
>> thread: "https://patchwork.kernel.org/patch/10102573/";
>> -Split bindings (stm32.txt) to separate patches.
>> -Remove ARCH_STM32_MCU/MPU flags
>> -Adopt rst format for Documentation/arm/stm32 files
>> -s/STMicrolectronics/STMicroelectronics/g
>>  > Ludovic Barre (7):
>>    Documentation: arm: stm32: move to rst format
>>    ARM: stm32: prepare stm32 family to welcome armv7 architecture
>>    dt-bindings: stm32: add support of STM32MP157
>>    ARM: stm32: add initial support for STM32MP157
>>    ARM: configs: multi_v7: add stm32 support
>>    ARM: dts: stm32: add stm32mp157c initial support
>>    ARM: dts: stm32: add initial support of stm32mp157c eval board
>>
> I will merge stm32 DT patches and mach-stm32 patches in my next pull
> requests.
> What about Documentation patch and multi-v7 config patch ?
> (I could add Documentation patch in my DT pull request)

Please make the DT pull request have only DT related changes including
header files that are needed by DT and binding documentation, but
have the rest in a separate pull request.

       Arnd
