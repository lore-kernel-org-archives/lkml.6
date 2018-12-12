Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF13C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5134020873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635143;
	bh=ppSsWLSPQN9/OSxzftYBE+M4YZMmUtfNScoa3kV4+T4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=twx8ImTl75rfjp3L6mkwWqv58Lh9rzYa+vmXT+wjOjO63Kdw5szNPmXT1WFkocIV4
	 325LinbDnXbS28DSBsdbrm11wJYqNGr4BtgwLpyvjmmobOdZ8Po2w1Yro4tUAFGXPm
	 KzTsN79jK15WY6TpAVCMoScQlMCfxsuseQaaqB8Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5134020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeLLRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:19:02 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F8720851;
        Wed, 12 Dec 2018 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635141;
        bh=ppSsWLSPQN9/OSxzftYBE+M4YZMmUtfNScoa3kV4+T4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxTrmvkaTB7c7MIxVIMlAiOSjODDOxNeclC3tKq6YfVrs0v/llFmDmMftzwcid4ol
         xXOfdpZL+q0hgAElKsFcq/5bWo/quUlO0tYjQNKzLgtvHDBJrJTZul6FqGvGi79XSp
         lKpBQKsNnH6JRVfNKkeeK1wLR0tOSlieFoUQR/lI=
Date:   Wed, 12 Dec 2018 17:18:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, xc-racer2@live.ca,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        baolin.wang@linaro.org, smohanad@codeaurora.org,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, freeman.liu@spreadtrum.com,
        marcus.folkesson@gmail.com, geert@linux-m68k.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: exynos-adc: Add S5PV210 variant
Message-ID: <20181212171846.4f4675a7@archlinux>
In-Reply-To: <20181207191136.5464-2-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
        <20181207191136.5464-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 20:11:34 +0100
Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:

> From: Jonathan Bakker <xc-racer2@live.ca>
>=20
> S5PV210's ADC variant is almost the same as v1 except that it has 10
> channels and doesn't require the pmu register
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
Long enough I thing ;)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/exynos_adc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index f10443f92e4c..fa2d2b5767f3 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -115,6 +115,7 @@
>  #define MAX_ADC_V2_CHANNELS		10
>  #define MAX_ADC_V1_CHANNELS		8
>  #define MAX_EXYNOS3250_ADC_CHANNELS	2
> +#define MAX_S5PV210_ADC_CHANNELS	10
> =20
>  /* Bit definitions common for ADC_V1 and ADC_V2 */
>  #define ADC_CON_EN_START	(1u << 0)
> @@ -282,6 +283,16 @@ static const struct exynos_adc_data exynos_adc_v1_da=
ta =3D {
>  	.start_conv	=3D exynos_adc_v1_start_conv,
>  };
> =20
> +static const struct exynos_adc_data exynos_adc_s5pv210_data =3D {
> +	.num_channels	=3D MAX_S5PV210_ADC_CHANNELS,
> +	.mask		=3D ADC_DATX_MASK,	/* 12 bit ADC resolution */
> +
> +	.init_hw	=3D exynos_adc_v1_init_hw,
> +	.exit_hw	=3D exynos_adc_v1_exit_hw,
> +	.clear_irq	=3D exynos_adc_v1_clear_irq,
> +	.start_conv	=3D exynos_adc_v1_start_conv,
> +};
> +
>  static void exynos_adc_s3c2416_start_conv(struct exynos_adc *info,
>  					  unsigned long addr)
>  {
> @@ -478,6 +489,9 @@ static const struct of_device_id exynos_adc_match[] =
=3D {
>  	}, {
>  		.compatible =3D "samsung,s3c6410-adc",
>  		.data =3D &exynos_adc_s3c64xx_data,
> +	}, {
> +		.compatible =3D "samsung,s5pv210-adc",
> +		.data =3D &exynos_adc_s5pv210_data,
>  	}, {
>  		.compatible =3D "samsung,exynos-adc-v1",
>  		.data =3D &exynos_adc_v1_data,

