Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA649C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5D421479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8+vhlne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5D421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJIPfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeJIPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:35:42 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6EFA21479;
        Tue,  9 Oct 2018 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539073198;
        bh=QT4pXoe0CLoZdz9DqcU8EAbyxvlmnVYXocf8VltJhF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p8+vhlneUJ/wkVTmcbvuLrm8jQxxUG6v7i+QKbchTnej8tlxbySGogjWrH169Ba6I
         7GPLwaz2Z1+Cw9f0lLT1aC5OyzJE8QfNiTNWYdrl7aBIS/AMl6/I+v7DBqrPUhK64Z
         UvL0l3g85iYrY7jXZa0UqOuOD2BCtZ9WRLSeVLx4=
Received: by mail-wr1-f44.google.com with SMTP id g15-v6so761129wru.9;
        Tue, 09 Oct 2018 01:19:57 -0700 (PDT)
X-Gm-Message-State: ABuFfohL5C5EiM2AJqWb8Zn99dticI5wlGhs2lJKw/MHXS3TDmy7zjR0
        7upKTJhPb14BNZGNu/DNpjJfkhVNi77S3vue6Sc=
X-Google-Smtp-Source: ACcGV60hlvI4K07GT9LsebZSI055rAfdSUsGI/4/574a6GNGmgjiJCW0246OX5KfSh3kcnITXb3PRGhpvC7p7xJLpfE=
X-Received: by 2002:adf:f84e:: with SMTP id d14-v6mr19253203wrq.174.1539073196381;
 Tue, 09 Oct 2018 01:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130@eucas1p1.samsung.com>
 <20181008125009.3721-1-m.szyprowski@samsung.com> <20181008125009.3721-4-m.szyprowski@samsung.com>
In-Reply-To: <20181008125009.3721-4-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 9 Oct 2018 10:19:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc5uB0cnwvcN5SinmajKgb=O-bGgrmRHCThNndFwLGeyw@mail.gmail.com>
Message-ID: <CAJKOXPc5uB0cnwvcN5SinmajKgb=O-bGgrmRHCThNndFwLGeyw@mail.gmail.com>
Subject: Re: [PATCH 3/7] clocksource: Change CPU hotplug priority of
 exynos_mct driver
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
> Exynos Multi-Core Timer driver (exynos_mct) must be started before
> ARM Architected Timers (arch_timer), because both timers share common
> hardware block and turning on MCT is needed to get ARM Architected
> Timer working properly.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/cpuhotplug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
