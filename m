Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE47C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E362082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zYE4+uDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E362082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJBAPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeJBAPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:15:15 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A125321476;
        Mon,  1 Oct 2018 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538415383;
        bh=MvrhLc7wACbzdQ0HyvEfh+Q4uODZP/Sa/Hz9E2Jyp+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zYE4+uDa3+GWqFrivcPoDkwAiq3mSNVNY4oLrkt1l/HczKkhNUDDPuc4FXaxwEaV8
         HJo1k4/gELgvwjnyDWC6u8R2pnthYcrNA6iPvXGLUDmC7WJgBATShbUREuAcb8IkKR
         PAzTa8fSYyBKsE39adSATNvMZ3x5xcdTfl9mNN6w=
Received: by mail-qk1-f179.google.com with SMTP id q12-v6so8599402qkl.13;
        Mon, 01 Oct 2018 10:36:23 -0700 (PDT)
X-Gm-Message-State: ABuFfohocoRNpxPB/BZ2ofmSaTwujBStPRi1bZqZDWPmbs7olOK+n/HS
        WiTRNPChdiYh56BSW2egNAi5tLLXNqEb1SjUTQ==
X-Google-Smtp-Source: ACcGV62ixXGyF8N9W3rgDQU+4hFHArJNZ8U0VCEBW/0Y8jYdXHwRnO5XV+92STiD22Snjjpk6E/xEnvktYE8whTwQj0=
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr8830136qku.184.1538415382819;
 Mon, 01 Oct 2018 10:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org> <20181001121857.GA31488@arm.com>
In-Reply-To: <20181001121857.GA31488@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Oct 2018 12:36:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg@mail.gmail.com>
Message-ID: <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg@mail.gmail.com>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
To:     Will Deacon <will.deacon@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sricharan <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 7:18 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Aug 30, 2018 at 08:15:40PM +0530, Vivek Gautam wrote:
> > Add bindings doc for Qcom's smmu-v2 implementation.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
>
> It would be nice to have an Ack from a DT maintainer on this, since it's
> adding new compatible strings...

I did...

Rob
