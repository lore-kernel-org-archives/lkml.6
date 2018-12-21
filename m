Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7425218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwTD5LGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbeLUKjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:39:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33483 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388997AbeLUKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:39:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4725329wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ATiQY0Qc74SrpfxCoDW4+VuycPfFizeqo6onKZP6utI=;
        b=jwTD5LGdinu2OknbYXCQ0L8pwS9BC9y5t7QqO5Hbp7Axf3M31i0Ljs4MaeU7+rljKG
         JhiBhRODTLoG2vHnlzjNtnjO/Q9HIWgGeBRGMwYapvxvPRyCQw3AzJS+amsA5xmKnc1s
         84t/4dOUIov4PF6ZpaLOSPls7TIqBie6JZF+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ATiQY0Qc74SrpfxCoDW4+VuycPfFizeqo6onKZP6utI=;
        b=lmUb13x9YXNZyj9mjyvj+NK/VHmVoOdXN+QVCkhSYlTbFpsLRCvr2WUtJ5ZBs2fjhI
         bV5ievOfNmY6MQhEW3KIy4f1QtcqlRhOgh+AmGqH/ZcgrtdCxtmp9u1CGs7zXTB70RAn
         iqm67IjWNxlTUFgAFCSUEnS6pthCilhcZ8nggLTMCzs15Ya3nJ0uGokT1XuJ0fhu33jf
         1ckP/KfNTwReCIRmfo4tpbyP35n+Av0dZgN75hDIOWY4GckfwGkU7owYTTPIzcYnHxPy
         jq1ZEN9szZqabWwEVc5LejVTR+9ZNkNG3aiC4ZdE42HMh2WkvmvN6Gx7+/gL8H4ASdWr
         FQ1w==
X-Gm-Message-State: AJcUukeDMeQ0s4Q3MXNXYDJjuOZFKW5errHUmIQmjfAW07lmxTcnJtxU
        vzGjLV2D5e2wBUCID0B/eSvdqQ==
X-Google-Smtp-Source: ALg8bN6hh3EmWWY2WL7A/9rCfRtdzk7Kwd5uJPpqCTDTno0GY5fINRDYO7BqjWN6TMUVUidvkkbUYQ==
X-Received: by 2002:adf:b608:: with SMTP id f8mr1951154wre.120.1545388749818;
        Fri, 21 Dec 2018 02:39:09 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id k15sm12026422wru.8.2018.12.21.02.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:39:09 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:39:07 +0000
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
Subject: Re: [PATCH 1/4] mfd: exynos-lpass: Enable UART module support
Message-ID: <20181221103907.GK13248@dell>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1@eucas1p2.samsung.com>
 <20181214113410.22848-2-m.szyprowski@samsung.com>
 <20181221101306.GH13248@dell>
 <7a43948e-17b9-1fd6-6b11-400016a4a28c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a43948e-17b9-1fd6-6b11-400016a4a28c@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018, Marek Szyprowski wrote:

> Hi
> 
> On 2018-12-21 11:13, Lee Jones wrote:
> > On Fri, 14 Dec 2018, Marek Szyprowski wrote:
> >
> >> From: Beomho Seo <beomho.seo@samsung.com>
> >>
> >> This patch enables support for UART module in Exynos Audio SubSystem.
> >> There are boards (for example TM2), which use it for communication with
> >> bluetooth chip.
> > Does it though?  Or does it enable the interrupt and reset something?
> > These calls would probably benefit from some documentation by way of
> > comments.
> 
> It only enables routing interrupts out of LPASS HW module. This is
> completely transparent for the rest of the system (UART and CPU/GIC).
> UART driver will get them via standard ARM/GIC interrupt controller and
> UART driver will enable/mask/handle it by itself via standard methods.

Sounds fine.  But that is not what the commit message says.

> >> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> >> [mszyprow: rephrased commit message, added UART reset]
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> ---
> >>  drivers/mfd/exynos-lpass.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> >> index ca829f85672f..2713de989f05 100644
> >> --- a/drivers/mfd/exynos-lpass.c
> >> +++ b/drivers/mfd/exynos-lpass.c
> >> @@ -82,11 +82,13 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
> >>  		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
> >>  
> >>  	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
> >> -		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
> >> +		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S |
> >> +		     LPASS_INTR_UART);
> >>  
> >>  	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
> >>  	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
> >>  	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
> >> +	exynos_lpass_core_sw_reset(lpass, LPASS_UART_SW_RESET);
> >>  }
> >>  
> >>  static void exynos_lpass_disable(struct exynos_lpass *lpass)
> 
> Best regards

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
