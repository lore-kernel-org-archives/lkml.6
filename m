Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8661ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7284620671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTVFGAJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7284620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbeGSLfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:35:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35538 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbeGSLfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:35:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so6821090ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRJIM0Db/GgQraXIfw2OSSAkep6fOSus85X/PLZoQto=;
        b=kTVFGAJka9sI8/3x+jK/GsEuSGbs7lhFuxqd4rKafCkB0mQEQmq17O7/xl/Ds1VdPd
         i/SnoU7uAkGisrqYc3HRe+s5vVMDla/YNHqpz+HU64h9jpP1zQirg89fbMqq+2exBinX
         UtK6A2qOZyrn8nVKSNTnX3NGnN8aFZOzNvE/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRJIM0Db/GgQraXIfw2OSSAkep6fOSus85X/PLZoQto=;
        b=gfziBhCHjRKnuFQl+5tKDYH2zfy8hbzz1U4zqNVf+vBj5pWAgFjjrrPIfJVDNkMAQl
         Mqzjv7eqSxIGTPrYZb67VibaNA0U447JcQv1CSjR9kgGTwpWsUpM5COiB4ZD56PNr5Mk
         iBAKpfNppDSptwKXyENVbcqf3rZHxG11A92zCmW8HY8CxmJY6yFxbyremuBTffBeQ8Fe
         gEqY3z23nOPw4xamKNPMyY084fcrbOfIKQT9GjbKDvcnmLMnTTp4IYw3hKNlFExF2Hh2
         7WNUZBCPODU9lttJXVKhziKv7Rzq+ls+7VRaCOGLTEWP6VBpQAHg2tdDFElkdYFSoow2
         ZToA==
X-Gm-Message-State: AOUpUlHDgtU8UW/qAZwl6gMJVAuw7seZP19/rJb2G85g80R4U7rHVxqD
        ibRL/u82GcJRljhSaSxwUzHxc6blveSuWIXcAiLRtg==
X-Google-Smtp-Source: AAOMgpfstuO9bIqj6wfiZNhX8g0dLCl7b83VMGWAPaJ73+3bm7uJzrE4WMS1O88hvJ3nABTEFajM3pBpknNssydYeds=
X-Received: by 2002:a2e:47c8:: with SMTP id u191-v6mr7166725lja.58.1531997595815;
 Thu, 19 Jul 2018 03:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180718145258.15254-1-niklas.cassel@linaro.org>
In-Reply-To: <20180718145258.15254-1-niklas.cassel@linaro.org>
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Thu, 19 Jul 2018 12:53:04 +0200
Message-ID: <CAP71WjzPxxwNp-FkUsRAP4e_+Z_q12wcLeXryk-eYdLi-WJexg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: msm8916: drop legacy suffix for clocks used
 by MSM DRM driver
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Niklas,

On Wed, Jul 18, 2018 at 4:53 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> Drop legacy suffix for clocks used by MSM DRM driver.

I had the same patch locally, which I forgot to send.. so thanks for
sending it ;)

you might want to add in the commit log:

    Since "720c3bb80235 (drm/msm: drop _clk suffix from clk names)",
we can see such
    messages when booting:

> Fixes the following warnings:
>
> msm_dsi_phy 1a98300.dsi-phy: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
> msm 1a00000.mdss: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
> msm 1a00000.mdss: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
> msm 1a00000.mdss: Using legacy clk name binding.  Use "vsync" instead of "vsync_clk"
> msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
> msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
> msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "core" instead of "core_clk"
> msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "vsync" instead of "vsync_clk"
> msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "mdp_core" instead of "mdp_core_clk"
> msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
> msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
> msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "byte" instead of "byte_clk"
> msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "pixel" instead of "pixel_clk"
> msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "core" instead of "core_clk"
>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index c2625d15a8c0..7b32b8990d62 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -858,9 +858,9 @@
>                         clocks = <&gcc GCC_MDSS_AHB_CLK>,
>                                  <&gcc GCC_MDSS_AXI_CLK>,
>                                  <&gcc GCC_MDSS_VSYNC_CLK>;
> -                       clock-names = "iface_clk",
> -                                     "bus_clk",
> -                                     "vsync_clk";
> +                       clock-names = "iface",
> +                                     "bus",
> +                                     "vsync";
>
>                         interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
>
> @@ -883,10 +883,10 @@
>                                          <&gcc GCC_MDSS_AXI_CLK>,
>                                          <&gcc GCC_MDSS_MDP_CLK>,
>                                          <&gcc GCC_MDSS_VSYNC_CLK>;
> -                               clock-names = "iface_clk",
> -                                             "bus_clk",
> -                                             "core_clk",
> -                                             "vsync_clk";
> +                               clock-names = "iface",
> +                                             "bus",
> +                                             "core",
> +                                             "vsync";
>
>                                 iommus = <&apps_iommu 4>;
>
> @@ -922,12 +922,12 @@
>                                          <&gcc GCC_MDSS_BYTE0_CLK>,
>                                          <&gcc GCC_MDSS_PCLK0_CLK>,
>                                          <&gcc GCC_MDSS_ESC0_CLK>;
> -                               clock-names = "mdp_core_clk",
> -                                             "iface_clk",
> -                                             "bus_clk",
> -                                             "byte_clk",
> -                                             "pixel_clk",
> -                                             "core_clk";
> +                               clock-names = "mdp_core",
> +                                             "iface",
> +                                             "bus",
> +                                             "byte",
> +                                             "pixel",
> +                                             "core";
>                                 phys = <&dsi_phy0>;
>                                 phy-names = "dsi-phy";
>
> @@ -963,7 +963,7 @@
>                                 #phy-cells = <0>;
>
>                                 clocks = <&gcc GCC_MDSS_AHB_CLK>;
> -                               clock-names = "iface_clk";
> +                               clock-names = "iface";
>                         };
>                 };
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
