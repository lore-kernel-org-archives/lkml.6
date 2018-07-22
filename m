Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3244CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A1020874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A1020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeGVHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:06:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36559 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeGVHG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:06:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id k15-v6so805784edr.3;
        Sat, 21 Jul 2018 23:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g60GJHdAd5RoOZu5TUGZwY5gSTd/H1YJ/Vd48Dgg+7w=;
        b=ELXwTXmLnTbRSCifTXxDtADEi1uSdtTIK1kKuXQJI2hgY5jvRniK8aDhoFqd8B3IVo
         mvNlxkwRQMHowjuoxf48hqlxl3SIJ4hiZ0SVsbGlRtHBCd7XWmjs6j6+OYxJWFRJ2Nkh
         EOKll4jWgn4fU8nIz+MIlYJLwSJXxIJ9CRvcN0Dk3NaI86sntfIkRRq19Q34mgPOhQge
         bVraqCBKywlCLWfXSHgsGAKThtkVWIyTIXVpBKaKG7uVybob5py+s+TV/M5cbWHG9woI
         rOcs21XBIPJPkiYBxFWSbcfqlgWp7OJwtnVxkH/4kBtwSaW6lsxcQvXKE39Nafn43Wh9
         LS+A==
X-Gm-Message-State: AOUpUlEU6k1vILqwkIaF888JowjOYQJQHoc3gFmHonQhMc8LF1F8dNqT
        xVGT3w//5BJ+YiU7k8sBl5g5d3Jof/o=
X-Google-Smtp-Source: AAOMgpfv2RDdrPiM0dbH+oVlAM2yW1qBkckJb34YUVplIvVwS+PwgFX3SQrzKKr3LhDsJSIKSxS1xg==
X-Received: by 2002:a50:b684:: with SMTP id d4-v6mr8488509ede.250.1532239855214;
        Sat, 21 Jul 2018 23:10:55 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id l36-v6sm3070761edc.68.2018.07.21.23.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 23:10:54 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h10-v6so14763710wre.6;
        Sat, 21 Jul 2018 23:10:54 -0700 (PDT)
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr5255271wrh.148.1532239854363;
 Sat, 21 Jul 2018 23:10:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 23:10:33
 -0700 (PDT)
In-Reply-To: <20180722055739.26464-7-icenowy@aosc.io>
References: <20180722055739.26464-1-icenowy@aosc.io> <20180722055739.26464-7-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 22 Jul 2018 14:10:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com>
Message-ID: <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 6/9] dt-bindings: phy: add binding for
 Allwinner USB3 PHY
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 1:57 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
>
> Add a device tree binding for the PHY.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v3:
> - Added Chen-Yu's Review tag.
>
> Rob,
> Although you mentioned that the supply is for the port, not the phy;
> currently in USB situation "powering on the PHY" also indicates
> "powering on the port" and nearly all usages of phy-supply is for Vbus.
>
> Maybe we should change the overall phy-supply to satisfy this.

Or maybe change it to vbus-supply, like we have for phy-sun4i-usb,
until USB port power sequencing is added. (I remember there were
patches for this. What happened?)

ChenYu

> Thanks,
> Icenowy
>
>  .../bindings/phy/sun50i-usb3-phy.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..912d55f9f69d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional Properties:
> +- phy-supply : from the generic phy bindings, a phandle to a regulator that
> +              provides power to VBUS.
> +
> +Example:
> +       usb3phy: phy@5210000 {
> +               compatible = "allwinner,sun50i-h6-usb3-phy";
> +               reg = <0x5210000 0x10000>;
> +               clocks = <&ccu CLK_USB_PHY1>;
> +               resets = <&ccu RST_USB_PHY1>;
> +               #phy-cells = <0>;
> +               status = "disabled";
> +       };
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
