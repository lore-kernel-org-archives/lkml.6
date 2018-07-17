Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B50ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D46620C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9BIC5Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D46620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeGQM4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeGQM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:56:52 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAF821475;
        Tue, 17 Jul 2018 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531830267;
        bh=qcgKRUTRMpob4NE2bZpCv7wds/SX8FRk7qgV6LcpriU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=i9BIC5UawoxNTAofWsHVRTXwXAjQfaKKKTSaI7YWjHB8hOXDdLu2xMXjMMxw/0eTc
         Bd8mNBKnx3vWnkzLDVR/gcLG32QpDi70QG7me/KxAMmi8Pgm5Qsv5zIMUuiTDmpjvI
         bOv6pMiTUaL1ADdJVNeY1jzoiGca94+oNllvesh0=
Received: by mail-wm0-f42.google.com with SMTP id s13-v6so12430824wmc.1;
        Tue, 17 Jul 2018 05:24:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlEH2qxEUizL08w1mhgoSCNq3hyyLqpw4x3inSDE1mxD21UYcfRz
        4h/GnpGFRcPzUHIDZ5GwG0mAHX21zJ5BlMkZLa0=
X-Google-Smtp-Source: AAOMgpdd0ZN9O87G7GEnp5NEwdsWx3R1gC2rDGkolcjUiq3VYWJ12fi/rwACGOILaQdqF11Z0IwggUqpGYtXVqwWoHA=
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr1187212wmb.118.1531830265148;
 Tue, 17 Jul 2018 05:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:24:24
 -0700 (PDT)
In-Reply-To: <1531822342-4293-2-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <1531822342-4293-2-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 14:24:24 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
Message-ID: <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: exynos: cleanup of clk err check for exynos_tmu_work
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
> cleanup err check in exynos_tmu_work as clk internal
> framework will perform if clk is enable/disable
> so drop the double check of IS_ERR and other such references.

I do not understand the statement. Clock framework will perform if clk
is enable/disable? How clock can be "enable" or "disable"? You mean
gate clock? you mean clock pointer is an ERR pointer?

> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 0164c9e..2dbde97 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -300,8 +300,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>
>         mutex_lock(&data->lock);
>         clk_enable(data->clk);
> -       if (!IS_ERR(data->clk_sec))
> -               clk_enable(data->clk_sec);
> +       clk_enable(data->clk_sec);
>
>         status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>         if (!status) {
> @@ -334,8 +333,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  err:
>         clk_disable(data->clk);
>         mutex_unlock(&data->lock);
> -       if (!IS_ERR(data->clk_sec))
> -               clk_disable(data->clk_sec);
> +       clk_disable(data->clk_sec);
>  out:
>         return ret;
>  }
> @@ -789,19 +787,16 @@ static void exynos_tmu_work(struct work_struct *work)
>         struct exynos_tmu_data *data = container_of(work,
>                         struct exynos_tmu_data, irq_work);
>
> -       if (!IS_ERR(data->clk_sec))
> -               clk_enable(data->clk_sec);
> -       if (!IS_ERR(data->clk_sec))
> -               clk_disable(data->clk_sec);
> -
>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>
>         mutex_lock(&data->lock);
>         clk_enable(data->clk);
> +       clk_enable(data->clk_sec);

You are changing here the logic completely. Before the "enable" was
followed immediately by "disable". Now you are moving disable
somewhere else... All this looks suspicious...

Best regards,
Krzysztof

>
>         /* TODO: take action based on particular interrupt */
>         data->tmu_clear_irqs(data);
>
> +       clk_disable(data->clk_sec);
>         clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>         enable_irq(data->irq);
> @@ -1134,8 +1129,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  err_sclk:
>         clk_disable_unprepare(data->sclk);
>  err_clk_sec:
> -       if (!IS_ERR(data->clk_sec))
> -               clk_disable_unprepare(data->clk_sec);
> +       clk_disable_unprepare(data->clk_sec);
>  err_clk:
>         clk_disable_unprepare(data->clk);
>  err_sensor:
> @@ -1155,8 +1149,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>
>         clk_disable_unprepare(data->sclk);
>         clk_disable_unprepare(data->clk);
> -       if (!IS_ERR(data->clk_sec))
> -               clk_disable_unprepare(data->clk_sec);
> +       clk_disable_unprepare(data->clk_sec);
>
>         if (!IS_ERR(data->regulator))
>                 regulator_disable(data->regulator);
> --
> 2.7.4
>
