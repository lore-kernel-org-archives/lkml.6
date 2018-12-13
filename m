Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860DC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3C920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544715491;
	bh=tEUtgrgbBbkMhRpyP02t+bNZtvpM2zX8nctqBRGCaDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pUl5ZgsHuy+8uvidIGByu+o0knnOpuECx30d6qKsC4fbSZDzJPnZM4GwQQ+FCrUaj
	 q19f2S/H3EkKulX/caoG/hQNc9AZn++zMDZ9acKH/XFXM0NSPn8/NX+fUUUBUIYEn7
	 ZtivdVI57K+JmQyg/ekwlrBpuzG/a1jzbKIHwz3o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3C920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeLMPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbeLMPiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:38:10 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C2820870;
        Thu, 13 Dec 2018 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544715489;
        bh=tEUtgrgbBbkMhRpyP02t+bNZtvpM2zX8nctqBRGCaDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0wzrcN9w7gHWzgoMsu7hpqH+tfTz36CkSQtO6Ww5sFzGIrj747iL1tLgLYJzd1cby
         zkE4xC/lGMWlnmesqPzWS78HmbCzCMG5L1MRUvInWKMUE3K1SSqdOzqduGgJdlIALv
         5nmchj8Htr3/UhrGPDn+kV1hvq1hVKgOiHQOEDZw=
Received: by mail-qk1-f171.google.com with SMTP id q1so1326736qkf.13;
        Thu, 13 Dec 2018 07:38:09 -0800 (PST)
X-Gm-Message-State: AA+aEWb8FXA2BLNKdImTPtL5hHsyYWxCAZBv00T1jasHJioccDVno9BE
        ePADocls6nn9344xY+6yw1+UJo45YAvx8p3uxA==
X-Google-Smtp-Source: AFSGD/W5LexxU/3vb56Ir91vqA7EDPRWGo+vjaKyNB+FbgO5CR1fDZ+mSGPxljWM0uZY6R9LBpOxpTtgE89VeH3+Ghk=
X-Received: by 2002:a37:a483:: with SMTP id n125mr1208572qke.184.1544715488926;
 Thu, 13 Dec 2018 07:38:08 -0800 (PST)
MIME-Version: 1.0
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com> <1544705183-13288-2-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1544705183-13288-2-git-send-email-stefan.popa@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Dec 2018 09:37:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMF=uf5Dcrfz_57KwYK9XDtJamGtf23JiUMDH-F6xa7w@mail.gmail.com>
Message-ID: <CAL_JsqLMF=uf5Dcrfz_57KwYK9XDtJamGtf23JiUMDH-F6xa7w@mail.gmail.com>
Subject: Re: [PATCH 01/11] staging: iio: adc: ad7606: Simplify the Kconfing menu
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Stefan Popa <stefan.popa@analog.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 8:18 AM Stefan Popa <stefan.popa@analog.com> wrote:
>
> There is no point in having three menu entries that can be selected
> individually. Instead, the SPI and parallel interfaces should select
> AD7606.
>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/staging/iio/adc/Kconfig | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index fc23059..af1bad8 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -4,35 +4,29 @@
>  menu "Analog to digital converters"
>
>  config AD7606
> -       tristate "Analog Devices AD7606 ADC driver"
> +       tristate
>         depends on GPIOLIB || COMPILE_TEST
>         depends on HAS_IOMEM
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
> -       help
> -         Say yes here to build support for Analog Devices:
> -         ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> -
> -         To compile this driver as a module, choose M here: the
> -         module will be called ad7606.
>
>  config AD7606_IFACE_PARALLEL
> -       tristate "parallel interface support"
> -       depends on AD7606
> +       tristate "Analog Devices AD7606 ADC driver with parallel interface support"
> +       select AD7606

I don't think this works because the depends on for AD7606 may not be
satisfied. Moving the HAS_IOMEM here would help and either drop
GPIOLIB or move that too.

Rob
