Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E3CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2C620C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiTeHX1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2C620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbeGQNCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeGQNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:02:14 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8604420C0A;
        Tue, 17 Jul 2018 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531830587;
        bh=O3xvb6Wke7ojEh0Rmt4s5tVke9CS6pW1vIBvxLHz8nA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RiTeHX1aDP+yA3amjuaa5jNtsl6X2N8mTqCKk7Ti0PPBw27jLeGxE+CBVnXF0RpWC
         n0UqF/XrCZQu8mjMzA1Md9ERLTucnKOZkiRBBKNBDtCntLvTNc2w1zLMkm0swG+PJ+
         a4COLZ6JWGoN2BcOD4qShIjdoay/cQSpASxM1LEM=
Received: by mail-wm0-f46.google.com with SMTP id s14-v6so1345815wmc.1;
        Tue, 17 Jul 2018 05:29:47 -0700 (PDT)
X-Gm-Message-State: AOUpUlEzPwwTLB4Ppq70cMTKvf/WTOO2Ern+LS8fGvZWuZ7P7SrMSgWb
        D/xgT9022+qN0CrlijM7NwOuP4KGiZEqf3ox+To=
X-Google-Smtp-Source: AAOMgpelckraYnH3Y6FSecJQEh9+0IiSSQ2j9Efd2Cvd3jyp+GKfd3mNJazY9xgGm2poMZb82UBjoOLJ0zMZHcDcwZY=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr1261579wma.72.1531830586094;
 Tue, 17 Jul 2018 05:29:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:29:45
 -0700 (PDT)
In-Reply-To: <1531822342-4293-5-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <1531822342-4293-5-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 14:29:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
Message-ID: <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
> add tmuctrl aliases node for exynos542x

Please use full sentence, starting with capital letter and ending with
a dot. Also please explain why you need tmuctrl aliases.

>
> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |  8 ++++----
>  arch/arm/boot/dts/exynos5420.dtsi                  | 20 ++++++++++++--------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++----
>  arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  8 ++++----
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  8 ++++----
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |  8 ++++----
>  6 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 57c2332..ff79f0b 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -1061,19 +1061,19 @@
>         status = "okay";
>  };
>
> -&tmu_cpu0 {
> +&tmu_cpu_0 {

This looks irrelevant to the topic of adding aliases.

Best regards,
Krzysztof
