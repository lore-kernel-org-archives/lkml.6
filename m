Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E622081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ayvsku85";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bey6UonG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E622081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2UtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:49:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2UtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:49:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96693602FE; Thu, 29 Nov 2018 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543484674;
        bh=2Z67Oez4a1sW8edCo4xL8GjcSbXbhT8kyUeOcCOSuPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ayvsku85RluZUcRMAUGhnlOLRPSO/h4bPiduV49Q8r19oaOJWdQ9yJPUzsXjB+wKv
         DFCALuZRhWm0GqF59BVnhp5hZVRpxIUjdo/TxCq85bPO7rypOpYPBU6gUS1KZ6HSd3
         0g5VCleut9iE6nMEdaQm4NkGMkI8sF0d9L1MwFk4=
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6E58602FE;
        Thu, 29 Nov 2018 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543484673;
        bh=2Z67Oez4a1sW8edCo4xL8GjcSbXbhT8kyUeOcCOSuPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bey6UonGKEw46VBVLbDo+2AxiTy+xvxTvZinYB+6FB1YA7WQDC0qHV7OgWeksaTkQ
         35qZDs2QzTV4IAFnXnMFKw8ZI+7pfNF6m6qpBxmIuxlEn6C3IxB5/+Qqt8mBy8vAGu
         BaYxvhOAwfmLa0yJqhcvZ35Vw6lMyNCagweD/6sE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6E58602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f181.google.com with SMTP id k12so1229201qtf.7;
        Thu, 29 Nov 2018 01:44:33 -0800 (PST)
X-Gm-Message-State: AA+aEWbFHzlCQt1JFxunMuucU9fuNEXYGsgOMbJxQyNyP/BmXdvge6qn
        haIoMch45qZQTA9Ybi8begPW9lW05er62I39xTM=
X-Google-Smtp-Source: AFSGD/X8BEjJz5EyFhZxs2AJI2uXCa0DK032Lf8MicGOWdDiJKFBV7AjAUj98Ul/I/p2x/oIxnea1q64NfZlnmi0X/s=
X-Received: by 2002:ac8:3e1a:: with SMTP id z26mr674044qtf.180.1543484673043;
 Thu, 29 Nov 2018 01:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
 <20181128073940.GA13072@infradead.org> <CAF6AEGuM-R0=KRSmT+bt6SBaZg_ea3A_YFE+xfR_oCH9d9uORA@mail.gmail.com>
In-Reply-To: <CAF6AEGuM-R0=KRSmT+bt6SBaZg_ea3A_YFE+xfR_oCH9d9uORA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 29 Nov 2018 15:14:21 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFDanGLoWf95CR2Etq76tC8+dpciOcJzou4QfAUO3WRQA@mail.gmail.com>
Message-ID: <CAFp+6iFDanGLoWf95CR2Etq76tC8+dpciOcJzou4QfAUO3WRQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Rob Clark <robdclark@gmail.com>
Cc:     hch@infradead.org, David Airlie <airlied@linux.ie>,
        Tomasz Figa <tfiga@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:09 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 2:39 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +             /*
> > > +              * dma_sync_sg_*() flush the physical pages, so point
> > > +              * sg->dma_address to the physical ones for the right behavior.
> > > +              */
> > > +             for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> > > +                     sg_dma_address(s) = sg_phys(s);
> > > +
> >
> > I'm sorry, but this is completely bogus and not acceptable.
> >
> > The only place that is allowed to initialize sg_dma_address is
> > dma_map_sg.  If the default dma ops don't work for your setup we have
> > major a problem and need to fix the dma api / iommu integration instead
> > of hacking around it.
>
> I agree that the dma/iommu integration is very problematic for drm (in
> particular, gpu drivers that use the iommu as an gpu mmu)..  Really we
> need a way that a driver can opt-out of this, and access the cpu cache
> APIs directly, skipping the dma API entirely.  But as it is, we've had
> to hack around the dma API.  I'm not really sure this hack is any
> worse than abusing dma_(un)map_sg() for doing cache operations.
>
> I probably should have paid more attention and nak'd the dma/iommu
> integration before it landed.  But given that now we are stuck in this
> situation, while I'm certainly interested if anyone has some ideas
> about how to let drivers opt out of the dma/iommu integration and
> bypass the dma API layer, I'm ok with replacing a hack with a less-bad
> hack.

May I take it as a positive nod to respin the next version?

Regards
Vivek

>
> BR,
> -R



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
