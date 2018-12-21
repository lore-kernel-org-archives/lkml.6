Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AA9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE14A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmTSB73S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbeLUO4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:56:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39205 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390875AbeLUO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:56:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so5978566wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5GF9f3hUQK5/o8DvydFcD1xQEw+eDaBDGUjVAHZanrc=;
        b=dmTSB73SjTNE/Jy3gWimEDWX6XuHJQRcrr2QrSy8O0d3EVfzJVqUDobZY4qgi3BEBA
         n35BJL+Z7mUJoaUrM9a72anRB1FBPjGwDVLOKvdxW+jHcogHagTdLZbZQYGZxOt/SlPH
         /BYcSxmlrAj7VV+GEgEkeCiCR1Bs8tlcwohCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5GF9f3hUQK5/o8DvydFcD1xQEw+eDaBDGUjVAHZanrc=;
        b=ZvxVu7yPkynRjk24ITjKZyLNRq67rXAJe5pe/P4Nvw2iBCqQWB9rukKKV1fSazVGwn
         iHiWeP9WDszmG07Z7GBXsawvCjGbx58G+n5htB5gcQJdOPCeasd2O+ityKGG4pB0QiXn
         bHlwX80tn6O24Hd52lxstfymsEp85KP1l9FV+xNO7napB1uYpypO1yYXCNJUbRVQbTOK
         w0u90fpiPXbSouHQG4ZU8YEBFt8pMd2opGdUxNtGUIhbPJf5CaTC7SFHp1WB79n4wqKp
         6x2XB7ZNCG3k3/isPOZzHZ4UMMvOTgASn2yudeUy1pqoQbrME0JlzmzClzviaqY9u0z/
         UWgQ==
X-Gm-Message-State: AA+aEWb0QZs20ya16d+/QhxCxOS0OwmRa3Rpp6cCh7d4JAKFCBdgeg69
        kmRR33N9nSJFdxPDGo3ADAj1Rg==
X-Google-Smtp-Source: AFSGD/V5oubnjd2HqvyNMXxinoX01tHoPhcz+3bydjNtGY+TLcZcge5pVYJNN3D0o/AV8RsLa20Tag==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr3250160wmh.124.1545404171268;
        Fri, 21 Dec 2018 06:56:11 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id a12sm14810744wro.18.2018.12.21.06.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:56:10 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:56:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/4] mfd: exynos-lpass: Enable UART module support
Message-ID: <20181221145608.GU13248@dell>
References: <20181221103907.GK13248@dell>
 <CGME20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861@eucas1p1.samsung.com>
 <20181221143228.934-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221143228.934-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018, Marek Szyprowski wrote:

> From: Beomho Seo <beomho.seo@samsung.com>
> 
> This patch enables proper interrupts routing between UART module
> in Exynos Audio SubSystem and the rest of the SoC. This routing is
> completely transparent for UART device and CPU/GIC. UART driver requests
> interrupts from the respective controller and enables/masks/handles it
> by itself via standard methods.
> 
> There are boards (for example TM2), which use UART module in Exynos Audio
> SubStem for communication with BlueTooth chip.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> [mszyprow: rephrased commit message, added UART reset]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changelog
> v2:
> - rephrased and extended commit message
> ---
>  drivers/mfd/exynos-lpass.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
