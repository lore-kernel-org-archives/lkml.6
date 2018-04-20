Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbeDTK6Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:58:25 -0400
Received: from gloria.sntech.de ([95.129.55.99]:51118 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754462AbeDTK6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:58:23 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        robh+dt@kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        dianders@google.com, groeck@google.com, kernel@collabora.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/6] dt-bindings: clock: add DDR3 standard speed bins.
Date: Fri, 20 Apr 2018 12:58:10 +0200
Message-ID: <39099779.d2GlTJ02DA@phil>
In-Reply-To: <62c4b6f0-e67c-8e25-a129-bf0c06c5157b@collabora.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com> <5662116.zj93FbmDPb@phil> <62c4b6f0-e67c-8e25-a129-bf0c06c5157b@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Donnerstag, 19. April 2018, 13:30:16 CEST schrieb Enric Balletbo i Serra:
> On 19/04/18 13:10, Heiko Stuebner wrote:
> > Am Donnerstag, 19. April 2018, 12:40:15 CEST schrieb Enric Balletbo i Serra:
> >> DDR3 SDRAM Standard (JESD79-3F) defines some standard speed bins for
> >> DDR3 memories. The devfreq/rk3399_dmc.txt binding refers to this file
> >> which does not exist, so add a ddr.h file with the standard speed bins
> >> for DDR3.
> >>
> >> Fixes: c1ceb8f7c167 (Documentation: bindings: add dt documentation for rk3399 dmc)
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >>  include/dt-bindings/clock/ddr.h | 34 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>  create mode 100644 include/dt-bindings/clock/ddr.h
> >>
> >> diff --git a/include/dt-bindings/clock/ddr.h b/include/dt-bindings/clock/ddr.h
> >> new file mode 100644
> >> index 000000000000..506aef7e609e
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/ddr.h
> >> @@ -0,0 +1,34 @@
> >> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> >> +
> >> +#ifndef DT_BINDINGS_DDR_H
> >> +#define DT_BINDINGS_DDR_H
> >> +
> >> +/* DDR3-800 Standard Speed Bins */
> >> +#define DDR3_800D	15
> >> +#define DDR3_800E		18
> >> +/* DDR3-1066 Standard Speed Bins */
> >> +#define DDR3_1066E	18
> >> +#define DDR3_1066F	21
> >> +#define DDR3_1066G	24
> > 
> > looking at the mentioned jedec standard, I don't see where these numerical
> > values are defined in the standard itself. [I may be blind though]
> > 
> 
> Damm it. No, you're not blind. I did an horrible mistake adding an old version
> of this file. It's wrong, that is supposed to be there is DDR3 table available
> in the ATF [1] not this.

Mistakes can always happen ... so no problem :-) .


>         /* 5-5-5 */
> 	DDR3_800D = 0,
> 	/* 6-6-6 */
> 	DDR3_800E = 1,
> 	/* 6-6-6 */
> 	DDR3_1066E = 2,
> 	/* 7-7-7 */
> 	DDR3_1066F = 3,
>         ...
> 
> The value is passed directly to the ATF so the above values are the correct.
> 
> One question that I have on my mind is if this file should be called as is or if
> will be better name as atf-ddr.h or something like that.
> ddr.h -> atf-ddr.h

The more interesting question would be if this isn't a very much rockchip
or even rk3399-specific scheme. So such a generic header name looks very
much out of place (also including the very generic constant names).

So far the only upstream ATF implementation is for the rk3399.


Heiko

> 
> [1]
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3399/drivers/dram/dram_spec_timing.h
>
> Sorry about that. Guess it's needed a v2 but let's wait a little bit for if more
> discussion arises.
> 
> Best regards,
>   Enric
> 
> > Could you explain a bit more where these numerical values are coming from?
> > 
> > 
> > Thanks
> > Heiko
> > 
> 
> 
