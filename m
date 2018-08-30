Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ADC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F8320661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnGZzrzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F8320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeH3EnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeH3EnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:43:11 -0400
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com [209.85.220.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907B120671;
        Thu, 30 Aug 2018 00:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535589822;
        bh=QV1qUjLTkIbnCZc7KpgPp9Y1RE8naddxILOO5lwIOPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NnGZzrzH2F6/VtO4NIRJAGAhxw/x8rEFmdeVgpd0cZh1DUiQdkBO46Hwr7J9z/j0s
         ocnVhbvkS32/MuYugsE6+toztR8Rocs+OEOBSbNKrSVvnriDw/TX/eo7UevSl2zowC
         r0BHkAScle7vzmypyEquYDxc/RLhDCaNrCJe/NhU=
Received: by mail-qk0-f173.google.com with SMTP id g13-v6so4672918qki.9;
        Wed, 29 Aug 2018 17:43:42 -0700 (PDT)
X-Gm-Message-State: APzg51B+CivQoSpvfTwFB+ynQ4/ciCND5TkLhOXMU4a0sUtd+eOI6Rra
        rH10vMmnpVG22K3iffUn6XeWhRlBfBzby2m2hw==
X-Google-Smtp-Source: ANB0VdaeQOaXrH82+h4wP20ODQ2PH8+xxeMcyFYDgLT+CTskdNdBUDEgKyYJA3iXpjZLpS2fvvBQb7aByjCRk1C0YGw=
X-Received: by 2002:a37:f19:: with SMTP id z25-v6mr8985597qkg.147.1535589821768;
 Wed, 29 Aug 2018 17:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-5-vivek.gautam@codeaurora.org> <20180828203418.GA18366@bogus>
 <a1e31d1e-aaa4-5951-2261-3169033c636a@codeaurora.org> <CAFp+6iGHus-kZv+Zr5aiYRLct07NCFBL3k44bX=c4eW7J24kZg@mail.gmail.com>
In-Reply-To: <CAFp+6iGHus-kZv+Zr5aiYRLct07NCFBL3k44bX=c4eW7J24kZg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Aug 2018 19:43:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKGHC9wCy583CTvAz8-A_M6zyrAX69yN5RUjv7Kbs1wFQ@mail.gmail.com>
Message-ID: <CAL_JsqKGHC9wCy583CTvAz8-A_M6zyrAX69yN5RUjv7Kbs1wFQ@mail.gmail.com>
Subject: Re: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alex.williamson@redhat.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 6:23 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> On Wed, Aug 29, 2018 at 2:05 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > Hi Rob,
> >
> >
> > On 8/29/2018 2:04 AM, Rob Herring wrote:
> > > On Mon, Aug 27, 2018 at 04:25:50PM +0530, Vivek Gautam wrote:
> > >> Add bindings doc for Qcom's smmu-v2 implementation.
> > >>
> > >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > >> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > >> ---
> > >>
> > >> Changes since v14:
> > >>   - This is a new patch added in v15 after noticing the new
> > >>     checkpatch warning for separate dt-bindings doc.
> > >>   - This patch also addresses comments given by Rob and Robin to add
> > >>     a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
> > >>     compatible string.
> > >>
> > >>   .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
> > >>   1 file changed, 47 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > >> index 8a6ffce12af5..52198a539606 100644
> > >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > >> @@ -17,10 +17,24 @@ conditions.
> > >>                           "arm,mmu-401"
> > >>                           "arm,mmu-500"
> > >>                           "cavium,smmu-v2"
> > >> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
> > > The v2 in the compatible string is kind of redundant unless the SoC has
> > > other SMMU types.
> >
> > sdm845 has smmu-v2, and smmu-500 [1].
> >
> > >>
> > >>                     depending on the particular implementation and/or the
> > >>                     version of the architecture implemented.
> > >>
> > >> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> > >> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> > >> +                  string that should be present along with the "qcom,smmu-v2"
> > >> +                  to facilitate SoC specific clocks/power connections and to
> > >> +                  address specific bug fixes.
> > >> +                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
> > >> +                  following:
> > >> +                  msm8996 - for msm8996 Qcom SoC.
> > >> +                  sdm845 - for sdm845 Qcom Soc.
> > > Rather than all this prose, it would be simpler to just add 2 lines with
> > > the full compatibles rather than <soc>. The <soc> thing is not going to
> > > work when/if we move bindings to json-schema also.
> >
> > then we keep adding
> >           "qcom,msm8996-smmu-v2", "qcom,smmu-v2"
> >           "qcom,msm8998-smmu-v2", "qcom,smmu-v2"
> >           "qcom,sdm845-smmu-v2", "qcom,smmu-v2",
> > and from [1]
> >           "qcom,sdm845-smmu-500", "arm,mmu-500", etc.
> > for each SoCs?
>
> How about following diff on top of this patch?
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 52198a539606..5e6c04876533 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,23 +17,18 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> -                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
> +                        "qcom,smmu-v2"
>
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
>
> -                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> -                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> -                  string that should be present along with the "qcom,smmu-v2"
> -                  to facilitate SoC specific clocks/power connections and to
> -                  address specific bug fixes.
> -                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
> -                  following:
> -                  msm8996 - for msm8996 Qcom SoC.
> -                  sdm845 - for sdm845 Qcom Soc.
> -
> -                  An example string would be -
> -                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
> +                  Qcom SoCs using qcom,smmu-v2 must have soc specific
> +                  compatible string attached to "qcom,smmu-v2" to take care
> +                  of SoC specific clocks/power connections and to address
> +                  specific bug fixes.
> +                  Precisely, it should be one of the following:
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
> +                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".

We don't need an explanation of why we need specific compatibles in
each binding document (though maybe we need a better explanation
somewhere). We just need to know what are valid values for compatibles
and this includes any combinations. Generally, this is just a list of
combinations.

The Renesas folks have figured out how to do this and they have lots
of SoCs. Yes, it makes for a lot of patches, but they are all mostly 1
liners and are dead simple to review. With QCom, I'm tired of having
the same damn discussion with every new binding.

Rob
