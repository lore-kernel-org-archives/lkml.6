Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A22184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1ggZk85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAYInU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:43:20 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46401 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:43:19 -0500
Received: by mail-io1-f68.google.com with SMTP id s8so7085133iob.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5C27t5i/Kxs7sqw0V4cwfbsTRjCbPSa4Pe/4IHFM4IU=;
        b=f1ggZk859V6w+zigTYcibT8r3QHPSARkxS5C9jTf8Sm2bH8BmAd0PedGXdK0Jc6EHp
         yrxCRVZfrGCkCosLH5cD7gD4aEqBABGyzT4GMdU0JmcXZIeCqUWCdwYS67AIFos/X6N9
         /Zc7r7Bogu+Zx0ac2BDv9+u0w22QbsOHfWPVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5C27t5i/Kxs7sqw0V4cwfbsTRjCbPSa4Pe/4IHFM4IU=;
        b=N+sCrkZgWS1DF6bgVJL72kbuz8+S+PDp5GeJBVPg3JjP6a1mwPszAb2wEfTRhsMuKx
         xSPf4bahKlPBBQy6rZnDjgFYWkwLxr/PrnsNt4SCmsgjTxcf4hrxfog5s4iNs2iowGns
         IbpZmuyY45lx1A9DbK/Zk/BgbW+ytyyz+Bs8iO+421nbZW5sJW56vT3fcKYXFStA25hJ
         ld18GZjkwkxGgKvg+WHYlUd1fyfIiopLb0Gh030MhYrM7gSc/IR2rSVLMPagDEy0+e4o
         pw/OAh5QmCdlZBBG2hSXG2l0kPWRS1ni5KvHAHWa14M9HNSmNHhO1GV2PKMcjun8TwZJ
         TxBg==
X-Gm-Message-State: AHQUAua+7IXFDV0ZNPllEvV5UNZ+whh2JvtP0lcS+bGc5iBE8+IKylaL
        MebnOGv0rt+0nUci9kwJ5ookJZFtUDfpbLiqHpAmtw==
X-Google-Smtp-Source: ALg8bN5l9hoVLJ+wkvRk2hidT/8N4aAJXqPZqBu3XHVW+oJcDKWoAZNhZUcSg4D4tAC3NuYfT+OocgJdVTPjrPTfN9I=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr5987962ion.173.1548405798631;
 Fri, 25 Jan 2019 00:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
In-Reply-To: <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 25 Jan 2019 09:43:07 +0100
Message-ID: <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> > <Christian.Koenig@amd.com> wrote:
> > >
> > > Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > > > The DRM driver stack is designed to work with cache coherent device=
s
> > > > only, but permits an optimization to be enabled in some cases, wher=
e
> > > > for some buffers, both the CPU and the GPU use uncached mappings,
> > > > removing the need for DMA snooping and allocation in the CPU caches=
.
> > > >
> > > > The use of uncached GPU mappings relies on the correct implementati=
on
> > > > of the PCIe NoSnoop TLP attribute by the platform, otherwise the GP=
U
> > > > will use cached mappings nonetheless. On x86 platforms, this does n=
ot
> > > > seem to matter, as uncached CPU mappings will snoop the caches in a=
ny
> > > > case. However, on ARM and arm64, enabling this optimization on a
> > > > platform where NoSnoop is ignored results in loss of coherency, whi=
ch
> > > > breaks correct operation of the device. Since we have no way of
> > > > detecting whether NoSnoop works or not, just disable this
> > > > optimization entirely for ARM and arm64.
> > > >
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: David Zhou <David1.Zhou@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > > > Cc: Michel Daenzer <michel.daenzer@amd.com>
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > Cc: Sean Paul <sean@poorly.run>
> > > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > > > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > > > Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >
> > > The subject line should probably read "disable uncached...".
> > >
> >
> > Ugh, of course ...
> >
> > > With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> > > <christian.koenig@amd.com>.
> > >
>
> Same:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>

Thanks all

Should I resend the patch with the subject corrected?
