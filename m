Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F6B20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Wb34Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F6B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeJPU4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPU4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:56:31 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C6620881;
        Tue, 16 Oct 2018 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539695167;
        bh=g4duEpsJS1VdTYdC4H2W7JnIL4xUim62Yj3MZKE9uJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4Wb34Ixi6gIYyKtPonz3lcZKApRbk2kUgXRntqadr08Bitfj12akMNn9uG+90pav
         QQQHgQfUOe+0CoMtnKNrLC3y5oB+3tWbk6jKWJ64xGSdUzM4LHyD1sbIRZrCyL1KJt
         mNtZ08Oy2uw23AyXRQ7GJWrg7WsQGhJhQOiAObcE=
Received: by mail-wm1-f41.google.com with SMTP id i8-v6so22216239wmg.0;
        Tue, 16 Oct 2018 06:06:07 -0700 (PDT)
X-Gm-Message-State: ABuFfoj7ZNAMZzVmjCuLWr6NgyprurwjxLq4Lc5uvIIvgYGkbN1OV2nt
        oss0PTu8Y9XekrmZPGOPMbI3D2JacAtGiIw/wGQ=
X-Google-Smtp-Source: ACcGV61IQVPmnCK3CE9FIeg78e8OSv4VIg4fYlb6lk2tUmy3FQGNNmLzHrgvklaHVgSROMUDx/osVLBPVNXHcXzG7Ro=
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr16387254wme.45.1539695165516;
 Tue, 16 Oct 2018 06:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017@eucas1p2.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com> <20181015123112.9379-6-m.szyprowski@samsung.com>
In-Reply-To: <20181015123112.9379-6-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 15:05:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPct1-8g6hcfzwkMdyFDJPfj=5Y9-s0R9mtpTJu99in7Xg@mail.gmail.com>
Message-ID: <CAJKOXPct1-8g6hcfzwkMdyFDJPfj=5Y9-s0R9mtpTJu99in7Xg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: exynos: Move arch-timer node to right place
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
> Move ARM architected timer device-tree node to the beginning of 'soc'
> node, to group it together with other ARM CPU core devices (like PMU).
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Looks okay, I'll take it after this merge window.

Best regards,
Krzysztof
