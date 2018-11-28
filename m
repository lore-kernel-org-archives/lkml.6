Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6626C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0A520863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue0aGUwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0A520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK2JGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2JGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:06:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1635120832;
        Wed, 28 Nov 2018 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442628;
        bh=0dabq8TB30UqkotGbejyx53E19VTweaYSW54JXUeu/U=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ue0aGUwWDwkku+x3V2P/6YEJun/R0OWpGzKPZk4IBiIq55B5W6wEZ+kc6v3LWTPJP
         X/j7N75wOoRTOnp4MKJatidB7vT65Uye5vzVGqm8EV91aMmWljZdVBjEN1WjeZCcRx
         Yu06/c+5dCmvnZ1G7V0aQrCRa7fLn0ny0hELuPK0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87a7lzq1jz.fsf@bootlin.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-7-gregory.clement@bootlin.com>
 <153936613666.5275.6122138233361141260@swboyd.mtv.corp.google.com>
 <87a7lzq1jz.fsf@bootlin.com>
Message-ID: <154344262734.88331.5318941402726866903@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 6/6] arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
Date:   Wed, 28 Nov 2018 14:03:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-11-23 07:02:56)
> Hi Stephen,
>  =

>  On ven., oct. 12 2018, Stephen Boyd <sboyd@kernel.org> wrote:
> =

> > +Rob
> >
> > Quoting Gregory CLEMENT (2018-09-22 11:17:09)
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm6=
4/boot/dts/marvell/armada-ap806.dtsi
> >> index 4a65e4e830aa..27c840e91abe 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> @@ -280,6 +280,12 @@
> >>                                 #address-cells =3D <1>;
> >>                                 #size-cells =3D <1>;
> >>  =

> >> +                               cpu_clk: clock-cpu {
> >> +                                       compatible =3D "marvell,ap806-=
cpu-clock";
> >> +                                       clocks =3D <&ap_clk 0>, <&ap_c=
lk 1>;
> >> +                                       #clock-cells =3D <1>;
> >> +                               };
> >
> > This looks like the wrong place because there isn't a reg property. It
> =

> There is no reg property because we are inside a syscon node where the
> registers are shared between multiple IPs.

The node right after this node has a reg property. What's going on?

> =

> > should go to the root of the tree. And then it looks like we're adding
> > something to DT to get a driver to probe, which is improper DT design.
> =

> There is nothing related to the driver, this subnode describes the way
> the hardware is designed. Under the system controller node there are
> several IPs , like the CPU clocks, but also the GPIO or the pinctrl.
> =


Ok. And some of them have reg properties and others don't? We should
somehow deprecate the idea of a syscon with child nodes. It leads to
this weird twisting of DT. The only use for syscon from my perspective
is when we have a register region that other random devices with their
own 'reg' property need to peek/poke random things into.

