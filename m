Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0401CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA02720673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqVKccPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA02720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbeK3Bxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:53:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53885 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbeK3Bb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:28 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so3786056ita.3;
        Thu, 29 Nov 2018 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfZIvNThYDQ4IjcNKC7Fi3JYmBMBLzaJvVpeqITnlUo=;
        b=jqVKccPiyYTDdRTZJOVfNOOb3Ky26TJ4HRIc8/n92OFxgtdmGaG0Fxiw2sx4Wb/FGV
         OEMV66aObSO30+8jZpKZBd5/bP+6QcP2+y5ZeYO/1PIDg2HaC7yKqsev0WjrwgOPjDtS
         QZl2F0CH3hCIy5hrCL5A+GS7ZLHy/CtYzdaheZVQqqzYEpy/Zng8+qbb2OWFYgDXv9nt
         t0S1i/VYsxtk0hY68F7cWAan140hPtqYIxnROpzt9CacE/iWRoMUUFcF+ea6fivcrpNT
         QQ+ZR61QW91r1l87myKv6nJW3EV0/tsZkC441/DgePd6Eo3aSxZ0Sl/Vf1rdsrHTsv5G
         0Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfZIvNThYDQ4IjcNKC7Fi3JYmBMBLzaJvVpeqITnlUo=;
        b=oiVQqd1N1sWq61rzasqYn9cHihwM5j/Vrswt/ZDlqg4QFn6PCdbG8eAv2aa4L5FJgh
         xooadFksJw0nEK6zBifFUHfnD5RIpQAeDJxz8eATHdt1LW+cJ9pJizK3bgVJuT03T25D
         7kfeotBMfi2OznUYX9p+VJenQdLWShGyZjL9fJBvAIcXiHM2NjGCkyqKGH7dWRvbkJHl
         tKzRY7haGhkw/gyA1cPe2vCeUeqEs1WGgsNtJ4JNr3nvCFofPK1ZVEP072cNKkEQKwjS
         zf/XlTKMRkwT6vv5uWj7Bt2ZgCTassmR574WyeR5qX7lrJ+PB1dQXq87SdvH9rjR/XJA
         6t0A==
X-Gm-Message-State: AA+aEWbRqxxeYyZ/yMIdnjQN8I06106531yIbE874TD7HKbkY+DGfCiV
        aoJ6x97XfU445pfJQAb866zYeByPpwzNGs02NFE=
X-Google-Smtp-Source: AFSGD/W4JtG2zGySOILqdZyPp0TtVdywvWMgwUqdWJqEUJDbyt9D+k6Y9H70tvk0/s1eGx5yJDxFxz/STiKc7rvAfik=
X-Received: by 2002:a02:3da:: with SMTP id e87mr1309077jae.78.1543501556348;
 Thu, 29 Nov 2018 06:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de>
In-Reply-To: <20181129141429.GA22638@lst.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 09:25:43 -0500
Message-ID: <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@lst.de
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 29, 2018 at 07:33:15PM +0530, Vivek Gautam wrote:
> > dma_map_sg() expects a DMA domain. However, the drm devices
> > have been traditionally using unmanaged iommu domain which
> > is non-dma type. Using dma mapping APIs with that domain is bad.
> >
> > Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> > to do the cache maintenance.
>
> As I told you before:  hell no.  If you spent the slightest amount of
> actually trying to understand what you are doing here you'd know this
> can't work.  Just turn on dma debugging and this will blow up in your
> face.

you can tone it down..  we weren't the ones who created the dma/iommu
mess, we are just trying to find a way to work around it

> Either you use the DMA API properly, that is you use it to map and
> to sync, or you don't use it at all.  Mix and match between iommu
> APIs and DMA APIs is simply not possible.

I'd *love* nothing more to not use the dma api.. but on arm there is
no other way to do cache maint.

BR,
-R
