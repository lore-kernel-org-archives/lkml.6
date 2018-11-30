Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE68C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F96B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGUynLRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F96B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeK3MXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:23:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34375 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3MXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:23:08 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so3243030iob.1;
        Thu, 29 Nov 2018 17:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3FONXkWY3U3pEkDPvnZpRUi0YhWKLbdocI43n/pciM=;
        b=rGUynLRcICf8A4Y6KXsm64hY5gIIt2LfgqHK6x1QuzdbldWuG/DpDhc0zqG5MVxSgi
         RMkBWzd6g8JcuZ2umcShVNCXYnr3YR08x2l3IFxNOa2P0T6htDD80LGb6NXY6PAY8y9s
         4PGVMwGFFSjTKgP5pEjgKcDMotglcHjSPVOtoz+DiTUwFRTavU6yhjJHom/7oIKLaFiY
         GSuDIPPn1+5hDdxxCAiNRyTqhs5aF0NxRhvETmGMlzfljAC2Nyk7Cgb4P/8ksctfXGLm
         b5v3OabjSoWAlyvV8/5Si4NUKnMCWFEmHa2UvLYrwrpSfhOpiMyZAbjdL08zV5pjk/YY
         lELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3FONXkWY3U3pEkDPvnZpRUi0YhWKLbdocI43n/pciM=;
        b=D9E/2bQD8j0/jOXMbl9Nu/bDy4Pip6Qgt51AhOZHVHOomhNnLY4jODdDmjKadvkVHf
         PUbzTHq5fNVCT2s1nsK6Z5GwzLsxWD3QCvGVTV3lLZBOFquhp8paGwM+IpIM0xPZB8Bx
         R8EOk0dUphVWqSi6nw1nhdl6Nh4GhyWzXSx1PbpM1iXOoo2qgwdIRw0r0F96T4eZJ8zA
         s4u3ysj6dZI8Y/XcIz7Li9IeZSC1Gp/kLMCAft47O9BSmzIG+qfNlcN3ADFRZ6eyhkLh
         arxUUcuRajEPno0S7XDx85SIWRrVwxs0xg4Oi0vkTdi2VUImfX7o65o3ofhcQYOJ9+gY
         flZQ==
X-Gm-Message-State: AA+aEWZRvKDupzr4Etc6EGgZ+fDkdQVQL82bKw64o/quzIADgmXMpLQs
        w0IVjzUi8e35vNSwYIoz8UDiDHb3pR4BTY1c8DU=
X-Google-Smtp-Source: AFSGD/UI08WDj8wtKpFAxFhRyYW9HrF9GZ/zxuco0wfFR0Lid52axLLG6isNHYkJyGnerdwy/TVTPXz4HXJYs6cPh1U=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr3083934iom.7.1543540538031;
 Thu, 29 Nov 2018 17:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de>
In-Reply-To: <20181129155758.GC26537@lst.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 20:15:23 -0500
Message-ID: <CAF6AEGsS6LnuoL9+_LsKLOWxKF6P0nTrxs7b0j0Kqnqz6tmocw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@lst.de
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 29, 2018 at 03:43:50PM +0100, Daniel Vetter wrote:
> > Yeah we had patches to add manual cache management code to drm, so we
> > don't have to abuse the dma streaming api anymore. Got shouted down.
> > Abusing the dma streaming api also gets shouted down. It's a gpu, any
> > idea of these drivers actually being platform independent is out of
> > the window from the start anyway, so we're ok with tying this to
> > platforms.
>
> Manual or not the iommu API is missing APIs for cache management,
> which makes it kinda surprising it actually ever worked for non-coherent
> devices.
>
> And fortunately while some people spent the last year ot two bickering
> about the situation others actually did work, and we now have a
> generic arch_sync_dma_for_device/arch_sync_dma_for_cpu kernel-internal
> API.  This is only used for DMA API internals so far, and explicitly
> not intended for direct driver use, but it would be perfect as the
> backend for iommu API cache maintainance functions.  It exists on all
> but two architectures on mainline.  Out of those powerpc is in the works,
> only arm32 will need some major help.

oh, hmm, I realized I'd been looking still at the armv7 dma-mapping, I
hadn't noticed arch_sync_* yet.. that does look like a step in the
right direction.

As far as hiding cache ops behind iommu layer, I guess I'd been
thinking more of just letting the drivers that want to bypass dma
layer take things into their own hands.. tbh I think/assume/hope
drm/msm is more the exception than the rule as far as needing to
bypass the dma layer.  Or at least I guess the # of drivers having
problems w/ the dma layer is less than the # of iommu drivers.

(Not sure if that changes my thoughts on this patch, it isn't like
what this patch replaces isn't also a problematic hack around the
inability to bypass the dma layer.  In the short term I just want
*something* that works, I'm totally happy to refactor later when there
are better options.)

BR,
-R
