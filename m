Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF43C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DACF218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGemaN4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfAXJh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:37:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33170 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:37:27 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so2073548itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19Ghs0w/nhlo4uQ8eD+zwEIEKJRefRDb4wX388+r+8k=;
        b=XGemaN4QR7SjKl697wLRKBep/wFxn817peN9hS+Mcc6b8n7AV+0PFgGHxPE/RUAxqm
         JG3uEo872Puw9oxIDWLryDmo/TERQThN8+wTMqLeAfV35nl71WaubbxQ/Nm+OOM9Z8UT
         VTdzQ/o5rBGu7pVDQhCoUR2Lammzr2M1unJrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19Ghs0w/nhlo4uQ8eD+zwEIEKJRefRDb4wX388+r+8k=;
        b=P9ufZp23SwLcQqu6Z303GCODI/xuIvOZpUmtYXlCfa9ue6RYfFAG/BYUfkj9mQ3m65
         w9vW86ZoCChtuFfon8G3XYiRVO5j/fCCLR0F0rKwNBTFfhVFP6WmTzFqPaOPj4UbBwJf
         MBVLCTvLid6YnCurn75VRaZfZitpH0+9LnT/5TUywaRawwBf2H2OlPxhurdXw23NjTab
         +lsc68UYNDTdXkiKKKygDm7OZeON/urxAPq5pEFr8U+f6c8aUlgJZdeoB3+kvxIV1fbn
         /K0ysXZYkhvmu4nedJuzuirD1+e8765mGcH5aE0w1L4TgNxy2Oi8nyXzAUugUX758aS+
         R0+g==
X-Gm-Message-State: AJcUukd2xX00cjXa/m/qfOWzKrd8iVjZYx3qvDymHYEjBenvdvqXTukg
        23jvJGC5nm0W84J5rjT0+btE8Xk+IwcqGm5uA0ysWQ==
X-Google-Smtp-Source: ALg8bN4ne/hR+SuW9iYCOPhafqRBnpHtutg5GMpH6iXvnvxu03ZZFm+w6EPHsZKic/F0XM3mbeVJt6EW3o9tdYM35AM=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr3714050jab.2.1548322645960;
 Thu, 24 Jan 2019 01:37:25 -0800 (PST)
MIME-Version: 1.0
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org> <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org> <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
In-Reply-To: <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Jan 2019 10:37:14 +0100
Message-ID: <CAKv+Gu-6=kUd_OYoe4TpFSUXHqC4etxH98mAN_gkHKvS1=1BGA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

On Thu, 24 Jan 2019 at 10:31, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-23 5:52 p.m., Ard Biesheuvel wrote:
> > On Wed, 23 Jan 2019 at 17:44, Christoph Hellwig <hch@infradead.org> wro=
te:
> >>
> >> I think we just want a driver-local check for those combinations
> >> where we know this hack actually works, which really just seems
> >> to be x86-64 with PAT. Something like the patch below, but maybe with
> >> even more strong warnings to not do something like this elsewhere:
> >
> > I agree that your patch seems like the right way to ensure that the WC
> > optimization hack is only used where we know it works.
> >
> > But my concern is that it seems likely that non-cache coherent
> > implementations are relying on this hack as well.
>
> I've been trying to tell you they can't rely on that, because the amdgpu
> driver doesn't use this functionality for fundamentals such as ring
> buffers used for feeding the hardware with commands. Instead, for those
> it relies on snooped PCIe transfers being coherent with the CPU caches.
>

I understand it does not use this functionality for the ring. Instead,
it uses the DMA API, no?

On non-cache coherent systems, that DMA API will allocate memory and
map it uncached for the CPU so that it is coherent with the non-cache
coherent device.

In any case, if non-cache coherent systems are unlikely to work, and
unsupported in case they do, I am fine with disabling this
optimization unconditionally for non-X86 architectures.

>
> >> -#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
> >> -       /* Don't try to enable write-combining when it can't work, or =
things
> >> -        * may be slow
> >> -        * See https://bugs.freedesktop.org/show_bug.cgi?id=3D88758
> >> -        */
> >> -
> >> -#ifndef CONFIG_COMPILE_TEST
> >> -#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better perf=
ormance \
> >> -        thanks to write-combining
> >> -#endif
> >> -
> >> -       if (bo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
> >> -               DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X8=
6_PAT for "
> >> -                             "better performance thanks to write-comb=
ining\n");
>
> FWIW, please don't drop these compile and build time warnings where we
> continue to take advantage of PAT.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
