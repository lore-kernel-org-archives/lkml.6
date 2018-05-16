Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeEPKN2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:13:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40309 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752799AbeEPKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:13:12 -0400
X-Google-Smtp-Source: AB8JxZp9elusjZ7TRZLaVbPirIBhaokvU9AhJdGnNX61R7e6pvamnk0bY+xQFztDTNTxEmejGeoXFQ==
Date: Wed, 16 May 2018 11:13:08 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, thierry.reding@gmail.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v5 0/6] Add support for PWM input capture on STM32
Message-ID: <20180516101308.GH5130@dell>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
 <20180516080635.GE5130@dell>
 <c48acc96-1eca-9adc-abb7-131921305ee8@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c48acc96-1eca-9adc-abb7-131921305ee8@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Fabrice Gasnier wrote:

> On 05/16/2018 10:06 AM, Lee Jones wrote:
> > On Wed, 16 May 2018, Fabrice Gasnier wrote:
> > 
> >> This series adds support for capture to stm32-pwm driver.
> >> Capture is based on DMAs.
> >> - First two patches add support for requesting DMAs to MFD core
> >> - Next three patches add support for capture to stm32-pwm driver
> >> - This has been tested on stm32429i-eval board.
> >>
> >> ---
> >> Changes in v5:
> >> - update patch 2 (mfd: stm32-timers: add support for dmas)
> >>   move stm32_timers_dma struct to header file,
> >>   fix warning on dma_mapping_error().
> >>
> >> Changes in v4:
> >> - Lee's comments on patch 2 (mfd: stm32-timers: add support for dmas)
> >>   Add kerneldoc header, better format comments.
> >>
> >> Changes in v3:
> >> - Dropped 2 precusor patches applied by Thierry in pwm tree:
> >>   "pwm: stm32: fix, remove unused struct device"
> >>   "pwm: stm32: protect common prescaler for all channels"
> >> - Note: this series applies on top on pwm tree
> >> - Implements Lee's comments on MFD part: rework stm32_timers_dma struct,
> >>   exported routine prototype now use generic device struct, more
> >>   various comments (see patch 2 changelog).
> >>
> >> Resend v2:
> >> - Add collected Acks
> >>
> >> Changes in v2:
> >> - Abstract DMA handling from child driver: move it to MFD core
> >> - Rework pwm capture routines to adopt this change
> >> - Comment on optional dma support, beautify DMAs probe
> >>
> >> Fabrice Gasnier (6):
> >>   dt-bindings: mfd: stm32-timers: add support for dmas
> >>   mfd: stm32-timers: add support for dmas
> >>   pwm: stm32: add capture support
> >>   pwm: stm32: improve capture by tuning counter prescaler
> >>   pwm: stm32: use input prescaler to improve period capture
> >>   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> > 
> > Applied patches 1-5.
> 
> Many thanks Lee !
> 
> Maybe I missed something, but just in case...
> In your pull request ("[GIT PULL] Immutable branch between MFD and PWM
> due for the v4.18 merge window") I only see 4 patches:
> Fabrice Gasnier (4):
>       mfd: stm32-timers: Add support for DMAs
>       pwm: stm32: Add capture support
>       pwm: stm32: Improve capture by tuning counter prescaler
>       pwm: stm32: Use input prescaler to improve period capture
> 
> I can't see patch 1 ("dt-bindings: mfd: stm32-timers: add support for dmas")
> Is it applied on another tree ?

Good spot.

Looks like a fumbled the key combination for the bindings patch.

Pull-request to follow.

> >>  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
> >>  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
> >>  drivers/mfd/stm32-timers.c                         | 201 +++++++++++++++-
> >>  drivers/pwm/pwm-stm32.c                            | 257 +++++++++++++++++++++
> >>  include/linux/mfd/stm32-timers.h                   |  58 +++++
> >>  5 files changed, 537 insertions(+), 2 deletions(-)
> >>
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
