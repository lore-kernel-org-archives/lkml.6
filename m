Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85BC2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVi/sf3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85BC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPVCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPVCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:02:31 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF652098A;
        Tue, 16 Oct 2018 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539695525;
        bh=mRr3Du5wYidjIGWzBb7K4pq2qrfimezFcNktr7loIH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sVi/sf3wFnkO0CvOgw37uFDjQi0kuCy9wrBkOvXj5Yvt2d8V+sCioxLbTl+pjuQCu
         rC6HxDxVzS1kIuEm2xP7mSM3arsA+BGTpicN9LuKIVOnsNasQCgAUE/V20o4wCFUej
         tNy5qjVu5L/5KUgrGQB+zMjSOfTixkc2a5gAbubw=
Received: by mail-wm1-f52.google.com with SMTP id 189-v6so22378767wmw.2;
        Tue, 16 Oct 2018 06:12:04 -0700 (PDT)
X-Gm-Message-State: ABuFfojSW/GNeeayQebcXCs+OAirewuFEBEjqoNxPwHJgrjPuQHl2361
        qqtCHPyRr3ziPIKGDvmRjePMuSlCv9t4OVlntDA=
X-Google-Smtp-Source: ACcGV60V9wz9ew8OwMle7bs9N2XsguFv/2RTNNFcG1OfCCQlc1tJ9+zd5Mt+WeYm9zpcRpzNUKsEaG/I24xSOJN9nAU=
X-Received: by 2002:a1c:9609:: with SMTP id y9-v6mr16189333wmd.67.1539695523195;
 Tue, 16 Oct 2018 06:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com> <20181015123112.9379-4-m.szyprowski@samsung.com>
In-Reply-To: <20181015123112.9379-4-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 15:11:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdPk-ATQd-3jzWariPek_WjG3TeLv-LJfzGWA9H7rY96Q@mail.gmail.com>
Message-ID: <CAJKOXPdPk-ATQd-3jzWariPek_WjG3TeLv-LJfzGWA9H7rY96Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks. This patch adds a mode of cooperation
> with arch_timer driver, so kernel can use CP15 based timer interface via
> arch_timer driver, which is mandatory on ARM64. In such mode driver only
> configures MCT registers and starts the timer but don't register any
> clocksource or events in the system. Those are left to be handled by
> arch_timer driver.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 52 +++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 17 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
