Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeCEORE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeCEOQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:16:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BD121777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELst9XQjR7Zfzp4BzI0JW0o+RlVBi5XKdws4vDuSkbyXfvb/A77yOK0PZdj5V+1M80awQRAm/lT6xsIMf1dBJbY=
MIME-Version: 1.0
In-Reply-To: <1520033229.8089.198.camel@mtkswgap22>
References: <cover.1519378871.git.sean.wang@mediatek.com> <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
 <20180302154215.xr3b2zlmuojw5i6l@rob-hp-laptop> <1520033229.8089.198.camel@mtkswgap22>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Mar 2018 08:16:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLO7YG+6LKa-5nvQzxpvU9MF5Y=1gZKogeCqGiW-dV3zw@mail.gmail.com>
Message-ID: <CAL_JsqLO7YG+6LKa-5nvQzxpvU9MF5Y=1gZKogeCqGiW-dV3zw@mail.gmail.com>
Subject: Re: [PATCH v1 16/19] arm: dts: mt7623: fixup available memory size on bananapi-r2
To: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 5:27 PM, Sean Wang <sean.wang@mediatek.com> wrote:
> On Fri, 2018-03-02 at 09:42 -0600, Rob Herring wrote:
>> On Fri, Feb 23, 2018 at 06:16:36PM +0800, sean.wang@mediatek.com wrote:
>> > From: Sean Wang <sean.wang@mediatek.com>
>> >
>> > There is 2GB DDR3 available on bananapi-r2 board as [1] specified.
>> >
>> > [1] http://www.banana-pi.org/r2.html
>> >
>> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> > ---
>> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> > index 140ff78..3e8d02c 100644
>> > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> > @@ -38,6 +38,11 @@
>> >                     default-state = "off";
>> >             };
>> >     };
>> > +
>> > +   memory {
>>
>> Unit address?
>>
>
> If I did it with adding unit address
>
> -       memory {
> +       memory@80000000 {
>                 device_type = "memory";
>                 reg = <0 0x80000000 0 0x80000000>;
>         };
>
>
> bad dtc blob is being generated and contains two memory nodes, one is
> memory and the other is memory@80000000 whose blob disassembly detail is
> as the following.
>
>       memory {
>                 device_type = "memory";
>                 reg = <0x0 0x0 0x0 0x0>;
>         };
>
>
>
>       memory@80000000 {
>                 device_type = "memory";
>                 reg = <0x0 0x80000000 0x0 0x80000000>;
>         };
>
>
> and bad memory node with size 0 would cause the boot fails.
>
>
> is it a dtc compiler problem ?

No, you are declaring "memory" node somewhere else. Perhaps using
skeleton.dtsi which we are trying to remove or you have some default.

Using just 'memory' is fine if the base address is variable and
determined at boot time or you have a bootloader that expects just
'memory'. Otherwise, this should be fixed, but you can do that after
this patch if you want.

Rob
