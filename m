Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8355EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB121721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOCiZF7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfBGUUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:20:45 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39237 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:20:44 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so3118941itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWzwCKldWlDuITTwMKAcHQgrlKV0RwGXY1y6DlMqVYc=;
        b=XOCiZF7xJp01MIe3SOcVn3LKlEANd4CgDVy2wJMARJAwHCPM68qCpBkBVKtwSupN+J
         9BejkhK7882IEyaUXzPx7hEmRF8OAK8CiMQX+7ydT/bPkr0vh+8aQRqIbEquJXSsM4zo
         1mmYCc++HL9GOBxW9eoGZlBg3leMG/jRp3LP17r+JwSbxcXSzCN/o2UznZK6QRiBQlFv
         HWbVveeEaYQlhFSRPFxbKiv4euujbpAjjIeC5hKmX7+KGw0HeR/ZE6JPezBNdOV7XOsY
         kkkKN4nPj2P4eVwf1Py9RAHsoQ4HIShB505kLd8ASEdFhDFN29EfwebsCdyhilsz3ncC
         u9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWzwCKldWlDuITTwMKAcHQgrlKV0RwGXY1y6DlMqVYc=;
        b=G6OzFPGllWawUSzT/xQiUsDhDqz65YR0j3gAsxD9MKgGAn33vx+Ur44zSQXehXAjH7
         2kvL/MjbSCMo8CtrdWO7ugcwquvBinxp53DoTAWscf2IeHa1jtXhH1fJ9Fp2i8p7qfbc
         exNek0swyCC3H9deWCZZuUP+c3TP9qw0Mg/ciEns5dCa8IeIaMyZbBGii2b4vzz5dAIY
         JC6KUBjI7yS6SASJBspNR0036cL73YGUCryMII0purkUYpa2YIIGn5/UdshPtE6Pnzcg
         W+5DKYlG3d4fv3WQyJSGSnQVmqZWngsHNwkaoKHzDe1TPPoH3Vl35NXHZ78LqLpFMnoN
         WfjQ==
X-Gm-Message-State: AHQUAubaT75Lbpu8GwXOrR9mx1yhq4G9FNtzFrTgJq5P50TQox6bEW7l
        ZR2bxqorUXGoXrCQYyjjf73KvpOXpf6m0BzVT8aVqQ==
X-Google-Smtp-Source: AHgI3IZ2u/S5LEE6Ry5w1eOwwLQC/nk2IyU9DvfSvOEjESn5FRiPx+07Dfwce4nL4uTXafwoj6WAcMsEWKJPGt2Ieug=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6795769itg.137.1549570843200;
 Thu, 07 Feb 2019 12:20:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org> <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Feb 2019 13:20:32 -0700
Message-ID: <CANLsYkwc_HQf=ghP7La7szKuPwVmdzjcr-91Z70hmzEGAEC+_A@mail.gmail.com>
Subject: Re: [PATCHv7 2/6] arm64: dts: qcom: msm8998: Add Coresight support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Enable coresight support by adding device nodes for the
> available source, sinks and channel blocks on MSM8998.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> This depends on MSM8998 rpm clocks and rpmcc node by Jeffrey Hugo
> and Marc Gonzalez [1][2][3].
>
> [1] https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
> [2] https://lore.kernel.org/lkml/1548866144-30265-1-git-send-email-jhugo@codeaurora.org/
> [3] https://lore.kernel.org/lkml/6da00186-e7c9-c93d-a80a-65eda2516451@free.fr/
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 435 ++++++++++++++++++++++++++
>  1 file changed, 435 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index eb691be6e171..3020a76ed201 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -566,6 +566,441 @@
>                         #interrupt-cells = <0x2>;
>                 };
>
> +               stm@6002000 {
> +                       compatible = "arm,coresight-stm", "arm,primecell";
> +                       reg = <0x06002000 0x1000>,
> +                             <0x16280000 0x180000>;
> +                       reg-names = "stm-base", "stm-data-base";
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       stm_out: endpoint {
> +                                               remote-endpoint = <&funnel0_in7>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6041000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x06041000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       funnel0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@7 {
> +                                       reg = <7>;
> +                                       funnel0_in7: endpoint {
> +                                               remote-endpoint = <&stm_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6042000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x06042000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       funnel1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@6 {
> +                                       reg = <6>;
> +                                       funnel1_in6: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6045000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x06045000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etf_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       merge_funnel_in0: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       merge_funnel_in1: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel1_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               replicator@6046000 {
> +                       compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +                       reg = <0x06046000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       replicator_out: endpoint {
> +                                               remote-endpoint = <&etr_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               port {
> +                                       replicator_in: endpoint {
> +                                               remote-endpoint = <&etf_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etf@6047000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0x06047000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       etf_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               port {
> +                                       etf_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etr@6048000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0x06048000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +                       arm,scatter-gather;
> +
> +                       in-ports {
> +                               port {
> +                                       etr_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7840000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07840000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU0>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7940000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07940000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU1>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7a40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07a40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU2>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm2_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in2>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7b40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07b40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU3>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm3_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in3>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@7b60000 { /* APSS Funnel */
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07b60000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       apss_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       apss_funnel_in0: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       apss_funnel_in1: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm1_out>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +                                       apss_funnel_in2: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm2_out>;
> +                                       };
> +                               };
> +
> +                               port@3 {
> +                                       reg = <3>;
> +                                       apss_funnel_in3: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm3_out>;
> +                                       };
> +                               };
> +
> +                               port@4 {
> +                                       reg = <4>;
> +                                       apss_funnel_in4: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm4_out>;
> +                                       };
> +                               };
> +
> +                               port@5 {
> +                                       reg = <5>;
> +                                       apss_funnel_in5: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm5_out>;
> +                                       };
> +                               };
> +
> +                               port@6 {
> +                                       reg = <6>;
> +                                       apss_funnel_in6: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm6_out>;
> +                                       };
> +                               };
> +
> +                               port@7 {
> +                                       reg = <7>;
> +                                       apss_funnel_in7: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm7_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@7b70000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x07b70000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       apss_merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel1_in6>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               port {
> +                                       apss_merge_funnel_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7c40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07c40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU4>;
> +
> +                       port{
> +                               etm4_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in4>;
> +                               };
> +                       };
> +               };
> +
> +               etm@7d40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07d40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU5>;
> +
> +                       port{
> +                               etm5_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in5>;
> +                               };
> +                       };
> +               };
> +
> +               etm@7e40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07e40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU6>;
> +
> +                       port{
> +                               etm6_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in6>;
> +                               };
> +                       };
> +               };
> +
> +               etm@7f40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07f40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU7>;
> +
> +                       port{
> +                               etm7_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in7>;
> +                               };
> +                       };
> +               };
> +
>                 spmi_bus: spmi@800f000 {
>                         compatible = "qcom,spmi-pmic-arb";
>                         reg =   <0x800f000 0x1000>,
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
