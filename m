Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11D6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EC121526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="naNU/Mvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EC121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbeITVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387549AbeITVOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:14:05 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D5F20833;
        Thu, 20 Sep 2018 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537457404;
        bh=CkWUq6dj+IN9kkKlcD21WIQ+l8tunhc/v3UD+A8GgGo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=naNU/MvtnEz5SZdajaxdzsDRTVuY91p3q40W1DCExw5p7/+aUL5HmkFWZORQcI/8P
         rtXlrpRXuylKOKXYOzqJGUYx7hzoC/1Jhfr8V3Py6y+FY+lUugR9mXaRAFZN0AxQA1
         PcnIFdFQHh3Qamn9Hmuke62jouev1bjxKF+yEsPs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180920014705.15144-1-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180920014705.15144-1-bjorn.andersson@linaro.org>
Message-ID: <153745740342.119890.12073424910838960020@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pms405 gpio support
Date:   Thu, 20 Sep 2018 08:30:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-09-19 18:47:05)
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/q=
com/pinctrl-spmi-gpio.c
> index a29efbe08f48..b54891998caa 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1055,6 +1055,7 @@ static const struct of_device_id pmic_gpio_of_match=
[] =3D {
>         { .compatible =3D "qcom,pm8994-gpio" },   /* 22 GPIO's */
>         { .compatible =3D "qcom,pmi8994-gpio" },  /* 10 GPIO's */
>         { .compatible =3D "qcom,pma8084-gpio" },  /* 22 GPIO's */
> +       { .compatible =3D "qcom,pms405-gpio" }, /* 11 GPIO's */

I thought we didn't update the C driver, because there isn't anything to
do here. Just make binding updates and it's all fine.

>         { .compatible =3D "qcom,spmi-gpio" }, /* Generic */
>         { },
>  };
