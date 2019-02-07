Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A39EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38FE21916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3WLKB38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBGUUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:20:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53994 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfBGUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:20:01 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so3143975ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd6Vn44Ds9llNxhimEhOJ4Nz7VLPTCK8kFHEDz2iY3c=;
        b=I3WLKB38MvmcYZFvL1bune86uhxzTahX8TYjT+9RdeZu+GDzPWh6+T3eRnwHVfjFrI
         7zzqUUQ3cKfEfmpM/x0lK+yXSSOfoeTdsaxGQfEhMOjUpJl/aGqEqMoFvsmI9gYXMmei
         6kOma3TQzLysDj6A6uKFRlsDF6wJWgh7lIp4X7q+Q2oTZAZao8zXJ/pR8MamWcd8k1QQ
         WhfedisibXOdYXFV9ev/pN1HITSMDWJag+FU9r8qlU3BIFJcvP9TeQRiN568KLteb933
         /LHv74tSwt8d7prMZpmt1SZszfXWGYdNOY9xHeIH5KiHBZsXGCtNM3+K2PUnfbLo6lEI
         ZJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd6Vn44Ds9llNxhimEhOJ4Nz7VLPTCK8kFHEDz2iY3c=;
        b=p0EjUl8eRU6B6gaB1tHYud10T7NYHMP43La9tzUgB6lGU1FBhgA/h+Au0SHl3Af5Ft
         cypqhLaweh5suv79MhldOK8RUKPT6k/2oWbO3pbuD5aSgq72zRyUB9qyWufWCiAq0Kve
         /5GNz+C+tT2S1kV3wl/Va+KeryyzhTuMIU+q1Fi+MxWOHkhyOGIr71VliNjhaypyhORk
         L6Qnp6jMpe7z/cq1SSbdmeCzD3nMFiA54Cc2KpWRSVEvLszFOcUmcWDsL7DwM27gnrlo
         SSjvZTvN+9kPkvbyS98dokr99DND4pX8Iz19hYoC8EhhZp2qjrg1tThQyxP27NWHbMFl
         yxjg==
X-Gm-Message-State: AHQUAuZTL1XEm/H8IIZk6oo2Lc/BES+WtLISGap6HIV6+0u6IHFda7AR
        cEQkKmDZYxYPZSKI5EHtRel5iVkMaYi4GilEelN4zA==
X-Google-Smtp-Source: AHgI3IYoM6DUohbpI4dzh4n2mDHyJqLXGzUglERjrTYLpCNKj0O52KZ5VAJEUZGklwA/WH+zpZ/XdggsVOrLgEwu52w=
X-Received: by 2002:a5d:960e:: with SMTP id w14mr8729064iol.86.1549570800018;
 Thu, 07 Feb 2019 12:20:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org> <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Feb 2019 13:19:48 -0700
Message-ID: <CANLsYkyu=mPwJh2RzTYiZgfEV+MXgGpEvUKLwXgVdsvBf3nqqQ@mail.gmail.com>
Subject: Re: [PATCHv7 1/6] arm64: dts: qcom: sdm845: Add Coresight support
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

On Thu, 31 Jan 2019 at 17:53, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add coresight components found on Qualcomm SDM845 SoC.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> - Depends on AOSS QMP side channel patches by Bjorn Andersson [1] - [4].
> - AMBA bus pclk change [5].
> - Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>   and size cells for soc") [6].
>
> [1] https://lore.kernel.org/lkml/20190131003933.11436-5-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190131003933.11436-6-bjorn.andersson@linaro.org/
> [3] https://lore.kernel.org/lkml/20190131003933.11436-7-bjorn.andersson@linaro.org/
> [4] https://lore.kernel.org/lkml/20190131003933.11436-10-bjorn.andersson@linaro.org/
> [5] https://lore.kernel.org/lkml/20190131020141.28352-1-bjorn.andersson@linaro.org/
> [6] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 434 +++++++++++++++++++++++++++
>  1 file changed, 434 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e2aaaa233e45..4121aac6d086 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1349,6 +1349,440 @@
>                         };
>                 };
>
> +               stm@6002000 {
> +                       compatible = "arm,coresight-stm", "arm,primecell";
> +                       reg = <0 0x06002000 0 0x1000>,
> +                             <0 0x16280000 0 0x180000>;
> +                       reg-names = "stm-base", "stm-stimulus-base";
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       stm_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel0_in7>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6041000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x06041000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               funnel@6043000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x06043000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       funnel2_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in2>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@5 {
> +                                       reg = <5>;
> +                                       funnel2_in5: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6045000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x06045000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       merge_funnel_out: endpoint {
> +                                               remote-endpoint = <&etf_in>;
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
> +                               port@2 {
> +                                       reg = <2>;
> +                                       merge_funnel_in2: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel2_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               replicator@6046000 {
> +                       compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +                       reg = <0 0x06046000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +                       reg = <0 0x06047000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@1 {
> +                                       reg = <1>;
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
> +                       reg = <0 0x06048000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7040000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07040000 0 0x1000>;
> +
> +                       cpu = <&CPU0>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7140000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07140000 0 0x1000>;
> +
> +                       cpu = <&CPU1>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7240000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07240000 0 0x1000>;
> +
> +                       cpu = <&CPU2>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7340000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07340000 0 0x1000>;
> +
> +                       cpu = <&CPU3>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7440000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07440000 0 0x1000>;
> +
> +                       cpu = <&CPU4>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm4_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in4>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7540000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07540000 0 0x1000>;
> +
> +                       cpu = <&CPU5>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm5_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in5>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7640000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07640000 0 0x1000>;
> +
> +                       cpu = <&CPU6>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm6_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in6>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7740000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07740000 0 0x1000>;
> +
> +                       cpu = <&CPU7>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm7_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in7>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@7800000 { /* APSS Funnel */
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x07800000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               funnel@7810000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x07810000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       apss_merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel2_in5>;
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
>                 usb_1_hsphy: phy@88e2000 {
>                         compatible = "qcom,sdm845-qusb2-phy";
>                         reg = <0 0x088e2000 0 0x400>;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
