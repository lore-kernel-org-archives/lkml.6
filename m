Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3762C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6122820880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635360;
	bh=XuK4ExPc8bBFloe/2WoPw14IMFW3BHgc7sK3vLIdSCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fe2lEXQxmLvy+qX6SUEBYNTqTbSz5dSr9P6d8GhEAnPt7s3O/owYt5TFejn3JwBUZ
	 3CW+RMrWb5NL/5R/aOQIDW24PWxXDitCFcp/Lw9Cmc7AHSKs3E71Y3WXdwqLo3dqao
	 oaDxA4fL1dHGiw/h0t3dIfPcmxhPztrJyqAhCSN4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6122820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeLLRWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbeLLRWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:22:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE582084E;
        Wed, 12 Dec 2018 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635358;
        bh=XuK4ExPc8bBFloe/2WoPw14IMFW3BHgc7sK3vLIdSCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q/sdtdF46m1GbA7mV5HTba9rfAl/gJHCeHr6JFA9sKJIRhIg1Yq40MPA42M2iBRaP
         lLScO5bAdWMg5uAnuhHx6vhu9KF6LlJNEe1nMy2jWZ2ejrVIY7lfZw+3gjk097HKRG
         ilLMjYVZn14yJQnoAhhmNOn0LnZpxDX9S56KILdY=
Date:   Wed, 12 Dec 2018 17:22:31 +0000
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
Subject: Re: [PATCH 2/3] iio: adc: Allow selection of Exynos ADC on S5PV210
Message-ID: <20181212172231.0adaf43b@archlinux>
In-Reply-To: <20181207191136.5464-3-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
        <20181207191136.5464-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 20:11:35 +0100
Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:

> From: Jonathan Bakker <xc-racer2@live.ca>
>=20
> Make it possible to use Exynos ADC driver on S5PV210 based devices.
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a52fea8749a9..20e126ff030e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -274,7 +274,7 @@ config EP93XX_ADC
> =20
>  config EXYNOS_ADC
>  	tristate "Exynos ADC driver support"
> -	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPIL=
E_TEST)
> +	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 =
|| (OF && COMPILE_TEST)
>  	depends on HAS_IOMEM
>  	help
>  	  Core support for the ADC block found in the Samsung EXYNOS series

