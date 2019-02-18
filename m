Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C9C10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C66121901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXmgAKPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbfBROUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:20:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52045 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391044AbfBROUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:20:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so5411964wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ClZXXrP3BYB32DX7heYICw4CsezNlo5nX4c0OSIYVrs=;
        b=kXmgAKPSzKBlErTbTVMwRbNVX5C/bVcgD4Ddc/3EUJDlxf70Bljrs/ZTu/t49hqqje
         hyU5qP81E5t9C9u+juruGkNJI7IV6MVL5GigmXKuwqgC3qZfXjRqElUZ5yF4WlCYBjhT
         JaBcDpFthRsAKQVdU9jxYKesXz93pUFjJraXpFxnOizq3ettppOWVf0gXs0uCQkUJ5TM
         vBCrG6XNkXO08k47y67EXgSUG40Ph75TeVxq4eD06H4frl76UtHBb9tj2ytiGkvE4YQc
         ruMCtxcwjWVuPSH9mj1IY951KdG9XyTbtnHWk/LQZ6JJ2YO2zHYZcMvHZwVk3HaX/sOI
         o82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ClZXXrP3BYB32DX7heYICw4CsezNlo5nX4c0OSIYVrs=;
        b=ioN/869VD2utdtPD8JVt25TKvky3euUe9OUZD8yOae6abbxDS6evRlyufivoLjJ9LQ
         Rr0LLyZH3Y1uAFtX6OR0ktRBXLD3G+v66NmC+c5yJcnPsDGAP9mdVdsmEy1nHu6lZk4O
         MoW7QjHNKjA0FAOmnJl7a4lwWEsAnYO1UWCkUs6GlbTJs5vvWses3A6gTFpa5dE1nAng
         g6BwOeOlyVTWHtx8k7kEWT1jjK9EJk2V3L4w+zZAB17Qa6TjEzvh0cl9mqOPpu+Av381
         MvygLqUiQWuoUGyUB7APJL5kC79yHnQWExixIVLhB1DNe1eComgQ5f4MxLVRHg+AFfqF
         niyg==
X-Gm-Message-State: AHQUAuYCP8q62rCes8wqem3q31cFFX60tyTr/MHZ3E/H72WW/N5xk2Nr
        oZ+KV5Svbszcc9RtJImmwVa/lQ==
X-Google-Smtp-Source: AHgI3Ib455TygYVlPC1SJ0oM7R+duaUfW4js4OfK+qogmUfNV65oGh4+/Typu4wLNSWvEwxM/qa/Kg==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr16028078wma.147.1550499609210;
        Mon, 18 Feb 2019 06:20:09 -0800 (PST)
Received: from [192.168.0.41] (148.125.92.92.rev.sfr.net. [92.92.125.148])
        by smtp.googlemail.com with ESMTPSA id e6sm15839091wrt.14.2019.02.18.06.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:20:08 -0800 (PST)
Subject: Re: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header
 for FlexTimer #defines
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-3-patrick.havelange@essensium.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ed4658a-7ef6-91c7-7afa-2f73f038ff95@linaro.org>
Date:   Mon, 18 Feb 2019 15:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218140321.19166-3-patrick.havelange@essensium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 15:03, Patrick Havelange wrote:

Changelog please

> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
>  drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
> index 846d18daf893..e1c34b2f53a5 100644
> --- a/drivers/clocksource/timer-fsl-ftm.c
> +++ b/drivers/clocksource/timer-fsl-ftm.c
> @@ -19,20 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
> +#include <linux/fsl/ftm.h>
>  
> -#define FTM_SC		0x00
> -#define FTM_SC_CLK_SHIFT	3
> -#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_PS_MASK	0x7
> -#define FTM_SC_TOIE	BIT(6)
> -#define FTM_SC_TOF	BIT(7)
> -
> -#define FTM_CNT		0x04
> -#define FTM_MOD		0x08
> -#define FTM_CNTIN	0x4C
> -
> -#define FTM_PS_MAX	7
> +#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
>  
>  struct ftm_clock_device {
>  	void __iomem *clksrc_base;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

