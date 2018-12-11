Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EBBC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17146205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fH8wewH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17146205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeLKQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:01:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39831 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbeLKP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:40 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so4581777itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7GgIEdfZjoPzHXKjruKKF4bLDJm5C4iEVQoLgxYlNA=;
        b=fH8wewH9gmW8AIjXG6YvW2fWZybyPGueW2f9j6NdlkI3Z7ckHNTRhh1FJ6eIawfQic
         9vGKLZP3xeEqyD4xNOnZBTlsbEKV+lD5egwUeZHOdL3PAmAdnXsxdfpZsUciZYOmBEMI
         AbooqmZp9PEpsHNoceG1/b+l2lQg6cZe1w82YxIEomS4n0b3Sb+jsVUjGa4MP50xfK+Y
         Jsihn+2y8LcLv0/YUn6Bxfh8Dv1RDipi/PRCJYfAz6btaSMsIpAvXjTVA1E1d9q+TdzZ
         Zqg5kWBek54CrgILRXCSWZBXQNIFeeEpeOxyncmdwOXbdciTJjxNfxut3FzYEx0IVBpv
         ba3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7GgIEdfZjoPzHXKjruKKF4bLDJm5C4iEVQoLgxYlNA=;
        b=ByhKdpPe6LX4xB46HJ9Gec+pLTiEtA4odZqlww28OnRXj5Y3X9ZDir6Mwr8VjiMbcX
         x5m/aY3sWoCPdGnUBOIuI6QCTmEIK+klpFkhIVb4y4UUyTN9/BODI2WczD9tYu55B+zF
         5I77GnsODSAU7Q/qv2dui4tke3sngnX3mySPosZR5s5aA/crEKZQJqVsSxXumvpMORNN
         nga/eo5Cg03Qk5G1Ub+roV/6K5d9BOvajSBMFM1h9Hb6CEfH2Ei6XvB7o98oV+RDBvtA
         fuHmKipHKaNDlrhFLehehelc1htAdZW3VJSHUC3JDD7j6Z708x/8m3OCa6Xo2Bne5QZl
         ZaJw==
X-Gm-Message-State: AA+aEWbm2EooVLtgldIxbpoREylgQ9mO+Atnl+ix7WqdWqc45Y9flbPx
        GF2mDLq6sweUTJSf5Cme0FmT1liz+SBEUeRnWAJMAg==
X-Google-Smtp-Source: AFSGD/Xa42s7qlran/2s4FWOHYk5xWmochjhyXZBVfzlmdyFZy2EvirPhMaWO+rQ7u7Ip2B7ZNTDTDx6JtS+Ar/D0xc=
X-Received: by 2002:a02:93c2:: with SMTP id z60mr14982400jah.51.1544543859038;
 Tue, 11 Dec 2018 07:57:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com> <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 11 Dec 2018 16:57:27 +0100
Message-ID: <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
Subject: Re: [PATCH v13 00/25] kasan: add software tag-based mode for arm64
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 4:18 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Andrey,
>
> On Thu, Dec 06, 2018 at 01:24:18PM +0100, Andrey Konovalov wrote:
> > This patchset adds a new software tag-based mode to KASAN [1].
> > (Initially this mode was called KHWASAN, but it got renamed,
> >  see the naming rationale at the end of this section).
> >
> > The plan is to implement HWASan [2] for the kernel with the incentive,
> > that it's going to have comparable to KASAN performance, but in the same
> > time consume much less memory, trading that off for somewhat imprecise
> > bug detection and being supported only for arm64.
>
> For the arm64 parts:
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> I assume that you plan to replace the current patches in -mm with this
> series?
>
> Cheers,
>
> Will

Hi Will,

Yes, that was the intention of sending v13. Should have I sent a
separate patch with v12->v13 fixes instead? I don't know what's the
usual way to make changes to the patchset once it's in the mm tree.

Thanks!
