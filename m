Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7EC21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfrK273v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfAXOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:01:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50379 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfAXOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:01:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so3262755wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zly3uJj3nfd6LGkHaexN+XCtlqBu6G31R9osIiXcn5Y=;
        b=XfrK273vOJhFqVOf+1SgApy2Ctx3xStj+i54ORpCNbe8b7lmTkF4tOKmiZ6lis2+hC
         LsTHR17+hOdKX0h1SuhMnDFRP9jkCIzMZoNFEf4sreZzv+0czlzetDK6E0F7Cgho/7FG
         d42/ZluW2dpJ6LyFMJjupX6yO8G3OWftd4S17aIPb1zUH49AUqlHJD8gdPwwSDnxRT+t
         B5csQ74gc2Yp8mzwCzyF74+uiPxyDAQcc0PFDznl8O2KAodX0FadGK3CsZLDa3UuUKyD
         J40QmN9Xi/eudPMhRf/EX2ZJRI4j5gFambT3MdTajwP/5QsRQKHXcwnC+rCjzuki15PU
         BD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zly3uJj3nfd6LGkHaexN+XCtlqBu6G31R9osIiXcn5Y=;
        b=lQ4ojPfwMAEgmofU3baxjXWQ0jNij4LxOVh1fQSbVAsd/GHGKjenWvv8we7fQzAQDS
         Z0EzXDzhMICGd5A3dp0RCztM/IkOA9B+YFnRVfla/AnTCOJfrUSWnXKx9oPwUEaZ1Ixa
         8pgf2wZnBm/eqaAQT90zxiB5CmbR2uOJe1Xqxw4RKa9Jgd8BdBR2uJCK1obhtMSgKBRi
         IRQaExUMMJxsfuNoZwEh31K3cbA3jFr+pJHajcYy56LPahtFCpYvLahF6D/ZA782IlHb
         uzJfVrnvscnjZURJmeUyjPr+Rlea0BOFhd7/3xLTF1HEWBIpFdZRr2DS96Ltu8mqlbs1
         63+A==
X-Gm-Message-State: AJcUukdU4zUr0AkIP1w96RZsvCoJ42QGNScAJaGL3w26339MZxZKueEv
        E/W43kBLPgKVvi71CqpQVhAngqytZJNgV8daI2Y=
X-Google-Smtp-Source: ALg8bN4yXpHJwSOtUBiqISJ2R6T42zvZijTklQrw9xVkchJxEkh4WkGurfcpm+rih+t/nm+kp2hUROmX7VwwqDnwDH0=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr2653509wmm.116.1548338509915;
 Thu, 24 Jan 2019 06:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Jan 2019 09:01:37 -0500
Message-ID: <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > > The DRM driver stack is designed to work with cache coherent devices
> > > only, but permits an optimization to be enabled in some cases, where
> > > for some buffers, both the CPU and the GPU use uncached mappings,
> > > removing the need for DMA snooping and allocation in the CPU caches.
> > >
> > > The use of uncached GPU mappings relies on the correct implementation
> > > of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
> > > will use cached mappings nonetheless. On x86 platforms, this does not
> > > seem to matter, as uncached CPU mappings will snoop the caches in any
> > > case. However, on ARM and arm64, enabling this optimization on a
> > > platform where NoSnoop is ignored results in loss of coherency, which
> > > breaks correct operation of the device. Since we have no way of
> > > detecting whether NoSnoop works or not, just disable this
> > > optimization entirely for ARM and arm64.
> > >
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: David Zhou <David1.Zhou@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > > Cc: Michel Daenzer <michel.daenzer@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Cc: Sean Paul <sean@poorly.run>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > > Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > The subject line should probably read "disable uncached...".
> >
>
> Ugh, of course ...
>
> > With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> > <christian.koenig@amd.com>.
> >

Same:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
