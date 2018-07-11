Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4BD20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBmFexvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4BD20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbeGKRo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732359AbeGKRo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:44:59 -0400
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com [209.85.223.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EB820E20;
        Wed, 11 Jul 2018 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531330776;
        bh=vdx7XfsN+bw0RZUisvn8/NjfQrtfp2jYZSEbcrkhCpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBmFexvx5GokQU6rgZbINSxbjXWj4d3GIh8rDUF068Lw3DMGKZeD8YWUcKa04bLAz
         lrrn3iIDadt8cGzCUbcDVC8oqP/W6Gw4I+KpQgdF0G7jQ7Fy3GbqnXXBHsOKHaTD0K
         HfazfM9oc5xrme8c14VkK/lBrEOhMbDWuQguPZr4=
Received: by mail-io0-f179.google.com with SMTP id q4-v6so24744143iob.2;
        Wed, 11 Jul 2018 10:39:36 -0700 (PDT)
X-Gm-Message-State: AOUpUlFqO8Z4SBuU1mEj+R3fytFTFOA4N+EV5/7WIFKoy6hjN4qlrkMz
        srG+WNNDHQtlKdCO45sncwYJDWLVllgShYZrsQ==
X-Google-Smtp-Source: AAOMgpfCmNyBSpZFkebjY+29oLfSHk68GZRL/2IGeoIbIvBKz0VovnJqLrUP6cJJcEEP4cb1Ige/YYHiysPGflFvRKM=
X-Received: by 2002:a6b:b382:: with SMTP id c124-v6mr219069iof.489.1531330775422;
 Wed, 11 Jul 2018 10:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-7-icenowy@aosc.io>
 <20180711161356.GA4685@rob-hp-laptop> <C01136F1-594C-4459-B9C6-6E0434855234@aosc.io>
In-Reply-To: <C01136F1-594C-4459-B9C6-6E0434855234@aosc.io>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Jul 2018 11:39:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+AMJMf1-LPXHj7i_6_E+iRQ9nBa1FMd19RqJ+eAQxizQ@mail.gmail.com>
Message-ID: <CAL_Jsq+AMJMf1-LPXHj7i_6_E+iRQ9nBa1FMd19RqJ+eAQxizQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: phy: add binding for Allwinner USB3 PHY
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:20 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8812=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
12:13:56, Rob Herring <robh@kernel.org> =E5=86=99=E5=88=B0:
> >On Fri, Jul 06, 2018 at 11:38:02PM +0800, Icenowy Zheng wrote:
> >> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> >> external USB3 pins of the SoC.
> >>
> >> Add a device tree binding for the PHY.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >> Splitted from the PHY driver patch in v1.
> >>
> >>  .../bindings/phy/sun50i-usb3-phy.txt          | 24
> >+++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>  create mode 100644
> >Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >>
> >> diff --git
> >a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >> new file mode 100644
> >> index 000000000000..912d55f9f69d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >> @@ -0,0 +1,24 @@
> >> +Allwinner sun50i USB3 PHY
> >> +-----------------------
> >> +
> >> +Required properties:
> >> +- compatible : should be one of
> >> +  * allwinner,sun60i-h6-usb3-phy
> >> +- reg : a list of offset + length pairs
> >> +- #phy-cells : from the generic phy bindings, must be 0
> >> +- clocks : phandle + clock specifier for the phy clock
> >> +- resets : phandle + reset specifier for the phy reset
> >> +
> >> +Optional Properties:
> >> +- phy-supply : from the generic phy bindings, a phandle to a
> >regulator that
> >> +           provides power to VBUS.
> >
> >Power to the phy or Vbus? If the latter only, then this property should
> >
> >be elsewhere (like a connector node).
>
> I don't think there's connector nodes for USB ports now.

Yes, there's a recently added binding.

> And by checking existed device trees, use phy-supply on USB
> phy is common. It's seen on Meson GXBB, RK3399 and Hi6220
> in arch/arm64/boot/dts.

I don't doubt that the phy needs a supply, but that's not how you
described it. If it is needed for the phy, then it's okay to have it.
If it is for Vbus and not connected to the phy, then it is not okay.

Rob
