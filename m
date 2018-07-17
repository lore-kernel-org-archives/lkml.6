Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B46520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSrtmiqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B46520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeGQNAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbeGQNAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:00:37 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE5021470;
        Tue, 17 Jul 2018 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531830491;
        bh=SMTmtmaZDXjs7VA9RSDWfoAg6up0p+yoME3FOuqVAXg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YSrtmiqCAnjqANaFTxIohhxJ6qWffa4etCGGMKvOj8/izsp9loj+NDFo/JTO/hn8h
         l/UTpybupErkWTEfG+H83a7rDJ1LdAGvAdxMlcmc9HuTAPwd/sKPzoEo7mdO54Cqv/
         FAhVvD/5dDPT897Mh/0T3pqDLh37Lux/FOB5ldTQ=
Received: by mail-wr1-f45.google.com with SMTP id c13-v6so1091803wrt.1;
        Tue, 17 Jul 2018 05:28:11 -0700 (PDT)
X-Gm-Message-State: AOUpUlHC/2mxI4/PKTeEMbA2kWP71YNLUfnCeYeD32aaFgt7A6Pv3Wql
        WrN8tg1VReyBZVzwPJ00KU5r/iNQZxK8beEHwm8=
X-Google-Smtp-Source: AAOMgpck+9Qm1j81Hg5efyGCKA3IBeNpz98KMdUoTnQrHiDPjkQUuueYxBvSTTEqqzxqLqXqf4RehZuwDJguZIvH7Y4=
X-Received: by 2002:adf:81a3:: with SMTP id 32-v6mr1334813wra.9.1531830490049;
 Tue, 17 Jul 2018 05:28:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:28:09
 -0700 (PDT)
In-Reply-To: <1531822342-4293-4-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <1531822342-4293-4-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 14:28:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
Message-ID: <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for exynos5422
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
> e-fuse range min~max range is 16~76. if e-fuse value is out of

s/e-fuse/Fuse/
s/if/If/

Can you share the sources confirming that fuse values are between 16 and 76?

Best regards,
Krzysztof

> this range, then thermal sensor may not sense thermal data properly.
>
> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 4a2733c..6481d91 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -940,11 +940,13 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>                 data->reference_voltage = 16;
>                 data->efuse_value = 55;
>                 if (data->soc != SOC_ARCH_EXYNOS5420 &&
> -                   data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
> +                   data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO) {
> +                       data->min_efuse_value = 16;
> +                       data->max_efuse_value = 76;
> +               } else {
>                         data->min_efuse_value = 40;
> -               else
> -                       data->min_efuse_value = 0;
> -               data->max_efuse_value = 100;
> +                       data->max_efuse_value = 100;
> +               }
>                 break;
>         case SOC_ARCH_EXYNOS5433:
>                 data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
> --
> 2.7.4
>
