Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF19C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5067B2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244061;
	bh=iQDzrkJmBkI1WR7GR9QVMGpNtNLZRQLGUPVREeh+YcM=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=2tvJ5yMz0GIVRteEyfb4Q6XlogR5FpddneSvCO98w/Kpg9cQGMYiDmw+Wy8Ro9toi
	 ZJ4fW79CsNUUYJDxLrSG0lq2zw6D3rcg1YJhVDo8rUOaCsN9eJXTLYonw2H61PtsNW
	 1Zjnc6KBMdBDfc0cVfg4SfbQn7QBRdPbeRB0Hf1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfAKWBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfAKWBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:01:00 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3030220878;
        Fri, 11 Jan 2019 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547244059;
        bh=iQDzrkJmBkI1WR7GR9QVMGpNtNLZRQLGUPVREeh+YcM=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=Z/ztwOOiBLiq6IwHE1knClDriFAuzg5WC6NmK2mi64jP04ij0nptJSv8DoJVsi5q0
         haoHNL6GKLmu2oqf/BH7ao0h+yveUbEibhcgCUitleA9t7c5K8nS8tejEPLyZteSUo
         4umR24lFiUoc1pVw2XdmPAmc97moI+8qtM++IpHk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/6] pinctrl: qcom: spmi-gpio: hardcode IRQ counts
User-Agent: alot/0.8
In-Reply-To: <20190110011258.17227-2-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-2-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154724405834.169631.5375710339019706473@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:00:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-09 17:12:53)
> @@ -1062,14 +1056,15 @@ static int pmic_gpio_remove(struct platform_devic=
e *pdev)
>         return 0;
>  }
> =20
> +/* data contains the number of GPIOs */
>  static const struct of_device_id pmic_gpio_of_match[] =3D {
> -       { .compatible =3D "qcom,pm8916-gpio" },   /* 4 GPIO's */
> -       { .compatible =3D "qcom,pm8941-gpio" },   /* 36 GPIO's */
> -       { .compatible =3D "qcom,pm8994-gpio" },   /* 22 GPIO's */
> -       { .compatible =3D "qcom,pmi8994-gpio" },  /* 10 GPIO's */
> -       { .compatible =3D "qcom,pma8084-gpio" },  /* 22 GPIO's */
> -       { .compatible =3D "qcom,pms405-gpio" },   /* 12 GPIO's, holes on =
1 9 10 */
> -       { .compatible =3D "qcom,spmi-gpio" }, /* Generic */
> +       { .compatible =3D "qcom,pm8916-gpio", .data =3D (void *) 4 },
> +       { .compatible =3D "qcom,pm8941-gpio", .data =3D (void *) 36 },
> +       { .compatible =3D "qcom,pm8994-gpio", .data =3D (void *) 22 },
> +       { .compatible =3D "qcom,pmi8994-gpio", .data =3D (void *) 10 },
> +       { .compatible =3D "qcom,pma8084-gpio", .data =3D (void *) 22 },
> +       /* pms405 has 12 GPIOs with holes on 1, 9, and 10 */
> +       { .compatible =3D "qcom,pms405-gpio", .data =3D (void *) 12 },

We've been lazy and not been updating this file.

 $ git grep "qcom,spmi-gpio"
 arch/arm/boot/dts/qcom-pm8941.dtsi:                     compatible =3D "qc=
om,pm8941-gpio", "qcom,spmi-gpio";
 arch/arm/boot/dts/qcom-pma8084.dtsi:                    compatible =3D "qc=
om,pma8084-gpio", "qcom,spmi-gpio";
 arch/arm64/boot/dts/qcom/pm8005.dtsi:                   compatible =3D "qc=
om,pm8005-gpio", "qcom,spmi-gpio";
 arch/arm64/boot/dts/qcom/pm8998.dtsi:                   compatible =3D "qc=
om,pm8998-gpio", "qcom,spmi-gpio";
 arch/arm64/boot/dts/qcom/pmi8994.dtsi:                  compatible =3D "qc=
om,pmi8994-gpio", "qcom,spmi-gpio";
 arch/arm64/boot/dts/qcom/pmi8998.dtsi:                  compatible =3D "qc=
om,pmi8998-gpio", "qcom,spmi-gpio";

So we'll need to add pm8005, pm8998, pmi8998 here with their pin counts
too to avoid breaking those devices with this patch.

