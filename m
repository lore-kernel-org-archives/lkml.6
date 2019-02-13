Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA621222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeJ1BUR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbfBMHZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:25:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfBMHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:25:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so1289224wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o7gp582uZMLQbN6NF7AnrOiJyNbHjk3ey4j2nlxVOlE=;
        b=YeJ1BUR+bCbuf0g3DygC8SPqbtfqKcNmVH/eJrtChdxU5z/o/SZCvcKMvjs3y8hKT4
         DiKoTNs0u1yG44RR6faJ3VQdYEFvopiJ6Jy+qQhEba63cRwmjYOQeZGskli5eI+BEXzo
         S9yrSUCWqhLX8NBYPgIwBWZnpMGfLEedJZ4VUCVCt41f5WVxNadU6zYC8RnJvQf0zZsY
         IMaUebzLiBAizqDvP7yPV394u3hePIeNjI5Le9rFbgn2iRviDtXT1e0DHhI+1ZPXHejw
         /yOq/xVqUs6pjOb+Sf2IujJLOoaRi0bSosHCjgKC72eErdMEEFjmvOFBzkI41IcWF4Le
         +dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o7gp582uZMLQbN6NF7AnrOiJyNbHjk3ey4j2nlxVOlE=;
        b=lBYVU0xUIP95PSmDMidsdWKIt8kQdInoGWEvW2AW/vnRNELM89GMkDZZFYO+eETQIY
         KOQ24lOzyaxPtIVu+5F3njvBqa4FotoOgGS9qaRo0+5EvUg6b1/VQm0dQh1gtJrtu9OA
         yUBhMJjOikqG746Fds5+SpN1cstHB3FInWJR+IrKGUsgfD4Fg4sLDrZBmTB6Zbn3BMKP
         CzbV5GMsR7J5c7/JgSUnkLk2ML6tnILTKOJd/h9KDPmGXMrUkQlCdhPQqTXZ5nr2dJsk
         BG0OgYJ+PtrkBMiohn3XO+mwE2D7jaqQ730j/+kMxsIGXPq/HMNkWBrP+GvZrbJ71BHW
         MnVg==
X-Gm-Message-State: AHQUAuYEc5otG0f4K20o5N/FrFGR8t8YQ0HA+2cPGLC1Bhb5XxOcdAZI
        50iCV4jbUg56AnjEpkJYCzLUPw==
X-Google-Smtp-Source: AHgI3IYYWHyfdOlRGo/NNJrs5XehosDY5ZJ+GxAyOTkHhiFV2Ho6z44IHBXsUwWu5JsuoT+jX3wsBw==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr5628008wrx.74.1550042700585;
        Tue, 12 Feb 2019 23:25:00 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id v1sm31335983wrw.90.2019.02.12.23.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:24:59 -0800 (PST)
Date:   Wed, 13 Feb 2019 07:24:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2] mfd: sec: Add support for the RTC on S2MPA01
Message-ID: <20190213072458.GB1863@dell>
References: <20190212214639.9613-1-stuart.menefy@mathembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212214639.9613-1-stuart.menefy@mathembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Stuart,

It's been a while.  I hope all is well with you.

> The RTC portion of the S2MPA01 appears to have the same
> register layout as the S2MPS14.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/mfd/sec-core.c | 2 ++
>  drivers/mfd/sec-irq.c  | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index e0835c9df7a1..08621ef5d822 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -103,6 +103,8 @@ static const struct mfd_cell s2mps15_devs[] = {
>  static const struct mfd_cell s2mpa01_devs[] = {
>  	{
>  		.name = "s2mpa01-pmic",
> +	}, {
> +		.name = "s2mps14-rtc",
>  	},
>  };

Ideally one line entries should be on one line (see: s2mps13_devs).

Would you like to take a couple of minutes to make those changes
file-wide and rework this patch on top of it please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
