Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C02C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05A920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MvXkAITy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05A920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbeHATB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:01:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36041 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403790AbeHATB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:01:56 -0400
Received: by mail-io0-f194.google.com with SMTP id r15-v6so16704483ioa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAzllBxJyklrgLmXJjj6dSlAHYEyacwpyj8aShj8hFg=;
        b=MvXkAITyLBfrveFt4jp9XvpTAV+m6NmpDUPGe1Ks1y/eKwTRM02/hR+cdkgect7j/O
         Hxy6TBw8AgOlRvpWbDxGqiHhDLaI0pt2+/HJeOroYmugiNexUA8vZjTX9Z6idP/O6wyE
         TMTNdJOA5dHvL2pJqc+rc5eJRp7Ekbq7LDnSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAzllBxJyklrgLmXJjj6dSlAHYEyacwpyj8aShj8hFg=;
        b=oHsWjCgsJCjGu6VPSq0l4RFK2B5ospPc81CkfMYqxWZGUh2TEwHied3/nw5X+FPnbe
         Tskw4mUxD5G+RUG2oescTHX9khaMWTCt2HnIRoTGPNpD/O23H4CiRveSoF95vPL8iWGP
         lM7e0I2k7La5H54fLMSNGvRJzpp2YtSetpGnTk4T9QFT6baNa8vWT3jd6ACh57laSWYY
         FAgmUgR/qqvq8Hqkc1DjiS1AwPP1Qs5vsDZkUkIB0Xd2oFume4vBNR0/paqdlErbmUvm
         KiOhArjmAprnzP52DG8qfb79c103gaRVAEStWbCXWp8fKjxIdnrg+Z4Dj3kJb8TIsKNZ
         sJBA==
X-Gm-Message-State: AOUpUlFdKYJZLuAZ+JnpRIoIXC7f7mz391Lc6mqkJ95ku54k1LYwcJVf
        lqUrXFwEkms+OMNGF/XOqSKoz523Vfx8VojJcis=
X-Google-Smtp-Source: AAOMgpdP1WjL/Q/a3GICfQX8lUlh3GItjoHj28f0Oi+W71x3Z6qlVqcx0gFjuChDlIoNVCzDprGmGuJJBuv/Bg98gNE=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12-v6mr4360303ioh.203.1533143716507;
 Wed, 01 Aug 2018 10:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk>
In-Reply-To: <20180731174349.GA12944@agluck-desk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Aug 2018 10:15:05 -0700
Message-ID: <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:43 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Jul 31, 2018 at 08:03:28PM +0300, Kirill A. Shutemov wrote:
> > But it's not the only issue unfortunately. Tony reported issue with
> > booting ia64 with the patch. I have no clue why. I rechecked everything
> > ia64-specific and looks fine to me. :-/
>
> If I just revert bfd40eaff5ab ("mm: fix vma_is_anonymous() false-positives")
> then ia64 boots again.

Ok, I'd love to have more information about this, but I'm assuming
that Tony isn't running some odd ia64 version of Android, so there's
definitely something else than just the ashmem thing going on. Either
it's some odd ia64-specific special vma, or it's just something
triggered on an ia64 boot that nobody else noticed or cared about.

And I was just going to do the final revert and started this email to
say so, when I looked at the obvious candidate: the
ia64_init_addr_space() function. Trivially fixed.

But as I was doing that, I also noticed another problem with the vma
series: the vma_init() conversion of automatic variables is buggy.
Commit 2c4541e24c55 ("mm: use vma_init() to initialize VMAs on stack
and data segments") is really bad, because it never grew the memset()
that was discussed, and the patch that was applied was the original
one - so vma_init() only initializes a couple of fields. As a result,
doing things like this:

-       struct vm_area_struct vma = { .vm_mm = mm };
+       struct vm_area_struct vma;

+       vma_init(&vma, mm);

is just completely wrong, because it actually initializes much less
than it used to, and leaves most of the vma filled with random stack
garbage. In particular, it now fills with garbage the fields that TLB
flushing really can care about: things like vm_flags that says "is
this perhaps an executable-only mapping that only needs to flush the
ITLB?"

I don't actually believe that we should do vma_init() on those
on-stack vma's anyway, since they aren't "real" vma's. They are
literally crafted just for TLB flushing - filling in the vm_mm (and
sometimes vm_flags) pointers so that the TLB flushing knows what to
do.

So using "vma_init()" on them is actively detrimental as things stand
right now. The reason I looked at them was that I was trying to see
who actually uses "vm_area_alloc()" and "vma_init()" right now that
would be affected by that commit bfd40eaff5ab ("mm: fix
vma_is_anonymous() false-positives") outside of actual
honest-to-goodness device file mmaps.

Anyway, the upshot of all this is that I think I know what the ia64
problem was, and John sent the patch for the ashmem case, and I'm
going to hold off reverting that vma_is_anonymous() false-positives
commit after all.

I'm still unhappy about the vma_init() ones, and I have not decided
how to go with those. Either the memset() in vma_init(), or just
reverting the (imho unnecessary) commit 2c4541e24c55. Kirill, Andrew,
comments?

Tony, can you please double-check my commit ebad825cdd4e ("ia64: mark
special ia64 memory areas anonymous") fixes things for  you? I didn't
even compile it, but it really looks so obvious that I just committed
it directly. It's not pushed out yet (I'm doing the normal full build
test because of the ashmem commit first), but it should be out in
about 20 minutes when my testing has finished.

I'd like to get this sorted out asap, although at this point I still
think that I'll have to do an rc8 even though I feel like we may have
caught everything.

                        Linus
