Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230EBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E7820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLEsEPnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E7820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeLELMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeLELMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:12:39 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04FF20989;
        Wed,  5 Dec 2018 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544008358;
        bh=C0jvGcRv9UsknAfqJvNP6eKG2uaCJg4zqUAFO82b+Bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qLEsEPnX+hXifi6BDQiOidDW31UpPvnvsS4dFFyTplbFR1dzJotGP5teg0JOpCTlV
         1Y+nFt8dFxbF9ZMaw0MrF2AYKhNx18C86khs5zLzOu0mVGlz1jS9y/EydRJZrwFdmD
         6ev3YmUyQvxcvqlmChsuodLeD3U8A8lW7dGeqk40=
Received: by mail-lj1-f179.google.com with SMTP id e5-v6so17955231lja.4;
        Wed, 05 Dec 2018 03:12:37 -0800 (PST)
X-Gm-Message-State: AA+aEWZ4ro7nD0hsOC0o0et+IRmkCfez3AWtshgTcXcSjmwMCbKkXNyS
        sc6eF+u+jaTkPLBUvIkPrK4LBfxjOI4s5Q15INQ=
X-Google-Smtp-Source: AFSGD/VMb9KbVgESvp5zxEfhj/1neNJwfismfRKxsLCGZtkFWzg2gWmmAGY2Xdf6Qv9Ig57K09txvVLS+5EGzmM0DUY=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr17184219lji.60.1544008355906;
 Wed, 05 Dec 2018 03:12:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f@eucas1p1.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com> <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Dec 2018 12:12:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
Message-ID: <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
To:     l.luba@partner.samsung.com
Cc:     linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 12:06, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Mark the state for devfreq device while entring suspend/resume process.
>
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

I already applied v2:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/dt

Best regards,
Krzysztof

> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b6091c2..4429b72 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -298,6 +298,7 @@
>                         opp-400000000 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <1150000>;
> +                               opp-suspend;
>                         };
>                 };
>
> @@ -367,6 +368,7 @@
>                         };
>                         opp-200000000 {
>                                 opp-hz = /bits/ 64 <200000000>;
> +                               opp-suspend;
>                         };
>                 };
>         };
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 51f72f0..908c0c4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -432,6 +432,7 @@
>                         opp-400000000 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <1050000>;
> +                               opp-suspend;
>                         };
>                 };
>
> @@ -520,6 +521,7 @@
>                         opp-200000000 {
>                                 opp-hz = /bits/ 64 <200000000>;
>                                 opp-microvolt = <1000000>;
> +                               opp-suspend;
>                         };
>                 };
>
> --
> 2.7.4
>
