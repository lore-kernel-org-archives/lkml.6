Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3343D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jKeyJZma";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jKeyJZma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3343D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJRTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:33:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJRTd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:33:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB6D360B73; Thu, 18 Oct 2018 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539862400;
        bh=0L6EddOgErezuqYWi4CHAbqZF7HbZ4bqbEi5ow9Nehw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jKeyJZmaAhTmfjCdOp6AJQp1PtipjY/Ltu+oT5jYvkGOWYjlMcmoXuqUh8Em8bV1c
         erQ0vrc5KzX97YCJJy90tONF1glrA8+bbMpuQEUDuIBtnjtcB+RGkcm9x1PsUA5CDT
         I4GIs3dpP1GplgqUpPzJ7UhmV7y+wVcF9gqwzRYE=
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 026F5606DC;
        Thu, 18 Oct 2018 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539862400;
        bh=0L6EddOgErezuqYWi4CHAbqZF7HbZ4bqbEi5ow9Nehw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jKeyJZmaAhTmfjCdOp6AJQp1PtipjY/Ltu+oT5jYvkGOWYjlMcmoXuqUh8Em8bV1c
         erQ0vrc5KzX97YCJJy90tONF1glrA8+bbMpuQEUDuIBtnjtcB+RGkcm9x1PsUA5CDT
         I4GIs3dpP1GplgqUpPzJ7UhmV7y+wVcF9gqwzRYE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 026F5606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f172.google.com with SMTP id q5-v6so18496575qki.6;
        Thu, 18 Oct 2018 04:33:19 -0700 (PDT)
X-Gm-Message-State: ABuFfoiZfBaCy+jEGLeWkWz0a8AJJtPtREPpCfKxSzkjhivrSFOBSZul
        IVO7+4JjV+xZEeVRi7/uE7vj6Qo8S06X8IHA9B8=
X-Google-Smtp-Source: ACcGV62AJW4uAV2uhiEph7H5790lOYLB58GWZentmTnwDMcM43OQtMrgEQbBIqpsyKQlMlQ5RufTHJCUmyxZW2hIWs0=
X-Received: by 2002:a37:5003:: with SMTP id e3-v6mr2184308qkb.102.1539862399238;
 Thu, 18 Oct 2018 04:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181017172312.194281-1-evgreen@chromium.org> <20181017172312.194281-2-evgreen@chromium.org>
In-Reply-To: <20181017172312.194281-2-evgreen@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 18 Oct 2018 17:03:06 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHRECKosJWQZoaZa6QxAmW0MZLNPsFAbD21vW+kG0xJ-A@mail.gmail.com>
Message-ID: <CAFp+6iHRECKosJWQZoaZa6QxAmW0MZLNPsFAbD21vW+kG0xJ-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: add UFS controller
To:     evgreen@chromium.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, swboyd@chromium.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On Wed, Oct 17, 2018 at 10:55 PM Evan Green <evgreen@chromium.org> wrote:
>
> This change adds the UFS controller and PHY to SDM845.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 66 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..20b2c258816a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -808,6 +808,72 @@
>                         };
>                 };
>
> +               ufshc1: ufshc@1d84000 {
> +                       compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
> +                                    "jedec,ufs-2.0";
> +                       reg = <0x1d84000 0x2500>;
> +                       interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +                       phys = <&ufsphy1_lanes>;
> +                       phy-names = "ufsphy";
> +                       lanes-per-direction = <2>;
> +                       power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +                       clock-names =
> +                               "core_clk",
> +                               "bus_aggr_clk",
> +                               "iface_clk",
> +                               "core_clk_unipro",
> +                               "ref_clk",
> +                               "tx_lane0_sync_clk",
> +                               "rx_lane0_sync_clk",
> +                               "rx_lane1_sync_clk";
> +                       clocks =
> +                               <&gcc GCC_UFS_PHY_AXI_CLK>,
> +                               <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +                               <&gcc GCC_UFS_PHY_AHB_CLK>,
> +                               <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +                               <&rpmhcc RPMH_CXO_CLK>,
> +                               <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +                               <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +                               <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +                       freq-table-hz =
> +                               <50000000 200000000>,
> +                               <0 0>,
> +                               <0 0>,
> +                               <37500000 150000000>,
> +                               <0 0>,
> +                               <0 0>,
> +                               <0 0>,
> +                               <0 0>;
> +
> +                       resets = <&gcc GCC_UFS_PHY_BCR>;
> +                       reset-names = "rst";
> +
> +                       status = "disabled";
> +               };
> +
> +               ufsphy1: ufsphy@1d87000 {

nit: s/ufsphy@1d87000/phy@1d87000

> +                       compatible = "qcom,sdm845-qmp-ufs-phy";
> +                       reg = <0x1d87000 0x18c>;
> +                       #clock-cells = <1>;

why do we need this clock-cells? ufsphy i think is not providing any
clocks. Is it?
Rest looks good.

Best regards
Vivek

> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clock-names = "ref",
> +                                     "ref_aux";
> +                       clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> +                                <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +
> +                       status = "disabled";
> +
> +                       ufsphy1_lanes: lanes@1d87400 {
> +                               reg = <0x1d87400 0x108>,
> +                                     <0x1d87600 0x1e0>,
> +                                     <0x1d87c00 0x1dc>;
> +                               #phy-cells = <0>;
> +                       };
> +               };
> +
>                 tcsr_mutex_regs: syscon@1f40000 {
>                         compatible = "syscon";
>                         reg = <0x1f40000 0x40000>;
> --
> 2.16.4
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
