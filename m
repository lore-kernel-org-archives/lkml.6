Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeDTJgV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:36:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36993 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754229AbeDTJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:35:52 -0400
X-Google-Smtp-Source: AIpwx48rJV1quaFqRlHcx3MukdTplE3GqhO3t4iLcySZUvHp/WvKAQSngtWpqrb3vtLHsUYVViBQNw==
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3
 sid controller
To: Kyle Evans <kevans@freebsd.org>, icenowy@aosc.io
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, quentin.schulz@free-electrons.com,
        edu.molinas@gmail.com, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-15-embed3d@gmail.com>
 <20180129095200.attg7cgvpifpchtn@flea.lan>
 <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
 <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
 <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
 <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
Date: Fri, 20 Apr 2018 11:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

I'm already working on a Version 3 of this patch series. Right now this 
slowed down since I'm very busy and the ToDo-List is still very long.

My plan is to send out a version during this release cycle.

If you need it right now feel free to submit patches!

Philipp

On 19.04.2018 17:19, Kyle Evans wrote:
> On Thu, Apr 19, 2018 at 10:13 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>>
>> 于 2018年4月19日 GMT+08:00 下午11:11:22, Kyle Evans <kevans@freebsd.org> 写到:
>>> On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.com>
>>> wrote:
>>>>
>>>>
>>>> On 29.01.2018 10:52, Maxime Ripard wrote:
>>>>>
>>>>> On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
>>>>>>
>>>>>> This patch enables the the sid controller in the H3. It can be used
>>>>>> for thermal calibration data.
>>>>>>
>>>>>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>>>>>> ---
>>>>>>    arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>>>>>    1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>> b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>> index 3f83f6a27c74..9bb5cc29fec5 100644
>>>>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>>> @@ -72,6 +72,13 @@
>>>>>>                  };
>>>>>>          };
>>>>>>    +     soc {
>>>>>> +               sid: eeprom@1c14000 {
>>>>>> +                       compatible = "allwinner,sun8i-h3-sid";
>>>>>> +                       reg = <0x01c14000 0x400>;
>>>>>> +               };
>>>>>> +       };
>>>>>> +
>>>>>
>>>>>
>>>>> Shouldn't you also use a nvmem-cells property to the THS node?
>>>>>
>>>>> Maxime
>>>>>
>>>>
>>>> Oh seems like I forgot that.
>>>> As related to the wiki [1] this should be 64 bit wide at the address
>>> 0x34. I
>>>> will add that in the next version.
>>>>
>>>>
>>>> [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
>>>>
>>>> Thanks,
>>>> Philipp
>>>>
>>>
>>> Hi,
>>>
>>> Any chance this will see a v3 soon? I'm kind of interested in sid node
>>> for h3. =)
>>
>> This patch is independent and can be easily sent out
>> by its own.
>>
> 
> Right- I had considered doing so, but wanted to make sure I wasn't
> going to collide with this series if a v3 is imminent.
> 
