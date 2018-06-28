Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF42C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617F024309
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9+KWinD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j07roS3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617F024309
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967199AbeF1W6p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:58:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38994 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966992AbeF1W6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:58:43 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so4617745uad.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MKhzBZF6bF01wFalm/itvkOTmHMvbHHLYIgGeNHVd+g=;
        b=Y9+KWinDwYpBKn1ePFXv2JVwzZfj+SQhQzNcA/Vb0IspOjI5DhMyUu4Y4dxD//L6y5
         rUCyFJAnJ4Qwh0W+JFvSotgeDSIZmddqCU2tHsLIub4P//ciT+BKE4kssjuSJkfurgeR
         ADQqAfuynJxmOBGSPL4iyfTtjdY553o0L8rRysQ3I5YuokKcfy/JU3KKoqMD9oILgxXp
         KV71CY2dcPb19fD07dvWJqg0SGoaVtOck57zwR4YSv5wqenFUJwiXIS2ZG765up+4K2P
         e+kHbBFQXefhZIo1hM7zrqPUvbqBe8KGG/nXXzSUlb05qJ7qSdvbioF0twLNOEnOF4+Q
         MQGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MKhzBZF6bF01wFalm/itvkOTmHMvbHHLYIgGeNHVd+g=;
        b=j07roS3incZI3HfmiviTuwV2zRfDAnaJ4yE6GV10w//n2Vs8PGZ3c6ZF7slJ+xphkn
         SX99PHf50lEFz0mlzTr40BwppFK+2De2N8QkXlqnRlk0ho9owhBtyNCPJGrAcStzvMGP
         C4LdwrGHy5RxHZTPxky6GRFBF68ObBK4iWWdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MKhzBZF6bF01wFalm/itvkOTmHMvbHHLYIgGeNHVd+g=;
        b=BuscgzFHYUJlwHpgTK/yyfBdmWx6rIlWlS1Jb7oj0bqMz4qmRpeVhZTP4wPejs3SHv
         5UkyfByGjIf1Cvr1OoUnUDFAPRwgwscACj/tFAQV9R2PMky+cQt//LILNPp8zpnLnl1j
         jR5tF0caa6lNYWs9Yre1W38PfJLFKpEMlpDkkThCbUryPMDHG4nY13qaTkiBVMt19gQj
         DXLUGbEZBFKXA8EUGdrPJadYrBXDtWTrNyJC+LjLLLZj/1HqOY0SnimfmLvSLxwhssCu
         T7diThIpAcD8O6YVwwhVennn943ZsjrPg7nnYoMpteNm02ul2SGxYjZEIIwBGEY5L6ix
         eG3w==
X-Gm-Message-State: APt69E2T0Nctx/rxBaigmqconx1hlpaLHb4WtQQYfWR8N/6+/OMY0qWG
        mP/41jAD11JjOQ/ssIzXoLIso1TLsdgvFtUIhtuwtA==
X-Google-Smtp-Source: AAOMgpdIqDTuxok1DvXTX1AlGlRn+02FMllmNvEK3ouVfIYiTf3Sg4r8ZkA7Y5gSrFkq9tNaQo/JeSUXlOQBzXr9wKY=
X-Received: by 2002:a9f:3d21:: with SMTP id l33-v6mr7671481uai.135.1530226721815;
 Thu, 28 Jun 2018 15:58:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 15:58:41
 -0700 (PDT)
In-Reply-To: <20180628210915.160893-3-mka@chromium.org>
References: <20180628210915.160893-1-mka@chromium.org> <20180628210915.160893-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jun 2018 15:58:41 -0700
X-Google-Sender-Auth: JuvMsc2CAyi81qvJ8atcHJWTh9s
Message-ID: <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
> bindings.
>
> Note: devices with the pm8998 need to have a 'thermal-zones' node (which
> may be empty) with a label 'thermal_zones'.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Do you know if this patch actually does anything since you didn't
define a cooling-maps?  Hopefully at least the critical shuts things
down?

Do you have any idea how we'll eventually want to specify a
cooling-maps?  Are we just going to assume we're included by an sdm845
device and refer to the big/little CPU phandles?


> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index f2d39074ed74..d85ceb4f976b 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -3,6 +3,7 @@
>
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  &spmi_bus {
>         pm8998_lsid0: pmic@0 {
> @@ -59,3 +60,30 @@
>                 #size-cells = <0>;
>         };
>  };
> +
> +&thermal_zones {

As per comments in patch #1, don't rely on a label.  Just put your
stuff in a top-level "thermal-zones" node.

> +       pm8998 {
> +               polling-delay-passive = <250>;
> +               polling-delay = <1000>;
> +
> +               thermal-sensors = <&pm8998_temp>;
> +
> +               trips {
> +                       passive {

IMO you should proactively put a label on these trips even if there's
no cooling device yet.  It's expected that at some point someone will
add a cooling device and refer to them, right?



-Doug
