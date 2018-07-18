Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6034220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wm3EZg0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6034220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeGROeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbeGROeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:34:03 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BA520858;
        Wed, 18 Jul 2018 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531922159;
        bh=7XSbSyEIE9AGO2MZi1WJIQp+EKeDbyUrLy9zIwsR5NA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wm3EZg0AAKyDfM3QliBixALQ0MhLBIQg09QipGWyXeRKqR5QoWfVLtiFPf/Onc1fK
         QqGznAAzJQoVLo+nFjOj5U2v6IquycgTwv9YX7UgBgp3MttkCiEyLpZ5kxvzlMgQqP
         vfZ5iOHx5Q3lkKuI+SR5wD84EyRgfAUBihjozmYY=
Received: by mail-wr1-f49.google.com with SMTP id v14-v6so4792294wro.5;
        Wed, 18 Jul 2018 06:55:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlEvdTZ7rMAsVO+rfpyJ3vhyBgU2xW6uKzW4jmdQLCsJU96LXDvm
        7wA+gHV1AQvjlXX4iKIXvUJy20nkDFKXTMnRG40=
X-Google-Smtp-Source: AAOMgpeUAryA1QflAhqlAIdm1IFd8D9o7tz5fSL04MqtFiEnRC8SCfpwcd0F++SYue335b0x78elMrwjQTz+fpIpJJo=
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr4384169wro.279.1531922158165;
 Wed, 18 Jul 2018 06:55:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 06:55:57
 -0700 (PDT)
In-Reply-To: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
References: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 15:55:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdAEp-7jw-AqPfmqq+ygY_p4BGt92voCNRc3z57KU_-ZA@mail.gmail.com>
Message-ID: <CAJKOXPdAEp-7jw-AqPfmqq+ygY_p4BGt92voCNRc3z57KU_-ZA@mail.gmail.com>
Subject: Re: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 14:59, Anand Moon <linux.amoon@gmail.com> wrote:
> Add missing GIC interrupts property for pwm nodes.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fixed the patch indentation issue with all tabs.
> sorry checkpatch could not figure out the error.
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 5d2f0a0..f48fb9b 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -169,6 +169,11 @@
>                 pwm: pwm@12dd0000 {
>                         compatible = "samsung,exynos4210-pwm";
>                         reg = <0x12DD0000 0x100>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;

OK, thanks for v2. Now only tabs are used but in previous mail I
mentioned which example to use - the rtc node which nicely aligns
continued lines. Why you did not follow this alignment?

I'll fix it when applying, no need to resend.

Best regards,
Krzysztof
