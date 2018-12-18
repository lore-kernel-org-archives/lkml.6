Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B08C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B28218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPlCvfML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeLRNbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:31:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45549 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLRNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:31:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so8125588pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h86N0lQF/Ig6ovkqWBcT1Ptx1emyXtcvgQtnEfD7pfE=;
        b=sPlCvfMLVbvOGvRmjIW74DD0y2VL1C2eFWGnGubSq9KW1xkb/nWs6ncO7SEGWLRap9
         HeJj6vu+f3NESKHkonRKNkVwk7/a2vwQLSqUOyuy/7JewrG8QLMA4g7L7eboTJ5MOjuw
         uQ0scx3+jzQ/NJZNAuEC2eQjpQcsy8iTW4+6jukLsfbIuc3B5Wdf6rewdeY8mDdiddg0
         MGGKMpxC2NzZwf0R4z2j5bXRASxaU/uxCP8PWGn6G2nWHtXNdKUit5vcUgEMDFEqWm90
         swsmcyTvqwnx1VlFw0xpNBhfE4KpZBaCgAYy6r8lf1IFdsBBo+xas2+uwSjZy+5L7pST
         GQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h86N0lQF/Ig6ovkqWBcT1Ptx1emyXtcvgQtnEfD7pfE=;
        b=rlam8IvihDST94EI3eLa9UVxzvam37JOScwHUCtI83E4+JTO23ZTPls4b88lKOAl4j
         /n2cIWvniZXuZCECZ0SDbZmsDw1fVkRyYX6UNHV/lWG8yVCqHvwJEc2oHxYMPpnRC30w
         crji6KJYlOVb5OcNUimgGQyIUm7EitapFa16uvQ7FQY0TlmoqUbF6QgdNOwXUwZ77/xY
         EDgR87IBH/lecW2G0tBRWUAXDxeujxjW2wPg7qICFA2Mqkhv4XAUd5XMhJOev+ZUT6Cu
         lAGCBxCJsaa+7U4tCZC5BH+ljX/+rGmnF+Mh+I1a9JdVXf4rBTae0InscfuX2l9tWHfr
         i4tg==
X-Gm-Message-State: AA+aEWa45ichMhAaJlXKIGycnBZ/BkESRM8Ya33npeegRqTF35GIPxSM
        iBwld8apaX97NUFkhx7jF3yoAXC3HOZuppYzwUETcw==
X-Google-Smtp-Source: AFSGD/V1y6RmJq++xX3WVMmh9McpQSeGS8sVPblnd2Z0tV/Kjgr0Yw2uYDMO66qXbrbv2zeRDPz0TU7hojM4U8P6vj4=
X-Received: by 2002:a62:1c86:: with SMTP id c128mr1807442pfc.54.1545139908555;
 Tue, 18 Dec 2018 05:31:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com> <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com> <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
 <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com> <CAAeHK+w2jppKbb26bBk6uP9ydZeHrtNc6b2CVv4xbvt6ecVooA@mail.gmail.com>
 <20181217123847.492b9ae4934bd0d95b0bbbdc@linux-foundation.org>
In-Reply-To: <20181217123847.492b9ae4934bd0d95b0bbbdc@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 18 Dec 2018 14:31:37 +0100
Message-ID: <CAAeHK+yiGcu4u7rvugfY7wGUiHug7C1wvSuygXN6L5-wWMHtyw@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based mode
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
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
        Vishwath Mohan <vishwath@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 9:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 17 Dec 2018 20:33:42 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > > Curiosity, did you try your patches with SLUB red zoning enabled?
> > > Since the area used for the Redzone is just after the payload, aligning the
> > > object_size independently from the allocator could have side effects, at least
> > > if I understand well how the mechanism works.
> > >
> > > Setting ARCH_SLAB_MINALIGN should avoid this as well.
> > >
> > > What do you think?
> >
> > Sounds good to me.
> >
> > Andrew, how should proceed with this? Send another fixup patch or
> > resend the whole series?
>
> It depends on how extensive the changes are.  I prefer a fixup, but at
> some point it's time to drop it all and start again.

The fixup in only a few lines, so I just sent it as a separate patch
named "[PATCH mm] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
manual aligning".

Thanks!
