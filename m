Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B740C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2068920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbeGXUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:49:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43015 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGXUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:49:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so5112665edt.10;
        Tue, 24 Jul 2018 12:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLoASFOtpKimNUhvJQIklnjcmsdzzhCenPa448uNxgo=;
        b=k2hRbv8e6eOejDXW+ONGoXHI+RZD95Zki1T+mKgyYJDZea7HN4I/Oim88cYYJxF3Dl
         lV2NnSdXWW+wnxTth6ZOZ7S2aOTyu61IucslUDVhwMvZfta/FKCF+Qh4cmkQau0gC5x0
         MkXr0wm9m2E8A5QA3Vd5HHvb6QS/9+DZ39UsXs1o+9dvALVkEuKYalmW1KaN4r+H5Zrs
         XrNeQkXSilvzw+fvODQmI+Bvos0iJDMH9G9fIcSVgtb8X9yaTmYgHfWrZO+JLmdK5nVt
         8b7vAVkOLv6fOm06n9t+Ir4DK2GZsnSouAiUaqF5GuwijtDiAFMEL1r8WqWRZ9tA4C+V
         uVdg==
X-Gm-Message-State: AOUpUlGC/XQqQZPLhPDkpvnoq9ARUk/SzBRfeZn+Z3/8QL4nOo9anKp3
        GmgUzJe+Atx/z+85wC8pJto=
X-Google-Smtp-Source: AAOMgpdI0Ki6G5ePIp0mujLjxbjVk4bqBCyEj2Gfg4RiV3tMlh0ExoGBo16wCxzSn2cUypR3UpoQVg==
X-Received: by 2002:a50:b86f:: with SMTP id k44-v6mr19122924ede.310.1532461307224;
        Tue, 24 Jul 2018 12:41:47 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id m20-v6sm6206285edc.96.2018.07.24.12.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:41:46 -0700 (PDT)
Date:   Tue, 24 Jul 2018 21:41:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [RFT v2 06/10] pinctrl: samsung: Write external wakeup interrupt
 mask
Message-ID: <20180724194142.22nav7lfpouzd57o@kozik-lap>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723175302.22535-7-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:52:58PM +0200, Krzysztof Kozlowski wrote:
> The pinctrl driver defines an IRQ chip which handles external wakeup
> interrupts, therefore from logical point of view, it is the owner of
> external interrupt mask.  The register controlling the mask belongs to
> Power Management Unit address space so it has to be accessed with PMU
> syscon regmap handle.
> 
> This mask should be written to hardware during system suspend.  Till now
> ARMv7 machine code was responsible for this which created a dependency
> between pin controller driver and arch/arm/mach code.
> 
> Try to rework this dependency so the pinctrl driver will write external
> wakeup interrupt mask during late suspend.
> 
> Impact on ARMv7 designs (S5Pv210 and Exynos)
> ============================================
> This duplicates setting mask with existing machine code
> arch/arm/mach-exynos/suspend.c and arch/arm/mach-s5pv210/pm.c but it is
> not a problem - the wakeup mask register will be written twice.  The
> machine code will be cleaned up later.
> 
> The difference between implementation here and ARMv7 machine code
> (arch/arm/mach-*) is the time of writing the mask:
> 1. The machine code is writing the mask quite late during system suspend
>    path, after offlining secondary CPUs and just before doing actual
>    suspend.
> 2. The implementation in pinctrl driver uses late suspend ops, therefore it
>    will write the mask much earlier.  Hopefully late enough, after all
>    drivers will enable or disable its interrupt wakeup
>    (enable_irq_wake() etc).
> 
> Impact on ARMv8 designs (Exynos5433 and Exynos7)
> ================================================
> The Suspend to RAM was not supported and external wakeup interrupt mask
> was not written to HW.  This change brings us one step closer to
> supporting Suspend to RAM.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c    | 50 ++++++++++++++++++++++++++++-
>  drivers/pinctrl/samsung/pinctrl-samsung.h   |  3 ++
>  include/linux/soc/samsung/exynos-regs-pmu.h |  2 ++
>  3 files changed, 54 insertions(+), 1 deletion(-)

Thanks, applied all previous, up to this one.

Best regards,
Krzysztof

