Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4FBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3CA218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546896369;
	bh=ad8RhK7BmHzamvb05nsZBz++ZPgPxPXElNeOhOpxp2g=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=2T7wRKEUVTsJy1Nz2oaZn25014qNUmLbmlDvJxm+vAFdrL9NFwhQTcqjmyP0NYeiG
	 3pJB8Ek7YokjbgPwMVMxKsMVX/hhiFojv2BseGjoYzGCx1KLw/U2t44hYZwo5Wammy
	 q7FwpA8oua+mztWwQlNVbAd0MVJrpkra1nwFc7Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAGV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfAGV0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:26:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAFDF206BB;
        Mon,  7 Jan 2019 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546896367;
        bh=ad8RhK7BmHzamvb05nsZBz++ZPgPxPXElNeOhOpxp2g=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=LZUCTIwyuHaXt+SwdpEn/uUfcsSLQhmEkfecKdcauRM9FeCfQie1x5X18NmqM//Mz
         QGrLpOfxytZytqcGUa3AmvFHOQFM2v0l6JeHQH02sf5u0VqLH5Vglvr70Kwl6jgxRO
         emqBHJq6tAW2ISiLew3EV+Kpr9Ik6oEJo3o6MmcA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/5] spmi: pmic-arb: hardcode IRQ counts
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
In-Reply-To: <20190107021145.6370-2-masneyb@onstation.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20190107021145.6370-1-masneyb@onstation.org> <20190107021145.6370-2-masneyb@onstation.org>
Message-ID: <154689636697.15366.4175054145572492763@swboyd.mtv.corp.google.com>
Date:   Mon, 07 Jan 2019 13:26:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-06 18:11:41)
> @@ -1062,19 +1076,6 @@ static int pmic_gpio_remove(struct platform_device=
 *pdev)
>         return 0;
>  }
> =20
> -static const struct of_device_id pmic_gpio_of_match[] =3D {
> -       { .compatible =3D "qcom,pm8916-gpio" },   /* 4 GPIO's */
> -       { .compatible =3D "qcom,pm8941-gpio" },   /* 36 GPIO's */
> -       { .compatible =3D "qcom,pm8994-gpio" },   /* 22 GPIO's */
> -       { .compatible =3D "qcom,pmi8994-gpio" },  /* 10 GPIO's */
> -       { .compatible =3D "qcom,pma8084-gpio" },  /* 22 GPIO's */
> -       { .compatible =3D "qcom,pms405-gpio" },   /* 12 GPIO's, holes on =
1 9 10 */
> -       { .compatible =3D "qcom,spmi-gpio" }, /* Generic */
> -       { },
> -};
> -
> -MODULE_DEVICE_TABLE(of, pmic_gpio_of_match);
> -

Please don't move the array. It isn't necessary if you use
device_get_match_data() instead of of_match_device().

