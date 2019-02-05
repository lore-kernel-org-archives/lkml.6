Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67921C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C43217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549404214;
	bh=P/SkehkSMbaxES7JAlbIPn7lIoGVLBvE3nN3woMMRJk=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=Za0Wj7731gSOi3GIcOJTZ5gvbaHLN2iRQGOu62RJWHWO41+72s/JOw6dSah9dhxbn
	 SIIf7NF+eQuFosm8zBcGjHE+P8zoaKpSUnZN2ejhM54itTRLjnnaFbPT70IXajpYHN
	 3DUhfHh/lwOWIpYAW5IBC/qumGu2/DyYz0xsIx7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfBEWDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfBEWDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:03:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B62320823;
        Tue,  5 Feb 2019 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549404211;
        bh=P/SkehkSMbaxES7JAlbIPn7lIoGVLBvE3nN3woMMRJk=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=jGENKyiqOLFmmIw2swb3CERrNVpTGBWOZd0ISBajJsw5yLerLpFzsjxjlzgQOd9qc
         dXWGpqET5ckJs3wQlcn0nxpNBOYm2DIk6xTQt3HkP4xC7innS4+kpKNCRFe61E0GWN
         eJYozpMCoIbI6Lz+7Ugcb3KvgbR9+u69J7E6iBl0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: msm8998: Add mmcc node
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940421042.169292.8494408240796466238@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866184-30378-1-git-send-email-jhugo@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org
In-Reply-To: <1548866184-30378-1-git-send-email-jhugo@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:03:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-01-30 08:36:24)
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/=
qcom/msm8998.dtsi
> index 7136ab1..5673a65 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -814,6 +814,21 @@
>                         status =3D "disabled";
>                 };
> =20
> +               mmcc: clock-controller@c8c0000 {
> +                       compatible =3D "qcom,mmcc-msm8998";
> +                       #clock-cells =3D <1>;
> +                       #reset-cells =3D <1>;
> +                       #power-domain-cells =3D <1>;
> +                       reg =3D <0x0c8c0000 0x40000>;
> +
> +                       clock-names =3D
> +                               "xo",

Weird newline here. Please put "xo" on the same line as clock-names.

> +                               "gpll0";
> +                       clocks =3D
> +                               <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +                               <&gcc GPLL0_OUT_MAIN>;

Ah ok, so only the multimedia clks get the xo clk from rpm for now?

