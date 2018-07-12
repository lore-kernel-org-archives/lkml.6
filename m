Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DBEBC169
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC75C208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qNswKwoo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KTCQCvLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC75C208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeGLSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:50:36 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36140 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeGLSug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:50:36 -0400
Received: by mail-ua0-f194.google.com with SMTP id y8-v6so19055511uan.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jPuFI/SMH/sJFImcIgmng0oCqlSrwdPCiCiS6uA5SNc=;
        b=qNswKwooWtJD5Mi1fWzHZG5lC0ICyhkZeFXbKqlwIu8LGaKMOxBanRHSOa+0wFQebI
         RF6t/7srnFskTKfhzDrU8VjUmgsksyadcloW175uJgyXcCZzir9Ss9FjJG4XvEQKTk7V
         EgjiZVEtSzK84y55vl3kJ7Q/LO7u+OprCbW92Cf9oYjgurB0n8qHdrHyunhnNTaowrF3
         YugEF4jApOrsfP1QHvLzFa6zTHeEJ+QTycap0AUgWubUQUdDy2TFl/hPFamOFtrnVDGS
         egVxRzLeV4MLEXCcJJqrLE9dzWAi2D0gQUluKRPxJO0C6vPEV0L9ZJSEZXloh1o9xVyl
         P7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jPuFI/SMH/sJFImcIgmng0oCqlSrwdPCiCiS6uA5SNc=;
        b=KTCQCvLTLg8tyV62C9cOMJktpND9I4WeP2eqpO6Q+P621DWblZ5pdRrHYQFzKCJxM5
         dFubwBnoXJpo8ANgiTB9WcCzEZ0avKIu/mvVVmw313ox/kWFMtUM0+1yExWEJ6HDvREv
         d5KPLY/0W6wsCLyFYPbUXwbGjrHpDeLYMirKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jPuFI/SMH/sJFImcIgmng0oCqlSrwdPCiCiS6uA5SNc=;
        b=EzDWAObVhKWhBlcPQJCxZkbrTNitDNwKEJ4sVg7oSxAphMzKYWMxrUv4/LlSQZFX9x
         kAPP0hU5Ry8Txeed8ACOe1/yt++UPxS4NGo/Cvp4XZRH/ikah+WFU5P9G/mHjbrGnQDz
         /2yETWkUpTka2iDztDgdKmQFEpxjxgK4UP/YuVcPxFrZ3zmp6s9i5+Mjh22XmRGsixGS
         oKSPDxviQib3uNgBaZjqN1pBamJME18lICM03RDcb82ktKpPbHXdZLfsZK6LZN37S2gw
         4hsE5heNFgwBUUiYJjGw1KBP3UPi+Q1q/7gTc3vlLwxtUF13N79CSIBARgWBi2QSAHdB
         UcAA==
X-Gm-Message-State: AOUpUlFQZ67cfo+VJwlNpUTuXAyzUA8VbGlU6J1Ox1kOVAb2gM0aeMAj
        4s5pyCj7wXYM8p+D2FFtnqzm9vVFkhEP6Pru0xHUFg==
X-Google-Smtp-Source: AAOMgpdtV2cUvjrmgjnpKbk1mJntNdf8vJt4pPrEAdyJD43jnMpGdB21f2IBBZ34xT2uKSLlYUeMtbWknxHvMkd/y5k=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr2164507uac.135.1531420789091;
 Thu, 12 Jul 2018 11:39:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 11:39:47
 -0700 (PDT)
In-Reply-To: <20180709212522.187257-2-mka@chromium.org>
References: <20180709212522.187257-1-mka@chromium.org> <20180709212522.187257-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 11:39:47 -0700
X-Google-Sender-Auth: _O_uVbIjnIycnG9SpIO3FQ_Wp34
Message-ID: <CAD=FV=UMpo8AfMkRt1a99VRzsDrESTVAJ5QcyD0tzYVxPfKL-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 2:25 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> configured without an IIO input it always reports 37=C2=B0C for temperatu=
res
> below the first hardware trip point at 105=C2=B0C. This hardware trip poi=
nt
> is configured as critical trip point, to initiate a system shutdown
> before the temperature reaches the next hardware trip point at 125=C2=B0C=
,
> where the PMIC performs a partial shutdown.
>
> The temperature of the critical trip point can be increased after
> adding the die temperature ADC as IIO input for spmi-temp-alarm, which
> significantly increases the precision of the temperature measurements.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - moved 'thermal-zones' node to the beginning of the .dtsi
>
> Changes in v2:
> - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
>   to refer to it
> - use 105=C2=B0C hardware trip point as critical trip point
> - reduced number of trip points to 2
> - lowered temperature of passive trip point
> - updated trip point names and added labels
> - updated commit message
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/q=
com/pm8998.dtsi
> index 7eea94701b23..52c5e797aab2 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -3,6 +3,31 @@
>
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +       thermal-zones {
> +               pm8998 {
> +                       polling-delay-passive =3D <250>;
> +                       polling-delay =3D <1000>;
> +
> +                       thermal-sensors =3D <&pm8998_temp>;
> +
> +                       trips {
> +                               pm8998_alert0: pm8998-alert0 {
> +                                       temperature =3D <95000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +                               pm8998_crit: pm8998-crit {
> +                                       temperature =3D <105000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };

IMHO since the 95000 won't trigger until we get the ADC, it's a bit
too extreme to go straight to shutdown when the PMIC reaches 105.  I
think we should take David Collins's advice and disable the "partial
PMIC shutdown" and then set the two stages to 105 (passive) / 125
(critical).  In theory we could add a 115 (hot) stage in there that
would only get triggered later when the ADC gets hooked up.

Personally I wouldn't land this patch until we do that.

-Doug
