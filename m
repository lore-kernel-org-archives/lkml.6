Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB34C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B93320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B93320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeGXMQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:16:38 -0400
Received: from mx.socionext.com ([202.248.49.38]:43866 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbeGXMQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:16:37 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jul 2018 20:10:40 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8253718011F;
        Tue, 24 Jul 2018 20:10:40 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 24 Jul 2018 20:10:40 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1A3AE403AB;
        Tue, 24 Jul 2018 20:10:40 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D9AF1120453;
        Tue, 24 Jul 2018 20:10:39 +0900 (JST)
Date:   Tue, 24 Jul 2018 20:10:39 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <CAL_JsqKjC3J16uk2GTQyTquMbvO5Aw6kr4BfdNLAfZHD3MuBgQ@mail.gmail.com>
References: <20180717195531.8587.4A936039@socionext.com> <CAL_JsqKjC3J16uk2GTQyTquMbvO5Aw6kr4BfdNLAfZHD3MuBgQ@mail.gmail.com>
Message-Id: <20180724201039.F6E6.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 17 Jul 2018 08:16:23 -0600 <robh@kernel.org> wrote:

> On Tue, Jul 17, 2018 at 4:55 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> >
> > Hi Rob,
> > Thank you for your comments.
> >
> > On Mon, 16 Jul 2018 14:50:49 -0600 <robh@kernel.org> wrote:
> >
> > > On Fri, Jun 29, 2018 at 05:38:58PM +0900, Kunihiko Hayashi wrote:
> > > > Add DT bindings for PHY interface built into USB3 controller
> > > > implemented in UniPhier SoCs.
> > > >
> > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > ---
> > > >  .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 +++++++++++++++++++++
> 
> [...]
> 
> > > > +Optional properties:
> > > > +- phy-supply: A phandle to the regulator for USB VBUS.
> > >
> > > The phy actually needs Vbus or you just want to control Vbus from the
> > > phy driver?
> >
> > To enable each USB port correspond with phy, we must enable Vbus for each port.
> > However, the host driver doesn't have the way to control regulators directly,
> > then I think it is reasonable to control Vbus by using phy regulator.
> 
> DT should reflect the h/w. If Vbus rail is powering the phy then it
> should be in the phy node. If you just happen to want to put Vbus
> control in the phy driver, that's an OS problem and doesn't belong in
> DT. In that case, Vbus should be described as part of a USB connector
> node and any driver can walk the tree or graph and get Vbus regulator.

I think it's difficult to describe port nodes related to connectors that
has vbus regulator.

This controller has a glue layer, that consists of "reset", "regulator",
and "phy", and there are their respective drivers and their own nodes,
but no glue layer driver [1].

[1] https://www.spinics.net/lists/linux-usb/msg165060.html

For example, when the glue layer node has each port that includes vbus,
we will describe like that:

--------------------------------
usb {
	...
	resets = <&usb_reset>;
	phys = <&usb_phy0>, <&usb_phy1>;
};

usb-glue {
	usb_reset: reset {
		...
	};
	usb_vbus0: regulator {
		...
	};
	usb_vbus1: regulator {
		...
	};
	usb_phy0: phy {
		...
	};
	usb_phy1: phy {
		...
	};

	ports {
		port@0 {
			...
			vbus-supply = <&usb_vbus0>;
		};
		port@1 {
			...
			vbus-supply = <&usb_vbus1>;
		};
	};
};
--------------------------------

However, there is no driver that can walk the tree to get vbus regulator,
and we can't describe that the vbus and phy are related.

In this controller, each port with vbus corresponds to each phy,
and we need to enable the phy and control the vbus.

For the above reasons, and since vbus is not phy's power,
I think it's reasonable to add "vbus-supply" only instead of "phy-supply"
in the phy node like sun4i-usb-phy, rockchip-usb-phy, etc.

--------------------------------
usb {
	...
	resets = <&usb_reset>;
	phys = <&usb_phy0>, <&usb_phy1>;
};

usb-glue {
	usb_reset: reset {
		...
	};
	usb_vbus0: regulator {
		...
	};
	usb_vbus1: regulator {
		...
	};
	usb_phy0: phy {
		...
		vbus-supply = <&usb_vbus0>;
	};
	usb_phy1: phy {
		...
		vbus-supply = <&usb_vbus1>;
	};
};
--------------------------------

Thank you,

---
Best Regards,
Kunihiko Hayashi


