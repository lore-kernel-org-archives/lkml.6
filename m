Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB415C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CC7213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfkO+POW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CC7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJIP1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeJIP1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:27:45 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7701D213A2;
        Tue,  9 Oct 2018 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539072722;
        bh=DGi3ZTSQYnQha9eatBs29sMrxdlnityyUtHJMQDAt0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PfkO+POW+t56zcQxmLRVgtjW5kjjdaJJeP/P9gtMyO09KWLBICw/7keu3rV9++fya
         rGHAFsElA23mIjdd95TZ3uriDYbtFZc4Nu7Od68ZM38hm7K1hlg3uum/7miuEyCSNx
         drx9LqtaKIPQOQUCNU8/Y/L9MTfnK+mDb8k6ISHw=
Received: by mail-wm1-f53.google.com with SMTP id a8-v6so892160wmf.1;
        Tue, 09 Oct 2018 01:12:02 -0700 (PDT)
X-Gm-Message-State: ABuFfoiymET1R/C+p630GaZ41NcKRUXiDOhduRTjx/9Bsh79i9R+4Cwz
        tXFlwTvpOAQ6g1XX4qoGdn0vo/uF04rtujHfAak=
X-Google-Smtp-Source: ACcGV601IZVvCP0RslGWZ2nxXXXUgoWj4KI6oGX/uhhXdFjc0DhRBTeTW0wMccJMB7UA2DbPMKXuiQ2q30brE7ppCFw=
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr999573wme.45.1539072720919;
 Tue, 09 Oct 2018 01:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37@eucas1p1.samsung.com>
 <20181008125009.3721-1-m.szyprowski@samsung.com> <20181008125009.3721-2-m.szyprowski@samsung.com>
In-Reply-To: <20181008125009.3721-2-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 9 Oct 2018 10:11:49 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfMCy_tiZ7x6gn6m4BnER=niONxJCwvMTTZwcEHK--5fg@mail.gmail.com>
Message-ID: <CAJKOXPfMCy_tiZ7x6gn6m4BnER=niONxJCwvMTTZwcEHK--5fg@mail.gmail.com>
Subject: Re: [PATCH 1/7] clocksource: exynos_mct: Remove dead code
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

On Mon, 8 Oct 2018 at 14:50, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Exynos Multi-Core Timer driver is used only on device-tree based
> systems, so remove non-dt related code.

You can also mention that in case of !CONFIG_OF the code is anyway
equal because of_irq_count() has a stub returning 0.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
