Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CA620869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CA620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeKSAf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:35:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51921 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKSAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:35:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so2809475wmc.1;
        Sun, 18 Nov 2018 06:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5bRVe+1GEIGf7nDBCtz6axaOwURXCLzOsmmDEdvyxCU=;
        b=IftUGWEdPpRwBMmOvFR+Zh6S8sa44HpsH3IBU2IIE/fWbKrZRE+sSTMUeYneA/DXcl
         PsKADmwUyKYZK08qtYF/pBIqxBcCR59JDc4rphaaM/j7DGAd6A4zMGi/m1TA2Nofx4Ea
         ydJTfD5ALs0apF+KuBE/LRm8xQdhlg3t7MRSmtt0LU8PyaZvPSLarUOKTA6Ehp4AJK9O
         W6LTaPtViDGV4TyGZ5Zys8V/aMBwfboVY52ejZezVUPkQrTUHW4pgVAn+pfJyIrZ1Ysq
         JWOvoO8renBthq9QtHcxvrK86jQophayAwYH6chLHDP52NoK0/fL0vRVhSR2gip5IgJh
         RuuA==
X-Gm-Message-State: AGRZ1gIpjWdNp+x2MnBP1viGpzLMJEygnt+kjUcehHR/9s6+5l8VAkao
        1NK8hTerjXDFEyz0BifAWck=
X-Google-Smtp-Source: AJdET5euTx/e1jYGSbSdLonHg9z8Vjut6F4KLqaa7kx3fK77INfiYgDVpoJTPu/iAyOY/Ws+/GAGzQ==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr4147459wma.57.1542550498572;
        Sun, 18 Nov 2018 06:14:58 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id m65sm4566376wmb.4.2018.11.18.06.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 06:14:57 -0800 (PST)
Date:   Sun, 18 Nov 2018 15:14:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ARM: dts: exynos: Add all CPUs in cooling maps
Message-ID: <20181118141455.GA11419@kozik-lap>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
 <24d8433f544046eda4d21e8c7133e3bab770b615.1542362000.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24d8433f544046eda4d21e8c7133e3bab770b615.1542362000.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 03:31:10PM +0530, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos3250-artik5.dtsi      |   6 +-
>  arch/arm/boot/dts/exynos3250-monk.dts         |   6 +-
>  arch/arm/boot/dts/exynos3250-rinato.dts       |   6 +-
>  arch/arm/boot/dts/exynos4210-trats.dts        |   4 +-
>  arch/arm/boot/dts/exynos4210.dtsi             |   2 +-
>  .../boot/dts/exynos4412-itop-scp-core.dtsi    |   8 +-
>  arch/arm/boot/dts/exynos4412-midas.dtsi       |   8 +-
>  .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
>  arch/arm/boot/dts/exynos4412-odroidu3.dts     |  17 ++-
>  arch/arm/boot/dts/exynos4412.dtsi             |   6 +-
>  arch/arm/boot/dts/exynos5250.dtsi             |   7 +-
>  arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 106 +++++++++++-------
>  .../boot/dts/exynos5422-odroidxu3-common.dtsi | 106 +++++++++++-------

Thanks, applied.

Best regards,
Krzysztof

