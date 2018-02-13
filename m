Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966045AbeBMWWQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:22:16 -0500
Received: from gloria.sntech.de ([95.129.55.99]:36154 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965935AbeBMWWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:22:15 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@gmail.com>,
        Rob Herring <robh@kernel.org>, Brian Norris <briannorris@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        William wu <wulf@rock-chips.com>, kernel@collabora.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 2/3] Documentation: bindings: add usb3-host-disable and usb3-host-port for Rockchip USB Type-C PHY
Date: Tue, 13 Feb 2018 23:22:09 +0100
Message-ID: <6549869.GHAcyYtscp@diego>
In-Reply-To: <CAFqH_50=d3Z-JWiFnxnCm0pF_bpyWG9-9M1mk5nQUYUwZh-Yyw@mail.gmail.com>
References: <20180208152028.9997-1-enric.balletbo@collabora.com> <CANBLGcykb99SntD=C67_-iUoZZLeFfMw8jZWdF9fmFss3u24iA@mail.gmail.com> <CAFqH_50=d3Z-JWiFnxnCm0pF_bpyWG9-9M1mk5nQUYUwZh-Yyw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Dienstag, 13. Februar 2018, 23:08:26 CET schrieb Enric Balletbo Serra:
> 2018-02-13 10:18 GMT+01:00 Emil Renner Berthing
> 
> <emil.renner.berthing@gmail.com>:
> > On 12 February 2018 at 23:29, Rob Herring <robh@kernel.org> wrote:
> >> On Mon, Feb 12, 2018 at 3:26 PM, Brian Norris <briannorris@chromium.org> 
wrote:
> >>> Hi,
> >>> 
> >>> On Mon, Feb 12, 2018 at 10:43:41AM -0600, Rob Herring wrote:
> >>>> On Thu, Feb 8, 2018 at 3:23 PM, Enric Balletbo Serra
> >>>> 
> >>>> <eballetbo@gmail.com> wrote:
> >>>> > 2018-02-08 18:52 GMT+01:00 Rob Herring <robh@kernel.org>:
> >>>> >> On Thu, Feb 8, 2018 at 9:20 AM, Enric Balletbo i Serra
> >>>> >> 
> >>>> >> <enric.balletbo@collabora.com> wrote:
> >>>> >>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>>> >>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> >>>> >>> @@ -36,6 +36,12 @@ offset, enable bit, write mask bit.
> >>>> >>> 
> >>>> >>>   - rockchip,uphy-dp-sel : the register of type-c phy enable DP
> >>>> >>>   function
> >>>> >>>   
> >>>> >>>     for type-c phy0, it must be <0x6268 19 19>;
> >>>> >>>     for type-c phy1, it must be <0x6268 3 19>;
> >>>> >>> 
> >>>> >>> + - rockchip,usb3-host-disable : the register of type-c phy disable
> >>>> >>> usb3 host +   for type-c phy0, it must be <0x2434 0 16>;
> >>>> >>> +   for type-c phy1, it must be <0x2444 0 16>;
> >>>> >>> + - rockchip,usb3-host-port : the register of type-c phy usb3 port
> >>>> >>> number
> >>>> >>> +   for type-c phy0, it must be <0x2434 12 28>;
> >>>> >>> +   for type-c phy1, it must be <0x2444 12 28>;
> >>>> >> 
> >>>> >> When does this list stop? Adding properties for various register
> >>>> >> fields doesn't scale. This information should be in the driver and
> >>>> >> based on the compatible string if necessary.
> >>>> > 
> >>>> > I see, seams reasonable to me, is this applicable to the new ones
> >>>> > only
> >>>> > or I should get rid of all the proprieties like this from the DT
> >>>> > (including the old ones)?
> >>>> 
> >>>> We're already kind of stuck with the existing ones. So it depends if
> >>>> people want to phase them out or not.
> >>> 
> >>> FWIW, any Chrome{device} using these sort of bindings is perfectly
> >>> capable of handling changed bindings (we ship DTBs with the kernel). But
> >>> that's not typically how mainline covers binding deprecation.
> >> 
> >> If it's CrOS only that's using these, then it's really up to you all.
> >> I guess it depends if many folks are trying to run mainline on CrOS
> >> devices and don't necessarily keep things in sync.
> > 
> > For what it's worth I run mainline on my Chromebook Plus
> > (rk3399-gru-kevin), but in order to have a somewhat working setup you
> > need to run
> > 4.16-rc1 + various patches from the rockchip mailing list which means
> > you have to keep up with the latest mainline (both kernel and devicetree)
> > anyway. So I'm all in favour of cleaning up the devicetree.
> > 
> >>> If we're going to start recommending not putting these offsets in the
> >>> DT, I'd vote for deprecating them, for consistency. (Otherwise, we'll
> >>> keep running into this same question.) We only documented the RK3399
> >>> ("rockchip,rk3399-typec-phy") binding, so all users should have the same
> >>> offsets. I dunno if/how we pick a time for eventually removing the
> >>> bindings entirely.
> >> 
> >> Yes, makes sense.
> 
> One question, maybe silly question, that comes to my mind is, as the
> offsets for same register are different between type-c phy0 and type-c
> phy1 and there is two instances, the driver needs to know which type-c
> phyter is and I'm not sure the proper way to do it. It is just check
> the type-c phyter base address? So if base address is 0xff7c0000
> (phy0) we know that we should apply the offsets for phy0 and if base
> address is 0xff800000 we know that we should apply the offsets for
> phy1?

sounds reasonable and we already did something similar for example
for the inno-usb2 phys where you can find the struct rockchip_usb2phy_cfg
matching against a reg property. GRF reg offset in that case but
matching against the base address for the type-c phy should therefore
be fine as well.


Heiko
