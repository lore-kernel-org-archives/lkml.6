Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEDBo2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:44:28 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:25401 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEDBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:44:27 -0400
Subject: Re: [PATCH] ARM64: dts: meson-axg: enable AP6255 wifi module
To: Kevin Hilman <khilman@baylibre.com>
References: <20180423145729.14368-1-yixun.lan@amlogic.com>
 <7h7eos1n68.fsf@baylibre.com>
 <30de15b8-4cc4-7f97-d134-7af75cb6ace1@amlogic.com>
 <CAOi56cXKmv_Us1wDcMOYbdjFzZcLVu_t210Yrv891wKi22hV8A@mail.gmail.com>
CC: <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <2cbd74df-ab25-f6f3-df0e-f58a083eb834@amlogic.com>
Date: Fri, 4 May 2018 09:44:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAOi56cXKmv_Us1wDcMOYbdjFzZcLVu_t210Yrv891wKi22hV8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Kevin

On 04/30/18 23:35, Kevin Hilman wrote:
> On Fri, Apr 27, 2018 at 6:56 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>> On 04/28/18 03:09, Kevin Hilman wrote:
>>> Yixun Lan <yixun.lan@amlogic.com> writes:
>>>
>>>> The Meson-AXG S400 board is shipped with AP6255 wifi module,
>>>> which is actually using the brcmfmac 43455 driver.
>>>>
>>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>> ---
>>>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
>>>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>>> index f67d4e47e641..b3e1bdca32bb 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>>> @@ -51,7 +51,16 @@
>>>>
>>>>      sdio_pwrseq: sdio-pwrseq {
>>>>              compatible = "mmc-pwrseq-simple";
>>>> -            reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>>>> +            reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
>>>
>>> You didn't mention this GPIO change in the changelog.  Is it
>>> intentional?
>>
>> Yes, the 'sdio_pwrseq' is used by wifi driver till now
>> previous the reset-gpio is wrongly configured (copy & paste error),
>> according to the schematics, it's GPIOX_7 which need to be fixed here.
>>
>> to be clean, in s400 board
>>  GPIOX_6 is WIFI_WAKE_HOST pin
>>  GPIOX_7 is WIFI_PWREN pin
>>
>> do you want me to put a note into the commit message? and resend this patch?
> 
> OK, thanks for the explanation.
> 
> I'd prefer the GPIO pin fix as a separate, standalone patch.
> 
> Thanks,
> 
> Kevin
> 
> .
> 

As we already talked offline, this error was introduced exactly in the
v4.18 cycle, so I will send a fix which can be squashed into the old commit

Yixun
