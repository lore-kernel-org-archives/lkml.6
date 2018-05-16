Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeEPIoS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:44:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28031 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751728AbeEPIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:44:14 -0400
Subject: Re: [RESEND PATCH v5 0/6] Add support for PWM input capture on STM32
To: Lee Jones <lee.jones@linaro.org>
CC: <alexandre.torgue@st.com>, <thierry.reding@gmail.com>,
        <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
 <20180516080635.GE5130@dell>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <c48acc96-1eca-9adc-abb7-131921305ee8@st.com>
Date: Wed, 16 May 2018 10:43:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516080635.GE5130@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 10:06 AM, Lee Jones wrote:
> On Wed, 16 May 2018, Fabrice Gasnier wrote:
> 
>> This series adds support for capture to stm32-pwm driver.
>> Capture is based on DMAs.
>> - First two patches add support for requesting DMAs to MFD core
>> - Next three patches add support for capture to stm32-pwm driver
>> - This has been tested on stm32429i-eval board.
>>
>> ---
>> Changes in v5:
>> - update patch 2 (mfd: stm32-timers: add support for dmas)
>>   move stm32_timers_dma struct to header file,
>>   fix warning on dma_mapping_error().
>>
>> Changes in v4:
>> - Lee's comments on patch 2 (mfd: stm32-timers: add support for dmas)
>>   Add kerneldoc header, better format comments.
>>
>> Changes in v3:
>> - Dropped 2 precusor patches applied by Thierry in pwm tree:
>>   "pwm: stm32: fix, remove unused struct device"
>>   "pwm: stm32: protect common prescaler for all channels"
>> - Note: this series applies on top on pwm tree
>> - Implements Lee's comments on MFD part: rework stm32_timers_dma struct,
>>   exported routine prototype now use generic device struct, more
>>   various comments (see patch 2 changelog).
>>
>> Resend v2:
>> - Add collected Acks
>>
>> Changes in v2:
>> - Abstract DMA handling from child driver: move it to MFD core
>> - Rework pwm capture routines to adopt this change
>> - Comment on optional dma support, beautify DMAs probe
>>
>> Fabrice Gasnier (6):
>>   dt-bindings: mfd: stm32-timers: add support for dmas
>>   mfd: stm32-timers: add support for dmas
>>   pwm: stm32: add capture support
>>   pwm: stm32: improve capture by tuning counter prescaler
>>   pwm: stm32: use input prescaler to improve period capture
>>   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> 
> Applied patches 1-5.

Many thanks Lee !

Maybe I missed something, but just in case...
In your pull request ("[GIT PULL] Immutable branch between MFD and PWM
due for the v4.18 merge window") I only see 4 patches:
Fabrice Gasnier (4):
      mfd: stm32-timers: Add support for DMAs
      pwm: stm32: Add capture support
      pwm: stm32: Improve capture by tuning counter prescaler
      pwm: stm32: Use input prescaler to improve period capture

I can't see patch 1 ("dt-bindings: mfd: stm32-timers: add support for dmas")
Is it applied on another tree ?

Best Regards,
Fabrice

> 
>>  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
>>  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
>>  drivers/mfd/stm32-timers.c                         | 201 +++++++++++++++-
>>  drivers/pwm/pwm-stm32.c                            | 257 +++++++++++++++++++++
>>  include/linux/mfd/stm32-timers.h                   |  58 +++++
>>  5 files changed, 537 insertions(+), 2 deletions(-)
>>
> 
