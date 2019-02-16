Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2B4218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfBPU2X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:28:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45420 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbfBPU2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 15:28:23 -0500
Received: from p57b77d08.dip0.t-ipconnect.de ([87.183.125.8] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gv6ZP-0007d1-K7; Sat, 16 Feb 2019 21:28:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexandru M Stan <amstan@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
Date:   Sat, 16 Feb 2019 21:28:13 +0100
Message-ID: <2105716.Hge0YL7z4n@phil>
In-Reply-To: <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
References: <20190215115150.32299-1-enric.balletbo@collabora.com> <22158501.cNvkU8jGDh@diego> <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. Februar 2019, 02:13:25 CET schrieb Alexandru M Stan:
> On Fri, Feb 15, 2019 at 3:09 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi Enric,
> >
> > Am Freitag, 15. Februar 2019, 12:51:50 CET schrieb Enric Balletbo i Serra:
> > > In order to use earlycon, the stdout-path property needs to be set
> > > in the chosen node.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > What's the reason for adding this only for the Chromebook variants?
> > Uart2 is pretty much the standard output for all devices, so I'd assume
> > at least all veyron boards should use uart2 as well, making this ideally
> > live in the rk3288-veyron.dtsi instead?
> 
> Yep, all veyriants use uart 2, even when they're not chromebooks.
> Feel free to put it in the other file instead.
> 
> Otherwise it'll make things like the Asus Chromebit (mickey), AOpen
> Chromebox mini (fievel), and AOpen Chromebase (tiger) unhappy
> while debugging.
> 
> The rk3288-veyron-chromebook.dtsi file is more for things that make
> a chromebook portable. Ex: built in display, lid switch, cros-ec.
> 
> Note how we have no uart2 references either in our tree in the
> chromebook specific dtsi:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi

thanks for the confirmation :-) .

I've moved the choosen node over to veyron.dtsi and applied the result
for 5.1

Thanks
Heiko


