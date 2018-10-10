Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84754C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3910C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmLHMYUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3910C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJJQk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeJJQk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:40:27 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4AD2150D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539163151;
        bh=HyG5azoQDX8JPB7rSiSM9+ipKAwB/nGKef6WreQYce8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YmLHMYUkl84wNk0UwM46bbNnEZQ/V2gb+rabpzJNBWGpBgiZxpsQqbc3eq06iVJ2v
         G64mS6UcX1d9lL8lf7K6zcfsMonOfUG7COHIScTZtI1a4SOEFGA1B2ANG1zb6xQYq5
         1yAA9EblGN7+ODg5lSg8r+PAxcjeec25riSUnqBo=
Received: by mail-wm1-f46.google.com with SMTP id i8-v6so4611408wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:19:10 -0700 (PDT)
X-Gm-Message-State: ABuFfohNkAHz0jt/0JG8ePSd7fcvpCvFzvrMF1zu8v3VEt0ukHii/46s
        oeDrm3P1fhCrbpOJCnmCt/f2MhQw5YEuwoqYKmA=
X-Google-Smtp-Source: ACcGV60rCZ3ovhXqUAkJzUlcOQjjAYL+h5CF3AMkzPBEnTremVJaz6+g/ZRvELolX7qkfH+mWe/XiFW+lMNTCUw2Gh8=
X-Received: by 2002:a1c:9609:: with SMTP id y9-v6mr140249wmd.67.1539163149245;
 Wed, 10 Oct 2018 02:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
 <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
In-Reply-To: <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Oct 2018 11:18:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
Message-ID: <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
Subject: Re: [PATCH] config: arm: exynos: remove PROVE_LOCKING from defconfig
To:     l.luba@partner.samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 at 17:34, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
> bus transactions.
>
> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
> The overhead can be measures using hackbench test which will speed up
> by x3 times (11sec -> 3.4sec).
> When you check transaction on cache or buses, the results are way higher
> than normal for the same hackbench test:
> L1d cache invalidations: 26mln vs 4mln
> L2u cache invalidations: 42mln vs 12mln
> bus cyc/access: 30cyc/access vs. 20cyc/access
> context switch is x3 times cheaper
>
> Enable this option only when you have some locking issue to investigate.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 27ea6dfc..fbf52f3 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -324,7 +324,6 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_SOFTLOCKUP_DETECTOR=y
>  # CONFIG_DETECT_HUNG_TASK is not set
> -CONFIG_PROVE_LOCKING=y

You just disabled all debugging around locks (so also basic checks).
You did not describe this in the message... and it also makes me
wonder what were you testing? Kernel without any lock debugging (so
this patch) or kernel without lockdep only (not this patch).

As for the reason behind this change, I am not sure. We had locking
issues and this change really helped us to spot them. Most of the
issues are solved so maybe this is not needed anymore but on the other
hand - this is development/debugging config, not a distro-ready. It
might serve as a reference for distro configs but clearly it is not
for production.

Best regards,
Krzysztof

>  CONFIG_DEBUG_ATOMIC_SLEEP=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_CRYPTO_RSA=m
> --
> 2.7.4
>
