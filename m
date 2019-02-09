Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2004C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E80221773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549726785;
	bh=RGmw6w6J6koCCWaO/5B2P+FqvE/gaQ+XH8qXVz8uD9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ElJYWkN6ji8wrE9jRE4tkGSkpu33FGLM41OBCzOT0mz8aV39XCSnw58UkUr2ir4K5
	 APm1iHa76eYb7J0F/9g5/d9asgZZVkuya0L39ci30ybjQDltI9i07DE8gAm3oyXO/F
	 4NPeNu/Fw2mHJR4/ZPIBMy+oyf7FEaMfBDpWgKGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBIPjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfBIPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:39:42 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561EE21773;
        Sat,  9 Feb 2019 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549726782;
        bh=RGmw6w6J6koCCWaO/5B2P+FqvE/gaQ+XH8qXVz8uD9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NW9SiYeKNXg0J72jv9cqkVCDcnU7HTwAswxM5Sb/LOYwJjk25V6x2jsrA4oUjPV8P
         Sk1GIIjBUZJ8U7oT7fr2b2CEMaJbTwxhdVxDnLfJqNS/DL+2dq/gdbJKiZB/5lcH7C
         cyYpd+8wP0TiKtWg1kMEDV3yB417RH0gz4AuOop4=
Date:   Sat, 9 Feb 2019 15:39:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio/adc: Add bindings for Ingenic
 JZ47xx SoCs ADC.
Message-ID: <20190209153936.351ac73a@archlinux>
In-Reply-To: <20190204001514.29891-2-contact@artur-rojek.eu>
References: <20190204001514.29891-1-contact@artur-rojek.eu>
        <20190204001514.29891-2-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 01:15:13 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Add device tree bindings for the ADC controller on JZ47xx SoCs,
> used by the ingenic-adc driver.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Applied, 

Thanks,

Jonathan

> ---
> 
>  Changes:
> 
>  v2: no change
> 
>  include/dt-bindings/iio/adc/ingenic,adc.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/ingenic,adc.h
> 
> diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
> new file mode 100644
> index 000000000000..82706b2706ac
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/ingenic,adc.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_IIO_ADC_INGENIC_ADC_H
> +#define _DT_BINDINGS_IIO_ADC_INGENIC_ADC_H
> +
> +/* ADC channel idx. */
> +#define INGENIC_ADC_AUX		0
> +#define INGENIC_ADC_BATTERY	1
> +
> +#endif

