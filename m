Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbeBGQBI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:01:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52797 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeBGQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:01:06 -0500
X-Google-Smtp-Source: AH8x225eT1Yzbg72vZXeqSqgyOaGEs/hvrqGmn0gCHxP/+9Mu2l9YWPE01MUpmwiWixkmbEYqHhbdQ==
Subject: Re: [PATCH] arm: dts: mt7623: enable all four available UARTs on
 bananapi-r2
To: Sean Wang <sean.wang@mediatek.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <b4e84a68da76c1ca538150a730777ff530c1db5a.1513922513.git.sean.wang@mediatek.com>
 <dc3c28c7-03c3-f1c6-39c1-b8df8be4fac3@gmail.com>
 <1514043318.30687.10.camel@mtkswgap22> <1516697505.12197.30.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cd1df7f9-89f4-06d5-5384-9f3b9f7ade48@gmail.com>
Date: Wed, 7 Feb 2018 17:01:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1516697505.12197.30.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/23/2018 09:51 AM, Sean Wang wrote:
> On Sat, 2017-12-23 at 23:35 +0800, Sean Wang wrote:
>> On Sat, 2017-12-23 at 08:52 +0100, Matthias Brugger wrote:
>>>
>>> On 12/22/2017 07:06 AM, sean.wang@mediatek.com wrote:
>>>> From: Sean Wang <sean.wang@mediatek.com>
>>>>
>>>> On bpi-r2 board, totally there're four uarts which we usually called
>>>> uart[0-3] helpful to extend slow I/O devices. Among those ones, uart2 has
>>>> dedicated pin slot which is used to conolse log. uart[0-1] appear at the
>>>> 40-pins connector and uart3 has no pinout, but just has test points (TP47
>>>> for TX and TP48 for RX, respectively) nearby uart2. Also, some missing
>>>> pinctrl is being complemented for those devices.
>>>>
>>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>>> ---
>>>>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 26 ++++++++++++++++++++++++--
>>>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>>>> index 7bf5aa2..64bf5db 100644
>>>> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>>>> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>>>> @@ -409,6 +409,20 @@
>>>>  				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
>>>>  		};do you like it or quite want me to remove the uart3 node?
>>>>  	};
>>>> +
>>>> +	uart2_pins_a: uart@2 {
>>>> +		pins_dat {
>>>> +			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
>>>> +				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	uart3_pins_a: uart@3 {
>>>> +		pins_dat {
>>>> +			pinmux = <MT7623_PIN_242_URTS2_FUNC_URTS2>,
>>>> +				 <MT7623_PIN_243_UCTS2_FUNC_UTXD3>;
>>>> +		};
>>>> +	};
>>>>  };
>>>>  
>>>>  &pwm {
>>>> @@ -454,16 +468,24 @@
>>>>  &uart0 {
>>>>  	pinctrl-names = "default";
>>>>  	pinctrl-0 = <&uart0_pins_a>;
>>>> -	status = "disabled";
>>>> +	status = "okay";
>>>>  };
>>>>  
>>>>  &uart1 {
>>>>  	pinctrl-names = "default";
>>>>  	pinctrl-0 = <&uart1_pins_a>;
>>>> -	status = "disabled";
>>>> +	status = "okay";
>>>>  };
>>>>  
>>>>  &uart2 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&uart2_pins_a>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&uart3 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&uart3_pins_a>;
>>>>  	status = "okay";
>>>>  };
>>>>  
>>>
>>> Why do we want to enable uart3 when there are only test points?
>>> It is not very useful, or do I oversee something?
>>>
> 
>> I have been listening to the sound from potential users of bpi-r2 to
>> understand what assistance I have to provide to them. Something could
>> be seen through [1] in the forum to know they had been trying hard to
>> explore all available UARTs from the SoC in the last weeks. The patch
>> should be really useful for these people and for the extra soldering
>> it shouldn't become a problem for these makers.
>>
>> [1] http://forum.banana-pi.org/t/gpio-uart-not-the-debug-port/3748
>>
>> 	Sean 
>>
> 
> Hi, Matthias
> 
> do you like it or quite want me to remove the uart3 node?
> 
> I can take it into account along with other pending dts changes in my
> queue.
> 

Sorry for the late answer.
Do I understand correctly that uart3 is routed to TP47 and TP48, and these test
points are accessible through the SATA connector? Doesn't they break SATA then?

I think as they are only available through a non-documented test point, we
shouldn't enable it.

Regards,
Matthias
