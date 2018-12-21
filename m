Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DCAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FE1218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ce3g6XgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbeLUIkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:40:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55246 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388072AbeLUIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:40:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4480620wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tf1B/0sMesJfH+HmA4iAP0Sn3AZ4Gs7mp4+bQjMC6yQ=;
        b=Ce3g6XgAGR/pchMGQ49V8Snubp160RXDplkt9ta1jK2kH2sO+WZcC3B8EN0dCI4WHL
         sJK6r2sbKOs7a4xwnfWv+Gn8tHe5iHbdl2xT4JjUQ0C3Nd7KfjVi5Lh6WjfteGRturVK
         Y2QtwKsM22jiPp80nTFNc5Jo1HoQLteL1Uzck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tf1B/0sMesJfH+HmA4iAP0Sn3AZ4Gs7mp4+bQjMC6yQ=;
        b=LDBb9hOmJtBDocGKgF0Qfw1zzHFd39N724mHx0VHwBmDUq2wx8dfiGgIWQkjcBm/c9
         92UvMRmUMw0mQRYgdA1jHhxx2a0RVpW5AVy5a1MyBLbT3i7A3+maePFhKixbWJV7PxdI
         q0cY9DK2fmQlDEXRuiPrcsbjJHFOzoi9rQc5qI1T1Wy61onngXicH7xzfb5WLfrO+5Fn
         SXfixPr6+YR/QgOlWxS+lMtgqOtoGTHHDRYHnmP6fjCstrMTWVdjRS2H6ObucuGjuBZF
         a+iRQGKLYco6j/zVL4tTsnEG+h3qsjuEC5H8xyfRGS6PiYdd3b2GSCrawFJ4FBZBuCAf
         DICQ==
X-Gm-Message-State: AJcUukcqkqyzNgc0izqEuH8YHNOkaapdsq+CbJ7zrer9//uoZS3USmJQ
        4mHwr6IeCEaUjLe/BhrBsxjz5Q==
X-Google-Smtp-Source: AFSGD/U8Jzgwv+Bcm/0I+KzdmlOpTvdbyXBiYapL5R7RxmdAi+gsNj7Q/b2HnmtfHaGIMmmt60IPgg==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr1790293wmd.89.1545381613189;
        Fri, 21 Dec 2018 00:40:13 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id x186sm8881966wmg.41.2018.12.21.00.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:40:12 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:40:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
Message-ID: <20181221084010.GR4497@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <25e67fe9b5397aa5f11bdd7026e4ae6be51dd18b.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25e67fe9b5397aa5f11bdd7026e4ae6be51dd18b.1544512919.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> In the past, there have been words on various lists that if LDO3 is
> disabled in u-boot, but enabled in the DTS, the axp209 driver would
> fail to continue/hang. Several enable/disable patches have been
> issues to devicetree's in both the kernel and u-boot to address
> this issue.
> 
> What really happened however, was that the AXP209 shuts down without
> a notice and without setting an interrupt. This is caused when LDO3
> gets overloaded, for example with large capacitors on the LDO3 output.
> 
> Normally, we would expect that AXP209 would source 200 mA as per
> datasheet and set and trigger an interrupt when being overloaded.
> For some reason however, this does not happen.
> 
> As a work-around, implement software-based 'regulator-soft-start'
> property for AXP209 LDO3 regulator, which is used to first bring up
> the LDO3 to the lowest possible voltage and then enable the LDO.
> 
> After that, we can set the requested voltage as usual.
> 
> Combining this setting with the regulator-ramp-delay allows LDO3 to
> come up slowly and staggered, potentially reducing overall inrush current.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
>  1 file changed, 3 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
