Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeBLWaK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932628AbeBLWaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:30:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F361217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x225huBAiXv1ue8rvv8UuhQMNy4A+1uN42RTyKUQT7IHlMyFE/RtKERGlkoILfMiwj1ayZtTFrMdAGwVD6BsM5bQ=
MIME-Version: 1.0
In-Reply-To: <20180212212643.GA37044@ban.mtv.corp.google.com>
References: <20180208152028.9997-1-enric.balletbo@collabora.com>
 <20180208152028.9997-2-enric.balletbo@collabora.com> <CABGGisyaqV5HtTUL5LdjH3ZcU3_RTPmzMvEAhv5wZjCD_XCujg@mail.gmail.com>
 <CAFqH_53-iN9m=U+WdQh6_rKyxE5c9RUQO9qD1QaY0QePM_pOZA@mail.gmail.com>
 <CAL_JsqLvkPEm1mZaEfEVFEYMoGvOsbSQb8c35UvjmRTCwrCF8Q@mail.gmail.com> <20180212212643.GA37044@ban.mtv.corp.google.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Feb 2018 16:29:46 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+iqc8SB-=8mRbsvBg6XB+hjUcRrbEtUhDWiXVNZetcrA@mail.gmail.com>
Message-ID: <CAL_Jsq+iqc8SB-=8mRbsvBg6XB+hjUcRrbEtUhDWiXVNZetcrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: bindings: add usb3-host-disable and
 usb3-host-port for Rockchip USB Type-C PHY
To: Brian Norris <briannorris@chromium.org>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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

On Mon, Feb 12, 2018 at 3:26 PM, Brian Norris <briannorris@chromium.org> wrote:
> Hi,
>
> On Mon, Feb 12, 2018 at 10:43:41AM -0600, Rob Herring wrote:
>> On Thu, Feb 8, 2018 at 3:23 PM, Enric Balletbo Serra
>> <eballetbo@gmail.com> wrote:
>> > 2018-02-08 18:52 GMT+01:00 Rob Herring <robh@kernel.org>:
>> >> On Thu, Feb 8, 2018 at 9:20 AM, Enric Balletbo i Serra
>> >> <enric.balletbo@collabora.com> wrote:
>> >>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> >>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> >>> @@ -36,6 +36,12 @@ offset, enable bit, write mask bit.
>> >>>   - rockchip,uphy-dp-sel : the register of type-c phy enable DP function
>> >>>     for type-c phy0, it must be <0x6268 19 19>;
>> >>>     for type-c phy1, it must be <0x6268 3 19>;
>> >>> + - rockchip,usb3-host-disable : the register of type-c phy disable usb3 host
>> >>> +   for type-c phy0, it must be <0x2434 0 16>;
>> >>> +   for type-c phy1, it must be <0x2444 0 16>;
>> >>> + - rockchip,usb3-host-port : the register of type-c phy usb3 port number
>> >>> +   for type-c phy0, it must be <0x2434 12 28>;
>> >>> +   for type-c phy1, it must be <0x2444 12 28>;
>> >>
>> >> When does this list stop? Adding properties for various register
>> >> fields doesn't scale. This information should be in the driver and
>> >> based on the compatible string if necessary.
>> >>
>> >
>> > I see, seams reasonable to me, is this applicable to the new ones only
>> > or I should get rid of all the proprieties like this from the DT
>> > (including the old ones)?
>>
>> We're already kind of stuck with the existing ones. So it depends if
>> people want to phase them out or not.
>
> FWIW, any Chrome{device} using these sort of bindings is perfectly
> capable of handling changed bindings (we ship DTBs with the kernel). But
> that's not typically how mainline covers binding deprecation.

If it's CrOS only that's using these, then it's really up to you all.
I guess it depends if many folks are trying to run mainline on CrOS
devices and don't necessarily keep things in sync.

> If we're going to start recommending not putting these offsets in the
> DT, I'd vote for deprecating them, for consistency. (Otherwise, we'll
> keep running into this same question.) We only documented the RK3399
> ("rockchip,rk3399-typec-phy") binding, so all users should have the same
> offsets. I dunno if/how we pick a time for eventually removing the
> bindings entirely.

Yes, makes sense.

Rob
