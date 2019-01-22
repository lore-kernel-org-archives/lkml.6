Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61AF21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH3O+iEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfAVU4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:56:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAVU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:56:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so28977470wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y1Twsy5d3FmV1GSVk5zXfwAuFbIksJY0V6VcJQIaTLs=;
        b=YH3O+iEBgPhmf6ph1isS1rSjC51CSkZqMFaI3u3FY/THDI/o7OP4/3ZlbPyayUF/qV
         XGejvGFYUw2osZqRDh5V9twu5rgnCrBWM9EuB9mppvfjPaLick34ELF6PFFXFcolI9PY
         zdYG5UMxUJt/4B13GwwUgtMxjWqB8S8lXGEPJFiDZi4sCexZO90C0bFnM8bgxGY7AKCp
         Cj4HyGUKZzf+McgYlYTCyplNMiw9JBEG1nxWAYHIHROMDZD4VDAAgHot39dF6bPKdOkg
         YYNB/uhQDqj7QRZI5BkC2rMkQpG6S5dzm1Bgz4TJrgRuq9ypHhwjExzSEfkpcA/z5spa
         h61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y1Twsy5d3FmV1GSVk5zXfwAuFbIksJY0V6VcJQIaTLs=;
        b=MJDqXv1hmYazZ9+VZ1Pd69dmLP4s+5GTSuvPDE9w0HP1Fy1awfJOfjnN20/hz3x3Wz
         020P5zFv3s31AZekuwiSyBImoiSfqRVgSmrHnlMCCitsMIdVcTVkXF4nIFxxPn+YPU0N
         U2CNdNBPv2znnaZJRkTbp+0jiA1L25MRQ3iQvuter9yLs4LneGPd1YysifNOpNTM9wmG
         z/YQS8XdhjvyZFoMv3mYP905Gm3z0CWUkmpxbji0dNRAQPcYsolWFNHEGyFQ7TM9iUdh
         GKfHc5xTwdZefBmW/+Gfnvr8C3D1o/ZTE3OioedzKe72bo2A9NKPEYtQYlrCxslVxZSD
         EYiw==
X-Gm-Message-State: AJcUukeAhVW6pEnMqTEQ3bD6NOT53BfzNPj2nCOTC8NruvmZn57BI3pX
        Sr0+f7rRaDFxlyS1vyDpPCa7xU4J/gnXI94s8jo=
X-Google-Smtp-Source: ALg8bN74syTrDcHW0X3XdG9wcbGqRfmlgVw7jVnXOEUeSwHcOQ+tWRWfv7XP25eVVfT15jNPAH0yiI+KFx9JJQpW9qc=
X-Received: by 2002:a5d:5351:: with SMTP id t17mr34356756wrv.288.1548190605573;
 Tue, 22 Jan 2019 12:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net> <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Jan 2019 15:56:33 -0500
Message-ID: <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:19 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 21 Jan 2019 at 20:04, Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
> >
> > On 2019-01-21 7:28 p.m., Ard Biesheuvel wrote:
> > > On Mon, 21 Jan 2019 at 19:24, Michel D=C3=A4nzer <michel@daenzer.net>=
 wrote:
> > >> On 2019-01-21 7:20 p.m., Ard Biesheuvel wrote:
> > >>> On Mon, 21 Jan 2019 at 19:04, Michel D=C3=A4nzer <michel@daenzer.ne=
t> wrote:
> > >>>> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> > >>>>> On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
> > >>>>>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> > >>>>>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.=
org> wrote:
> > >>>>>>>
> > >>>>>>>> Until that happens we should just change the driver ifdefs to =
default
> > >>>>>>>> the hacks to off and only enable them on setups where we 100%
> > >>>>>>>> positively know that they actually work.  And document that fa=
ct
> > >>>>>>>> in big fat comments.
> > >>>>>>>
> > >>>>>>> Well, as I mentioned in my commit log as well, if we default to=
 off
> > >>>>>>> unless CONFIG_X86, we may break working setups on MIPS and Powe=
r where
> > >>>>>>> the device is in fact non-cache coherent, and relies on this
> > >>>>>>> 'optimization' to get things working.
> > >>>>>>
> > >>>>>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers fo=
r
> > >>>>>> correct basic operation (the scenario Christian brought up is a =
very
> > >>>>>> specialized use-case), so that shouldn't be an issue.
> > >>>>>
> > >>>>> The point is that this is only true for x86.
> > >>>>>
> > >>>>> On other architectures, the use of non-cached mappings on the CPU=
 side
> > >>>>> means that you /do/ rely on non-snooped transfers, since if those
> > >>>>> transfers turn out not to snoop inadvertently, the accesses are
> > >>>>> incoherent with the CPU's view of memory.
> > >>>>
> > >>>> The driver generally only uses non-cached mappings if
> > >>>> drm_arch/device_can_wc_memory returns true.
> > >>>
> > >>> Indeed. And so we should take care to only return 'true' from that
> > >>> function if it is guaranteed that non-cached CPU mappings are coher=
ent
> > >>> with the mappings used by the GPU, either because that is always th=
e
> > >>> case (like on x86), or because we know that the platform in questio=
n
> > >>> implements NoSnoop correctly throughout the interconnect.
> > >>>
> > >>> What seems to be complicating matters is that in some cases, the
> > >>> device is non-cache coherent to begin with, so regardless of whethe=
r
> > >>> the NoSnoop attribute is used or not, those accesses will not snoop=
 in
> > >>> the caches and be coherent with the non-cached mappings used by the
> > >>> CPU. So if we restrict this optimization [on non-X86] to platforms
> > >>> that are known to implement NoSnoop correctly, we may break platfor=
ms
> > >>> that are implicitly NoSnoop all the time.
> > >>
> > >> Since the driver generally doesn't rely on non-snooped accesses for
> > >> correctness, that couldn't "break" anything that hasn't always been =
broken.
> > >
> > > Again, that is only true on x86.
> > >
> > > On other architectures, DMA writes from the device may allocate in th=
e
> > > caches, and be invisible to the CPU when it uses non-cached mappings.
> >
> > Let me try one last time:
> >
> > If drm_arch_can_wc_memory returns false, the driver falls back to the
> > normal mode of operation, using a cacheable CPU mapping and snooped GPU
> > transfers, even if userspace asks (as a performance optimization) for a
> > write-combined CPU mapping and non-snooped GPU transfers via
> > AMDGPU_GEM_CREATE_CPU_GTT_USWC.
>
> Another question: when userspace requests for such a mapping to be
> created, does this involve pages that are mapped cacheable into the
> userland process?

AMDGPU_GEM_CREATE_CPU_GTT_USWC means the buffer should be uncached and
write combined from the CPU's perspective (hence the 'CPU' in the flag
name).  On the GPU side if that flag is set, we do an non-snooped GPU
mapping for better performance if the buffer ends up getting mapped
into the GPU's address space for GPU access.

Alex
