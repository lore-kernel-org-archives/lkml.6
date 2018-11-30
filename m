Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352FC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrC0mYZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352FC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeK3T2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3T2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:28:01 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A21206B7;
        Fri, 30 Nov 2018 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543565970;
        bh=89c0y6qOCfya/pnqhwHBjoAmqS816Oq09i7UpfPG0Es=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TrC0mYZ7YwvaMw3L77EHb1B5MFqE4Vl0b1c/agUIY6jb0LrBxELk4tCjow8RLFT50
         avKoH+bfm6ll7CeNLJVCTRFOe2LoGNTbHO4paE/r4m2k3010zPQDIQngwWqR+1MpYy
         BYW4OsCvDxIjhWSGJFKnbxVT0uX4DVZLZsVZAsGc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <154356596981.88331.14415961625410424962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 06/14] dt-bindings: clock: milbeaut: add Milbeaut clock
 description
Date:   Fri, 30 Nov 2018 00:19:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sugaya Taichi (2018-11-18 17:01:11)
> Add DT bindings document for Milbeaut clock.
> =

> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/clock/milbeaut-clock.txt   | 93 ++++++++++++++++=
++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-cloc=
k.txt
> =

> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b=
/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> new file mode 100644
> index 0000000..5c093c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> @@ -0,0 +1,93 @@
> +Milbeaut M10V Clock Controller Binding
> +----------------------------------------
> +Milbeaut clock controller is consists of few oscillators, PLL, multiplex=
er
> +and few divider modules
> +
> +This binding uses common clock bindings
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: shall be "socionext,milbeaut-m10v-clk-regs"
> +- reg: shall contain base address and length of clock registers
> +- #clock-cells: shall be 0
> +
> +Example:
> +       m10v-clk-tree@ {
> +               compatible =3D "socionext,milbeaut-m10v-clk-regs";
> +               reg =3D <0x1d021000 0x4000>;
> +
> +               clocks {
> +                       #address-cells =3D <0>;
> +                       #size-cells =3D <0>;
> +
> +                       uclk40xi: uclk40xi {
> +                               compatible =3D "fixed-clock";
> +                               #clock-cells =3D <0>;
> +                               clock-frequency =3D <40000000>;
> +                       };
> +               };

This style of binding is highly discouraged. We don't describe each and
every clk in DT, we describe clk controllers and their outputs and
inputs in DT. The driver is the place where the clock controller
describes the internal clk topology of that controller. Also, fixed
frequency clks are typically oscillators and those would come from the
board dts file, but otherwise I wouldn't expect to see fixed frequency
clks in DT.

> +       }
> +
> +The clock consumer shall specify the desired clock-output of the clock
> +controller (as defined in [2]) by specifying output-id in its "clock"
> +phandle cell
> +[2] arch/arm/boot/dts/milbeaut-m10v-clk.h
> +
[...]
> +
> +Example
> +       piclk_mux_0: spiclk_mux_0 {
> +               compatible =3D "socionext,m10v-clk-div";
> +               #clock-cells =3D <0>;
> +               clocks =3D <&pll10_div_1_2>;
> +               offset =3D <bSPICLK>;
> +               mask =3D <0x3>;
> +               ratios =3D <4 0x5 2 0x4>;
> +       };
> +
> +       pll10: pll10 {
> +               compatible =3D "socionext,m10v-pll-fixed-factor";
> +               #clock-cells =3D <0>;
> +               clocks =3D <&uclk40xi>;
> +               offset =3D <10>;
> +               clock-div =3D <5>;
> +               clock-mult =3D <108>;
> +       };
> +
> +       emmcclk: emmcclk {
> +               compatible =3D "socionext,m10v-clk-div";
> +               #clock-cells =3D <0>;
> +               clocks =3D <&pll11>;
> +               offset =3D <bEMMCCLK>;
> +               mask =3D <0x3>;
> +               ratios =3D <15 0x7 10 0x6 9 0x5 8 0x4>;

Yeah, please no. This whole binding needs a rewrite to not have one node
per clk.

