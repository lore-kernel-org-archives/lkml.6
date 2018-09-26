Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA33821533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA33821533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeI0BV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:21:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40884 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeI0BV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:21:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so2858350edd.7;
        Wed, 26 Sep 2018 12:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kl+IfQTF+jKtGGDnFlZcSWGEjHHieSRA97SPhcaNsc8=;
        b=iBwkePrl2Hqv15D9bGS6Gw8R/IcnutsN6ybV3qqDwseBBcxTuaG7HtF+L2cbb42VjU
         ErvbgD9UUWqySWChcv5k1wOzf/tPpo/7pERLH1jtOft2ZNoqMr84+FThP8l5a+6nKecX
         Yte0gBD/5IfVtTPvbv/I1yIWxk+l+2x8yeoxIdxGgsYFGZwhSM/0pZy25o1j0cOBnafe
         RkxhXWFP8Ki5gxVxH+bpU7pB1V3f6s8WieYByuHAYoww+e2DTDZ+nnGfXV9/jV3NC0dq
         cXE8makF7TMfvC07rrCybmvvMY99WutXD7POALqJUzuIbcPMPr7wRX8sjz+UHtJmM0YP
         eONw==
X-Gm-Message-State: ABuFfog9IOA3Zi/Kbk007MuIVQmJBTUcThdtq2bNp/y+H2n3kvxCHZo3
        4T1YJ1PR35DEvPYm1h3ty0s=
X-Google-Smtp-Source: ACcGV631rPganaD26/cAnpIL+AR0i5mWN4gNPhRMhESP/wzkLpQ6i3HApXlp9Jdu6C0pYqUZinxAug==
X-Received: by 2002:a50:c299:: with SMTP id o25-v6mr1906226edf.188.1537988853463;
        Wed, 26 Sep 2018 12:07:33 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id s41-v6sm86611edd.61.2018.09.26.12.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:07:32 -0700 (PDT)
Date:   Wed, 26 Sep 2018 21:07:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv4 0/6] Add support for UHS-I on Exynos5422 odroid boards
Message-ID: <20180926190730.GB6461@kozik-lap>
References: <20180922075238.884-1-linux.amoon@gmail.com>
 <20180922075238.884-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180922075238.884-2-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 07:52:32AM +0000, Anand Moon wrote:
> This is series v4 since my previous patches were incomplete with driver
> changes missing.
> 
> v4 changes.
> squash cd-gpios and wp-gpio changes into single patch.
> change the subject prefix to "ARM: dts: exynos:"
> 
> These changes add UHS-I tuning for dw_mmc-exynos driver.
> 
> Rebased on Krzysztof branch next/dt
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git 
> 

Except the one about CD and WP pins (where I replied), they look ok. It
would be nice if you get tested-by tags for them.

Best regards,
Krzysztof

> Anand Moon (6):
>   ARM: dts: exynos: Added UHS-I bus speed support
>   ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
>   ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
>   ARM: dts: exynos: Add CD and WP pins to Odroid XU3/XU4 SD card
>   ARM: dts: exynos: update maximum frequency for emmc to 200MHz
>   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
> 
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 10 ++++++++--
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 
