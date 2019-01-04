Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56070218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546561780;
	bh=njkQ7rcGZOWokJ7cycUYwiessN0xYCk0aBK7wHYBAJc=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=qHbmGWv+0OXbpP+PguqZkdZ4L4QqL2S0GUyTcx+5GNtMyMh2AgDMsnsQed4umOj8i
	 yuYWxK1CBsRRgDsq5hN1bJrVb9hNze4JxpeL56ea5P5qwowT33CmkJ8287vSwVaDPM
	 LMAqHNiA/JsVlhtDqXMMESPfhnunvkb2AUcQ1S0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfADA3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfADA3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:29:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F8720660;
        Fri,  4 Jan 2019 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546561778;
        bh=njkQ7rcGZOWokJ7cycUYwiessN0xYCk0aBK7wHYBAJc=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=WVtyGRQb9pP7wEMuRusw0E1L0gA3nR/quBJb7aXsbLtskoc7S7ZPBO3GDM94BAJZE
         Nu4jGsUnrmXedMZU5KNSLhb57eC+ALbzLvai4zf2mZI2YSkqvkUBcEDI/vzinwogQF
         d/qmOQO31IiYzX6JBn/GkgidcOixqH1zLGM8cJD8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] ARM: dts: qcom: msm8974: add interrupt properties
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
In-Reply-To: <20181229114755.8711-4-masneyb@onstation.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181229114755.8711-1-masneyb@onstation.org> <20181229114755.8711-4-masneyb@onstation.org>
Message-ID: <154656177748.15366.4715288412613717364@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 16:29:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2018-12-29 03:47:55)
> Add interrupt properties now that spmi-gpio is a proper hierarchical IRQ
> chip.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-=
pm8941.dtsi
> index 9a91b758f7aa..d0b7f0eff288 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -65,6 +65,9 @@
>                         gpio-controller;
>                         gpio-ranges =3D <&pm8941_gpios 0 0 36>;
>                         #gpio-cells =3D <2>;
> +                       interrupt-parent =3D <&spmi_bus>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <4>;
>                         interrupts =3D <0 0xc0 0 IRQ_TYPE_NONE>,
>                                      <0 0xc1 0 IRQ_TYPE_NONE>,
>                                      <0 0xc2 0 IRQ_TYPE_NONE>,

Shouldn't we remove the interrupts property here then? Although we use
it to count the number of gpios that are supported so I guess we'll have
to specify it all the time now just to know how many pins there are.
Alternatively we change the driver to know about all the different
compatibles and use the right number of gpios for each compatible string
that we see.

