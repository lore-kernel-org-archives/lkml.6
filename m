Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A362C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C99218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545227759;
	bh=FM+hsBx9/RBvpYL8sdkk2SO2cjqnMa9L4ZTTEJHHrXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UbSoGkI71MHt+GmhaPMtMc9YwZ7aVEJzjFPwVe1gMh9wkD8MJ1P600Wr77NMpBWhb
	 KdHpPVl5mJu3vXh2bSb05w0Ub/isxRsZ8kD4NBgjajiocslE2CzNuwBksj/jmv9nFl
	 BTqwQH/1ap1o7udf1m1XqD5syNOYb2RFuYTVAZ3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeLSNz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeLSNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:55:58 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF06218A6;
        Wed, 19 Dec 2018 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545227756;
        bh=FM+hsBx9/RBvpYL8sdkk2SO2cjqnMa9L4ZTTEJHHrXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NN7ExXfe9m3AN1QAD409R99D5hkT263tmcT7QMtQNYRXjaFmJs64FHlamMPP7WEB9
         XIh/xFI0rS1YvZt6E3V5PBuCPwM5Zz89IMHdQM4bGSgzT/SHHm6NJ7TQju4xBrfU6e
         PzQQzOcwmB9uA123x23++xlEo1RixkChVsxaLyrI=
Received: by mail-qt1-f173.google.com with SMTP id r14so22318438qtp.1;
        Wed, 19 Dec 2018 05:55:56 -0800 (PST)
X-Gm-Message-State: AA+aEWa7QcwKl4A0S5QelNTGl9NTWY1ZL/TFLNg6ie8aqIkKm76Jh9UN
        DUOegzWTjmklt/Vejx2Ti0VV8Os5tkh00N2UCA==
X-Google-Smtp-Source: AFSGD/U7MMddC0x398KdCFTj5CQ7/aHVczQLCSfUV1R98gGC1p/jxF4mJvD6vB5+15NByhakKiMMJunMABmOHn+XaDg=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr22163473qtf.26.1545227755896;
 Wed, 19 Dec 2018 05:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20181219123147.16090-1-james.qian.wang@arm.com> <20181219123147.16090-3-james.qian.wang@arm.com>
In-Reply-To: <20181219123147.16090-3-james.qian.wang@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 19 Dec 2018 07:55:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsQ__dpu0Xh5zmLbOx_B8t0t0kJzoh-nOf=nuZSppAYg@mail.gmail.com>
Message-ID: <CAL_JsqLsQ__dpu0Xh5zmLbOx_B8t0t0kJzoh-nOf=nuZSppAYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
To:     james.qian.wang@arm.com
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan.Chai@arm.com,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yiqi.Kang@arm.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Tiannan.Zhu@arm.com, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        thomas.Sun@arm.com, Ayan.Halder@arm.com,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jin.Gao@arm.com, nd@arm.com, Sean Paul <sean@poorly.run>,
        Lowry.Li@arm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Julien.Yin@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 6:33 AM james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
>
> Add DT bindings documentation for the ARM display processor D71 and later
> IPs.
>
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> ---
>  .../bindings/display/arm/arm,komeda.txt       | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komeda.txt
>
> diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.txt b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> new file mode 100644
> index 000000000000..d4b53c11b2a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> @@ -0,0 +1,87 @@
> +Device Tree bindings for ARM Komeda display driver
> +
> +Required properties:
> +- compatible: Should be "arm,mali-d71"
> +- reg: Physical base address and length of the registers in the system
> +- interrupts: the interrupt line numbers of the device in the system

How many?

> +- interrupt-names: contains the names of the IRQs in the order they were
> +    provided in the "interrupts" property. Must contain: "DPU".

There's no point in *-names when there is only one entry.

> +- clocks: A list of phandle + clock-specifier pairs, one for each entry
> +    in 'clock-names'
> +- clock-names: A list of clock names. It should contain:
> +      - "pclk": for the APB interface clock
> +      - "mclk": for the main processor clock

The order here doesn't match the example.

> +- #address-cells: Must be 1
> +- #size-cells: Must be 0
> +
> +Required properties for sub-node: pipeline@nq
> +Each device contains one or two pipeline sub-nodes (at least one), each
> +pipeline node should provide properties:
> +- reg: Zero-indexed identifier for the pipeline
> +- clocks: A list of phandle + clock-specifier pairs, one for each entry
> +    in 'clock-names'
> +- clock-names: should contain:
> +      - "aclk": AXI interface clock
> +      - "pxclk": pixel clock

The order here doesn't match the example.

> +
> +- port: each pipeline connect to an encoder input port. The connection is
> +    modelled using the OF graph bindings specified in

modeled

> +    Documentation/devicetree/bindings/graph.txt
> +
> +Optional properties:
> +  - memory-region: phandle to a node describing memory (see
> +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
> +    to be used for the framebuffer; if not present, the framebuffer may
> +    be located anywhere in memory.
> +
> +Example:
> +/ {
> +       ...
> +
> +       dp0: display@c00000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "arm,mali-d71";
> +               reg = <0xc00000 0x20000>;
> +               interrupts = <0 168 4>;
> +               interrupt-names = "DPU";
> +               clocks = <&dpu_mclk>, <&dpu_aclk>;
> +               clock-names = "mclk", "pclk";
> +
> +               pl0: pipeline@0 {
> +                       clocks = <&fpgaosc2>, <&dpu_aclk>;
> +                       clock-names = "pxclk", "aclk";
> +                       reg = <0>;

Is there a register range for each pipeline? If so, using that here
would be better than index.

> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;

You can drop 'ports' moving port up a level. And for a single port,
you don't need reg.

> +                                       dp0_pl0_out: endpoint {
> +                                               remote-endpoint = <&db_dvi0_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +               pl1: pipeline@1 {
> +                       clocks = <&fpgaosc2>, <&dpu_aclk>;
> +                       clock-names = "pxclk", "aclk";
> +                       reg = <1>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       dp0_pl1_out: endpoint {
> +                                               remote-endpoint = <&db_dvi1_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +       ...
> +};
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
