Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E39AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588B216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Um4rGpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C588B216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeI1USN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeI1USN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:18:13 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DDE216E3;
        Fri, 28 Sep 2018 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538142859;
        bh=5gsKBw+fLIXhel3JAu6Fy2iJ0S4F6Cn8zIzl9b0eF+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Um4rGpRmFA2DuQIDQ9WNDuoKwSLfJdON3YIq9v9jG94n6In74U3FbdF4mLE6NAYF
         fD5I15TFkYcLpozeJ4QODKFruy8xwQGpvETFLeJH41gQteXHnU1JJnYlz/6Oc+OGZx
         gwz8oKl8bcX4HY4DVZSH27suvZTPSpnZ8ZPEQWI0=
Received: by mail-wr1-f54.google.com with SMTP id j15-v6so6486490wrt.8;
        Fri, 28 Sep 2018 06:54:19 -0700 (PDT)
X-Gm-Message-State: ABuFfoheBC7WOy2GLNHtI/RfBMtph+W2cVxD9CdE8omYW7zCFbgEN5rL
        GENYZvHzF6yGfdqIUXbDpMdMmD1hm258aU/6ru0=
X-Google-Smtp-Source: ACcGV62s+ji4zndvJobRLEdFrjOJunLKEep9pMvpv0aSlgjWQi2zHfNlFA9qTSGy1sfRJRLvmxAjBup6gZ5i92PBPN8=
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr4199831wru.44.1538142857732;
 Fri, 28 Sep 2018 06:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
 <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
In-Reply-To: <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 28 Sep 2018 15:54:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
Message-ID: <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
Subject: Re: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
To:     =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 at 15:37, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> config option) is not working properly (debug messages are not
> displayed after resume) on Exynos platforms because GPIOs restore
> code is not implemented.

AFAIR, it worked properly for the suspend part showing more logs.
Unless it changed, the feature looks still useful.

Best regards,
Krzysztof

>
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/plat-samsung/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: b/arch/arm/plat-samsung/Kconfig
> ===================================================================
> --- a/arch/arm/plat-samsung/Kconfig     2018-09-28 15:20:06.041911426 +0200
> +++ b/arch/arm/plat-samsung/Kconfig     2018-09-28 15:20:06.037911426 +0200
> @@ -238,7 +238,8 @@ comment "Power management"
>
>  config SAMSUNG_PM_DEBUG
>         bool "Samsung PM Suspend debug"
> -       depends on PM && DEBUG_KERNEL
> +       depends on DEBUG_KERNEL
> +       depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
>         depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
>         help
>           Say Y here if you want verbose debugging from the PM Suspend and
>
