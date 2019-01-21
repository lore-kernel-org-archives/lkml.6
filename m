Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2032C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47D22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm0rROjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAUSUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:20:14 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35635 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfAUSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:20:14 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so17131488ion.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJhOepUD6NaSayAfqLhlWuoQ/QOfSBGfPNnmKMxehZg=;
        b=hm0rROjlNQsH4JlgreRAtYafeQOWAtKoXTVjMjrT2SrfdjWwsbs0/cM1Df/2551mCD
         aB2NIwGh6PtkU4LJqNiUnC9ccd/MxSvVZmUe7p8qihObwBXmx5bizvR6D4nwZRxbSzcD
         TRkcVrpj1W7hRzWFBQLCKatfPlpTT5EgcAThI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJhOepUD6NaSayAfqLhlWuoQ/QOfSBGfPNnmKMxehZg=;
        b=mBvEZjceh9pEGgLPCQHEKUynachCAyWFQpe0GFhu0wQTRtHH3Zl97ax/Rcb3cEHam8
         DswkEQdth8E7wO3Jr/yNZmOHKgIv59iZqvCDsViRCTiOXL7Av2zNRWBU04RMs6jFiTQa
         7H3y+JstmFM1UsUq9gP0AlP1b58z8XyCx6j3QMsA/Uei7bu4hdmwNAHvtOYxYreFf2GL
         ROXPwSvbRNJiQeS8kkq5Z7dHDSsShFKu4B3DZWo3ih7kFcDiCfBOf13ipCCJCix6w8/a
         PK1VHXxekEmVaYCxZCOptXo9POHH369eokfKrIr2QhT0mz2XfILcZdZ9mJTGcAjhIZ5q
         62tw==
X-Gm-Message-State: AJcUukdicN5qGGNjAKKCWHh62zdRCSLimwbZnvj1IWnEhxKcNb7D4Q1Z
        9F0lTfqcpWVA1aXbJlahy6cwExrB0CKwms6lfQSfEA==
X-Google-Smtp-Source: ALg8bN5ByDojMvNCkHvw+nhvxmX81xfCKgkECLG9m3o1l96NamrDv7X9AAf2gib9QfeBaMtuqMM1y6vwNZwwjFWF5UE=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr16371109iob.170.1548094813483;
 Mon, 21 Jan 2019 10:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net> <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
In-Reply-To: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 19:20:02 +0100
Message-ID: <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
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

On Mon, 21 Jan 2019 at 19:04, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> >>
> >> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> >>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> w=
rote:
> >>>
> >>>> Until that happens we should just change the driver ifdefs to defaul=
t
> >>>> the hacks to off and only enable them on setups where we 100%
> >>>> positively know that they actually work.  And document that fact
> >>>> in big fat comments.
> >>>
> >>> Well, as I mentioned in my commit log as well, if we default to off
> >>> unless CONFIG_X86, we may break working setups on MIPS and Power wher=
e
> >>> the device is in fact non-cache coherent, and relies on this
> >>> 'optimization' to get things working.
> >>
> >> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
> >> correct basic operation (the scenario Christian brought up is a very
> >> specialized use-case), so that shouldn't be an issue.
> >>
> >
> > The point is that this is only true for x86.
> >
> > On other architectures, the use of non-cached mappings on the CPU side
> > means that you /do/ rely on non-snooped transfers, since if those
> > transfers turn out not to snoop inadvertently, the accesses are
> > incoherent with the CPU's view of memory.
>
> The driver generally only uses non-cached mappings if
> drm_arch/device_can_wc_memory returns true.
>

Indeed. And so we should take care to only return 'true' from that
function if it is guaranteed that non-cached CPU mappings are coherent
with the mappings used by the GPU, either because that is always the
case (like on x86), or because we know that the platform in question
implements NoSnoop correctly throughout the interconnect.

What seems to be complicating matters is that in some cases, the
device is non-cache coherent to begin with, so regardless of whether
the NoSnoop attribute is used or not, those accesses will not snoop in
the caches and be coherent with the non-cached mappings used by the
CPU. So if we restrict this optimization [on non-X86] to platforms
that are known to implement NoSnoop correctly, we may break platforms
that are implicitly NoSnoop all the time.
