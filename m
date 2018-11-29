Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D0C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EB82082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9SdpF++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EB82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK3GEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:04:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40745 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:04:13 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so2455374ioh.7;
        Thu, 29 Nov 2018 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyy5yvTAUOmlEPj+xK+uWoEqiMsQzkVUDFwnxbzT9ZM=;
        b=R9SdpF++3J5wNrSgIIiOZH57y04E765lRhzJu/kQqrptWQC3+2C/YrjQ1ypCdoPswF
         tlnji4OlO5GOZ45I1+STjJxPErj+9EuvYC2IELaUiWir0z2vjKLPvor1wopKMk0tcnEx
         DcWVheElQWGPXrUAc22u2TNtg+GjrjSLcDqK6DEYb36EeEdyqLs8upIDMWaaAXZ4ItdU
         eISX637c0y5HKmNHjq6TODkxZwSkHNWsNqcFYB9IkOmnrDGqjcV686NZ2FlA3h1V7FCO
         EFDXdH7fAk5vQRvQKrXCU17VHHZ0Sim/kQAYTILnhEdLrhmHMZ/TIo/gvDkKvNen8HLB
         k6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyy5yvTAUOmlEPj+xK+uWoEqiMsQzkVUDFwnxbzT9ZM=;
        b=hjIPG39UybShMAEZQK/xdHcgt/Cf3zQPFcCXSq+nfM4prYiB8DkYHodB7cawBLZvg/
         9KkEJxtJfOsQLHPj+VVeoEMdnMK9hoZnxiVbY3PJDTu9BUriL5Q/LjjZ1TdY58r2TSXd
         hlaWSGBSjYvCEh3dnYkiLrDCmz0THro1KEfDxb51VPQD1vybhi7oPI/V/AyV9vLKnk9L
         7FL1w/Eap7Z0qAdIESFOZQdCpAfv3FiMVNjL0N2rH7DcJS8eCG4jejMwHW/rLbSNykko
         Nk4JEEdIyBX2IshXe3Yeuv3amFUy+MqbGGjL1QqdbcrjBW0k5Fac9rTzuikYZhowtybL
         RjVw==
X-Gm-Message-State: AA+aEWYQ40/wJbstcAOl9lZs+rHTTTkOFSaoDMYee5gd2Ji2HM9bwvnn
        qAC/AmLbEtJU7Yc2nhezMNyt88s/INrYlZ1kKOM=
X-Google-Smtp-Source: AFSGD/VO+WGIdJk3fbf4iGppxQcXo9TOW2mnIfHXi0kfcs0slEpxE/m5gvYoouK8+jwWGBOWAghZKdPyoWE/r4xergE=
X-Received: by 2002:a6b:fc05:: with SMTP id r5mr2207832ioh.129.1543517869444;
 Thu, 29 Nov 2018 10:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local>
 <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
 <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
In-Reply-To: <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 13:57:38 -0500
Message-ID: <CAF6AEGsT9RO2RmgBTa0HQRjRUiRKy9N3vQxvD7RVWp4HpnWn+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, hch@lst.de,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:24 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> [CC Marek]
>
> On Thu, Nov 29, 2018 at 9:09 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Nov 29, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Note that one thing I'd like to avoid is exposing these funtions directly
> > > to drivers, as that will get us into all kinds of abuses.
> >
> > What kind of abuse do you expect? It could very well be that gpu folks
> > call that "standard use case" ... At least on x86 with the i915 driver
> > we pretty much rely on architectural guarantees for how cache flushes
> > work very much. Down to userspace doing the cache flushing for
> > mappings the kernel has set up.
>
> i915 is a very specific case of a fully contained,
> architecture-specific hardware subsystem, where you can just hardcode
> all integration details inside the driver, because nobody else would
> care.
>
> In ARM world, you can have the same IP blocks licensed by multiple SoC
> vendors with different integration details and that often includes the
> option of coherency.

fwiw, I believe all the GPU IP blocks that are used across multiple
SoCs have their own GPU MMU (potentially in addition to an iommu?).
So the dma-api is a much better fit for them..  drm/msm is a lot
closer to drm/i915 scenario, so I don't so much care if the solution
to our unique problem isn't something that would work for other
drivers ;-)

BR,
-R
