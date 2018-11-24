Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB64DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7755420868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7755420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeKYG4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:56:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40932 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeKYG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:56:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so13236909lji.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+mguipRos5p4Wl26EiwNQqfwIiTrQ/3gIJ3YG2DlqU=;
        b=hPBC4nZ2I4uXr64EfIjoFDzQ0+T9wk6wBEkFJSZ48ehyquQCW3PrPAcFGnREWBu9ng
         rSlgnznzC8DTqINuPzQne3oIx2mUKcsMPDWDeaE91pXIfpg90tjog7IK7+1FLDXHXon/
         w0YnL/DUPmk/NVuwedUmNBUQw4zdoExWjCeWNh4vJvSqiAxddFIie9oUAy5KpHKnPAjE
         eO70WEr/M8CBQHb4xoER8zIMIIqJ2w4MSvicpHVNkkLaVJmWzsNUxVb3nvL885oPaQLA
         01fePkoJxGupk2kBNzyKD1SbHBUxBQ0kibPn4ZBVEb5cv+uRNo6YBNkrG/Ub4EpF62sZ
         5/ow==
X-Gm-Message-State: AA+aEWZyClTExFYYKYVfslZu8DWxJKgiY7jM39epBTREi4URKSfqVmRv
        ti4HOGK4L42WBSyaW9i6DzeCUjUnllpAgz/PD3I4og==
X-Google-Smtp-Source: AJdET5fjk29ojtu51yPyaKT1wfzAT8o9Z0BFI0JCY7ADKR9FAteR0FCCgQCGSpyTHN6yu0rvoU+VAkF9zRoyTtkXO0g=
X-Received: by 2002:a2e:8449:: with SMTP id u9-v6mr14427727ljh.121.1543090011542;
 Sat, 24 Nov 2018 12:06:51 -0800 (PST)
MIME-Version: 1.0
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com> <20181121113944.GD27797@zn.tnic>
In-Reply-To: <20181121113944.GD27797@zn.tnic>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Sun, 25 Nov 2018 01:36:37 +0530
Message-ID: <CACi5LpPx1bmH6duAbWFNMVStg-2GR=dSVuKrEfVCko8HzmqF_A@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thanks for your review. Please see my replies inline:

On Wed, Nov 21, 2018 at 5:10 PM Borislav Petkov <bp@alien8.de> wrote:
>
> + Kees.
>
> On Fri, Nov 16, 2018 at 03:17:49AM +0530, Bhupesh Sharma wrote:
> > x86_64 kernel uses 'page_offset_base' variable to point to the
> > start of direct mapping of all physical memory. This variable
> > is also updated for KASLR boot cases, so this can be exported
> > via vmcoreinfo as a standard ABI between kernel and user-space,
> > to allow user-space utilities to use the same for calculating
> > the start of direct mapping of all physical memory.
> >
> > 'arch/x86/kernel/head64.c' sets the same as:
> >    unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
> >
> > and also uses the same to indicate the base of KASLR regions on x86_64:
> >    static __initdata struct kaslr_memory_region {
> >           unsigned long *base;
> >               unsigned long size_tb;
> >    } kaslr_regions[] = {
> >           { &page_offset_base, 0 },
> >    .. snip ..
>
> Why is that detail needed in the commit message?

This (and similar) details were requested by Baoquan during the v1
review, that is why I added them to the v2 commit log.
Although personally I also think that such details are probably not
needed in a commit log (may be better suited for a cover letter, which
is maybe a overkill for this single patch).
Will drop this from v3.

> > Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> > live-debugging of a running kernel via user-space utilities
> > like makedumpfile (see [1]).
> >
> > Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
>
> Use passive tone in your commit message: no "we" or "I", etc.

Ok.

> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst.

Ok.

> > details), whose live debugging feature is broken with newer kernels
> > (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> > added to kcore, thus leading to an additional sections in the same, and
> > makedumpfile is not longer able to determine the start of direct
> > mapping of all physical memory, as it relies on traversing the PT_LOAD
> > segments inside kcore and using the last PT_LOAD segment
> > to determine the start of direct mapping.
> >
> > Such user-space issues can be resolved if the user-space code instead
> > uses a standard ABI to read the kernel exposed machine specific
> > variables. With the kernel commit 23c85094fe1895caefdd
> > ["proc/kcore: add vmcoreinfo note to /proc/kcore"]), it is
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to /proc/kcore")'
> #54:
> variables. With the kernel commit 23c85094fe1895caefdd

Ok.

> > now possible to use the vmcoreinfo present inside kcore as the standard
> > ABI which can be used by the user-space utilities for reading
> > the machine specific information (and hence for debugging a
> > live kernel).
> >
> > User-space utilities like makedumpfile, kexec-tools and crash
> > are either already using this ABI or are discussing patches
> > which look to add the same feature. This helps in simplifying the
> > overall code and also in reducing code-rewrite across the
> > user-space utilities for getting values of these kernel
> > symbols/variables.
>
> > Accordingly this patch allows appending 'page_offset_base' for
> > x86_64 platforms to vmcoreinfo, so that user-space tools can use the
> > same as a standard interface to determine the start of direct mapping
> > of all physical memory.
> >
> > Testing:
> > -------
> >  - I tested this patch (rebased on 'linux-next') on a x86_64 machine
> >    using the modified 'makedumpfile' user-space code (see [3] for my
> >    github tree which contains the same) for determining how many pages
> >    are dumpable when different dump_level is specified (which is
> >    one use-case of live-debugging via 'makedumpfile').
> >  - I tested both the KASLR and non-KASLR boot cases with this patch.
> >  - Here is one sample log (for KASLR boot case) on my x86_64 machine:
> >
> >    < snip..>
> >    The kernel doesn't support mmap(),read() will be used instead.
> >
> >    TYPE               PAGES                   EXCLUDABLE      DESCRIPTION
> >    ----------------------------------------------------------------------
> >    ZERO               21299                   yes             Pages filled
> >    with zero
> >    NON_PRI_CACHE      91785                   yes             Cache
> >    pages without private flag
> >    PRI_CACHE  1                       yes             Cache pages with
> >    private flag
> >    USER               14057                   yes             User process
> >    pages
> >    FREE               740346                  yes             Free pages
> >    KERN_DATA  58152                   no              Dumpable kernel
> >    data
> >
> >    page size:         4096
> >    Total pages on system:     925640
> >    Total size on system:      3791421440       Byte
> >
> > [1]. MAN pages -> MAKEDUMPFILE(8) and CRASH(8)
> > [2]. makedumpfile issue with latest kernels -> http://lists.infradead.org/pipermail/kexec/2018-October/021769.html
> > [3]. https://github.com/bhupesh-sharma/makedumpfile/tree/add-page-offset-base-to-vmcore-v1
> >
> > Cc: Boris Petkov <bp@alien8.de>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Cc: Dave Anderson <anderson@redhat.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: x86@kernel.org
> > Cc: kexec@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> > Changes since v1:
> >  - Fixed the build issue reported by build bot and tested this version
> >    with 'make allmodconfig'.
> >  - Reworded most of the commit log to explain the intent behind the
> >    patch.
> >
> >  arch/x86/kernel/machine_kexec_64.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 4c8acdfdc5a7..6161d77c5bfb 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >       VMCOREINFO_SYMBOL(init_top_pgt);
> >       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >                       pgtable_l5_enabled());
> > +#ifdef CONFIG_RANDOMIZE_BASE
> > +     VMCOREINFO_NUMBER(page_offset_base);
> > +#endif
> >
> >  #ifdef CONFIG_NUMA
> >       VMCOREINFO_SYMBOL(node_data);
> > --
>
> All above are only nitpicks though.

Right the above are mostly nitpicks, but useful ones, so I will
address these in the v3.

> My opinion is this: people are exporting all kinds of kernel-internal
> stuff in vmcoreinfo and frankly, I'm not crazy about this idea.
>
> And AFAICT, this thing basically bypasses KASLR completely but you need
> root for it so it probably doesn't really matter.
>
> Now, on another thread we agreed more or less that what gets exported in
> vmcoreinfo is so tightly coupled to the running kernel so that it is not
> even considered an ABI. I guess that is debatable but whatever.

I understand.

> So my only request right now would be to have all those things being
> exported, documented somewhere and I believe Lianbo is working on that.

I will work with Lianbo to get this added to his documentation patch as well.

> But I'm sure others will have more to say about it.

Sure, I will wait for a couple of days more and then send out a v3 and
also make sure that
this variable being export'ed also gets added to the overall documentation patch
which Lianbo is creating.

Regards,
Bhupesh
