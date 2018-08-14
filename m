Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07378C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B939020837
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B939020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeHOBrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:47:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54051 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732120AbeHOBrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:47:16 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so20825338itw.3;
        Tue, 14 Aug 2018 15:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCj2eBkXhbQ4eupu1ycrv5oErVjXU95mjR7H51Qe2hU=;
        b=M8prO+jBvcRZshviDTuqsiLwz1qOu2vHE4yFwVwHyiFfTM/9R/NDS42kCYwKMZH1RY
         lQLM2ItKiI+TikI8e43J24w4PjOnfUnM+I5QciFxm/zjKdFPjXCZTEIdtBiyBgxffZ8l
         IwJsUvOWh8qfusOrqHqCF/mJf2kZqZc6pRQM93nXwBM0C4guWVF78ceXPwhdqTKRtc2G
         o5sly2D5ZmX9G52kcTAvzH/urjukAoL/J+cz1mQ42z7drGW3uKlkEziLvXyAGKDL8tOV
         vexQ+XkM26lqfvU/xN078SstTOWrWwskJjP9SBQMOngitd0lQZ8ml9gY2OCnCuGWAAzz
         vvfg==
X-Gm-Message-State: AOUpUlFjbHjbXSwwivc0ZgghJTTkL9osyMg93JSBvt3GYl5uIekUgN/K
        nm2McmePbGC0K/b7p6hkgA==
X-Google-Smtp-Source: AA+uWPx9EaCQzHemRouIdvTO/mOZP4vrIfYCAclvmV2xYasgg71XeHrRITDt1KujrqVa6ctXgl6mhQ==
X-Received: by 2002:a24:4511:: with SMTP id y17-v6mr17075071ita.67.1534287472931;
        Tue, 14 Aug 2018 15:57:52 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u68-v6sm229379ita.36.2018.08.14.15.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 15:57:52 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:57:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Gross <andy.gross@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
Message-ID: <20180814225750.GA31263@rob-hp-laptop>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
 <20180814102740.30222-4-vivek.gautam@codeaurora.org>
 <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
 <CAFp+6iG8HohQ5=gwL37OuykK+R4U407yfrp=WN6pSgOK-mdzzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iG8HohQ5=gwL37OuykK+R4U407yfrp=WN6pSgOK-mdzzA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 01:09:43AM +0530, Vivek Gautam wrote:
> Adding Jordan here.
> 
> On Tue, Aug 14, 2018 at 4:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> > Hi Vivek,
> >
> > On 14/08/18 11:27, Vivek Gautam wrote:
> >>
> >> Add device node for qcom,smmu-v2 available on sdm845.
> >> This smmu is available only to GPU device.
> >>
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
> >>   1 file changed, 23 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> index 1c2be2082f33..bd1ec5fa5146 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> @@ -6,6 +6,7 @@
> >>    */
> >>     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> >> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
> >>   #include <dt-bindings/clock/qcom,rpmh.h>
> >>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >> @@ -989,6 +990,28 @@
> >>                         cell-index = <0>;
> >>                 };
> >>   +             gpu_smmu: iommu@5040000 {
> >> +                       compatible = "qcom,sdm845-smmu-v2",
> >> "qcom,smmu-v2";
> >
> >
> > Which of "sdm845" or "msm8996"[1] is the actual SoC name here?
> 
> Well, the bindings use the SoC prefix with smmu-v2, so it should be
> sdm845 for this SoC. This is same as I posted in my v1 of the series [2].
> Using 8996 based string in sdm845 makes things look awful.

You need to list valid values of '<soc>' in the binding. Otherwise we 
get this confusion.

Rob
