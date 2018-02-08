Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeBHVXh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:23:37 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41420 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:23:35 -0500
X-Google-Smtp-Source: AH8x226soCeMJe3d0CXf6YQEN25Z7kRXPCCF9TGFBzDqCR++SGvmcy7sI3CKO/rKTEMyDAGfVG+KbQRrUi5e4ghj9NA=
MIME-Version: 1.0
In-Reply-To: <CABGGisyaqV5HtTUL5LdjH3ZcU3_RTPmzMvEAhv5wZjCD_XCujg@mail.gmail.com>
References: <20180208152028.9997-1-enric.balletbo@collabora.com>
 <20180208152028.9997-2-enric.balletbo@collabora.com> <CABGGisyaqV5HtTUL5LdjH3ZcU3_RTPmzMvEAhv5wZjCD_XCujg@mail.gmail.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 8 Feb 2018 22:23:33 +0100
Message-ID: <CAFqH_53-iN9m=U+WdQh6_rKyxE5c9RUQO9qD1QaY0QePM_pOZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: bindings: add usb3-host-disable and
 usb3-host-port for Rockchip USB Type-C PHY
To: Rob Herring <robh@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        huang lin <hl@rock-chips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

2018-02-08 18:52 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Thu, Feb 8, 2018 at 9:20 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> From: William wu <wulf@rock-chips.com>
>>
>> rockchip,usb3-host-disable is the register of type-c phy disable usb3 host
>> rockchip,usb3-host-port is the register of type-c phy usb3 port number
>>
>> Signed-off-by: William wu <wulf@rock-chips.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> index c3be83be9615..9085d95d0079 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> @@ -36,6 +36,12 @@ offset, enable bit, write mask bit.
>>   - rockchip,uphy-dp-sel : the register of type-c phy enable DP function
>>     for type-c phy0, it must be <0x6268 19 19>;
>>     for type-c phy1, it must be <0x6268 3 19>;
>> + - rockchip,usb3-host-disable : the register of type-c phy disable usb3 host
>> +   for type-c phy0, it must be <0x2434 0 16>;
>> +   for type-c phy1, it must be <0x2444 0 16>;
>> + - rockchip,usb3-host-port : the register of type-c phy usb3 port number
>> +   for type-c phy0, it must be <0x2434 12 28>;
>> +   for type-c phy1, it must be <0x2444 12 28>;
>
> When does this list stop? Adding properties for various register
> fields doesn't scale. This information should be in the driver and
> based on the compatible string if necessary.
>

I see, seams reasonable to me, is this applicable to the new ones only
or I should get rid of all the proprieties like this from the DT
(including the old ones)?

Thanks,
  Enric

> Rob
