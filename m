Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F55218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="D0+wcJVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfAXOxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:53:21 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37226 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfAXOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:53:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id u19so2076196uae.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdykN5UmMQtX6eWvw2cj/OmCft/apq5HGTz+1838zLE=;
        b=D0+wcJVoU7BI4mDwJx1kPHFi9YxlvSutBXcWNd+MmX9rqvXkLZwhEsgIJ2B/iPOdle
         IZIDtCdwDXxjY7+cYKezJG8LCZ7vlClN1Z+OqRghJZOgNF+bQPJg39BmZ/cdEslboEIa
         xFkIUdCDYUnBqEZeoJEAG0MomOWKSFuICRpXPYHkwr0tdqt/3b2uJXxZ35zkA5DeoDbC
         51LTy7eSICqE8abr2XOQ59NlgwM7xFCFKkRW4Y0vJ/XplekyUFxlcz1KFBrDVPW0Ob97
         kW3CKu6jGSrkzWGH+pADYv4mK0r9Xn3h6PcRfMoKn1ct9DVf73iyAPf2GhhDK7rU6zjC
         UZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdykN5UmMQtX6eWvw2cj/OmCft/apq5HGTz+1838zLE=;
        b=Lmu5RDE3W08nIIkgYx68MuOMkTOJBnOjCAcXyRJE69EXWAGl4+MpE4aDaSbIwGVhn4
         04jQFrCvnO+k2OIzOcxNZg/li0NQdTa0D25gFrYhCCVh7hp+llriVdM4dKdsMeOyx0BX
         6jQ+5hetxLbAEYdCl/sjK/gEN89zU22FWEUyzkjUM34BLHrGH1hoW5z7XVCwLYE2/GYV
         jeeRqDpw8fD+jizkgubf3TLIJrx/cYEkgmgjVVls7GqrKsLlJR5e8lHYYtkOWuff0SOL
         A3xo5QOGn6qaY7lfCfeHGLyekWwS5XAhRWAGDUj4efNScoiQ8mdXJXHhqtlLNGW7rjFs
         bPjQ==
X-Gm-Message-State: AJcUukcO906OmkIk9bGQRClkG4As8JF3EgZysQD34LqwKLDdsDQ1uxLX
        4XqClhm4whNfA6bEn+l3sFH8GzOTkkQ+WbTw1WHrKQ==
X-Google-Smtp-Source: ALg8bN47S3DydN9PoTjFgdAL8YyL825KdPZMmNbvSEtAmT+Y1MazaPW583nWuXAiznt9fbFEEI9wMSKavR5LOfeCiCc=
X-Received: by 2002:ab0:7db:: with SMTP id d27mr2621481uaf.4.1548341599019;
 Thu, 24 Jan 2019 06:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20190124124508.6541-1-niklas.cassel@linaro.org>
In-Reply-To: <20190124124508.6541-1-niklas.cassel@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 24 Jan 2019 20:23:07 +0530
Message-ID: <CAHLCerOvpf0ONVV0V6JKbQL_k31qqyiT8vcjvsvK4PPTMqZS_Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: dts: msm8916: remove bogus argument to the
 cpu clock
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 6:15 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> The apcs node has #clock-cells = <0>, which means that those who
> references it should specify 0 arguments.
>
> The apcs reference in the cpu node incorrectly specifies an argument,
> remove this bogus argument.
>
> Fixes: 65afdf458360 ("arm64: dts: qcom: msm8916: Add CPU frequency scaling support")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index d302d8d639a1..e4bfd47178b1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -111,7 +111,7 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> -                       clocks = <&apcs 0>;
> +                       clocks = <&apcs>;
>                         operating-points-v2 = <&cpu_opp_table>;
>                         #cooling-cells = <2>;
>                 };
> @@ -123,7 +123,7 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> -                       clocks = <&apcs 0>;
> +                       clocks = <&apcs>;
>                         operating-points-v2 = <&cpu_opp_table>;
>                         #cooling-cells = <2>;
>                 };
> @@ -135,7 +135,7 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> -                       clocks = <&apcs 0>;
> +                       clocks = <&apcs>;
>                         operating-points-v2 = <&cpu_opp_table>;
>                         #cooling-cells = <2>;
>                 };
> @@ -147,7 +147,7 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> -                       clocks = <&apcs 0>;
> +                       clocks = <&apcs>;
>                         operating-points-v2 = <&cpu_opp_table>;
>                         #cooling-cells = <2>;
>                 };
> --
> 2.19.1
>
