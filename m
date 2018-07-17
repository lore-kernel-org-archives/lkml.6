Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C90ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3E520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="frM9XBPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3E520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGQM5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbeGQM5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:57:35 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C38921470;
        Tue, 17 Jul 2018 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531830309;
        bh=t2+W6BtxwL0+DGOOS3R8F4GybkQXYq66lmVabQw56ZU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=frM9XBPgp5xzjyu0XFwd/V1MiaIKnP26AEpGa7HKirnREpG3h8FvC4walPZ+oDoU1
         Mtbe8Pn/+53mbe7GsK50aXHFx606nLC8tIzK4FSmtxDfjzynhN1YD9Uky0T5Bau+jl
         cF8N/30I2k7DnxHJyUa7nEWHpigbY0gvFMkMYvwM=
Received: by mail-wr1-f41.google.com with SMTP id q10-v6so1072285wrd.4;
        Tue, 17 Jul 2018 05:25:09 -0700 (PDT)
X-Gm-Message-State: AOUpUlFxTq5HEvn2cndzPR3Ck6fRRoQKbP0xDLD356mLA6LkBMW0DK1a
        Vr3YkeBjIMxUzgHm+BD8EzNkl3cnMoTNJ3woE08=
X-Google-Smtp-Source: AAOMgpcwotAiogon41n4l+awsBJta9VLAU7mVae/O6FPUexcjH802sidAVn46Ru7XLPYT9vJ1IKiqe8J1AM3AdzGMG0=
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr1296002wrr.227.1531830308094;
 Tue, 17 Jul 2018 05:25:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:25:07
 -0700 (PDT)
In-Reply-To: <1531822342-4293-3-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <1531822342-4293-3-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 14:25:07 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
Message-ID: <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
Subject: Re: [PATCH 3/5] thermal: exynos: increase the number of trips for exynos542x
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
> increase the number of trips to support more polling modes,
> changes help supress following warning.
>
> [    4.231731] thermal thermal_zone0: failed to read out thermal zone (-22)
> [    4.237190] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
> [    4.244661] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
> [    4.254821] thermal thermal_zone1: failed to read out thermal zone (-22)
> [    4.260370] exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
> [    4.267631] exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
> [    4.277551] thermal thermal_zone2: failed to read out thermal zone (-22)
> [    4.283090] exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
> [    4.290438] exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
> [    4.300280] thermal thermal_zone3: failed to read out thermal zone (-22)
> [    4.305711] exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
> [    4.313171] exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
> [    4.323002] thermal thermal_zone4: failed to read out thermal zone (-22)
>
> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

NAK

Exynos5420/5422/5800 has 4 trip points (understood as in current driver design).

Best regards,
Krzysztof

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 2dbde97..4a2733c 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -935,7 +935,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>                 data->tmu_read = exynos4412_tmu_read;
>                 data->tmu_set_emulation = exynos4412_tmu_set_emulation;
>                 data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
> -               data->ntrip = 4;
> +               data->ntrip = 8;
>                 data->gain = 8;
>                 data->reference_voltage = 16;
>                 data->efuse_value = 55;
> --
> 2.7.4
>
