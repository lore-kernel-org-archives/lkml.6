Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E690C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C177223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1J759hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C177223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeKLSxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbeKLSxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:53:01 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636B4223CB;
        Mon, 12 Nov 2018 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542013246;
        bh=CXFRI9xpMkAIufqjmbpESzkJVagAVVh0/xAPM2ArlXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M1J759hzVv9ljiCjcSCe5UehLFG4z19roNouS8lGRZVk5moY2hr5eOKBfB0Xj79qY
         v2u+AqXlvI4/6R5e0SEUgYarNgQnk00LNSpd+wO6WuZPIfKE25Lu+aOtS4citpqF2r
         FWGI/Cl0yzm+Is0B39VnUDb5h0G6dzPRrORyfXKg=
Received: by mail-lj1-f176.google.com with SMTP id e5-v6so6882623lja.4;
        Mon, 12 Nov 2018 01:00:46 -0800 (PST)
X-Gm-Message-State: AGRZ1gLJHuU6NGs0QLZbaxWktzV1mHsjy5ImaLSXMWc9DCIS8cWl2/ld
        N6t5ft0kqHrqKX2TMRm8lAjkrYZajU/uz/M74EU=
X-Google-Smtp-Source: AJdET5fqUn5egnyujNHuiwlzZogSjmHoLrt/X9DZwmzoQJFmeHooyJy4T9qNKl1pUMVrgV/go4qWjfxrk1fP1Ed6CAo=
X-Received: by 2002:a2e:85d3:: with SMTP id h19-v6mr100345ljj.82.1542013244507;
 Mon, 12 Nov 2018 01:00:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f@eucas1p1.samsung.com>
 <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com> <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Nov 2018 10:00:33 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcGOiVwVuaT+2RHGs0VxA2XRjOd6efsDQaGrWWCJS7vNg@mail.gmail.com>
Message-ID: <CAJKOXPcGOiVwVuaT+2RHGs0VxA2XRjOd6efsDQaGrWWCJS7vNg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] arm64: dts: exynos5433: add support for thermal
 trip irq-mode
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Lukasz for patches. I like your work!

I have few more comments which will probably apply for all the DTS commits.

On Wed, 7 Nov 2018 at 18:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flag which indicates

This patch does not add support. Support for flag was added in your
first drivers/thermal patches in this set. This patch adds new flag.
(and does something more, so read on)

> that trip point triggers IRQ when temperature is met.
> Exynos5433 supports 8 trip point which will trigger IRQ.

/8 trip point/8 trip points/

> Above that number other trip points should be registered
> without 'irq-mode' flag.

Please fix the line-wrap.

>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
>  1 file changed, 70 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> index fe3a0b1..c4330f6 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> @@ -17,37 +17,44 @@ thermal-zones {
>                         atlas0_alert_0: atlas0-alert-0 {
>                                 temperature = <65000>;  /* millicelsius */
>                                 hysteresis = <1000>;    /* millicelsius */
> -                               type = "active";
> +                               type = "passive";

This change is not explained in commit msg.

Basically you are doing here two things (related to each other). You
clearly define which trip points are IRQ-type and you correct the type
of trip point. Active is incorrect. This second thing is missing in
your commit msg and I believe it is main reason behind this patch. You
should focus then on this reason - start from it. Subject could be
like "Use proper passive type for thermal trip points".

Without this explanation I don't see the strong reason behind that
patch. IOW, everything was working fine before... so why adding this
new flag? Or maybe something was not fine... and then it is real
reason why you are sending the patch. Usually commit message should
answer to the most important question "WHY". Now, it explains
"WHAT"... but I can see it from the source code. However from the code
it is not easy to guess WHY.

Best regards,
Krzysztof
