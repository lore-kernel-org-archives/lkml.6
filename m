Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC8EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B221206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="0RJKDN3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B221206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeIFS2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:28:42 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39409 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeIFS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:28:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so20595888oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9BgaeRG+wqIlySU29NYEpoctcTm3y5N+wQiCBLkoqwk=;
        b=0RJKDN3NU5S4eJA/0EeRkXnkJn5ckzwCvKhWKwD50L6KqI0QS/8/EgbVwjKmQ2XSv6
         R/OZ7pCF2Fyzp9iqgmcXRf4pjekowp6KsnwbvLGUZSnaWmjRD3FXramb+dnOfTYH/a+m
         aeA/doDWIsf9OI2MReZpWdFLlPnfzHN+OIlukEDUXCBWg+cRyICjiCL04Jc+rcZgcBGV
         t0pqg3EUinbgHis9vW6QD1CQVaMnX2gLY6xTad0oPW/QhLs1Dcak3ycHhOcCl9PiVCpw
         HLsG1MSnayPszOGhmJNetKyd0C9p0ntREEW99O7AGTxrldIU9lsKztmBGwNBzdNtO53c
         16Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9BgaeRG+wqIlySU29NYEpoctcTm3y5N+wQiCBLkoqwk=;
        b=JdTKvZoxuVA0JnxyyxPrIgXsahMta3L2YGolt5PRzd2cxUeR1D7HcmLrUgaoAV8YRT
         JVWFKrK07nmIXKCc1M5rKGCxnVNvDDZqivm3tpnIVeC1iohHWYg4Kuw73m7+uCFJEs/2
         1nOzrGW4Lnz8nlPwLEoLYP9PsGBBJTFL9HoHCzHjUcQhJb7oLb9AhXDvZAjuhpOVCLBn
         67knpbZCDjbuy12p4X0aclmim2Pi04J/8heRdZDSZrqbgKyZeCr8blIa8jmt/f/0EN6N
         NaKlF/ET1tV10OydRout8aBekWKhOC7th1SNGhrFPzJ0NWpnHD2M6vgYdyEIFfr1RMb+
         d3Ng==
X-Gm-Message-State: APzg51D1dsd6ikEnly57ELeHPcd4i8BhxqMIXHaAUnsdjWZOBrgH1srV
        4bbfJJeH1UcZ1aETXMkjnHUmWKCLe+bCbw86ZUBEig==
X-Google-Smtp-Source: ANB0VdZh97vzGhs3N25aETCLF2I3Ac8aLj82JprH6RfQY8TRtXepbiUsIFQbjwM7wxCReczCUAHWk6Wr1E2l/Ix/X5U=
X-Received: by 2002:aca:a93:: with SMTP id k19-v6mr3219611oiy.83.1536241981404;
 Thu, 06 Sep 2018 06:53:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:684a:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 06:53:00 -0700 (PDT)
In-Reply-To: <20180904050123.26601-4-bjorn.andersson@linaro.org>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org> <20180904050123.26601-4-bjorn.andersson@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 6 Sep 2018 19:23:00 +0530
Message-ID: <CAHLCerM2por+ES+OhH2nUOOPF_tmYjk6zGdw-2dr=JRu5Jfrbg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] arm64: dts: qcom: msm8998: Add tsens and thermal-zones
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:31 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> Add the two tsens instances and the thermal zones for CPUs, GPUs,
> battery and skin sensors.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - New patch
>
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi |  38 +++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi     | 193 ++++++++++++++++++++++
>  2 files changed, 231 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index 09b46c54e413..202aa1a5cf27 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -12,6 +12,44 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       thermal-zones {
> +               battery-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 0>;
> +
> +                       trips {
> +                               battery_crit: trip0 {
> +                                       temperature = <60000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               skin-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 5>;
> +
> +                       trips {
> +                               skin_alert: trip0 {
> +                                       temperature = <44000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               skip_crit: trip1 {
> +                                       temperature = <70000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +       };
> +
>         vph_pwr: vph-pwr-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vph_pwr";
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 98b9edb89424..f92f04f9ed6d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -225,6 +225,183 @@
>                 };
>         };
>
> +       thermal-zones {
> +               cpu-thermal0 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 6>;
> +
> +                       trips {
> +                               cpu_alert0: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit0: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal1 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 7>;
> +
> +                       trips {
> +                               cpu_alert1: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit1: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal2 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 8>;
> +
> +                       trips {
> +                               cpu_alert2: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit2: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal3 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 9>;
> +
> +                       trips {
> +                               cpu_alert3: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit3: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal4 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 10>;
> +
> +                       trips {
> +                               cpu_alert4: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit4: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal5 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 11>;
> +
> +                       trips {
> +                               cpu_alert5: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit5: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal6 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 0>;
> +
> +                       trips {
> +                               cpu_alert6: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit6: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu-thermal7 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 1>;
> +
> +                       trips {
> +                               cpu_alert7: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit7: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               gpu-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 3>;
> +               };
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> @@ -281,6 +458,22 @@
>                         cell-index = <0>;
>                 };
>
> +               tsens0: thermal@10aa000 {
> +                       compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
> +                       reg = <0x10aa000 0x2000>;
> +

use the SROT and TM split for v2?

> +                       #qcom,sensors = <12>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
> +               tsens1: thermal@10ad000 {
> +                       compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
> +                       reg = <0x10ad000 0x2000>;
> +

use the SROT and TM split for v2?

> +                       #qcom,sensors = <8>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 apcs_glb: mailbox@9820000 {
>                         compatible = "qcom,msm8998-apcs-hmss-global";
>                         reg = <0x17911000 0x1000>;
> --
> 2.18.0
>
