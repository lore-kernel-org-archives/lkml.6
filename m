Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C420663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s4q6dvmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfBXTwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:52:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39412 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfBXTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:52:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id b4so5647648oif.6;
        Sun, 24 Feb 2019 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYQcmmvOWPoSOeQLQkGxZasGkeWzPpVbLTX8A4pezEg=;
        b=s4q6dvmV8vzyo06grp4cC+jC04xPsR8+JpkdIPVXUy45VgdXNnGRcaFxBKuURWkBUb
         p6ddlpeIaURXH91qcCtIpHOiUmVD40NLv0LSb70q48NMh76kJN2Wo2gxhAVec670W47K
         28uZyPp1Shy73IVAlvqvGGQ+HIJQ6WTGqvXdLczF/p4YhxpDHYV++DtYdU6RdP2ZQv2t
         uoWynKM/57sKPB592SsOLBeByczmtqnsHCeh1hYh7tZCrHIcS8mRZ7SLQfBvaiZKxWL/
         zLsvaB+7A4IXljqaoQrEHDKEMfMfmg54USMV1rBVp1mxyYAuoxw4lGrUrw/a8U+uJioj
         SUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYQcmmvOWPoSOeQLQkGxZasGkeWzPpVbLTX8A4pezEg=;
        b=lRuluHNdFcVy0okYgUEHPej6kzedBVEei4DVsZNxklmP6vC0DWgNWZhcsnqs9LPfwK
         X2yCyLKz+QdJURIq9CBro7iNTJ9++HuLdNE7t88fyMX2wh2XZvgYCdLwqNLFkyJ0fLs1
         /NilVLYgbM4B3T63Ti1zoC4vH+q/kCIPxLNGsFcZj0wYbM1cWrOptVHyEwHkvtkJGzkn
         uDoGF5v3oiZMMEe5V1uhTrfJFTFqwp35yiXXpnpCqxBdGYoEDz8Auod1oR3LrDxdOBMI
         7CBPB2QTohokX5XNjnAWO0QYUDwIWFOSQuice3KLq8w1lvE3kSJWvIa65mmHiF05RmbE
         lxXQ==
X-Gm-Message-State: AHQUAuYW6wrbawrQTnv4/fmsDeb/I8dt2SNbpZZzhnCoULGq+ui2MM5T
        ptypas/e4KpAnm1tmUvCcsqcpZJSe+iSgdIqP4k=
X-Google-Smtp-Source: AHgI3IbIeKx3wATaNvdtt2nNjW6v0A+ktUiVw6Fniny1gw2+4boGchyewPpYn/tjfrbZtpEjSJl6SsL2In8Jigb70hE=
X-Received: by 2002:aca:5d87:: with SMTP id r129mr9232994oib.39.1551037971667;
 Sun, 24 Feb 2019 11:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com> <20190212151413.24632-5-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 24 Feb 2019 20:52:40 +0100
Message-ID: <CAFBinCC87H+Do3dGooYMpFjozBTCv2agmS_p5cJRbFQ7QCiuiA@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +
> +Example device nodes:
> +       usb: usb@ffe09000 {
> +                       compatible = "amlogic,meson-g12a-usb-ctrl";
> +                       reg = <0x0 0xffe09000 0x0 0xa0>;
> +                       interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       clocks = <&clkc CLKID_USB>;
> +                       clock-names = "usb";
> +                       resets = <&reset RESET_USB>;
> +                       reset-names = "usb";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               /* USB2 Port 0 */
> +                               usb20: port@0 {
> +                                       reg = <0>;
> +                                       phys = <&usb2_phy0>;
> +                               };
> +
> +                               /* USB2 Port 1 */
> +                               usb21: port@1 {
> +                                       reg = <1>;
> +                                       phys = <&usb2_phy1>;
> +                               };
> +
> +                               /* USB3 Port 0 */
> +                               usb3: port@4 {
> +                                       reg = <4>;
> +                                       phys = <&usb3_pcie_phy PHY_TYPE_USB3>;
> +                               };
> +                       };
> +
> +                       dwc2: usb@ff400000 {
> +                               compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
> +                               reg = <0x0 0xff400000 0x0 0x40000>;
> +                               interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
> +                               clock-names = "ddr";
> +                               dr_mode = "peripheral";
> +                               g-rx-fifo-size = <192>;
> +                               g-np-tx-fifo-size = <128>;
> +                               g-tx-fifo-size = <128 128 16 16 16>;
> +                       };
you suggested (off-list) that the OTG capable PHY should be passed to
the dwc2 instance
I'm aware that this is an example - could you please still add it for
consistency?

> +
> +                       dwc3: dwc3@ff500000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0x0 0xff500000 0x0 0x100000>;
> +                               interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +                               dr_mode = "host";
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,quirk-frame-length-adjustment;
> +                       };
maybe the phys should also be passed to the dwc3 instance?


Regards
Martin
