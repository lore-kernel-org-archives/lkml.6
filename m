Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B54C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201F12175A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201F12175A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeGCWgA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:36:00 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39763 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:35:58 -0400
Received: by mail-yb0-f195.google.com with SMTP id k127-v6so1348273ybk.6;
        Tue, 03 Jul 2018 15:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R1ySuh5OZkuaI1wPY3sXyQa5Ft6yJdbu/YK3TSu6Tkk=;
        b=oAYh0izJFctb63FRDP6p7Iw+hMUPyfpl4EsBs04RN4LLPgN9kGQx69QNOg2+VHHQOy
         vAEyV4ujS5EJj1Y8uq7TTibzsPBKiDWchbXtIjupBd3A5Rzf3t290u42RlBAhfKe+FDw
         z03bSEa3Hhl0Ltg3Zi1TbCAY8GIAJOa+liCSQbkn0x5vGnFbuxPMpjXrSGe1sv6/iqvd
         rvDlxp4PvUSAe7HjdakAywgPO/8AG/cICHs0GhYItEVh5r2SXNDV0eoDoXbgoz3yAsgG
         iRxVWVzAbpm7sbhVhHaQveIy/xtu398ukavFAnD3b2iuhdoRYuSAGoqG4qp9Hb5D7CP+
         T3zQ==
X-Gm-Message-State: APt69E2wG7qMZhFoHAIzFIVo2Gt9QBB1mChJQctZlSJZfaVaue/BI2bn
        qiEAaqdt4MOykAKyeF/dbg==
X-Google-Smtp-Source: ADUXVKIDLwETdIm9e/Klumxj13UXxMUuQTFAfpUTRiRR15WeapIsbOnypJ0mDUMpQAsBkHF1Cm4Uww==
X-Received: by 2002:a25:44d7:: with SMTP id r206-v6mr16143933yba.475.1530657358161;
        Tue, 03 Jul 2018 15:35:58 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m128-v6sm769168ywe.100.2018.07.03.15.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:35:57 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:35:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
Message-ID: <20180703223554.GA32313@rob-hp-laptop>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <20180627045234.27403-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627045234.27403-3-rnayak@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:22:30AM +0530, Rajendra Nayak wrote:
> Add DT bindings to describe the rpm/rpmh power domains found on Qualcomm
> Technologies, Inc. SoCs. These power domains communicate a performance
> state to RPM/RPMh, which then translates it into corresponding voltage on a
> PMIC rail.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 ++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        |  39 +++++
>  2 files changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> new file mode 100644
> index 000000000000..8825080afa5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -0,0 +1,146 @@
> +Qualcomm RPM/RPMh Power domains
> +
> +For RPM/RPMh Power domains, we communicate a performance state to RPM/RPMh
> +which then translates it into a corresponding voltage on a rail
> +
> +Required Properties:
> + - compatible: Should be one of the following
> +	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
> +	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
> + - power-domain-cells: number of cells in Power domain specifier
> +	must be 1.
> + - operating-points-v2: Phandle to the OPP table for the Power domain.
> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
> +
> +Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
> +various OPPs for different platforms as well as Power domain indexes
> +
> +Example: rpmh power domain controller and OPP table
> +
> +#include <dt-bindings/power/qcom-rpmhpd.h>
> +
> +qcom,level values specified in the OPP tables for RPMh power domains
> +should use the RPMH_REGULATOR_LEVEL_* constants from
> +<dt-bindings/power/qcom-rpmhpd.h>
> +
> +	rpmhpd: power-controller {
> +		compatible = "qcom,sdm845-rpmhpd";
> +		#power-domain-cells = <1>;
> +		operating-points-v2 = <&rpmhpd_opp_table>;
> +	};
> +
> +	rpmhpd_opp_table: opp-table {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		rpmhpd_opp_ret: opp1 {
> +			qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +		};

I don't see the point in using the OPP binding here when you aren't 
using *any* of the properties from it.

Rob
