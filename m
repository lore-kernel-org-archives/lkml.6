Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E24AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9B20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546540525;
	bh=/TZNA+Cxjt/uJHLZQZrJxY0WdLNvcJCICEh3JwD+1Yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FvGX5tpg/C37IQTDB9hckZhK2qhoQsbjqz+Ve74BfBgmTCDw2WZ/Khwx6f3GUryWx
	 6/K4XEKazNoUrNN5ebljK2hMoQGjaUXsAMabSH9C4gtmWnQ0/fVT4TMVZ3gI4ds811
	 jTUnU22YFof9JLmXa/tGkjkd08otjBESPUnOanaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfACSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfACSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:35:23 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E6921872;
        Thu,  3 Jan 2019 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546540522;
        bh=/TZNA+Cxjt/uJHLZQZrJxY0WdLNvcJCICEh3JwD+1Yc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yxmI1xwmQzup67vs1dS/qptVwTbxRKzm1mzShXjHrR92cE0beA1YPeE3WUSesFiIF
         qbb9YHaGuWAaIkZ69IZUWw0OM4apwSJ0eAeVIyKySoNmfVp2S6YykFl3TEWz9U7huD
         o3/yaVahfzUSoTnzQFD+zvI3QVkFLERUbAjKcRfM=
Received: by mail-qk1-f182.google.com with SMTP id c21so4247593qkl.6;
        Thu, 03 Jan 2019 10:35:21 -0800 (PST)
X-Gm-Message-State: AJcUukeD155PlaR3yCarBmdN1cUa1s4+3vt6Fir1QEoAl2mgCm9ykUSz
        zb0Go49WQBjIxY9MoiQ1t9e6joACo2m7v0ZmEA==
X-Google-Smtp-Source: ALg8bN5R9EIBHt4Q5iSvWTU5rZLZiAL4ewPGBLoWY6Co8z3743BcnYZ3ekexsMaD3c5u0ZegNVz8il3imneV1KGgwH4=
X-Received: by 2002:a37:5686:: with SMTP id k128mr42531465qkb.29.1546540521038;
 Thu, 03 Jan 2019 10:35:21 -0800 (PST)
MIME-Version: 1.0
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
 <20181227213353.GA8110@bogus> <BN7PR12MB2836C77E851E7AC4BCD38BF0C2B00@BN7PR12MB2836.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB2836C77E851E7AC4BCD38BF0C2B00@BN7PR12MB2836.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Jan 2019 12:35:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLWqhspMNPeqYvh-_ynej-KmwVW93OeQ3E7ic+XSDXngg@mail.gmail.com>
Message-ID: <CAL_JsqLWqhspMNPeqYvh-_ynej-KmwVW93OeQ3E7ic+XSDXngg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive
 strength config
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Preetham Chandru <pchandru@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 6:08 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Hi Rob,
>
> >> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> >> Tegra210 sdmmc which has pad configuration registers in the pinmux
> >> reigster domain.
> >
> > typo
> >
> >>
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> ---
> >>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6
> >> +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> index 32b4b4e41923..2cecdc71d94c 100644
> >> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> @@ -39,12 +39,16 @@ sdhci@c8000200 {
> >>      bus-width = <8>;
> >>  };
> >>
> >> -Optional properties for Tegra210 and Tegra186:
> >> +Optional properties for Tegra210, Tegra186 and Tegra194:
> >
> >Adding Tegra194, but this patch concerns Tegra210...
> Yes this is mainly part of Tegra210 Patch but pinctrls sdmmc-1v8 and sdmmc-3v3
> also applies for Tegra194 and since it was not mentioned, added Tegra194 as well.
> Does adding Tegra194 in this should come as separate patch?

Same patch is fine, just make the commit message match.

> >
> >>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> >>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> >>    for controllers supporting multiple voltage levels. The order of names
> >>    should correspond to the pin configuration states in pinctrl-0 and
> >>    pinctrl-1.
> >> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable
> >> +for
> >
> >These are in addition to the previous values?
> Yes these are additional pinctrl states for pad drive settings which are in pinmux
> Domain and are applicable during calibration process.

Maybe '-cal' instead of '-drv' since that's the mode they apply to.

Rob
