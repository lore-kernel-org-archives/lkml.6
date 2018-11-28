Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98672C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8A20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ITLkKK0o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Su2us9EP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA8A20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeK1UDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:03:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeK1UDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:03:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4FD560C61; Wed, 28 Nov 2018 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543395769;
        bh=VYoCnpZS0pG7F3nwYm6u0/ssqCRXzYD+NX4/SExvkN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ITLkKK0oBmjuK7UJ2t++3WJ3x41gZ9sgRZ9vGQ1wG75bmZqlc7+K0mT7OTfgdE/88
         HOfTPn3J9363uYcWQGF1fNsA/vaNZk5wLjR+ykL6Ia1xq+Jsh9JOwVXez7k4m7TQfd
         pW9RZ7MrJDKcQhdKAc+p3hIiK00NFvusBgt/4Sqw=
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9564760B62;
        Wed, 28 Nov 2018 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543395767;
        bh=VYoCnpZS0pG7F3nwYm6u0/ssqCRXzYD+NX4/SExvkN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Su2us9EP5u+ChhPO0Qmb6GH30Qw1A2sIBy860t7oLpfA7advqhxfWth6xjFW4QLqG
         bAUTXJg9D6aVtwD9kBsLsZjmZkb76cVnq5qC8bBFxhNTQg1T4CcK9Aq/8mgihMyGmd
         3viKOvsDgI0QVfDGN0QVT0fw2aeDbC4HTMWPAmdg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9564760B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f176.google.com with SMTP id v11so24989857qtc.2;
        Wed, 28 Nov 2018 01:02:47 -0800 (PST)
X-Gm-Message-State: AA+aEWYDitEH2vxeXIZUOAnx76q+klWB+1/gusrlOCnleqIJ+YAPyfs/
        g2AfJBBUePJkX1tr1pfn8pqrOK+zhzxduQIAzcI=
X-Google-Smtp-Source: AFSGD/UsyZ3GMUP8iz5Gwc5M1qacGc5czpyEjDK+dH92No1FpzWAyorKdpF+UntAim+l6FkVk0rVOsnY92Kzd5UR+p4=
X-Received: by 2002:a0c:f9c3:: with SMTP id j3mr293036qvo.107.1543395766444;
 Wed, 28 Nov 2018 01:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org> <20181128073940.GA13072@infradead.org>
In-Reply-To: <20181128073940.GA13072@infradead.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 28 Nov 2018 14:32:34 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHDh3-5+RTikaPz1SMqxCaVMJ86WvPJjpSVp9GjzOfLfQ@mail.gmail.com>
Message-ID: <CAFp+6iHDh3-5+RTikaPz1SMqxCaVMJ86WvPJjpSVp9GjzOfLfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@infradead.org
Cc:     David Airlie <airlied@linux.ie>, Rob Clark <robdclark@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>, seanpaul@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph ,

On Wed, Nov 28, 2018 at 1:10 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +             /*
> > +              * dma_sync_sg_*() flush the physical pages, so point
> > +              * sg->dma_address to the physical ones for the right behavior.
> > +              */
> > +             for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> > +                     sg_dma_address(s) = sg_phys(s);
> > +
>
> I'm sorry, but this is completely bogus and not acceptable.
>
> The only place that is allowed to initialize sg_dma_address is
> dma_map_sg.  If the default dma ops don't work for your setup we have
> major a problem and need to fix the dma api / iommu integration instead
> of hacking around it.

Thanks for reviewing this change.
From what I understand the things in drm, we don't use the default
iommu-dma domain
for drm devices. Rather we allocate a new iommu domain, and therefore we can't
use the default dma ops. Hence we need separate dma_sync_sg*() to
flush/invalidate
the cache. For this we need to initialize the sg's addresses.

Please correct me if my understanding is incomplete.

Best regards
Vivek



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
