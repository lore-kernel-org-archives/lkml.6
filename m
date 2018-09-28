Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DEC20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W/deg7ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DEC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeI1U4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:56:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42193 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeI1U4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:56:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11-v6so6610756wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4tDKLPmuxUhe6l7qNGxjdkZP+rVlFN1lBKcvyX+xKF4=;
        b=W/deg7adVipgFSEx2/Ez+cQMfUcY1EviszjIjTx+3/fVS+OB1jBJAWLFsbWE/aTbIG
         SCE7an9tYnOQojlTHtfmF0mz2ijgb1JbGpbY+zFOMwlRH9gOYLdhA4TFAH5oAm5anTtB
         FbJJRF+DSECKgKRXn08iUAYKgksOhbFBs1diUz/AOfsp1fiSHECTy23Lfur6rzZIadH9
         iUyGF6Mvyg69jRt0WutmIOvcRebrNIE1X+mJzIqKXOFCS8u3GXQwpOYodzWfYv4xW2bJ
         wMXr8Wd7iBkRzdiq0AIbJgMS3BNsMe+chZc+wREhm6qpT07xcvdhqxbphabf83YtPDeF
         +nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4tDKLPmuxUhe6l7qNGxjdkZP+rVlFN1lBKcvyX+xKF4=;
        b=k2JHaR5Qm8OFlVyX35D2ahEoHmy78tIe1Q6aRSWFN/VvqedW9D2q+Ehk3H+meXtxd0
         P4DhlBpF7z7UDy+aYf5BKYs9/zVwU2XCcz6V7y1LS/QNpau/0h7U/6PxVpDNdNnHn9bK
         brmpYMkcLEZKL9Dfz0g3ZOGTxZzTTlGgYlhxGT5cHgiHgEoyNudNFi6PChsOZDPCxJPS
         D8pyR1hU9xzzfhXvjwwGziY0vqTHHVt1ovMMGMv8+DSO17dQFpp9GOxChzNLzFelqm4I
         1NvBEeZ27F+FUfe4lIrd0wR3qw4T+5kPVDopIZ3IGOnPYCRwWKDe2WpPxibteM+Jz5mP
         waDw==
X-Gm-Message-State: ABuFfoiVUb9kbRbV6gyrk88JovNO2Am0VDq4gjoull3Re6ZFFLmTYqAu
        BcZJSp1clQSLCTyJL5PjNBy8htKjCgZxXz5eMo6Jmg==
X-Google-Smtp-Source: ACcGV63tNspinjLKzmEMi8bz8871peTqTQRl0Gn78FoL6/K52z8k0XPw9c4SDDRPpHNh2Ukf/s8TACERWFUuhX/Trzk=
X-Received: by 2002:adf:fdca:: with SMTP id i10-v6mr13384176wrs.276.1538145140437;
 Fri, 28 Sep 2018 07:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180928142816.4311-1-mjourdan@baylibre.com> <20180928142816.4311-2-mjourdan@baylibre.com>
In-Reply-To: <20180928142816.4311-2-mjourdan@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Fri, 28 Sep 2018 16:32:09 +0200
Message-ID: <CAMO6naws6gRXogL8MyGdz8rBivg7ZxLG1ZoPy0zff=rnHfKPQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: media: add Amlogic Video Decoder Bindings
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata: I forgot the following tag:

Reviewed-by: Rob Herring <robh@kernel.org>

(The patch is unchanged from v2)
Le ven. 28 sept. 2018 =C3=A0 16:29, Maxime Jourdan <mjourdan@baylibre.com> =
a =C3=A9crit :
>
> Add documentation for the meson vdec dts node.
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../bindings/media/amlogic,vdec.txt           | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.=
txt
>
> diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/D=
ocumentation/devicetree/bindings/media/amlogic,vdec.txt
> new file mode 100644
> index 000000000000..aabdd01bcf32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
> @@ -0,0 +1,71 @@
> +Amlogic Video Decoder
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The video decoding IP lies within the DOS memory region,
> +except for the hardware bitstream parser that makes use of an undocument=
ed
> +region.
> +
> +It makes use of the following blocks:
> +
> +- ESPARSER is a bitstream parser that outputs to a VIFIFO. Further VDEC =
blocks
> +then feed from this VIFIFO.
> +- VDEC_1 can decode MPEG-1, MPEG-2, MPEG-4 part 2, MJPEG, H.263, H.264, =
VC-1.
> +- VDEC_HEVC can decode HEVC and VP9.
> +
> +Both VDEC_1 and VDEC_HEVC share the "vdec" IRQ and as such cannot run
> +concurrently.
> +
> +Device Tree Bindings:
> +---------------------
> +
> +VDEC: Video Decoder
> +--------------------------
> +
> +Required properties:
> +- compatible: value should be different for each SoC family as :
> +       - GXBB (S905) : "amlogic,gxbb-vdec"
> +       - GXL (S905X, S905D) : "amlogic,gxl-vdec"
> +       - GXM (S912) : "amlogic,gxm-vdec"
> +- reg: base address and size of he following memory-mapped regions :
> +       - dos
> +       - esparser
> +- reg-names: should contain the names of the previous memory regions
> +- interrupts: should contain the following IRQs:
> +       - vdec
> +       - esparser
> +- interrupt-names: should contain the names of the previous interrupts
> +- amlogic,ao-sysctrl: should point to the AOBUS sysctrl node
> +- amlogic,canvas: should point to a canvas provider node
> +- clocks: should contain the following clocks :
> +       - dos_parser
> +       - dos
> +       - vdec_1
> +       - vdec_hevc
> +- clock-names: should contain the names of the previous clocks
> +- resets: should contain the parser reset
> +- reset-names: should be "esparser"
> +
> +Example:
> +
> +vdec: video-decoder@c8820000 {
> +       compatible =3D "amlogic,gxbb-vdec";
> +       reg =3D <0x0 0xc8820000 0x0 0x10000>,
> +             <0x0 0xc110a580 0x0 0xe4>;
> +       reg-names =3D "dos", "esparser";
> +
> +       interrupts =3D <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
> +                    <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
> +       interrupt-names =3D "vdec", "esparser";
> +
> +       amlogic,ao-sysctrl =3D <&sysctrl_AO>;
> +       amlogic,canvas =3D <&canvas>;
> +
> +       clocks =3D <&clkc CLKID_DOS_PARSER>,
> +                <&clkc CLKID_DOS>,
> +                <&clkc CLKID_VDEC_1>,
> +                <&clkc CLKID_VDEC_HEVC>;
> +       clock-names =3D "dos_parser", "dos", "vdec_1", "vdec_hevc";
> +
> +       resets =3D <&reset RESET_PARSER>;
> +       reset-names =3D "esparser";
> +};
> --
> 2.19.0
>
