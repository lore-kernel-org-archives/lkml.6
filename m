Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C9BC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3215F20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiDk30Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3215F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeKTXVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbeKTXVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:21:12 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF1F20831;
        Tue, 20 Nov 2018 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542718333;
        bh=xDGpHmcnpZsQSBscSpJ6ST8CfNE4Mqhbeolo+pH8Crg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LiDk30Ls27Y9RXCSy48UXXWNv5b4vnNpNrejjlNT/mjBR29YpsU4iFtusKVaWczF8
         WT3Yt3dEapWDlmkn/o7vZCoHKbbFfK/6cGJBypMTTIH07asgD6gttMepZTO81ATLYi
         f4mLEs3ny0YN93F0QyL/0pm5IlFL+1itXGTEai3k=
Received: by mail-lj1-f173.google.com with SMTP id e5-v6so1529367lja.4;
        Tue, 20 Nov 2018 04:52:12 -0800 (PST)
X-Gm-Message-State: AGRZ1gI/2rMoD6TuLlx7ah6BMdCNy1eEeboKD7jb9UR0Mipr6zJ7U/w6
        bCqGp0oAJ/nfSx4Vg81E2FWW8Lo3Iys0lZDNGy8=
X-Google-Smtp-Source: AFSGD/UaVU/Q7rBSF27jn6IN2/pQ5i22suuHzSyxdIc4MZv1/B1ADcAngDoPG7UKtSF08M02zIWHXpMcomHm41EC0MY=
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr972978ljg.138.1542718330935;
 Tue, 20 Nov 2018 04:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181120123855eucas1p1a969fba923e9243e576cae0b632504af@eucas1p1.samsung.com>
 <20181120123844.3003-1-m.szyprowski@samsung.com>
In-Reply-To: <20181120123844.3003-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 20 Nov 2018 13:51:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc7HA58+zxny3fWJr7mVMqOx9xsKck+-7EHLsfymhfjcQ@mail.gmail.com>
Message-ID: <CAJKOXPc7HA58+zxny3fWJr7mVMqOx9xsKck+-7EHLsfymhfjcQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: s2mps11: Fix GPIO descriptor initialization
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, sbkim73@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 13:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> GPIO descriptor array must be zero initialized to ensure that core will
> properly handle also the case when no external GPIO pin is defined.
>
> Fixes: 1c984942f0a4 ("regulator: s2mps11: Pass descriptor instead of GPIO number")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This fixes broken eMMC boot on Artik, Rinato and Odroid XU3/XU4/HC1
> boards.

I missed that on my review. Now it looks fine, thanks for fixing it!
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> ---
>  drivers/regulator/s2mps11.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
> index 6fec45897194..63e66f485cc0 100644
> --- a/drivers/regulator/s2mps11.c
> +++ b/drivers/regulator/s2mps11.c
> @@ -1134,9 +1134,8 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       s2mps11->ext_control_gpiod = devm_kmalloc_array(&pdev->dev,
> -                       rdev_num, sizeof(*s2mps11->ext_control_gpiod),
> -                       GFP_KERNEL);
> +       s2mps11->ext_control_gpiod = devm_kcalloc(&pdev->dev, rdev_num,
> +                              sizeof(*s2mps11->ext_control_gpiod), GFP_KERNEL);
>         if (!s2mps11->ext_control_gpiod)
>                 return -ENOMEM;
>
> --
> 2.17.1
>
