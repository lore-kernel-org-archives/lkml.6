Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D723C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1650C20862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dwXoBdTM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PUb76AGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1650C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeH2PUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:20:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH2PUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:20:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 690F760265; Wed, 29 Aug 2018 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535541819;
        bh=r79vgoWTCc/sRzXWAXFT8gFumJhInCWlKBcATlv6w7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dwXoBdTMu0oD1EkB9eEiT7iGcRFMyEXjrW5siLhe3Z4DiPD4QPgCQb7fLhgEYzk3i
         XTTR+y3FiA+QDmN08fnmwZBHMq6RAJ8Igi3cNJNjNRBI9y9ODidcylPSmXVxjJsVcL
         0mD6uHw/dTaRp6+K9WC0F6Hu1qyrqmr0nKxFsrp0=
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com [209.85.216.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17D3360385;
        Wed, 29 Aug 2018 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535541818;
        bh=r79vgoWTCc/sRzXWAXFT8gFumJhInCWlKBcATlv6w7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PUb76AGvft7Xi9Z118pXIByAacdOxfs1gZGWJHzeSI88Qdk1p2seLqUnRZr+Swzqv
         yFqeD/WhQH7ykWYVcttYfE+a07gGRhl5ORRIDfDxiiPhum5jSijqffUjQWXYSlh8as
         SRW1W3PVJLndQJXzFtYr+A0ZfCQG6XS/gCfWJdhM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17D3360385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f172.google.com with SMTP id j7-v6so5248700qtp.2;
        Wed, 29 Aug 2018 04:23:38 -0700 (PDT)
X-Gm-Message-State: APzg51CLz/6xVlzI5WGUqihpk980C/70xPGhY8rIkfpa5Xl/8TUZsyvF
        VCm6mVx8BOCkjW85fNhN9VVLVPwc7DgtKm/mIdE=
X-Google-Smtp-Source: ANB0VdYMfQgB/udt1DfZ5dRLKdHU/GbwyPLCobQQtNEsedXinVrVJMGhdlvny+b8pArUXkfIFUtUknm7KPeDtMrIqAQ=
X-Received: by 2002:ac8:4596:: with SMTP id l22-v6mr6319184qtn.184.1535541817264;
 Wed, 29 Aug 2018 04:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-5-vivek.gautam@codeaurora.org> <20180828203418.GA18366@bogus>
 <a1e31d1e-aaa4-5951-2261-3169033c636a@codeaurora.org>
In-Reply-To: <a1e31d1e-aaa4-5951-2261-3169033c636a@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 29 Aug 2018 16:53:25 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGHus-kZv+Zr5aiYRLct07NCFBL3k44bX=c4eW7J24kZg@mail.gmail.com>
Message-ID: <CAFp+6iGHus-kZv+Zr5aiYRLct07NCFBL3k44bX=c4eW7J24kZg@mail.gmail.com>
Subject: Re: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 2:05 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Rob,
>
>
> On 8/29/2018 2:04 AM, Rob Herring wrote:
> > On Mon, Aug 27, 2018 at 04:25:50PM +0530, Vivek Gautam wrote:
> >> Add bindings doc for Qcom's smmu-v2 implementation.
> >>
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>
> >> Changes since v14:
> >>   - This is a new patch added in v15 after noticing the new
> >>     checkpatch warning for separate dt-bindings doc.
> >>   - This patch also addresses comments given by Rob and Robin to add
> >>     a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
> >>     compatible string.
> >>
> >>   .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
> >>   1 file changed, 47 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >> index 8a6ffce12af5..52198a539606 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >> @@ -17,10 +17,24 @@ conditions.
> >>                           "arm,mmu-401"
> >>                           "arm,mmu-500"
> >>                           "cavium,smmu-v2"
> >> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
> > The v2 in the compatible string is kind of redundant unless the SoC has
> > other SMMU types.
>
> sdm845 has smmu-v2, and smmu-500 [1].
>
> >>
> >>                     depending on the particular implementation and/or the
> >>                     version of the architecture implemented.
> >>
> >> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> >> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> >> +                  string that should be present along with the "qcom,smmu-v2"
> >> +                  to facilitate SoC specific clocks/power connections and to
> >> +                  address specific bug fixes.
> >> +                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
> >> +                  following:
> >> +                  msm8996 - for msm8996 Qcom SoC.
> >> +                  sdm845 - for sdm845 Qcom Soc.
> > Rather than all this prose, it would be simpler to just add 2 lines with
> > the full compatibles rather than <soc>. The <soc> thing is not going to
> > work when/if we move bindings to json-schema also.
>
> then we keep adding
>           "qcom,msm8996-smmu-v2", "qcom,smmu-v2"
>           "qcom,msm8998-smmu-v2", "qcom,smmu-v2"
>           "qcom,sdm845-smmu-v2", "qcom,smmu-v2",
> and from [1]
>           "qcom,sdm845-smmu-500", "arm,mmu-500", etc.
> for each SoCs?

How about following diff on top of this patch?

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 52198a539606..5e6c04876533 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,23 +17,18 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
-                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
+                        "qcom,smmu-v2"

                   depending on the particular implementation and/or the
                   version of the architecture implemented.

-                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
-                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
-                  string that should be present along with the "qcom,smmu-v2"
-                  to facilitate SoC specific clocks/power connections and to
-                  address specific bug fixes.
-                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
-                  following:
-                  msm8996 - for msm8996 Qcom SoC.
-                  sdm845 - for sdm845 Qcom Soc.
-
-                  An example string would be -
-                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
+                  Qcom SoCs using qcom,smmu-v2 must have soc specific
+                  compatible string attached to "qcom,smmu-v2" to take care
+                  of SoC specific clocks/power connections and to address
+                  specific bug fixes.
+                  Precisely, it should be one of the following:
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
+                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".

Thanks!
Best regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
