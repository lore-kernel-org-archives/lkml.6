Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CEFC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E252089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRv8geTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAUTTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:19:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36137 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAUTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:19:03 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so16744073itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tWkTW3k+bIMa8ZNbYJt7g6YWTX7Qi5IGP7maD32/94Y=;
        b=gRv8geTmTUA+7CBmtPOuabUbz8xyJC9hAd45Png5i8B6i/eKo4xe/DwNX5hjr3u9tg
         fUl2qucOfVw1Yujnp2sPnWPtOTYnvy6iFWdgLNfk+RQjfgxI0b/er+xiyM9dpYM+JA8M
         FQrs6ycbJRiIi6idbcbpBB/7b2r7okhbckZHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tWkTW3k+bIMa8ZNbYJt7g6YWTX7Qi5IGP7maD32/94Y=;
        b=h/t0f1E/4rV0KMV9A2EbTn1/XtqFgzmDUcmvKOsYA5vpzHsZkVu5ZKKpHtTKkwEav+
         iA2iOwJu8wWBbtb13rk3lS6ZGgt9oD2BXFs8vp4twiHogJI0p3ZLAO+kf0Qg2s0X8R2A
         yCYT+Lkma2qsEgGaaR1ExSMv8J65QDmWYMAiJbsURUfghM2+MXGKjhv7bBMZVoCeJCEQ
         rG8Gv97HslhwIyyT4pVXD2d//3F6v/62K+RFBPkg+FY9kAGICHP32/T2lML2gwXzrf9B
         DkBwWzNjMDeN4uMp56T/Y3EPIK7aR1W3FmOB5O+cY0tiKxWkGdhgW7R+uOSVWGdwEpRw
         1SaQ==
X-Gm-Message-State: AJcUukdlnUqqsEtVAYXRAqntq9QKKniF1UT4Uf4/5NgA10ylahoffXK5
        EvvljdXT7JyHDxj8HTE2nQyqdXHmI0Rx2U5ktjzJQw==
X-Google-Smtp-Source: AHgI3IaQ7V8HPG7/byRY7qZDpx0KwlvbP/JzgF9Zy0+0MAguhIlFyPtxf/9XSQUKrVWkg9APT3qNu/9KGFOCNDfu6To=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr495418ith.158.1548098342336;
 Mon, 21 Jan 2019 11:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net> <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
In-Reply-To: <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 20:18:51 +0100
Message-ID: <CAKv+Gu-gaZpKqyLt9Vft2e_zS4Xkc9+8HAYoHvuBo5C0hqL2Qw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        David Zhou <David1.Zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
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

On Mon, 21 Jan 2019 at 20:04, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-21 7:28 p.m., Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 19:24, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> >> On 2019-01-21 7:20 p.m., Ard Biesheuvel wrote:
> >>> On Mon, 21 Jan 2019 at 19:04, Michel D=C3=A4nzer <michel@daenzer.net>=
 wrote:
> >>>> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> >>>>> On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenzer.ne=
t> wrote:
> >>>>>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> >>>>>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.or=
g> wrote:
> >>>>>>>
> >>>>>>>> Until that happens we should just change the driver ifdefs to de=
fault
> >>>>>>>> the hacks to off and only enable them on setups where we 100%
> >>>>>>>> positively know that they actually work.  And document that fact
> >>>>>>>> in big fat comments.
> >>>>>>>
> >>>>>>> Well, as I mentioned in my commit log as well, if we default to o=
ff
> >>>>>>> unless CONFIG_X86, we may break working setups on MIPS and Power =
where
> >>>>>>> the device is in fact non-cache coherent, and relies on this
> >>>>>>> 'optimization' to get things working.
> >>>>>>
> >>>>>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
> >>>>>> correct basic operation (the scenario Christian brought up is a ve=
ry
> >>>>>> specialized use-case), so that shouldn't be an issue.
> >>>>>
> >>>>> The point is that this is only true for x86.
> >>>>>
> >>>>> On other architectures, the use of non-cached mappings on the CPU s=
ide
> >>>>> means that you /do/ rely on non-snooped transfers, since if those
> >>>>> transfers turn out not to snoop inadvertently, the accesses are
> >>>>> incoherent with the CPU's view of memory.
> >>>>
> >>>> The driver generally only uses non-cached mappings if
> >>>> drm_arch/device_can_wc_memory returns true.
> >>>
> >>> Indeed. And so we should take care to only return 'true' from that
> >>> function if it is guaranteed that non-cached CPU mappings are coheren=
t
> >>> with the mappings used by the GPU, either because that is always the
> >>> case (like on x86), or because we know that the platform in question
> >>> implements NoSnoop correctly throughout the interconnect.
> >>>
> >>> What seems to be complicating matters is that in some cases, the
> >>> device is non-cache coherent to begin with, so regardless of whether
> >>> the NoSnoop attribute is used or not, those accesses will not snoop i=
n
> >>> the caches and be coherent with the non-cached mappings used by the
> >>> CPU. So if we restrict this optimization [on non-X86] to platforms
> >>> that are known to implement NoSnoop correctly, we may break platforms
> >>> that are implicitly NoSnoop all the time.
> >>
> >> Since the driver generally doesn't rely on non-snooped accesses for
> >> correctness, that couldn't "break" anything that hasn't always been br=
oken.
> >
> > Again, that is only true on x86.
> >
> > On other architectures, DMA writes from the device may allocate in the
> > caches, and be invisible to the CPU when it uses non-cached mappings.
>
> Let me try one last time:
>

I could say the same :-)

> If drm_arch_can_wc_memory returns false, the driver falls back to the
> normal mode of operation, using a cacheable CPU mapping and snooped GPU
> transfers, even if userspace asks (as a performance optimization) for a
> write-combined CPU mapping and non-snooped GPU transfers via
> AMDGPU_GEM_CREATE_CPU_GTT_USWC.

I am not talking about the case where drm_arch_can_wc_memory() returns fals=
e.

I am talking about the case where it returns true, which is currently
the default for all architectures, except Power and MIPS in some
cases.

This mode of operation breaks my cache coherent arm64 system. (AMD Seattle)
With this patch applied, everything works fine.

> This normal mode of operation is also
> used for the ring buffers at the heart of the driver's operation.

But is it really the same mode of operation? Does it also vmap() the
pages? Or does it use the DMA API to allocate the ring buffers?
Because in the latter case, this will give you non-cached CPU mappings
as well if the device is non-cache coherent.

> If
> there is a platform where this normal mode of operation doesn't work,
> the driver could never have worked reliably on that platform, since
> before AMDGPU_GEM_CREATE_CPU_GTT_USWC or drm_arch_can_wc_memory even
> existed.
>

As I said, I am talking about the case where drm_arch_can_wc_memory()
returns true on a cache coherent system. This relies on NoSnoop being
implemented correctly in the platform, or a CPU architecture that
snoops the caches when doing uncached memory accesses (such as x86)
