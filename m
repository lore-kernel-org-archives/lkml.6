Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C046520823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549404146;
	bh=hkuzGSpTyTOw9ZwBzf9rP1zrDiXS/vQjC1uX5I1zl7A=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=WSsbHLTodnXaddlrMvT8yh1GcqnACuJr3FXuN52X0+OaDcA4lLPhJIPIzQtdrCIo1
	 zybsNmwPgAJP19u9rxJUExZCXsf6t5mnqhFgER8sQl0gytg83a9hwFiFnjgjJkjHLu
	 +EU58wk4tOoNyLPK4YNlWqqlETUqi6p+aFupxtKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfBEWCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:02:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfBEWCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:02:25 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD9520823;
        Tue,  5 Feb 2019 22:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549404144;
        bh=hkuzGSpTyTOw9ZwBzf9rP1zrDiXS/vQjC1uX5I1zl7A=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=FBtIG3a56Db7mlJS16rXusPIUEX0DbHyUOWp2cRAotSaZNn4Rt418Y/YnPXuM/Nha
         Eao51IKTbR7IpnuAJ6PcK4/K2u/J/1nRPJdjaPagruOVcJqmDpJwGczfjpA1bD5TdT
         DzsWreC/f+JzxNzuH6JcvYqWkuvjR/hNr9noiXMc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: Add support for the MSM8998 mmcc
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940414347.169292.9150834270087697417@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866159-30304-1-git-send-email-jhugo@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, bjorn.andersson@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <1548866159-30304-1-git-send-email-jhugo@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:02:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-01-30 08:35:59)
> Document the multimedia clock controller found on MSM8998
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,mmcc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Docu=
mentation/devicetree/bindings/clock/qcom,mmcc.txt
> index 8b0f784..ae85bca 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
> @@ -10,11 +10,18 @@ Required properties :
>                         "qcom,mmcc-msm8960"
>                         "qcom,mmcc-msm8974"
>                         "qcom,mmcc-msm8996"
> +                       "qcom,mmcc-msm8998"
> =20
>  - reg : shall contain base register location and length
>  - #clock-cells : shall contain 1
>  - #reset-cells : shall contain 1
> =20
> +For MSM8998 only:
> +       - clocks: a list of phandles and clock-specifier pairs,
> +                 one for each entry in clock-names.
> +       - clock-names: "xo" for the xo clock,
> +                      "gpll0" for the global pll 0 clock.

Wouldn't the DSI plls also be listed here? And anything else that is
external to this clock controller?

