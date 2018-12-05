Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C074C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E687A20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544026084;
	bh=/UF/MxvG92TnyDRm5hcG3+fOPtnFWrk4VZx+jrKEyM0=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=02URezT+JCBSrQPQ665UElVGMq/xiMJ2Ffo2Hgy+ZaeFfEo+7CZb1ZjgNipZ2fwIi
	 jMGq5ru17uch3R2pmlOUgHXVtOT2gurnrNtBwLdQUC/FjBqBRoGZdtMcLEpfPZEKsV
	 HlzDMcrXdj6J8kfWBb0vVyE0q5S0xlofAEFwOfiE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E687A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeLEQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:08:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeLEQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:08:02 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6BE2084C;
        Wed,  5 Dec 2018 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544026081;
        bh=/UF/MxvG92TnyDRm5hcG3+fOPtnFWrk4VZx+jrKEyM0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=XksMBmHlS6sPDomWwXj6+pM+Y681CsdvtgXywZx1Baas4NmgDQH1QtpWiUycPYv00
         q6+Jsvnu/m/P7tBV4HgdH4bXSgkYA+4GcWMmgCRHDx9RZBdkGtq5IQ/B0ucera57OC
         /OzR4YywFNHaCSg/L9OhClrxAvIdeVT9RqUuk1fk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
Cc:     k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
 <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
 <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
Message-ID: <154402608077.88331.684195407604647728@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Date:   Wed, 05 Dec 2018 08:08:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sylwester Nawrocki (2018-12-05 02:57:32)
> On 12/4/18 19:40, Stephen Boyd wrote:
> > Quoting Kamil Konieczny (2018-12-04 08:52:48)
> >> +
> >> +static const unsigned long imem_clk_regs[] __initconst =3D {
> >> +       ENABLE_ACLK_IMEM,
> >> +       ENABLE_ACLK_IMEM_INT_MEM,
> >> +       ENABLE_ACLK_IMEM_SSS,
> >> +       ENABLE_ACLK_IMEM_SLIMSSS,
> >> +       ENABLE_ACLK_IMEM_RTIC,
> >> +       ENABLE_ACLK_IMEM_SMMU_SSS,
> >> +       ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
> >> +       ENABLE_ACLK_IMEM_SMMU_RTIC,
> >> +       ENABLE_ACLK_IMEM_ARBG_TX,
> >> +       ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
> >> +       ENABLE_PCLK_IMEM,
> >> +       ENABLE_PCLK_IMEM_SSS,
> >> +       ENABLE_PCLK_IMEM_SLIMSSS,
> >> +       ENABLE_PCLK_IMEM_RTIC,
> >> +       ENABLE_PCLK_IMEM_SMMU_SSS,
> >> +       ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
> >> +       ENABLE_PCLK_IMEM_SMMU_RTIC,
> >> +       ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
> >> +};
> >> +
> >> +static const struct samsung_gate_clock imem_gate_clks[] __initconst =
=3D {
> >> +       /* ENABLE_ACLK_IMEM */
> >> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_=
200",
> >> +                       ENABLE_ACLK_IMEM, 24, 0, 0),
> =

> I don't think that clock will ever need to be disabled/enabled, so I would
> drop this definition. The clock will remain in its default state after re=
set
> (enabled).
> =

> >> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
> >> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
> > =

> > Why is there so much use of CLK_IGNORE_UNUSED in this file?
> =

> I suppose CLK_IGNORE_UNUSED is needed because there is no drivers that
> would enable required clocks. For some clocks the flag could probably
> indeed just be omitted, e.g. SLIMSSS clocks. =

> =

> I'm inclined to just define clocks that we are confident about and which
> are needed now. i.e. the SSS IP block clocks. So in include/dt-bindings/
> clock/exynos5433.h we would have something like:

Agreed, it doesn't make much sense to add clk support for clks that
you'll never need to modify one way or the other.

>  =

> +/* CMU_IMEM */
> +#define CLK_ACLK_SSS                   1
> +#define CLK_PCLK_SSS                   40
> =

> +#define IMEM_NR_CLK                    41
> =

> The other clocks could be added later as needed by someone who has =

> detailed knowledge about respective peripheral blocks.
> =


The slow addition of new clks to the binding header file makes for an
integration problem, so can we try to expose any clks that we know about
now as defines and make them not work if the driver isn't implementing
support for those clks? That way the binding is not changing but the
implementation can decide to support or not support certain clks.

