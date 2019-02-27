Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5073DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF40218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551257185;
	bh=+VHybkXZEZgWWpzCP9seJjfryQBRTOnGxtv/T8j9dqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O6zpxxa6ACJ74cLyi07sBN3woXabDDXioSMBGms2DhbRhGSFWwvNQ2+4CzmapyAM9
	 n6uQRUc3KHgQQqFCoiZikDNN0Nx/IJYYklY8YfK6hXudoG60yS0p2bIJj9Q0XrKLVs
	 m0RPox4bpZBhBMiHYGR5uu+8IKtSI1ZNv5AOovTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfB0IqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfB0IqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:46:23 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF1121906;
        Wed, 27 Feb 2019 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551257182;
        bh=+VHybkXZEZgWWpzCP9seJjfryQBRTOnGxtv/T8j9dqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lSQJ8vEhsxbglFGFB4LpwqAVqzrTfYPvSxXqKaKGlfUmZ33JoK2IYShKiC9Jno9sn
         NZfPC0m9kJ8OpbjJ3kTx3HASoHTeyEy2arS2S0xSzO10mSKl50xLzMS+5ZQHKZcpbt
         FefjVqUg71c3v59yGRq2aGxEUlUckgHn2FZuuCr8=
Received: by mail-lj1-f175.google.com with SMTP id l5so13269358lje.1;
        Wed, 27 Feb 2019 00:46:21 -0800 (PST)
X-Gm-Message-State: APjAAAU4DQJki827dk+x3M3KRMHTiGG7YL/8lbwyDpysS/ZqjqFsXoF6
        rWdYWVu/IK5c8PHBYnaxVhqjCh/c7Y2Y7ZL6xHI=
X-Google-Smtp-Source: APXvYqzz2cMievIQU2a/inead8cTm0gHAqevhnhk1i1MNAoni62pqp80R+lWnocb+j/Tv4T359hzEaMto8dPxeidjpo=
X-Received: by 2002:a2e:780a:: with SMTP id t10mr639791ljc.19.1551257180027;
 Wed, 27 Feb 2019 00:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 27 Feb 2019 09:46:08 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf_+dME_P9jy5=_LrjYEpgti4+CN0thkSXSvxwSGVH=Bw@mail.gmail.com>
Message-ID: <CAJKOXPf_+dME_P9jy5=_LrjYEpgti4+CN0thkSXSvxwSGVH=Bw@mail.gmail.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        robin.murphy@arm.com, tony@atomide.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 21:25, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
>
> The original change breaks omap dss:
>     omapdss_dispc 58001000.dispc:
>         dispc_errata_i734_wa_init: dma_alloc_writecombine failed
>
> Let's revert it first and then find a safer solution instead.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
>
> Would you please test and verify? Thanks!
>
>  kernel/dma/contiguous.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)

This fixes broken (since yesterday) linux-next on Exynos boards
(ARMv7), errors like:
dma-pl330: probe of 121a0000.pdma failed with error -12
exynos-ehci 12110000.usb: can't setup: -12
exynos-ehci 12110000.usb: USB bus 1 deregistered
exynos-ehci 12110000.usb: Failed to add USB HCD

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
