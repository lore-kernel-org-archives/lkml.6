Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E854520881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkno7G2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E854520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeJPUz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeJPUz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:55:29 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B14420881;
        Tue, 16 Oct 2018 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539695105;
        bh=ZDQ1fwbZfjIozWAC2w7pnpjrNwKT1ixn3fM/xJ9L1rI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mkno7G2o0VtVzMVkSxIyH/vx/xFi5+92ss/50fYoLApWu7D8b7Z3bGhARHUqA1PhT
         j0maKyf+mD6rlFb+f8E9UMV+fPCMcRoTA5z5crwPQWYmTJv6uMoY4wU4QeqOhYiifE
         Scpqy67Cyv70mqpOFN267gJ384zvV3vmim+BTOpM=
Received: by mail-wm1-f53.google.com with SMTP id 193-v6so23142950wme.3;
        Tue, 16 Oct 2018 06:05:05 -0700 (PDT)
X-Gm-Message-State: ABuFfoin7Ih2XXELaQ+Y6PRSve+EueoQNo9EFGm4UjF7JyWJfnZeYq75
        Bjd/H8CntJUd9jlGY09e4cE5bFytjNpmQCeANQI=
X-Google-Smtp-Source: ACcGV62Y1z1A6KlIBJQSSe9k3TGD33S7Ogvcr+QboME6A/AGj66nZXyOoU4jOSZDmvnJsbnHrX9sNwIEfvLnF3885Ww=
X-Received: by 2002:a1c:dac7:: with SMTP id r190-v6mr17145354wmg.137.1539695103779;
 Tue, 16 Oct 2018 06:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37@eucas1p2.samsung.com>
 <20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g@eucas1p2.samsung.com>
In-Reply-To: <20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 15:04:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcFnkwZfCg8q429L6HRfNxubTaoa+BRZ-1h3ti3Q2EAxw@mail.gmail.com>
Message-ID: <CAJKOXPcFnkwZfCg8q429L6HRfNxubTaoa+BRZ-1h3ti3Q2EAxw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
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

On Mon, 15 Oct 2018 at 17:50, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> config option) is not working properly (debug messages are not
> displayed after resume) on Exynos platforms because GPIOs restore
> code is not implemented.
>
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
> Then convert Exynos code to not require <plat/pm-common.h>
> header (use pr_debug() directly instead of S3C_PMDBG() macro and
> remove redundant s3c_pm_*() calls).
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v3:
> - don't move PM to the line below in Kconfig
>
> v2:
> - convert Exynos code to not require <plat/pm-common.h> header
>
> Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
> needed s3c_pm_check_*() calls".
>
>  arch/arm/mach-exynos/suspend.c |   14 ++++----------
>  arch/arm/plat-samsung/Kconfig  |    1 +
>  2 files changed, 5 insertions(+), 10 deletions(-)

Thanks. This and the other one (removing s3c_pm_check_*()) look OK
although it is too late for another pull so this will wait for next
cycle.

Best regards,
Krzysztof
