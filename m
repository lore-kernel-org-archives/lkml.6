Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2126218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnD5KmCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfB0IVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:21:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33766 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfB0IVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:21:54 -0500
Received: by mail-it1-f193.google.com with SMTP id f186so4542751ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 00:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8Fu1OStHytMuHz2phprGWy8fg13Av4NZhgoBm53868=;
        b=WnD5KmCr6bNu8ojyT6VT/8DKYzSzj2W5NQqij8pMRb//FkLRM4IyBnHNg4xvxqojAe
         AVKl94OZJhKxnfUvftPQz0DokXwJCvHJAkj/HpbfX8RZjs+aw4BA9WbBWU4fZ5NPI6TV
         mVS8Ka19o7qBVZgwn0SrBty2nU3iyBh9L5CK1h3vOSmz2rdTolrRXbSLJ0f2if1ypbrp
         7IjU5mjFmFyOcFnuViHhqY4KbzoY28dgyaCr6fmgBdKBZRxYTrgG4oLcc4zVhvg/6I+x
         d2bA7hAWxrYFs0uaKlf3OZWmjKM3BCBLvsd3ndkKEjzJK/o5mxijY+mqvccACHT0acCQ
         WS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8Fu1OStHytMuHz2phprGWy8fg13Av4NZhgoBm53868=;
        b=K99dpFPqpiKJDdnV9DS1DQmGzFoETppMDVO/1zCPjIDbKbNBa3HWfGzZRR38wmaho9
         L1QzMKksoR2mttVQ5ymLbpr4HpedtSggec6i/t+CalRewxk6O/IRcGErgDsWzH+JLC1c
         5uSEnq+zmGjdonL4s476NpB4ChdwBQKQDEQm2gGu4l+3oeM/n9OtWm9+9sdFRWYpbNVq
         jsAvvRc4AI/5+bhyjO61T6V+E5YRKs1P34sZw992qIqbsbgalfmPWwbbAaIkN7jv0G3B
         3/IqOgtXLIjEClVm6cx9i8ZfQihHSw9w+Kz3QtEbtvXjLZApwmXYMFfQwnM+Ke2QFd1B
         94aA==
X-Gm-Message-State: AHQUAuaYm+aK/OSy2yRgcauXq90wdqE+A2LaQZzhWB4bG2+Qu+fh7Fvc
        E6Ge/A5m4CmURV0PqzC8rwDSx1zbPzL+NytGv00M2g==
X-Google-Smtp-Source: AHgI3IaGyk3ci7BPj0PjsMcDLz8V/qaI2YtkvCf8NBVM3Otq3AIfZ1Tn8bKrZyrV6JKE6VAB9a7rpiBO0rSyQ3dEO2E=
X-Received: by 2002:a02:84ab:: with SMTP id f40mr553083jai.72.1551255713270;
 Wed, 27 Feb 2019 00:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20180514030007.GH677@sol.localdomain> <20180514030205.GI677@sol.localdomain>
 <CACT4Y+bV3HQTZ5+ugQmukiiJBkhN_FWqPRuNRYRbe6xoKstWVA@mail.gmail.com>
 <20180514172508.GC252575@gmail.com> <CACT4Y+Y9O34yzF=0wj9X6kzW19x8o-0LECcWWTb7KJDo7KYaXA@mail.gmail.com>
 <20190227071411.GB680@sol.localdomain>
In-Reply-To: <20190227071411.GB680@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Feb 2019 09:21:42 +0100
Message-ID: <CACT4Y+YmNOOTCQu_maU4vR2+s0Oehc860B9=MKMHQ_pZhB5orw@mail.gmail.com>
Subject: Re: CONFIG_KCOV causing crash in svm_vcpu_run()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 8:14 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Reviving this old thread because it wasn't fully fixed after all...
>
> On Tue, May 15, 2018 at 07:33:48AM +0200, Dmitry Vyukov wrote:
> > On Mon, May 14, 2018 at 7:25 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > > On Mon, May 14, 2018 at 07:14:41AM +0200, Dmitry Vyukov wrote:
> > >> On Mon, May 14, 2018 at 5:02 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > >> > Sorry, messed up address for KVM mailing list.  See message below.
> > >> >
> > >> > On Sun, May 13, 2018 at 08:00:07PM -0700, Eric Biggers wrote:
> > >> >> With CONFIG_KCOV=y and an AMD processor, running the following program crashes
> > >> >> the kernel with no output (I'm testing in a VM, so it's using nested
> > >> >> virtualization):
> > >> >>
> > >> >>       #include <fcntl.h>
> > >> >>       #include <linux/kvm.h>
> > >> >>       #include <sys/ioctl.h>
> > >> >>
> > >> >>       int main()
> > >> >>       {
> > >> >>               int dev, vm, cpu;
> > >> >>               char page[4096] __attribute__((aligned(4096))) = { 0 };
> > >> >>               struct kvm_userspace_memory_region memreg = {
> > >> >>                       .memory_size = 4096,
> > >> >>                       .userspace_addr = (unsigned long)page,
> > >> >>               };
> > >> >>               dev = open("/dev/kvm", O_RDONLY);
> > >> >>               vm = ioctl(dev, KVM_CREATE_VM, 0);
> > >> >>               cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
> > >> >>               ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
> > >> >>               ioctl(cpu, KVM_RUN, 0);
> > >> >>       }
> > >> >>
> > >> >> It bisects down to commit b2ac58f90540e39 ("KVM/SVM: Allow direct access to
> > >> >> MSR_IA32_SPEC_CTRL").  The bug is apparently that due to the new code for
> > >> >> managing the SPEC_CTRL MSR, __sanitizer_cov_trace_pc() is being called from
> > >> >> svm_vcpu_run() before the host's MSR_GS_BASE has been restored, which causes a
> > >> >> crash somehow.  The following patch fixes it, though I don't know that it's the
> > >> >> right solution; maybe KCOV should be disabled in the function instead, or maybe
> > >> >> there's a more fundamental problem.  What do people think?
> > >>
> > >>
> > >> If __sanitizer_cov_trace_pc() crashes, I would expect there must be
> > >> few more of them here:
> > >>
> > >> if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
> > >>     svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
> > >>
> > >> if (svm->spec_ctrl)
> > >>     native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> > >>
> > >> Compiler inserts these callbacks into every basic block/edge.. Aren't there?
> > >>
> > >> Unfortunately we don't have an attribute that disables instrumentation
> > >> of a single function. This is currently possible only on file level.
> > >>
> > >
> > > Yes, due to the code dealing with MSR_IA32_SPEC_CTRL, there were several calls
> > > to __sanitizer_cov_trace_pc() before the write to MSR_GS_BASE.  The patch I
> > > tested moves the write to MSR_GS_BASE to before all of them, so it's once again
> > > the first thing after the asm block.  Again I'm not sure it's the proper
> > > solution, but it did make it stop crashing.
> >
> > From KCOV perspective:
> > This is definitely the simplest and less intrusive solution.
> > It's somewhat unreliable. But it's hard to tell if/when it will
> > actually break in practice. Compiler can decide to insert the callback
> > after asm block, or a branch can be added to wrmsrl (e.g. under some
> > debug config). More reliable solution would be to restore registers in
> > asm block itself, or move this to a separate file and disable
> > instrumentation of that file (though, will not save from non-inlined
> > wrmsrl). But again, the proposed solution may work well for the next
> > 10 years, so additional complexity may not worth it.
> >
> > Btw, I don't see anything about fs/gs in vmx_vcpu_run. Is it VMLAUNCH
> > that saves/restores them?
>
> So it turns out there *is* a branch in wrmsrl() when CONFIG_PARAVIRT=y &&
> CONFIG_PARAVIRT_DEBUG=y, and that causes the same crash: the compiler inserts a
> call to __sanitizer_cov_trace_pc() prior to the GS_BASE register being restored
> in svm_vcpu_run().
>
>         #ifdef CONFIG_PARAVIRT_DEBUG
>         #define PVOP_TEST_NULL(op)      BUG_ON(pv_ops.op == NULL)
>         #else
>         #define PVOP_TEST_NULL(op)      ((void)pv_ops.op)
>         #endif
>
> Dmitry, in the long run maybe this should be solved by adding a function
> attribute to gcc that disables coverage for a function?
>
> But for now maybe CONFIG_KCOV should depend on !CONFIG_PARAVIRT_DEBUG?  Or does
> anyone have a better idea?  Alternatively as Dmitry suggested, svm_vcpu_run()
> could be moved to a separate file and compiled with different flags...


Re attribute. This is only place this come up so far. No precedents in
user-space and kernel is also quite extensive tested as well. Though
we bulk ignore some files involved in early boot, maybe the attribute
would be useful in some of these files too. E.g.:
https://bugzilla.kernel.org/show_bug.cgi?id=198443
We could add it, but adding an attribute to both compilers is not
something completely trivial and will take time to propagate to users.
I would go with some solution local to SVM for now.

It would be nice to restore segment registers right in the asm block
so that C code always have proper normal context for execution (e.g.
can affect KASAN/KMSAN/KTSAN too). But with paravirt it's not trivial,
right? At least not as trivial as executing WRMSR.
