Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7288ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5863620671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnQQ+Ofx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5863620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGSXyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbeGSXyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:54:01 -0400
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com [209.85.223.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD42320671;
        Thu, 19 Jul 2018 23:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532041723;
        bh=1jYA+7LuWic4wrArOJNYs7tXPb3ZEQyp6DinUWYU0C8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OnQQ+Ofx4Dr6Tc43CoqIFCAD5yK07uqTxug+EFlIBK0NjU1lQYrQx5puAH1EzFKnx
         FDcYcypFcDxcnIaHzTpZmpADh3Suz/MTlB7mylYvtVCf78tTIzogOFNTMYT1R6zE6K
         pALzJoyAhYMY90NE7lsijXstNcPZmz3i/nR5QGHs=
Received: by mail-io0-f176.google.com with SMTP id l25-v6so8460678ioh.12;
        Thu, 19 Jul 2018 16:08:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlEkYJe66hvC9jWQa+eqIPyC0RiELAGSuBVTrf3hfiWUTCAJDEIi
        mOXtr0EJlTeG4yBa/K8sK0VCCNhV29UxVRA/qQ==
X-Google-Smtp-Source: AA+uWPw5VeMAZRhSRuaIOBJ9u9P0tgZX6r5okhXoBsA9PRl3IF9rr/t2/SdaZp3Cr4WgkgUnXcMQaUVhBz+c+uFwcb0=
X-Received: by 2002:a6b:c693:: with SMTP id w141-v6mr10071141iof.79.1532041722371;
 Thu, 19 Jul 2018 16:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org> <20180719175356.14753-2-vivek.gautam@codeaurora.org>
In-Reply-To: <20180719175356.14753-2-vivek.gautam@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Jul 2018 17:08:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
Message-ID: <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sricharan <sricharan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:54 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Add device node for arm,mmu-500 available on sdm845.
> This MMU-500 with single TCU and multiple TBU architecture
> is shared among all the peripherals except gpu on sdm845.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 6d651f314193..13b50dff440f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -58,3 +58,7 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&apps_smmu {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 00722b533a92..70ca18ae6cb3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -980,6 +980,79 @@
>                         cell-index = <0>;
>                 };
>
> +               apps_smmu: arm,smmu@15000000 {

iommu@...

> +                       compatible = "arm,mmu-500";

Really unmodified by QCom? Would be better to have SoC specific compatible.

Rob
