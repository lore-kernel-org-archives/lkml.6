Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC43ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AAE2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0b20FFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AAE2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbeIUQo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389600AbeIUQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:44:28 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5626A2154D;
        Fri, 21 Sep 2018 10:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537527367;
        bh=5j18gfQmCz/s4LK1QsAE62CKnai2fJJ0CNH1V2zEyiA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S0b20FFe3ofdUY4QV65gOrHENnP2u1mbzvOZm+d3exdMyImq/KgJ0jhepRZD4we35
         mNsH27r77EcAwhP82HhW7avlcW+KsCd03Y1Any+k37Ldv3izecoyhxcBU54JLlo7xu
         Fji4cmQeeJvw1xB739c1w+43D7XoAASizAcUGFyI=
Received: by mail-wm1-f48.google.com with SMTP id f21-v6so2575208wmc.5;
        Fri, 21 Sep 2018 03:56:07 -0700 (PDT)
X-Gm-Message-State: APzg51AqI1JwfJvGuBax2BHEccP0A+Mx8r8hwYaoUKI5QGUcgC7qHTSm
        7fSwhiZt+7vTnoqi2zngxQHddEIRUZxO952kij8=
X-Google-Smtp-Source: ACcGV62zBaym18+B5lbLEnUQ58bGcysWkGsThazDwul9AWseb8vrtGd5DCrqMOYii2TBrk9qOTSoJjbp9PQDFhtN5Gg=
X-Received: by 2002:a1c:a60e:: with SMTP id p14-v6mr6692652wme.64.1537527365700;
 Fri, 21 Sep 2018 03:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180920175826.1284-1-linux.amoon@gmail.com>
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 21 Sep 2018 12:55:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
Message-ID: <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
Subject: Re: [PATCHv3 0/7] Add support for UHS-I on Exynos5422 odroid boards
To:     linux.amoon@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 at 19:58, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This is series v3 since my previous patches we incomplete with driver
> changes missing.
>
> These changes add UHS-I tuning for dw_mmc-exynos driver.
> Some new patches are added to enhance the performace.

Patches look like based on some older version of kernel tree (or
current mainline) and probably they will not apply on my tree. The
easiest is to base on top of linux-next or, for DTS patches, on my
next/dt branch.

Best regards,
Krzysztof

>
> Anand Moon (7):
>   ARM: dts: exynos5422: Added UHS-I bus speed support
>   ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid
>     XU3/XU4
>   ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
>   ARM: dts: exynos5422: use cd-gpio method to detect sd-card
>   ARM: dts: exynos5422: use wp-gpio method to detect sd-card
>   ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
>   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
>
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 +++++++-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
