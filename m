Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCWSy2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:54:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34683 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeCWSyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:54:23 -0400
X-Google-Smtp-Source: AG47ELtpzLhMxqdUQCEZ/1EOO5GTcvFKnQWcpBXGOdT9Ar04zquNLsi8G0jqMcLEFcjqN2YYC1jucQ==
Date: Fri, 23 Mar 2018 11:54:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        jcsing.lee@samsung.com, linux-kernel@vger.kernel.org, krzk@kernel.org,
        javier@osg.samsung.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        matthias.bgg@gmail.com, eddie.huang@mediatek.com,
        Chen.Zhong@mediatek.com, beomho.seo@samsung.com,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Add MediaTek PMIC keys support
Message-ID: <20180323185418.GD255819@dtor-ws>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <808b2029da224ab687fb0553cbc1c68e@mtkmbs08n1.mediatek.inc>
 <1521685073.28226.10.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521685073.28226.10.camel@mtkswgap22>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Thu, Mar 22, 2018 at 10:17:53AM +0800, Sean Wang wrote:
> Hi, Dmitry and Lee
> 
> The series seems not being got merged. Are they good enough to be ready
> into the your tree?
> 
> Recently I've tested the series with focusing on pwrkey event generated
> through interrupt when push and release the key on bpi-r2 board and then
> finally it's working fine. but for homekey it cannot be found on the
> board and thus I cannot have more tests more about it.
> 
> Tested-by: Sean Wang <sean.wang@mediatek.com>

You have my Ack on the input patch; I expect it go through Lee's tree as
there are some dependencies on mfd core piece.

Thanks.

> 
> 	Sean
> 
> 
> On Thu, 2018-03-22 at 10:03 +0800, Sean Wang (王志亘) wrote:
> > 
> > > -----Original Message-----
> > > From: Linux-mediatek [mailto:linux-mediatek-bounces@lists.infradead.org] On
> > > Behalf Of Chen Zhong
> > > Sent: Wednesday, October 25, 2017 9:16 PM
> > > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Rob Herring
> > > <robh+dt@kernel.org>; Lee Jones <lee.jones@linaro.org>; Alexandre Belloni
> > > <alexandre.belloni@free-electrons.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>; Alessandro Zummo
> > > <a.zummo@towertech.it>; devicetree@vger.kernel.org; Linus Walleij
> > > <linus.walleij@linaro.org>; Jaechul Lee <jcsing.lee@samsung.com>; linux-
> > > kernel@vger.kernel.org; Krzysztof Kozlowski <krzk@kernel.org>; Javier
> > > Martinez Canillas <javier@osg.samsung.com>; linux-
> > > mediatek@lists.infradead.org; linux-arm-kernel@lists.infradead.org; linux-
> > > input@vger.kernel.org; Matthias Brugger <matthias.bgg@gmail.com>; Eddie
> > > Huang (S智) <eddie.huang@mediatek.com>; Chen Zhong (钟辰)
> > > <Chen.Zhong@mediatek.com>; Beomho Seo <beomho.seo@samsung.com>;
> > > linux-rtc@vger.kernel.org
> > > Subject: [PATCH v6 0/6] Add MediaTek PMIC keys support
> > > 
> > > MediaTek PMIC are multi-function devices that can handle key interrupts,
> > > typically there are two keys attached to PMIC, which called pwrkey and
> > > homekey. PWRKEY usually used to wake up system from sleep. Homekey can
> > > used as volume down key due to board design. Long press keys can shutdown
> > > PMIC, the mode can be choose to be one key only or two keys together.
> > > This series add support for key functions for MediaTek PMIC MT6397/MT6323.
> > > 
> > > Changes since v5:
> > > - use __maybe_unused annotation instead of #ifdef guard
> > > - use of_* API instead of device_* API
> > > 
> > > Changes since v4:
> > > - rebase to Linux 4.14-rc1
> > > - add a common keyboard binding document
> > > - use child device tree node to define each key
> > > 
> > > Changes since v3:
> > > - make the naming to be consistent as mtk_pmic or MTK_PMIC
> > > - add suspend/resume functions to enable/disable irq
> > > - change binding properties to define wakeup sources
> > > 
> > > Changes since v2:
> > > - use standard properties for keycodes and debounce time
> > > - change to use platform_get_irq in leaf drivers
> > > - use better ways to define IRQ resources
> > > 
> > > Changes since v1:
> > > - create irq mappings in mfd core driver instead of leaf drivers
> > > - remove some unused parts in mtk-pmic-keys driver
> > > 
> > > Chen Zhong (6):
> > >   mfd: mt6397: create irq mappings in mfd core driver
> > >   dt-bindings: input: Add common keyboard document bindings
> > >   dt-bindings: input: Add document bindings for mtk-pmic-keys
> > >   dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
> > >   input: Add MediaTek PMIC keys support
> > >   mfd: mt6397: Add PMIC keys support to MT6397 driver
> > > 
> > >  Documentation/devicetree/bindings/input/keys.txt   |   8 +
> > >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |  43 +++
> > >  Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
> > >  drivers/input/keyboard/Kconfig                     |   9 +
> > >  drivers/input/keyboard/Makefile                    |   1 +
> > >  drivers/input/keyboard/mtk-pmic-keys.c             | 339
> > > +++++++++++++++++++++
> > >  drivers/mfd/mt6397-core.c                          |  26 +-
> > >  drivers/rtc/rtc-mt6397.c                           |   7 +-
> > >  8 files changed, 432 insertions(+), 7 deletions(-)  create mode 100644
> > > Documentation/devicetree/bindings/input/keys.txt
> > >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-
> > > keys.txt
> > >  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> > > 
> > > --
> > > 1.9.1
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 

-- 
Dmitry
