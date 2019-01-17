Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AB420851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGR5AVkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfAQII0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:08:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39553 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfAQII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:08:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so9889797wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Rj0Etm6yPGpLOQXk5vy8PRhUX5pe6H/rEWizDUGw0Zs=;
        b=kGR5AVkVFeWMIpTj55yqEc3uUjyD3fxth41Fa5j7f4uRTZeFVPDCASbtlsmCTqQ3ij
         peSmjmYGgZ1sy+KRBGAsjAmiyCZfS72nrF23B3oJ4LMaK56SPTrhZMDia9cBnUsR3CdS
         ilJGrK+v+9fAVRMbKpDICqZn5hslPo8LFqlnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Rj0Etm6yPGpLOQXk5vy8PRhUX5pe6H/rEWizDUGw0Zs=;
        b=InIhXfI27ryxoGFnAaFMdQFWJLTBaeFwHYIMg/uOeF7J3bQgcf6H9Ew8uL9C+CRNV7
         FGjFBMYExM9dlLGSmIV2RXZD0Q9ZvTu0G5eycjQVquA7XLhdNstYxuvmgHZqIe2/EnuS
         RJEFj/ldHGlIlj3qHGdisgeaAZzy73lQ1uq4/Wnwyx4U95qtmZ0LwoCOeiRetvGs/cDg
         Xiib8Fy8bmpTWot6DfdDvfZjsTyqGYUHXGwrt7k/S2ryDhaTk9O/dMtGb54aCon8CsKO
         sqmT3Pyet9OGaCFgTl/3Zw1NDLirQAq2OnuE1BCY96c5iLs3m5Zc5Eg17p8lQgiOWR4v
         5A3A==
X-Gm-Message-State: AJcUukdK+SnfWnn4U20BvEGd0pFtJ/STBKR0iP45SitVAQ3L50WuTFkD
        dOZd5Uhb6DZapIlR6ygR+RbJHA==
X-Google-Smtp-Source: ALg8bN4xHdujMDInhrY/LRtVhMVpJPBsKoHUrE109c3xQO02Ut2eWByEHGjE3RGSO+NJ5kPdnSGKug==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr10695004wrq.260.1547712504147;
        Thu, 17 Jan 2019 00:08:24 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id k3sm116381264wrm.7.2019.01.17.00.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:08:23 -0800 (PST)
Date:   Thu, 17 Jan 2019 08:08:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20190117080822.GJ23399@dell>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Christian Hohnstaedt wrote:

> These options apply to all regulators in this chip.
> 
> ti,strict-supply-voltage-supervision:
>   Set STRICT flag in CONFIG1
> ti,under-voltage-limit-microvolt:
>   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> ti,under-voltage-hyst-microvolt:
>   Select 200mV or 400mV UVLOHYS in CONFIG2
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Tested-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/tps65218.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65218.h |  4 ++
>  2 files changed, 93 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
