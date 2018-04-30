Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeD3Hea (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:34:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751917AbeD3He3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:34:29 -0400
X-UUID: ab5a952285774b649aab91fb9ac299b3-20180430
Message-ID: <1525073663.12322.219.camel@mtkswgap22>
Subject: Re: [PATCH v2 01/17] dt-bindings: power: reset: mt6323: add
 bindings for MT6323 power controller
From: Sean Wang <sean.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <mark.rutland@arm.com>, <sre@kernel.org>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <matthias.bgg@gmail.com>, <eddie.huang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Mon, 30 Apr 2018 15:34:23 +0800
In-Reply-To: <20180427200225.lq63ex7eiukc6egl@rob-hp-laptop>
References: <cover.1524646231.git.sean.wang@mediatek.com>
         <0b3123e42c8a47e3fa8b21aa2e139e6d3dc69f41.1524646231.git.sean.wang@mediatek.com>
         <20180427200225.lq63ex7eiukc6egl@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-27 at 15:02 -0500, Rob Herring wrote:
> On Wed, Apr 25, 2018 at 05:32:27PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Adding device-tree binding for the power controller which is a tiny
> > circuit block present as a part of MT6323 PMIC and is responsible for
> > externally powering off or on a remote SoC the PMIC is connected to.
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../bindings/power/reset/mt6323-poweroff.txt         | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> > new file mode 100644
> > index 0000000..6f7c590
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> > @@ -0,0 +1,20 @@
> > +Device Tree Bindings for Power Controller on MediaTek PMIC
> > +
> > +The power controller which could be found on PMIC is responsible for externally
> > +powering off or on the remote MediaTek SoC through the circuit BBPU.
> > +
> > +Required properties:
> > +- compatible: Should be one of follows
> > +	"mediatek,mt6323-pwrc": for MT6323 PMIC
> > +
> > +Example:
> > +
> > +	pmic {
> > +		compatible = "mediatek,mt6323";
> > +
> > +		...
> > +
> > +		power-controller {
> > +			compatible = "mediatek,mt6323-pwrc";
> 
> Why do you need this in DT? It doesn't define any resources. The parent 
> can just as well register a reset or poweroff handler.
> 
> Rob
> 

Yes, those binding can be removed. 

I tend to use platform_device_register_data embedded in mfd driver
to probe the existent poweroff driver in the next version.

> > +		};
> > +	}
> > -- 
> > 2.7.4
> > 
