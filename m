Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60734C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355A221535
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVSUqAKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355A221535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHOXZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeHOXZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:25:09 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECEA21534;
        Wed, 15 Aug 2018 20:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534365088;
        bh=b/EHUDJOKwklroxxSlgkptrKKb1wlkF/HaA36CzKDf4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iVSUqAKIH4NZIo5wFwAJSdRr20NaILx3SXGUIyY5W6H95DlDB628uiMqk0IbrfElh
         u5PtulpeLbsQOhCegzkPD6STJA6NOasDHfbxa/GlpBDOnIG9xJCbsJHK0dGPDJL99p
         gVLeKDtn6eI+ajhw/ODYbpEAZe0ib3asCgJO5Las=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Craig Tatlor <ctatlor97@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180811162453.10930-1-ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org
References: <20180811162453.10930-1-ctatlor97@gmail.com>
Message-ID: <153436508626.28926.521245329376033797@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] firmware: qcom: scm: Add sdm660 soc compatible
Date:   Wed, 15 Aug 2018 13:31:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Craig Tatlor (2018-08-11 09:24:50)
> Add the compatible for SDM660.
> This does not need clocks to do scm calls
> =

> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  drivers/firmware/qcom_scm.c                             | 3 +++
>  2 files changed, 4 insertions(+)
> =

> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Do=
cumentation/devicetree/bindings/firmware/qcom,scm.txt
> index fcf6979c0b6d..499608fcc864 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> @@ -11,6 +11,7 @@ Required properties:
>   * "qcom,scm-msm8660" for MSM8660 platforms
>   * "qcom,scm-msm8690" for MSM8690 platforms
>   * "qcom,scm-msm8996" for MSM8996 platforms
> + * "qcom,scm-sdm660" for SDM660 platforms
>   * "qcom,scm-ipq4019" for IPQ4019 platforms
>   * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
>  - clocks: One to three clocks may be required based on compatible.
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index e778af766fae..ee113ceb5d41 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -603,6 +603,9 @@ static const struct of_device_id qcom_scm_dt_match[] =
=3D {
>         { .compatible =3D "qcom,scm-msm8996",
>           .data =3D NULL, /* no clocks */
>         },
> +       { .compatible =3D "qcom,scm-sdm660",
> +         .data =3D NULL, /* no clocks */
> +       },

Do you need to update the driver? It looks like the scm driver should be
changed to just try and get all the clks it can and treat them as
optional clks, i.e. don't fail if they aren't actually listed in DT.
Then we can just have one qcom,scm compatible string in this driver but
we're free to add different compatibles to the binding for all the
different SoCs out there.

