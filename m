Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDCCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AB6218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX+nY/00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLRRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:17:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41470 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeLRRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:17:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so8102802plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=442vwuYNQl3+5+R2IJ9SAnj2SpikSYGCJwnnp94ndjs=;
        b=YX+nY/00hzrzrhGcabJW/utVNQDVyaI34CjDeDXKdc+Rseslqj7UR8Ddf5oCmldnMu
         NOITKWcZM2vowIlLpKt8CFETsRtFUdkcTxML5wsC57nFe7RVhaopiw/fpJa930YD6t74
         8qfLKIhzkFAR5R0nPvqEbmcfgcUKGMA6Pr7RQPrUBaub+zeGk0TkNL69RRZVX/uaowCb
         pBoU6GGUSJhH5lfPOab4FTFUAf665kyCMpzfWH3BAUmlCElkBEhTU3/yWqBfbVQOOKaR
         C5LvriU6dLuNtMc9zhUa7YvuK42A2ONFp1wckXdby+ZB+ujj9fA/of8OCMQ/xJH6B8mW
         JIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=442vwuYNQl3+5+R2IJ9SAnj2SpikSYGCJwnnp94ndjs=;
        b=PKZ5DhOn4TX8fvcqkzSynscebp/wWT9ibjj1MFi2EVfbPNCKxUxF5AvnrJTOJ+WUq2
         V56ll219PDo/urd0MJKjakp2d0GuiFk6IWruEnj+E+9FF+RTUK+Ov1HWjZnR8b4HEdnh
         HMBEzhY/g3+ZuK2rgL5bviftBcow3gC9jmYXAtYycXqvNnIH2mlsqwpYUzOn3Sw6kkaP
         5jMTZ/YPpVHYCWvHsXxFsFR72fFnMBMvpfjpWyllwX4JzGJGDDeH6XTQXoW+hKKWt8ME
         vKfQXGNaKSg/oAc2T8wRdjWkoEiT5GNJgjR9pEwUeP6hMac46PfPzIucCMioCXrDSK/1
         KfGA==
X-Gm-Message-State: AA+aEWbHBy+6uJXjC+hp1Dv7VbKjuiBBAcNIlLpip3e8Wgk5/3BLESti
        ZDJQPO1dVNY5dZhZR8/osLY0c844jyMpMuKDSSe7HQ==
X-Google-Smtp-Source: AFSGD/XG6prkkaGhEvsMh8RZmmoz4vN18xdqZlmvYKp7Ep4oBBgcJW+0c2dBBYrLaiWSMA/XFYvCi2eisvSYSxagorI=
X-Received: by 2002:a17:902:b406:: with SMTP id x6mr16359864plr.329.1545153463562;
 Tue, 18 Dec 2018 09:17:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544445454.git.andreyknvl@google.com> <20181212170108.GZ3505@e103592.cambridge.arm.com>
In-Reply-To: <20181212170108.GZ3505@e103592.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 18 Dec 2018 18:17:31 +0100
Message-ID: <CAAeHK+zf=qxfk0yRp-yb7rAJLFdUXJdidq5tA-x8-EBdV7kE7A@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] arm64: untag user pointers passed to the kernel
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 6:01 PM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Dec 10, 2018 at 01:50:57PM +0100, Andrey Konovalov wrote:
> > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > tags into the top byte of each pointer. Userspace programs (such as
> > HWASan, a memory debugging tool [1]) might use this feature and pass
> > tagged user pointers to the kernel through syscalls or other interfaces.
> >
> > Right now the kernel is already able to handle user faults with tagged
> > pointers, due to these patches:
> >
> > 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
> >              tagged pointer")
> > 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> >               pointers")
> > 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> >               pointers")
> >
> > When passing tagged pointers to syscalls, there's a special case of such a
> > pointer being passed to one of the memory syscalls (mmap, mprotect, etc.).
> > These syscalls don't do memory accesses but rather deal with memory
> > ranges, hence an untagged pointer is better suited.
> >
> > This patchset extends tagged pointer support to non-memory syscalls. This
> > is done by reusing the untagged_addr macro to untag user pointers when the
> > kernel performs pointer checking to find out whether the pointer comes
> > from userspace (most notably in access_ok). The untagging is done only
> > when the pointer is being checked, the tag is preserved as the pointer
> > makes its way through the kernel.
> >
> > One of the alternative approaches to untagging that was considered is to
> > completely strip the pointer tag as the pointer enters the kernel with
> > some kind of a syscall wrapper, but that won't work with the countless
> > number of different ioctl calls. With this approach we would need a custom
> > wrapper for each ioctl variation, which doesn't seem practical.
> >
> > The following testing approaches has been taken to find potential issues
> > with user pointer untagging:
> >
> > 1. Static testing (with sparse [2] and separately with a custom static
> >    analyzer based on Clang) to track casts of __user pointers to integer
> >    types to find places where untagging needs to be done.
> >
> > 2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
> >    a modified syzkaller version that passes tagged pointers to the kernel.
> >
> > Based on the results of the testing the requried patches have been added
> > to the patchset.
> >
> > This patchset has been merged into the Pixel 2 kernel tree and is now
> > being used to enable testing of Pixel 2 phones with HWASan.

Hi, Dave,

>
> Do you have an idea of how much of the user/kernel interface is covered
> by this workload?

Not really. I don't even know what kind of measurements can be used to
obtain this estimate. But Pixel 2 kernel with these patches + Android
runtime instrumented with HWASan works.

>
> > This patchset is a prerequisite for ARM's memory tagging hardware feature
> > support [3].
>
> It looks like there's been a lot of progress made here towards smoking
> out most of the sites in the kernel where pointers need to be untagged.
>
> However, I do think that we need a clear policy for how existing kernel
> interfaces are to be interpreted in the presence of tagged pointers.
> Unless we have that nailed down, we are likely to be able to make only
> vague guarantees to userspace about what works, and the ongoing risk
> of ABI regressions and inconsistencies seems high.
>
> I don't really see how we can advertise a full system interface if we
> know some subset of it doesn't work for foreseeable userspace
> environments.  I feel that presenting the current changes as an ABI
> relaxation may be a recipe for future problems, since the forwards
> compatibility guarantees we're able to make today are few and rather
> vague.
>
> Can we define an opt-in for tagged-pointer userspace, that rejects all
> syscalls that we haven't checked and whitelisted (or that are
> uncheckable like ioctl)?  This reflects the reality that we don't have
> a regular userspace environment in which standards-compliant software
> that uses address tags in a reasonable way will just work.
>
> It might be feasible to promote this to be enabled by default later on,
> if it becomes sufficiently complete.
>
>
> In the meantime, I think we really need to nail down the kernel's
> policies on
>
>  * in the default configuration (without opt-in), is the presence of
> non-address bits in pointers exchanged with the kernel simply
> considered broken?  (Even with this series, the de factor answer
> generally seems to be "yes", although many specific things will now
> work fine)
>
>  * if not, how do we tighten syscall / interface specifications to
> describe what happens with pointers containing non-address bits, while
> keeping the existing behaviour for untagged pointers?
>
> We would want a general recipe that gives clear guidance on what
> userspace should expect an arbitrarily chosen syscall to do with its
> pointers, without having to enumerate each and every case.
>
> To be sustainable, we would also need to solve that in a way that
> doesn't need to be reintented per-arch.

As I understand your main concern is userspace/kernel ABI changes
these patches introduce. This concern was already pointed out by
Catalin, and working out the details is still in progress.

>
> There may already be some background on these topics -- can you throw me
> a link if so?

I don't have a single link, I would suggest to look at the comments
for all the previous versions of this patchset. I see you saw the
pathset by Vincenzo, it also has some information about this.

>
> Cheers
> ---Dave

Thanks!
