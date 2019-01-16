Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF0720675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLBumlMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfAPV2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:28:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42727 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfAPV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:28:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3612398plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=H1Cev6RG5OCIJfUtiRyXisGTM+l88aY2G+3ATWqoIdg=;
        b=gLBumlMGhYuoGFkq/batjwsH40g75ihEpftBIAdXRTmkJuaz+hmSTdfOORe+5e5ql4
         u2OhRJvOqq6DvYQjNSm1iuwPMBLtiAD8D90wf328ydXBE8uLyPFbElRF262xsgNikGOl
         UIxEAFr9rlkJLhNeV5j1KzxcWw5HTD8claprU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=H1Cev6RG5OCIJfUtiRyXisGTM+l88aY2G+3ATWqoIdg=;
        b=FCukNSOG1gGOFli+c/a9aODC3sZpUKyx3Z0lrZASGFQITz0xoYrn1sE8Ph3pEfqrHQ
         5hq9E3cFnCqLmv0TpnhdF+gpkQKh79WgHmZPkytP22Z4qgZI3ODZL0cBwntYqRUAbuw/
         HaDPAyeaVlNBs7fyzTIH+H7e6JV04THoJkkTcMJmT8cCZX1qQ0eW/K9LpBbmQqHOL0Y/
         4t/+Ecx1YcD0drk1LbaREO7A0hg/OZfXIEhI6dHOwSCUCCt69B45SA8tTVsipfQBne4F
         LZHuMMyE673/kI3Xj2E9YxGnjYowcPZ7jj72ghCvHNhcEUhLXUKNpw09Eyg2fpnEyX0B
         2CbA==
X-Gm-Message-State: AJcUukd6aJ8Ea+EvQIj/YsS6N4guus11S9YCvNkEyBCloxTxBy5obhcT
        hXBXXgD98G/1XsJEkMdDq0B0xg==
X-Google-Smtp-Source: ALg8bN51GjHzGPY+ubMvemckqC1yuoAXBZkANApnbzXI9AU/dBM1rQd1k+95kcrFcQZ7SWBvkDLkag==
X-Received: by 2002:a17:902:5a0b:: with SMTP id q11mr12166805pli.186.1547674109719;
        Wed, 16 Jan 2019 13:28:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a90sm11389642pfj.109.2019.01.16.13.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:28:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm845: Expand soc bus address range
User-Agent: alot/0.8
In-Reply-To: <20190116071939.23136-1-bjorn.andersson@linaro.org>
References: <20190116071939.23136-1-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154767410807.169631.11634052870112778681@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 16 Jan 2019 13:28:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-15 23:19:39)
> DMA addresses for devices on the soc bus must be constrained to the 36
> address bits that the bus provides.  When no IOMMU is present then this
> is easy--DMA addresses are just physical addresses and physical
> addresses are (by definition) within the address bits of the bus.  When
> an IOMMU is present, however, DMA addresses are virtual addresses.
> Despite these addresses being virtual, however, they are still
> constrained by the 36 address bits of the bus.
>=20
> Unless dma-ranges is specified, which causes bus_dma_mask to be set, DMA
> allocations for devices on the platform_bus will use all 48 address bits
> available by the ARM SMMU. Causing addresses to be truncated on the bus.

I read it three times and still got confused by the statement that DMA
addresses are virtual addresses. There are CPU virtual addresses, DMA
addresses, IOVAs, and physical addresses. Stating that DMA addresses are
virtual addresses makes it sound like we're talking about CPU virtual
addresses.

Maybe it would be clearer if it stated that DMA addresses are 1:1 with
IOVAs (IO virtual addresses) when a device has an iommus property and
1:1 with physical addresses when that property is absent? When devices
use an iommus property the DMA addresses that are generated in the
absence of a dma-ranges property can have as many as 48 bits, as opposed
to the default of 32 bits in the absence of an iommus property.
Therefore we need to constrain the DMA addresses that devices which
reside in the SoC node (including the SMMU) can use to be at most 36
bits because that's the largest physical address the internal bus
supports. This expands the size of DMA addresses that devices without an
iommus property can use while also limiting the size that devices using
SMMU can use.

>=20
> This patch increases the #size-cells to 2, in order to be able to define
> dma-ranges describe the 36 bit DMA capability of the bus, and bumps

Did the commit text get cut off here?

>=20
> While touching all reg properties, addresses are padded to 8 digits.
>=20

I liked the paint the way it was without the padding. It matched the
unit address that way and didn't make anyone think they should pad that
out in the node name with leading zeros so that 'reg' and unit address
match.

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index c98b1937353b..fc01b1c93fe4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -346,14 +346,15 @@
>         };
> =20
>         soc: soc {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges =3D <0 0 0 0xffffffff>;
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;

Do we need #size-cells =3D <2>? Maybe it could be #size-cells =3D <1> and we
can avoid having to specify a second size entry that's always going to
be 0 because we don't have devices with huge IO regions in the SoC. Or
does it need to be 2 for the large size of the size element of
dma-ranges and ranges here? Looking at the code I think we can rely on
the size-cells of the parent node so I think it will work with size of 1
here.

> +               ranges =3D <0 0 0 0 0x10 0>;
> +               dma-ranges =3D <0 0 0 0 0x10 0>;
>                 compatible =3D "simple-bus";

It might also be a good idea to split the patch into two. The first
patch would expand the reg properties and the second one would do the
0x10 change and add dma-ranges. Then if anything goes wrong with the
second patch a quick revert is easier and smaller vs. the obviously good
reg property expanding patch that should be a no-op.

> @@ -378,25 +379,25 @@
> =20
>                 rng: rng@793000 {
>                         compatible =3D "qcom,prng-ee";
> -                       reg =3D <0x00793000 0x1000>;
> +                       reg =3D <0 0x00793000 0 0x1000>;
>                         clocks =3D <&gcc GCC_PRNG_AHB_CLK>;
>                         clock-names =3D "core";
>                 };
> =20
>                 qupv3_id_0: geniqup@8c0000 {
>                         compatible =3D "qcom,geni-se-qup";
> -                       reg =3D <0x8c0000 0x6000>;
> +                       reg =3D <0 0x008c0000 0 0x6000>;
>                         clock-names =3D "m-ahb", "s-ahb";
>                         clocks =3D <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>                                  <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
>                         status =3D "disabled";
> =20
>                         i2c0: i2c@880000 {
>                                 compatible =3D "qcom,geni-i2c";
> -                               reg =3D <0x880000 0x4000>;
> +                               reg =3D <0 0x00880000 0 0x4000>;
>                                 clock-names =3D "se";
>                                 clocks =3D <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
>                                 pinctrl-names =3D "default";
> @@ -693,18 +694,18 @@
> =20
>                 qupv3_id_1: geniqup@ac0000 {
>                         compatible =3D "qcom,geni-se-qup";
> -                       reg =3D <0xac0000 0x6000>;
> +                       reg =3D <0 0x00ac0000 0 0x6000>;
>                         clock-names =3D "m-ahb", "s-ahb";
>                         clocks =3D <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
>                                  <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
>                         status =3D "disabled";
> =20
>                         i2c8: i2c@a80000 {
>                                 compatible =3D "qcom,geni-i2c";
> -                               reg =3D <0xa80000 0x4000>;
> +                               reg =3D <0 0x00a80000 0 0x4000>;
>                                 clock-names =3D "se";
>                                 clocks =3D <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
>                                 pinctrl-names =3D "default";
> @@ -1044,9 +1045,9 @@
> =20
>                 ufs_mem_phy: phy@1d87000 {
>                         compatible =3D "qcom,sdm845-qmp-ufs-phy";
> -                       reg =3D <0x1d87000 0x18c>;
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       reg =3D <0 0x01d87000 0 0x18c>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
>                         clock-names =3D "ref",
>                                       "ref_aux";
> @@ -1536,13 +1537,13 @@
> =20
>                 usb_1_qmpphy: phy@88e9000 {
>                         compatible =3D "qcom,sdm845-qmp-usb3-phy";
> -                       reg =3D <0x88e9000 0x18c>,
> -                             <0x88e8000 0x10>;
> +                       reg =3D <0 0x088e9000 0 0x18c>,
> +                             <0 0x088e8000 0 0x10>;
>                         reg-names =3D "reg-base", "dp_com";
>                         status =3D "disabled";
>                         #clock-cells =3D <1>;
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
> =20
>                         clocks =3D <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> @@ -1571,11 +1572,11 @@
> =20
>                 usb_2_qmpphy: phy@88eb000 {
>                         compatible =3D "qcom,sdm845-qmp-usb3-uni-phy";
> -                       reg =3D <0x88eb000 0x18c>;
> +                       reg =3D <0 0x088eb000 0 0x18c>;
>                         status =3D "disabled";
>                         #clock-cells =3D <1>;
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
> =20
>                         clocks =3D <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> @@ -1602,10 +1603,10 @@
> =20
>                 usb_1: usb@a6f8800 {
>                         compatible =3D "qcom,sdm845-dwc3", "qcom,dwc3";
> -                       reg =3D <0xa6f8800 0x400>;
> +                       reg =3D <0 0x0a6f8800 0 0x400>;
>                         status =3D "disabled";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
> =20
>                         clocks =3D <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> @@ -1644,10 +1645,10 @@
> =20
>                 usb_2: usb@a8f8800 {
>                         compatible =3D "qcom,sdm845-dwc3", "qcom,dwc3";
> -                       reg =3D <0xa8f8800 0x400>;
> +                       reg =3D <0 0x0a8f8800 0 0x400>;
>                         status =3D "disabled";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
> =20
>                         clocks =3D <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
> @@ -1686,7 +1687,7 @@
> =20
>                 videocc: clock-controller@ab00000 {
>                         compatible =3D "qcom,sdm845-videocc";
> -                       reg =3D <0x0ab00000 0x10000>;
> +                       reg =3D <0 0x0ab00000 0 0x10000>;
>                         #clock-cells =3D <1>;
>                         #power-domain-cells =3D <1>;
>                         #reset-cells =3D <1>;
> @@ -1694,7 +1695,7 @@
> =20
>                 mdss: mdss@ae00000 {
>                         compatible =3D "qcom,sdm845-mdss";
> -                       reg =3D <0x0ae00000 0x1000>;
> +                       reg =3D <0 0x0ae00000 0 0x1000>;
>                         reg-names =3D "mdss";
> =20
>                         power-domains =3D <&dispcc MDSS_GDSC>;
> @@ -1716,14 +1717,14 @@
> =20
>                         status =3D "disabled";
> =20
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
> =20
>                         mdss_mdp: mdp@ae01000 {
>                                 compatible =3D "qcom,sdm845-dpu";
> -                               reg =3D <0x0ae01000 0x8f000>,
> -                                     <0x0aeb0000 0x2008>;
> +                               reg =3D <0 0x0ae01000 0 0x8f000>,
> +                                     <0 0x0aeb0000 0 0x2008>;
>                                 reg-names =3D "mdp", "vbif";
> =20
>                                 clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
> @@ -2061,85 +2062,85 @@
> =20
>                 intc: interrupt-controller@17a00000 {
>                         compatible =3D "arm,gic-v3";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;
>                         #interrupt-cells =3D <3>;
>                         interrupt-controller;
> -                       reg =3D <0x17a00000 0x10000>,     /* GICD */
> -                             <0x17a60000 0x100000>;    /* GICR * 8 */
> +                       reg =3D <0 0x17a00000 0 0x10000>,     /* GICD */
> +                             <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
>                         interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> =20
>                         gic-its@17a40000 {
>                                 compatible =3D "arm,gic-v3-its";
>                                 msi-controller;
>                                 #msi-cells =3D <1>;
> -                               reg =3D <0x17a40000 0x20000>;
> +                               reg =3D <0 0x17a40000 0 0x20000>;
>                                 status =3D "disabled";
>                         };
>                 };
> =20
>                 timer@17c90000 {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         ranges;

These could be written with ranges to remap the child nodes into the
address space of the parent. It would be nice to not change these
wrapper nodes and reduce the diff in this patch by using different
ranges properties.

>                         compatible =3D "arm,armv7-timer-mem";
> -                       reg =3D <0x17c90000 0x1000>;
> +                       reg =3D <0 0x17c90000 0 0x1000>;
> =20
>                         frame@17ca0000 {
>                                 frame-number =3D <0>;
>                                 interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_=
HIGH>,
>                                              <GIC_SPI 6 IRQ_TYPE_LEVEL_HI=
GH>;
> -                               reg =3D <0x17ca0000 0x1000>,
> -                                     <0x17cb0000 0x1000>;
> +                               reg =3D <0 0x17ca0000 0 0x1000>,
