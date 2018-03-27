Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeC0DV5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:21:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11119 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752169AbeC0DVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:21:54 -0400
X-UUID: e2f2f7a2a34348b8a30b36bd25f29215-20180327
Message-ID: <1522120906.18424.21.camel@mtkswgap22>
Subject: Re: [PATCH v1 01/16] dt-bindings: power: reset: mediatek: add
 bindings for power device
From: Sean Wang <sean.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <mark.rutland@arm.com>, <sre@kernel.org>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 27 Mar 2018 11:21:46 +0800
In-Reply-To: <20180326222455.6kou2rdn76k6p6ct@rob-hp-laptop>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <c5527464207b02d40f1c2682feb97ebf5dd443be.1521794176.git.sean.wang@mediatek.com>
         <20180326222455.6kou2rdn76k6p6ct@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23744.000
X-TM-AS-Result: No-14.246300-8.000000-10
X-TMASE-MatchedRID: zGP2F0O7j/v4OiVTWoD8RCa1MaKuob8PC/ExpXrHizyrmaMm8BwMJKSx
        VUPqsOdUDsWHoENn2KjDhTh6GtC1/l3MeDPg67Be7spMO3HwKCAW40XiUkbrG2ecrqZc3vabfhQ
        4FB19kmoqdv4KbYr7ea/MULUxW2VhgGgbIWz4XUxgP1dNF1ow7TFcf92WG8u/+Cckfm+bb6DfqL
        J6KzMx0CF7r1KLtjtCfnyL6QX6YMKR9GF2J2xqMzl/1fD/GopdcmfM3DjaQLHEQdG7H66TyH4gK
        q42LRYkGaKWfSYSA4bbcJyFK13PnNbJoXa/SBL6s0QWx2bcZhl+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.246300-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23744.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 17:24 -0500, Rob Herring wrote:
> On Fri, Mar 23, 2018 at 05:14:58PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add device-tree binding for the power device responsible for shutdown a
> > remote SoC, which is a tiny circuit block present on MediaTek PMIC based
> > RTC.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../bindings/power/reset/mt6397-rtc-poweroff.txt   | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > new file mode 100644
> > index 0000000..75a9d7d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > @@ -0,0 +1,24 @@
> > +Device-Tree bindings for Power Device on MediaTek PMIC RTC
> > +
> > +The power device is responsible for externally power off or on the remote
> > +MediaTek SoC through the a tiny circuit block BBPU inside PMIC RTC.
> > +
> > +Required parent node:
> > +- rtc
> > +	For MediaTek PMIC RTC bindings, see:
> > +	Documentation/devicetree/bindings/mfd/mt6397.txt
> > +
> > +Required properties:
> > +- compatible: Should be one of follows
> > +	"mediatek,mt6323-rtc-poweroff": for MT6323 PMIC
> > +	"mediatek,mt6397-rtc-poweroff": for MT6397 PMIC
> > +
> > +Example:
> > +
> > +	rtc {
> > +		compatible = "mediatek,mt6323-rtc";
> > +
> > +		power-off {
> > +			compatible = "mediatek,mt6323-rtc-poweroff";
> > +		};
> 
> There's no need for this node. The OS can register a device in the rtc 
> driver.
> 

It seems a good way.

I will remove the really simple dt-binding and use a
platform_device_register_simple api embedded in rtc driver to
register the power-off device.

Hope I do not misconception your points addressed here.

> > +	};
> > -- 
> > 2.7.4
> > 
