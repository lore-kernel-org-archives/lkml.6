Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E189AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A404620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635572;
	bh=taLdMqD8uGpTPXnoETTA3FKlb2OmR9x/D/srdsOy7jE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k8vtIvilg4W/UnWcwtXMaqid9voDg+hyZvH7p0okdoVHGp9g/Ap2tqGPrSurFVcly
	 X+Fi8FB9e8z5pGhhEN4+vFUP09mOfMhSPHtyTYYcuXtXoCidjbEDRO2UHODj+Eicy+
	 lPha1GVJA0I7jmoMDQeXs/mZqnA27/rSMHwMRFxc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A404620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeLLR0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:26:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLR0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:26:11 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BCC2084E;
        Wed, 12 Dec 2018 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635570;
        bh=taLdMqD8uGpTPXnoETTA3FKlb2OmR9x/D/srdsOy7jE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OQo+w0E2bfvk3XmlNAXG7GpnOJa8Vcl7oKXuJABsiIe8bnn0l8NXh6988aIqAcAhq
         98a9JrxoaB4AAdtyAmNwnNQueYIUFGUD0w2aCFFJtLrYG0aqvRd3bfxrzRy0IDMUJV
         UWs5kedJBLjWW4hVq+IqLG/E8iZmMDe86VvXqwps=
Date:   Wed, 12 Dec 2018 17:26:04 +0000
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
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: exynos-adc: Add S5PV210
 variant
Message-ID: <20181212172604.6336779e@archlinux>
In-Reply-To: <20181207191136.5464-4-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
        <20181207191136.5464-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 20:11:36 +0100
Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:

> From: Jonathan Bakker <xc-racer2@live.ca>
>=20
> Add information about new compatible for S5PV210
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.txt        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc=
.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> index 6c49db7f8ad2..a10c1f89037d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> @@ -11,7 +11,7 @@ New driver handles the following
> =20
>  Required properties:
>  - compatible:		Must be "samsung,exynos-adc-v1"
> -				for exynos4412/5250 and s5pv210 controllers.
> +				for exynos4412/5250 controllers.
>  			Must be "samsung,exynos-adc-v2" for
>  				future controllers.
>  			Must be "samsung,exynos3250-adc" for
> @@ -28,6 +28,8 @@ Required properties:
>  				the ADC in s3c2443 and compatibles
>  			Must be "samsung,s3c6410-adc" for
>  				the ADC in s3c6410 and compatibles
> +			Must be "samsung,s5pv210-adc" for
> +				the ADC in s5pv210 and compatibles
>  - reg:			List of ADC register address range
>  			- The base address and range of ADC register
>  			- The base address and range of ADC_PHY register (every

