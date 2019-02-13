Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF6A222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gROyL/QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbfBMVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:42:05 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46738 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbfBMVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:42:04 -0500
Received: by mail-vs1-f67.google.com with SMTP id n10so2343046vso.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnX9KxsN90JRW7XP0d2BKXiuce4XeoYfmQDwUNCm/AE=;
        b=gROyL/QBgZyxJxuq0iCEFddpNxhoBDbwXyAtRE1cndLD/02L87OtBdt4ilJFQF3y/O
         qGOiI/pStqd+PS0kfky+GUvLXpKeUi96UPObZP++3p2LgtlxVzQGsspPwaVFKdTxoTrg
         uEJwnd4yL/xU55NYKcFhE7VwGpfxPiMRUnfXuIWRd0N4zgzAcZN3JdNQ9BPySZTJz3Cd
         FT1UcJq7v3JcGDr1/cBBxhm37FRr4rMlQ1iPs/pr2b3mp4KXaoQGsxMr5U6eIBIEQNb3
         5Nzei10WmUC+ClvctJVxQdSTwERRiYIBdW3IOXyZS8i54XDAauKuMEYg5uqvFgOtLi13
         D0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnX9KxsN90JRW7XP0d2BKXiuce4XeoYfmQDwUNCm/AE=;
        b=snO0Cx4jI7fxfZ1k7SEwCX/HvIa1xC4RDHpTluJH2rABHvxYFm0wZ6g0Y9qeRYAw4V
         zhYQ1YGroFP5zZk6VzHrlSe3Lr/9XnF2+s60LxPun1RY/rRil//RZsdZ7tK/gjjg9HIY
         ULt4Kq/fJffiWYVkqRNtrwF7aij3e4BrcDlpwYI6e8HRmhWnJQgCjURvmk2bMBMIKceh
         a9wS8zP0LepnFwZWnhG6bNT3xFPo8nctzWQVA3ccknly3f9WYTe2IJ48Gk2XY9R4T5eM
         nRWqT5xN+1oLSuhUri6eeC0aI1f/RMNjixRXyr1zYnvvWv/7mA3UsRZnlKmgbM7Ezny3
         L5gw==
X-Gm-Message-State: AHQUAuadPOov2uoo6A64f0r8Z/PmbR1l5mEch6fMN78rFMqLbfMtmkzB
        F9NOJnZFtQb8/uJgcn9A8Et8O2d2jwZAsoxUHdlmoQ==
X-Google-Smtp-Source: AHgI3IY8Wgpc11K5lwy9z/bYE9VzoXcig6E7CpVK5DZ59ma0IqFavo5buVEKJYP7YpvQYpRycgpocjCSuuLzrJKc1MI=
X-Received: by 2002:a67:6f45:: with SMTP id k66mr190871vsc.104.1550094122438;
 Wed, 13 Feb 2019 13:42:02 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com> <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com> <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com> <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com> <20190213145834.GJ3567@e103592.cambridge.arm.com>
 <90c54249-00dd-f8dd-6873-6bb8615c2c8a@arm.com> <20190213174318.GM3567@e103592.cambridge.arm.com>
In-Reply-To: <20190213174318.GM3567@e103592.cambridge.arm.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Wed, 13 Feb 2019 13:41:49 -0800
Message-ID: <CAFKCwrgV0VNJ_jEU79XwkX0o7qLFcqh3MbVMg2=Vs8VKYyY9=Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:43 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, Feb 13, 2019 at 04:42:11PM +0000, Kevin Brodsky wrote:
> > (+Cc other people with MTE experience: Branislav, Ruben)
>
> [...]
>
> > >I'm wondering whether we can piggy-back on existing concepts.
> > >
> > >We could say that recolouring memory is safe when and only when
> > >unmapping of the page or removing permissions on the page (via
> > >munmap/mremap/mprotect) would be safe.  Otherwise, the resulting
> > >behaviour of the process is undefined.
> >
> > Is that a sufficient requirement? I don't think that anything prevents you
> > from using mprotect() on say [vvar], but we don't necessarily want to map
> > [vvar] as tagged. I'm not sure it's easy to define what "safe" would mean
> > here.
>
> I think the origin rules have to apply too: [vvar] is not a regular,
> private page but a weird, shared thing mapped for you by the kernel.
>
> Presumably userspace _cannot_ do mprotect(PROT_WRITE) on it.
>
> I'm also assuming that userspace cannot recolour memory in read-only
> pages.  That sounds bad if there's no way to prevent it.

That sounds like something we would like to do to catch out of bounds
read of .rodata globals.
Another potentially interesting use case for MTE is infinite hardware
watchpoints - that would require trapping reads for individual tagging
granules, include those in read-only binary segment.

>
> [...]
>
> > >It might be reasonable to do the check in access_ok() and skip it in
> > >__put_user() etc.
> > >
> > >(I seem to remember some separate discussion about abolishing
> > >__put_user() and friends though, due to the accident risk they pose.)
> >
> > Keep in mind that with MTE, there is no need to do any explicit check when
> > accessing user memory via a user-provided pointer. The tagged user pointer
> > is directly passed to copy_*_user() or put_user(). If the load/store causes
> > a tag fault, then it is handled just like a page fault (i.e. invoking the
> > fixup handler). As far as I can tell, there's no need to do anything special
> > in access_ok() in that case.
> >
> > [The above applies to precise mode. In imprecise mode, some more work will
> > be needed after the load/store to check whether a tag fault happened.]
>
> Fair enough, I'm a bit hazy on the details as of right now..
>
> [...]
>
> > There are many possible ways to deploy MTE, and debugging is just one of
> > them. For instance, you may want to turn on heap colouring for some
> > processes in the system, including in production.
>
> To implement enforceable protection, or as a diagnostic tool for when
> something goes wrong?
>
> In the latter case it's still OK for the kernel's tag checking not to be
> exhaustive.
>
> > Regarding those cases where it is impossible to check tags at the point of
> > accessing user memory, it is indeed possible to check the memory tags at the
> > point of stripping the tag from the user pointer. Given that some MTE
> > use-cases favour performance over tag check coverage, the ideal approach
> > would be to make these checks configurable (e.g. check one granule, check
> > all of them, or check none). I don't know how feasible this is in practice.
>
> Check all granules of a massive DMA buffer?
>
> That doesn't sounds feasible without explicit support in the hardware to
> have the DMA check tags itself as the memory is accessed.  MTE by itself
> doesn't provide for this IIUC (at least, it would require support in the
> platform, not just the CPU).
>
> We do not want to bake any assumptions into the ABI about whether a
> given data transfer may or may not be offloaded to DMA.  That feels
> like a slippery slope.
>
> Providing we get the checks for free in put_user/get_user/
> copy_{to,from}_user(), those will cover a lot of cases though, for
> non-bulk-IO cases.
>
>
> My assumption has been that at this point in time we are mainly aiming
> to support the debug/diagnostic use cases today.
>
> At least, those are the low(ish)-hanging fruit.
>
> Others are better placed than me to comment on the goals here.
>
> Cheers
> ---Dave
