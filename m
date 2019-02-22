Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0042205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550858961;
	bh=UupqhbqdFjKgKSI02MJoN0XI6eO4sJ++1hYERxTqud0=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=Zq3r3DAoMbBBSsby/FBcpC1LP/NQ6SoL80Bi+mOXC8PeDENiiI2M/zwws1KRtoGUz
	 512CKx+UMrrIyeVqC4CParwNi0U5wBQght1lfomoFrU/mX9w14KzAlTXx+tldlLAvV
	 2np7iD+9RzgO8GRY5o5NEdruMLHNoxzDQv6ofuXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfBVSJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfBVSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:09:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D63205C9;
        Fri, 22 Feb 2019 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550858958;
        bh=UupqhbqdFjKgKSI02MJoN0XI6eO4sJ++1hYERxTqud0=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=rEocUHsffCvK3PcLGoZGGv2zw0rJyuIkofLLfTStqhWtSS09sJjA5Z3wYHoGwQQxF
         UouGjx9OCvjRhY3Ups6GbOiBJN8O5uBvzbgYTCZcFVXNRevEBwUY3GvkblRvdQSS0D
         FIYwknpf1TD1PWKyctCp9jyeycNtWF4qlYnzi8yw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 02/14] mbox: qcom: add APCS child device for QCS404
Message-ID: <155085895764.77512.15118138971189768976@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1548700381-22376-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
To:     andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        david.brown@linaro.org, enric.balletbo@collabora.com,
        heiko@sntech.de, horms+renesas@verge.net.au,
        jagan@amarulasolutions.com, jassisinghbrar@gmail.com,
        jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
        sibis@codeaurora.org, will.deacon@arm.com
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Date:   Fri, 22 Feb 2019 10:09:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:49)
> There is clock controller functionality in the APCS hardware block of
> qcs404 devices similar to msm8916.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qc=
om-apcs-ipc-mailbox.c
> index 3cf2937..0d64aa5 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -97,16 +97,21 @@ static int qcom_apcs_ipc_probe(struct platform_device=
 *pdev)
>                 return ret;
>         }
> =20
> -       if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global"))=
 {
> -               apcs->clk =3D platform_device_register_data(&pdev->dev,
> -                                                         "qcom-apcs-msm8=
916-clk",
> -                                                         -1, NULL, 0);
> -               if (IS_ERR(apcs->clk))
> -                       dev_err(&pdev->dev, "failed to register APCS clk\=
n");
> -       }
> -
>         platform_set_drvdata(pdev, apcs);
> =20
> +       if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") =
||
> +           of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
> +               goto register_clk;

This goto is weird style, but I'm not the maintainer here. Maybe just do
an if condition with the body of the if inside like normally is done and
suffer the indenting pain?

