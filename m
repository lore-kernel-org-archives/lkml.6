Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDSPLs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:11:48 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:28615 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752530AbeDSPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:11:46 -0400
X-Google-Smtp-Source: AIpwx4/vu0mKFps/0fu3HlJnMbbaCu7p4mKAZfTzMTFgxSOjiuiVxzPNYs7+9rjkFnO9mIZO+eKvdlvuLGjzKFndbZg=
MIME-Version: 1.0
In-Reply-To: <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com> <20180128232919.12639-15-embed3d@gmail.com>
 <20180129095200.attg7cgvpifpchtn@flea.lan> <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
From: Kyle Evans <kevans@freebsd.org>
Date: Thu, 19 Apr 2018 10:11:22 -0500
X-Gmail-Original-Message-ID: <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
Message-ID: <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3
 sid controller
To: embed3d@gmail.com
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, quentin.schulz@free-electrons.com, icenowy@aosc.io,
        edu.molinas@gmail.com, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.com> wrote:
>
>
> On 29.01.2018 10:52, Maxime Ripard wrote:
>>
>> On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
>>>
>>> This patch enables the the sid controller in the H3. It can be used
>>> for thermal calibration data.
>>>
>>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>>> ---
>>>   arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>>> b/arch/arm/boot/dts/sun8i-h3.dtsi
>>> index 3f83f6a27c74..9bb5cc29fec5 100644
>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>> @@ -72,6 +72,13 @@
>>>                 };
>>>         };
>>>   +     soc {
>>> +               sid: eeprom@1c14000 {
>>> +                       compatible = "allwinner,sun8i-h3-sid";
>>> +                       reg = <0x01c14000 0x400>;
>>> +               };
>>> +       };
>>> +
>>
>>
>> Shouldn't you also use a nvmem-cells property to the THS node?
>>
>> Maxime
>>
>
> Oh seems like I forgot that.
> As related to the wiki [1] this should be 64 bit wide at the address 0x34. I
> will add that in the next version.
>
>
> [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
>
> Thanks,
> Philipp
>

Hi,

Any chance this will see a v3 soon? I'm kind of interested in sid node
for h3. =)

Thanks,

Kyle Evans
