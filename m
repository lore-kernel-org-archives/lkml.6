Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB775C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9598420839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH30eFel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9598420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIKS1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbeIKS1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:27:20 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46E4320839;
        Tue, 11 Sep 2018 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536672480;
        bh=B5iasDEWMmvosW3MVAEK+YKi2cN4Qxr16P/j1BqyHK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HH30eFelSR811ub8boaul8geicmKIgAbSWFy4+vQAXX208yuIA4d6LfxcVcgeO5mg
         zwalpSZmNUNAiK3lGsqEm0AvJ4o4PUpel/AYIiy6qmCsH7F3d1+oh6ZVRkiuHhNfkJ
         vbEA9CmS7Tule6EAIm/PakSwsa2FIBqn1xsn15/4=
Received: by mail-qk1-f174.google.com with SMTP id 93-v6so16697333qks.3;
        Tue, 11 Sep 2018 06:28:00 -0700 (PDT)
X-Gm-Message-State: APzg51CLFmI7u7uDoMxA+onQwHdL/WdGkZTn7VOwtrLlUH3oWOmfigaW
        lcLqR5eNdtUIjQH3OMen3E7v1KdfKP4F70NNhA==
X-Google-Smtp-Source: ANB0Vdalsshh4i32ceSqe+2LcNLR+RZU3Ewd5/BxeSKurf+robN3Z6BUyFyJel33DtY3zhjNPkNodRqQvL/pOkyZaDQ=
X-Received: by 2002:a37:bec4:: with SMTP id o187-v6mr18546859qkf.326.1536672479460;
 Tue, 11 Sep 2018 06:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
 <1536322536-53109-1-git-send-email-christianshewitt@gmail.com> <CAFBinCA=sDT4mVD=ZA90SF+d84bg5HCWuv6O5uz4+dKVSxNgiw@mail.gmail.com>
In-Reply-To: <CAFBinCA=sDT4mVD=ZA90SF+d84bg5HCWuv6O5uz4+dKVSxNgiw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Sep 2018 08:27:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLLF0_4V2VOAC093qfdg=D66foBS93=bDB4Dx4Xqxt5xA@mail.gmail.com>
Message-ID: <CAL_JsqLLF0_4V2VOAC093qfdg=D66foBS93=bDB4Dx4Xqxt5xA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 1:30 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Rob,
>
> On Fri, Sep 7, 2018 at 2:16 PM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
> >
> > This change adds the uart_A used by the brmcfmac sdio module in the
> > WeTek Hub and WeTek Play 2 devices. meson_uart_probe seems to mandate
> > an alias (without it, BT is not working) so this is also included.
> >
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> > index 70325b2..e75ace7 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> > @@ -10,6 +10,7 @@
> >  / {
> >         aliases {
> >                 serial0 = &uart_AO;
> > +               serial1 = &uart_A;
> >                 ethernet0 = &ethmac;
> >         };
> >
> > @@ -239,6 +240,18 @@
> >         vqmmc-supply = <&vddio_boot>;
> >  };
> >
> > +/* This is connected to the Bluetooth module: */
> > +&uart_A {
> > +       status = "okay";
> > +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> > +       pinctrl-names = "default";
> > +
> > +       bluetooth {
> > +               compatible = "brcm,bcm43438-bt";
> I have a question regarding the Broadcom Bluetooth compatible strings:
> Christian mentioned earlier that the Bluetooth controller identifies
> itself as BCM4335C0 (BCM4335 rev. C0)
>
> do we need to add a new compatible string (to
> Documentation/devicetree/bindings/net/broadcom-bluetooth.txt)?

Probably so. Without, how do you determine firmware filenames for example?

> if yes: should we also add a new of_device_id to hci_bcm.c or should
> board.dts simply use compatible = "brcm,bcm4335c0-bt",
> "brcm,bcm43438-bt"?

A fallback is fine. I'd probably drop the 'c0' part. Is that readable
from a register?

Rob
