Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4CC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93DC20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t05Y81Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbfALQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:50:55 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33409 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfALQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:50:54 -0500
Received: by mail-yw1-f65.google.com with SMTP id p65so7071390ywe.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaO7ZxXFClP1+k1Rrf7irHfcf76KrsN+FQv9UEeh0gk=;
        b=t05Y81BuMZSuJ3Qf03/s29f5cEJAeohwbr5hZJc2RrcPRO6eHvSCEwsoBZ8TncZdL9
         PmSFv57lPf98jmd7DJUXckoKesFwgGPp40VY4Gblne/wQyqG/r/MqToljc9zsCz0qxKp
         aRnm5M1tt5gMo/vHEU2zJp8W2o3GF8OgA4ajXs0FGG40PWe6hFw+ca4OkI60pLBD3kWB
         2n2BGWP7tzRyD26c8OTdhD2D0L1F4/eMN6vCzDo06ugdYINGlLUAp76YatbfknmKYRpH
         RxNfLgU6S5LVmaxnqLCcIX5XK4x4ZS2dNEqHJe3KNImCAkYzyXEhDG7xdyu1Mm9rEMYB
         k3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaO7ZxXFClP1+k1Rrf7irHfcf76KrsN+FQv9UEeh0gk=;
        b=DPTwpFXYJAc5SO4qcBcUlnc3qEBBRMlXLD1Tvw3x8EQE5tyhORSOu70+AqCI0JFQaf
         I6cSZIFlPcAIbp1WBwT+6eID+KgBfozxV8F7nj9hHYmUZBFjO/4EbdcSczRCRvzfmbjh
         Fv6K7ewYM/XvVbuRX7bxt2PCN46XujVU+bez37JUttZdgJAh3amdphZ+scNxGXgSjhwq
         WiGkaD8Dnhl4rc3KWktpA6cFEXAnVM5vRGPF1sZ7BXSRDnsYnKnm1uPAWPFdQedUoGwQ
         d/RCIv9MdX2J2tOQrQK+1GhLKuc68o1wl1g5ILpZ2wDddtEy5BOolhOyweh0q7v5SoVl
         2iEQ==
X-Gm-Message-State: AJcUukdt5ZiQtceVwj2Opgafey0kClRy8DcK2fFvwOnbBV7M/9pcFBl5
        ByM/g6fquWRqw65fISsH0e7nIUJDClaskpEBYVcdDw==
X-Google-Smtp-Source: ALg8bN6XzD17LVLAX7m/kSOcIUQ121Lu7vVxRfY/g+CIrLDeBR87sI3stQrULnEovy6QxqBn0V1BYoxbhWieErSfFEc=
X-Received: by 2002:a81:60c4:: with SMTP id u187mr18077076ywb.345.1547311853069;
 Sat, 12 Jan 2019 08:50:53 -0800 (PST)
MIME-Version: 1.0
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org> <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
 <20190112154944.GT6310@bombadil.infradead.org>
In-Reply-To: <20190112154944.GT6310@bombadil.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 12 Jan 2019 08:50:42 -0800
Message-ID: <CALvZod5XfFujzzMC0n2dZmofjof0juWw45RF4475CAEu9nAv3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, Michal Hocko <mhocko@suse.com>,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, Dave Hansen <dave.hansen@linux.intel.com>,
        will.deacon@arm.com, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, kvmarm@lists.cs.columbia.edu,
        linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>, marc.zyngier@arm.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, steve.capper@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        aneesh.kumar@linux.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
> > As far as I can see,
> >
> > #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> >
> > So what's the difference between:
> >
> > (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
> >
> > and
> >
> > (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT
>
> Nothing.  But there's a huge difference in the other parts of that same
> file where GFP_ACCOUNT is _not_ used.
>
> I think this unification is too small to bother with.  Something I've
> had on my todo list for some time and have not done anything about
> is to actually unify all of the architecture pte/pmd/... allocations.
> There are tricks some architectures use that others would benefit from.

Can you explain a bit more on this? If this is too low priority on
your todo list then maybe me or someone else can pick that up.

Shakeel
