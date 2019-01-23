Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC281C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C7720868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JaO7flI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWA2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:28:22 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42276 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfAWA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:28:21 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so98093vky.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hx/I5Uxyx54XWN1O7MeDfbIiaH2FN7OkgoMsFcs8oHU=;
        b=JaO7flI/kdZrv+Zt/C/qsS5CphBDrS5awNL99nZoN3tgw0Fhw/xWe5lBfE4mmrumrL
         jrC3vhPEJqlKuyWPQEA4YSj3WVqdppobrzzKptAJPxRGyFAo8ec4l6Zx4KEerhxsYtLF
         AWXzak6X81pUDifUNUnuYhkbxwjCJCb9m8wbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hx/I5Uxyx54XWN1O7MeDfbIiaH2FN7OkgoMsFcs8oHU=;
        b=fTtVQThSuXx9DF04UvWtTRTzSUSZQgOGPGaKhjHLMQSdmNVXeGHn6TgA3W/b7Vni+T
         FQcaQojcMfctXUQ5p97uotmKAi5QY2tz6IuSmmpq1rlkOeXrOdq3awh/+VL6m7PZFOKB
         nplp4C92y9XgulhtGyNaG/L5iMtaNFKsbqapizdHydha5wcgQVFPV2urkcE52gPU1DCX
         dZNJLuXbrIC8efN7MfrlaZ1aq/eSXrD9uTmhK1wmX82zX2GfH9ai29RHSXhJdtDhSC9K
         KX0kWuyMxg9LDJd1OK1ek6hBPrTAcoySJk7JIZon2ACEAlWmF7/Mdrjrebaxw5cQkJqG
         q8SA==
X-Gm-Message-State: AJcUukcDf2gvuIgzlhXGVgKXxXFVQuHysV6naL3idBZD9Jofl3Yeoqzq
        kR2oVFEa4A+LSGxzvzTzSPSyUvlvGuo=
X-Google-Smtp-Source: ALg8bN7A50MD6d+ZpXcUH9CZaFTMyhDrPbb2om7AQ5p1IPnQuHs7kvBoaqPtplZvP5axdUzPtSbmRQ==
X-Received: by 2002:a1f:a147:: with SMTP id k68mr31212vke.1.1548203300125;
        Tue, 22 Jan 2019 16:28:20 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id q193sm23803432vsd.0.2019.01.22.16.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:28:19 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id d21so141000uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:28:19 -0800 (PST)
X-Received: by 2002:ab0:5590:: with SMTP id v16mr34488uaa.132.1548203298731;
 Tue, 22 Jan 2019 16:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-11-bjorn.andersson@linaro.org>
In-Reply-To: <20190122055112.30943-11-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 16:28:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XuA0Sm0fXfaHtib7+rji1s3s_SmjHc6d_DbEQ1LROq+A@mail.gmail.com>
Message-ID: <CAD=FV=XuA0Sm0fXfaHtib7+rji1s3s_SmjHc6d_DbEQ1LROq+A@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> From: Sibi Sankar <sibis@codeaurora.org>
>
> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - Picked up Sibi's patch
> - Fixed reg to work with address/size-cells as 2
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 5cc2615461da..78df5f1bce2d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1617,6 +1617,64 @@
>                         clock-names = "xo";
>                 };
>
> +               mss_pil: remoteproc@4080000 {
> +                       compatible = "qcom,sdm845-mss-pil";
> +                       reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
> +                       reg-names = "qdsp6", "rmb";
> +
> +                       interrupts-extended =
> +                               <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack",
> +                                         "shutdown-ack";
> +
> +                       clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> +                                <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> +                                <&gcc GCC_BOOT_ROM_AHB_CLK>,
> +                                <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
> +                                <&gcc GCC_MSS_SNOC_AXI_CLK>,
> +                                <&gcc GCC_MSS_MFAB_AXIS_CLK>,
> +                                <&gcc GCC_PRNG_AHB_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "iface", "bus", "mem", "gpll0_mss",
> +                                     "snoc_axi", "mnoc_axi", "prng", "xo";
> +
> +                       qcom,smem-states = <&modem_smp2p_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
> +                                <&pdc_reset PDC_MODEM_SYNC_RESET>;
> +                       reset-names = "mss_restart", "pdc_reset";
> +
> +                       qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
> +                                       <&rpmhpd SDM845_CX>,
> +                                       <&rpmhpd SDM845_MX>,
> +                                       <&rpmhpd SDM845_MSS>;
> +                       power-domain-names = "load_state", "cx", "mx", "mss";
> +
> +                       mba {
> +                               memory-region = <&mba_region>;
> +                       };
> +
> +                       mpss {
> +                               memory-region = <&mpss_region>;
> +                       };
> +
> +                       glink-edge {
> +                               interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
> +                               label = "modem";
> +                               qcom,remote-pid = <1>;
> +                               mboxes = <&apss_shared 12>;
> +                       };
> +               };
> +
>                 sdhc_2: sdhci@8804000 {

Can you please sort by unit address now that you have a device tree
that has more stuff?

-Doug
