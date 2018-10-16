Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F586C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A0E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXM2TY0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A0E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJQFel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQFel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:34:41 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719E2208E4;
        Tue, 16 Oct 2018 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539726140;
        bh=bJ0N18mUEpgOp021EFRUL0bqmt0SZ8dKHH0APwW+NgQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=PXM2TY0PA4EoP6/cHMvNnXBdS3r+fI7Bpf1bsbO4+4kMosl5/wJ4b+MbRLNuShniJ
         9ApQN7evn9FMFCL9+EVDnG0N7MWeCd4dDORAYcnDm+FKmfrsd3o4BEc5TdzNtbqJnn
         HjNtDRSpAfe1pcEMP7zZnKd86qlv1TSvCLjeG2QQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180810095113.25292-7-manivannan.sadhasivam@linaro.org>
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
 <20180810095113.25292-7-manivannan.sadhasivam@linaro.org>
Message-ID: <153972613980.5275.10581925529054373344@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 6/9] arm64: dts: actions: Add Reset Controller support for
 S900 SoC
Date:   Tue, 16 Oct 2018 14:42:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-08-10 02:51:10)
> Add reset controller property and bindings header for the
> Actions Semi S900 SoC DTS.
> =

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Are these DT patches necessary for me to apply the clk patches? I'd like
to apply the clk patches without these dts bits.

>  arch/arm64/boot/dts/actions/s900.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/=
actions/s900.dtsi
> index aa3a49b0d646..4fbb39fd7971 100644
> --- a/arch/arm64/boot/dts/actions/s900.dtsi
> +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> @@ -6,6 +6,7 @@
>  =

>  #include <dt-bindings/clock/actions,s900-cmu.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/reset/actions,s900-reset.h>
>  =

>  / {
>         compatible =3D "actions,s900";
> @@ -172,6 +173,7 @@
>                         reg =3D <0x0 0xe0160000 0x0 0x1000>;
>                         clocks =3D <&hosc>, <&losc>;
>                         #clock-cells =3D <1>;
> +                       #reset-cells =3D <1>;
>                 };
>  =

>                 pinctrl: pinctrl@e01b0000 {
> -- =

> 2.17.1
>=20
