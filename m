Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120F221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0g2R31a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAVVHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:07:20 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51837 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAVVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:07:20 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so24017190ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bXRiTXzBLLRaOR+poEfIT/sh53Mi/Fp2YF7rqrlJr5c=;
        b=G0g2R31asSIFQRdJGb1kihSACoeQHh7yIqhoxZX4Z6/Yj0Xdr/wB/g976tzB17fHMu
         Bw3gArsZoV2vkBU+2OwuTvP/J602Qd8Ayq9OLPprpSG1yan+/TJ3CKhVudf2LLBtp5MO
         m468a+ybi2EybtFmGMx7XFD8qC3C+MrDrCu4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bXRiTXzBLLRaOR+poEfIT/sh53Mi/Fp2YF7rqrlJr5c=;
        b=PMopIk/B+1GeN9x2PHfBXow+StO5QvsvOPxEZCYmk3wqlTWFZseVIyjoK4VlY6GRqW
         Y0c6Q1TWS0KH6GxDX+e5D6ptNA733BfK5nXVSWMoZehD5manyXGh05KoRpBVT6uI85/9
         3QsDHLuky8NZpDYsNF2kc7AIw8Uwao35hV5Yf8iSG7AylpghqbPvHkZOG1n2Mx0OXMfn
         iJzQNC4sKDVxu4NA1PKhe5alrLKDXPfDl7rGu5HCf84OvSHJMRRRU6wzFgXXMiG8IvY0
         J1HCzaoyNoyRR1XrxD3nQiMHarvPEk2Bcqq23GKk1rCIgWj3cXtTCProJanTgthyFOa4
         EwCg==
X-Gm-Message-State: AJcUukf0c1lTJW9Cvt9JdPP4lZa2y+vopdzFcB08w/7FxlsSgqw0i4QA
        ZOyFKNDD8sJtW32uAFRACuZFx/hZXvmdFIp1CLJlhA==
X-Google-Smtp-Source: ALg8bN6/Q9U1Xs5xpTRgOS2vFbu9WQ6NRIRleN6PO13tCnVK3wA2x1AfQ5qladFBE4O1p/KDuaC46sgWLbwP0LAzleM=
X-Received: by 2002:a02:734b:: with SMTP id a11mr19908341jae.62.1548191238829;
 Tue, 22 Jan 2019 13:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net> <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
In-Reply-To: <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Jan 2019 22:07:07 +0100
Message-ID: <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Tue, 22 Jan 2019 at 21:56, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Jan 22, 2019 at 4:19 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Mon, 21 Jan 2019 at 20:04, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> > >
> > > On 2019-01-21 7:28 p.m., Ard Biesheuvel wrote:
> > > > On Mon, 21 Jan 2019 at 19:24, Michel D=C3=A4nzer <michel@daenzer.ne=
t> wrote:
> > > >> On 2019-01-21 7:20 p.m., Ard Biesheuvel wrote:
> > > >>> On Mon, 21 Jan 2019 at 19:04, Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
> > > >>>> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> > > >>>>> On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenze=
r.net> wrote:
> > > >>>>>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> > > >>>>>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradea=
d.org> wrote:
> > > >>>>>>>
> > > >>>>>>>> Until that happens we should just change the driver ifdefs t=
o default
> > > >>>>>>>> the hacks to off and only enable them on setups where we 100=
%
> > > >>>>>>>> positively know that they actually work.  And document that =
fact
> > > >>>>>>>> in big fat comments.
> > > >>>>>>>
> > > >>>>>>> Well, as I mentioned in my commit log as well, if we default =
to off
> > > >>>>>>> unless CONFIG_X86, we may break working setups on MIPS and Po=
wer where
> > > >>>>>>> the device is in fact non-cache coherent, and relies on this
> > > >>>>>>> 'optimization' to get things working.
> > > >>>>>>
> > > >>>>>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers =
for
> > > >>>>>> correct basic operation (the scenario Christian brought up is =
a very
> > > >>>>>> specialized use-case), so that shouldn't be an issue.
> > > >>>>>
> > > >>>>> The point is that this is only true for x86.
> > > >>>>>
> > > >>>>> On other architectures, the use of non-cached mappings on the C=
PU side
> > > >>>>> means that you /do/ rely on non-snooped transfers, since if tho=
se
> > > >>>>> transfers turn out not to snoop inadvertently, the accesses are
> > > >>>>> incoherent with the CPU's view of memory.
> > > >>>>
> > > >>>> The driver generally only uses non-cached mappings if
> > > >>>> drm_arch/device_can_wc_memory returns true.
> > > >>>
> > > >>> Indeed. And so we should take care to only return 'true' from tha=
t
> > > >>> function if it is guaranteed that non-cached CPU mappings are coh=
erent
> > > >>> with the mappings used by the GPU, either because that is always =
the
> > > >>> case (like on x86), or because we know that the platform in quest=
ion
> > > >>> implements NoSnoop correctly throughout the interconnect.
> > > >>>
> > > >>> What seems to be complicating matters is that in some cases, the
> > > >>> device is non-cache coherent to begin with, so regardless of whet=
her
> > > >>> the NoSnoop attribute is used or not, those accesses will not sno=
op in
> > > >>> the caches and be coherent with the non-cached mappings used by t=
he
> > > >>> CPU. So if we restrict this optimization [on non-X86] to platform=
s
> > > >>> that are known to implement NoSnoop correctly, we may break platf=
orms
> > > >>> that are implicitly NoSnoop all the time.
> > > >>
> > > >> Since the driver generally doesn't rely on non-snooped accesses fo=
r
> > > >> correctness, that couldn't "break" anything that hasn't always bee=
n broken.
> > > >
> > > > Again, that is only true on x86.
> > > >
> > > > On other architectures, DMA writes from the device may allocate in =
the
> > > > caches, and be invisible to the CPU when it uses non-cached mapping=
s.
> > >
> > > Let me try one last time:
> > >
> > > If drm_arch_can_wc_memory returns false, the driver falls back to the
> > > normal mode of operation, using a cacheable CPU mapping and snooped G=
PU
> > > transfers, even if userspace asks (as a performance optimization) for=
 a
> > > write-combined CPU mapping and non-snooped GPU transfers via
> > > AMDGPU_GEM_CREATE_CPU_GTT_USWC.
> >
> > Another question: when userspace requests for such a mapping to be
> > created, does this involve pages that are mapped cacheable into the
> > userland process?
>
> AMDGPU_GEM_CREATE_CPU_GTT_USWC means the buffer should be uncached and
> write combined from the CPU's perspective (hence the 'CPU' in the flag
> name).  On the GPU side if that flag is set, we do an non-snooped GPU
> mapping for better performance if the buffer ends up getting mapped
> into the GPU's address space for GPU access.
>

Yes, so much was clear. And the reason this breaks on some arm64
systems is because
a) non-snooped PCIe TLP attributes may be ignored, and
b) non-x86 CPUs do not snoop the caches when accessing uncached mappings.

I don't think there is actually any disagreement on this part. And I
think my patch is reasonable, only Christoph is objecting to it on the
grounds that drivers should not go around the DMA API and create
vmap()s of DMA pages with self chosen attributes.

What I am trying to figure out is why the coherency problem exists:
- it could be that the device is reading using cached mappings and
sees stale clean cachelines that shadow data written by the CPU using
uncached mappings
- or the device is writing with cached mappings, resulting in data to
be allocated there, but the CPU does not see it because it reads using
uncached mappings.

In the former case, I would expect cache invalidation right after the
vmap() to be sufficient, but in the latter case, it is a bit more
difficult probably.

So my question was whether there are cacheable aliases for those
uncached vmap()s being used?
