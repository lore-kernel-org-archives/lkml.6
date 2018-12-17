Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD422C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CCA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545075554;
	bh=A4k7LNbfEQH1Cid16589iwNCBJ8lF84JWvNasE0gFMQ=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=BPLRnvz4iRZonr+K03r3Jc++FRTgdRAVvnbL/PugGLePPPlFJYp7BiP3lhPTzikUo
	 zIzXsOC/zVOClTCXNNbJSQGpxnrwvkDCkMZenyHfx/lnYO3ZUNbRp2bDHbwGQO1lxH
	 8wnlPWlZGlELlS9pc3NGlCnMtHS1RV2wRT3CIg5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbeLQTjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeLQTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:39:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F2E206A2;
        Mon, 17 Dec 2018 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545075552;
        bh=A4k7LNbfEQH1Cid16589iwNCBJ8lF84JWvNasE0gFMQ=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=y2tgScXUkNoymC6vkN2czyHr9bhB/Fk3EYeFEmIpBxBR/SB4fHug95sBU0GA6b3E3
         cPPmZGWS874ZUat2AMr6jZJQ00zLw0C2wyLbZoQM+BBLrar9MEtmiI92O24gaYJw4u
         RNnnnX4Q2s+//7EA39dpVjsyVwqUlCt+d8OCL/eM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
To:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Mon, 17 Dec 2018 11:39:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:27)
> The high frequency pll functionality is required to enable CPU
> frequency scaling operation.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/q=
com/qcs404.dtsi
> index 4594fea7..ec3f6c7 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -375,6 +375,15 @@
>                         #mbox-cells =3D <1>;
>                 };
> =20
> +               apcs_hfpll: clock-controller@0b016000 {

Drop leading 0 on unit address please.

> +                       compatible =3D "qcom,hfpll";
> +                       reg =3D <0x0b016000 0x30>;

Wow that is small!

> +                       #clock-cells =3D <0>;
> +                       clock-output-names =3D "apcs_hfpll";
> +                       clocks =3D <&xo_board>;
> +                       clock-names =3D "xo";
> +               };
> +
