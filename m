Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbeEGXEM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:04:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33486 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeEGXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:04:09 -0400
X-Google-Smtp-Source: AB8JxZqJOvcZ2S37LRZ+Bif5KVTj8ZFgls5cZIKFHZiLIJu1hL3ZDV+mtEjXfbnpGGnHVg140Qm1Ew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180428054248.22387-2-bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
 <20180428054248.22387-2-bjorn.andersson@linaro.org>
Message-ID: <152573424824.138124.9876892052732688689@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8998: Add rpm and regulators for MTP
Date: Mon, 07 May 2018 16:04:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47N4HG1028223

Quoting Bjorn Andersson (2018-04-27 22:42:48)
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index d6665e4f801f..ccbf6347aacb 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -220,6 +220,16 @@
>                 method = "smc";
>         };
>  
> +       rpm_glink: rpm-glink {
> +               compatible = "qcom,glink-rpm";
> +
> +               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +
> +               qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +
> +               mboxes = <&apcs_glb 0>;

Why so many newlines?

> +       };
> +
>         soc: soc {};
>  };
>  
> @@ -337,4 +347,77 @@
>                 #interrupt-cells = <4>;
>                 cell-index = <0>;
>         };
> +
> +       rpm_msg_ram: memory@68000 {

unit address doesn't match reg property.

> +               compatible = "qcom,rpm-msg-ram";
> +               reg = <0x778000 0x7000>;
> +       };
> +
> +       apcs_glb: mailbox@9820000 {

unit address doesn't match reg property.

> +               compatible = "qcom,msm8998-apcs-hmss-global";
> +               reg = <0x17911000 0x1000>;
> +
> +               #mbox-cells = <1>;
> +       };
> +};
> +
> +&rpm_glink {
> +       rpm_requests {
> +               compatible = "qcom,rpm-msm8998";
> +               qcom,glink-channels = "rpm_requests";
> +
> +               pm8998-regulators {
> +                       compatible = "qcom,rpm-pm8998-regulators";
> +
> +                       pm8998_s1: s1 {};
> +                       pm8998_s2: s2 {};
> +                       pm8998_s3: s3 {};
> +                       pm8998_s4: s4 {};
> +                       pm8998_s5: s5 {};
> +                       pm8998_s6: s6 {};
> +                       pm8998_s7: s7 {};
> +                       pm8998_s8: s8 {};
> +                       pm8998_s9: s9 {};
> +                       pm8998_s10: s10 {};
> +                       pm8998_s11: s11 {};
> +                       pm8998_s12: s12 {};
> +                       pm8998_s13: s13 {};
> +                       pm8998_l1: l1 {};
> +                       pm8998_l2: l2 {};
> +                       pm8998_l3: l3 {};
> +                       pm8998_l4: l4 {};
> +                       pm8998_l5: l5 {};
> +                       pm8998_l6: l6 {};
> +                       pm8998_l7: l7 {};
> +                       pm8998_l8: l8 {};
> +                       pm8998_l9: l9 {};
> +                       pm8998_l10: l10 {};
> +                       pm8998_l11: l11 {};
> +                       pm8998_l12: l12 {};
> +                       pm8998_l13: l13 {};
> +                       pm8998_l14: l14 {};
> +                       pm8998_l15: l15 {};
> +                       pm8998_l16: l16 {};
> +                       pm8998_l17: l17 {};
> +                       pm8998_l18: l18 {};
> +                       pm8998_l19: l19 {};
> +                       pm8998_l20: l20 {};
> +                       pm8998_l21: l21 {};
> +                       pm8998_l22: l22 {};
> +                       pm8998_l23: l23 {};
> +                       pm8998_l24: l24 {};
> +                       pm8998_l25: l25 {};
> +                       pm8998_l26: l26 {};
> +                       pm8998_l27: l27 {};
> +                       pm8998_l28: l28 {};
> +                       pm8998_lvs1: lvs1 {};
> +                       pm8998_lvs2: lvs2 {};

What's the benefit to having the nodes here instead of in each board?

> +               };
> +
> +               pmi8998-regulators {
> +                       compatible = "qcom,rpm-pmi8998-regulators";
> +
> +                       pmi8998_bob: bob {};
> +               };

These may be board specific? So each regulator container would need
status = "disabled" and then status = "okay" in the board file.
