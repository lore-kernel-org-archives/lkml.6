Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDEAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14CC218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYB+Xu+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfA3TfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:35:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfA3TfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:35:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so629347oii.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yshu7Nu72+Dtk8rXL7JZUEueFPkhXdQ3uQBa9T7+FI8=;
        b=HYB+Xu+lqUkubBO9J+MbB83KhACX2c6ZCtNkmClbu5N4zCrW3Mu7YVFuwbEeXs1hcy
         BVAJNOjpO1VF6DXo4DlaRzWieNFvTz7eWJJgXe6dzEgcPnWrVQzMeLzqSn277CHoSS6D
         upGbxRbGy4ngHeuqNHJ6MdF+hWfabsm3ChRunH+F2aZVfnlAD23XMHxWfNGcUQQvRciP
         0PjrelBuZgpe/j4jIdecT7oL6cgtu088WSjJRWbkglD7wRM7TUipK9ZCwF6AVXOw/yCT
         sO/pp7u3Qkz43e0yV4hlOCmre9lifyq5FrP8NYiwpJWk/uGDtUXMpF8hUd2y0bklWom2
         psJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yshu7Nu72+Dtk8rXL7JZUEueFPkhXdQ3uQBa9T7+FI8=;
        b=oMpcqF5rJ3rzMk85dJZaNe2ZqevIR+ESsN9//1g6cKpqH8VvknsQFaloPCLNpYQ60D
         RJKF8wvKZkSs4wNPeYUV3XUNSXpS4Ua0ZfLaMu6CMmQgfRMGSTE+Iwv2tpthi/TSMO7f
         p+L5+XFSQ9i9DdyKf5CuD2dIDyVDdEP87ZODPdNMvIrU/nM/d+smaYmknl7Wn3gGGD7h
         jaegqqdzIrMtFQN/osij92TiZziFnwI1YuFWtzOc0IUir+rsaH2qo2KjSrpRGXrd+cJr
         qJD+8Eq2ic7g57yXjbJ6g8ssXpW0tUq6CzuYpDrbUhXDWaVRKh+I29jDfxLDRgRYkZG+
         KDew==
X-Gm-Message-State: AJcUukfqqhsP80/iy30FgfRaaGyyQ+8sdZab/w4Nk8P+HxtIrUHh7p/y
        mM8p17f8PYUM8KMchP0klES2qR7vKlqqfHCLpCidZQ==
X-Google-Smtp-Source: ALg8bN6hGKJnwAHsVa0igPx6WrWGeK6tM0dXYVfZJXpbjOb3IwGwK4BPXPa9qEXCDMEobRiXHFXi75Ss6vjpxle5Wd0=
X-Received: by 2002:aca:c413:: with SMTP id u19mr12681145oif.209.1548876918558;
 Wed, 30 Jan 2019 11:35:18 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
 <20190130182157.GP18558@fuggles.cambridge.arm.com>
In-Reply-To: <20190130182157.GP18558@fuggles.cambridge.arm.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Jan 2019 20:34:52 +0100
Message-ID: <CAG48ez2FMfyagDedETV54sFEit_mJy00iqBFsNngyeT=g=a4PA@mail.gmail.com>
Subject: Re: ARM64 suggestion: reduce the compat address limit (currently 0x100000000)?
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 7:22 PM Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jan 30, 2019 at 05:32:00PM +0100, Jann Horn wrote:
> > At the moment, compat tasks running on ARM64 can allocate memory up to
> > 0x100000000 (TASK_SIZE_32). Testing on an Android device (with an
> > admittedly somewhat old kernel):
>
> [...]
>
> > ffff1000-100000000 rw-p 00000000 00:00 0
> >
> > This means that mmap() allocations do not adhere to section 6.5.8 of
> > C99 ("If the
> > expression P points to an element of an array object and the
> > expression Q points to the
> > last element of the same array object, the pointer expression Q+1
> > compares greater than
> > P.") if you treat mmap() allocations as returning an array.
>
> Oh, good point.
>
> > In practice, I've also seen code that does things like computing a
> > pointer that is out of bounds by a few bytes and then comparing it
> > against the end of the array; while this is UB according to C99, it
> > probably makes sense to try to avoid breaking such code.
>
> Agreed, and since the current behaviour isn't something you can portably
> rely on anyway, I think we're ok to change it.
>
> > X86-64's compat code uses the limit 0xFFFFe000 (IA32_PAGE_OFFSET),
> > which I think makes more sense. Would it make sense to do something
> > like the following (untested)?
>
> Can't we just go with 0x100000000 - PAGE_SIZE instead?

Ah, yeah, sounds good. I think x86 probably only chose 0xFFFFe000 to
keep user allocations out of the way for the 32-bit vsyscall page.
