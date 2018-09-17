Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEBF20671
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E12KZq+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEBF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeIQW3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:29:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39069 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:29:15 -0400
Received: by mail-io1-f65.google.com with SMTP id l7-v6so12084337iok.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6kkwi9ODII+ly6Sy0nkzb3fHOIF6HzNCux2feEI7VR4=;
        b=E12KZq+EUBAd/2gE/ikuRp6Js+6HJIIr86Q9ZSAOf/iiFei8jooG228vM3BTkXBZDY
         dX9bIBdqBno3OmsMlm4TuGsbxTN7IODE6b/wnAuTi9Kd4pn/Q6AGVtQvK+yCgduKbsIS
         XkzIW4MlVrXPFWbFegJv+mrKhEQnVXkRqnTT4BdhXwWjlB9UGWXiCG6u8qdNe9xVDMVx
         hk17YIMwWh0Z7CBtr1aATdSLYY+j4tkwJEVBqvc7Ru4T1vDEtEMqtm0KsMqh61k9kH6D
         4evD+PfgXBLTpboLGOfIPoyliV7zS5jDFpHvq8ePC5EISFTnusZIr+D23vlDwc7h8eMn
         3d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6kkwi9ODII+ly6Sy0nkzb3fHOIF6HzNCux2feEI7VR4=;
        b=bh8oN4PApvq1QuaRhxjYg2y57cy7o7gG09SY1tAOuyvki+vK8nAtARpHJeQBSKoAf/
         ed0yrjo/Vc0+E2SuYpRa3jB3spWhk4Ctyc1JzTfITmlqNu5/OdFQ5SQMKIkg1d73/kfW
         vs0o0QY6DDSq8SskS0WNBgHBKrN7NVt0m5Eft+ZZemJEqChHiKW3Uze9HZbkeqgKPl/z
         olzynIzlPxir4n4eb3g7OqtXwrrAhtJUvS8tRTt/o/KLHaa7xppm9nI4p3v2PYmJfpFE
         BUpuCi11cL7WwdgGEzbkf1Fg1P8s7QuAtZMunwlKIdBn5IgZ+mf/APv/+EAEGyw4hIjC
         RGYw==
X-Gm-Message-State: APzg51CqdxwEJH5FTJPsv/NdmmmxHDr4LZz2OxW5vFhxz1xZlLBuADch
        fS7DQQil77ShRbznYZ+X4AtIlYI4iH4s0425AKW+EQ==
X-Google-Smtp-Source: ANB0VdYO9Sy10yJtvIQkz2/PfVhTpO6MDbJzGiDcPhw7AH36mEFfvOYzwheIGkG6F5Z2yqguqjtqdnZhrdSV86bW9nc=
X-Received: by 2002:a6b:ca85:: with SMTP id a127-v6mr22628516iog.31.1537203661373;
 Mon, 17 Sep 2018 10:01:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 10:01:00
 -0700 (PDT)
In-Reply-To: <20180911164152.GA29166@arrakis.emea.arm.com>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
 <20180907152600.myidisza5o4kdmvf@armageddon.cambridge.arm.com>
 <CA+55aFzQ+ykLu10q3AdyaaKJx8SDWWL9Qiu6WH2jbN_ugRUTOg@mail.gmail.com> <20180911164152.GA29166@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 17 Sep 2018 19:01:00 +0200
Message-ID: <CAAeHK+z4HOF_PobxSys8svftWt8dhbuUXEpq2sdXBTCXwTEH2g@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I took another look at the changes this patchset does to the kernel
and here are my thoughts:

I see two ways how a (potentially tagged) user pointer gets into the kernel:

1. A pointer is passed to a syscall (directly as an argument or
indirectly as a struct field).
2. A pointer is extracted from user context (registers, etc.) by some
kind of a trap/fault handler.
(Is there something else?)

In case 1 we also have a special case of a pointer passed to one of
the memory syscalls (mmap, mprotect, etc.). These syscalls "are not
doing memory accesses but rather dealing with the memory range, hence
an untagged pointer is better suited" as pointed out by Catalin (these
syscalls do not always use "unsigned long" instead of "void __user *"
though, for example shmat uses "void __user *").

Looking at patch #8 ("usb, arm64: untag user addresses in devio") in
this series, it seems that that devio ioctl actually accepts a pointer
into a vma, so we shouldn't actually be untagging its argument and the
patch needs to be dropped. Otherwise there's quite a few more cases
that needs to be changed (like tcp_zerocopy_receive() for example,
more can be found by grepping find_vma() in generic code).

Regarding case 2, it seems that analyzing casts of __user pointers
won't really help, since the code (arch/arm64/mm/fault.c) doesn't
really use them. However all of this code is arch specific, so it
shouldn't really change over time (right?). It looks like dealing with
tags passed to the kernel through these fault handlers is already
resolved with these patches (and therefore patch #6 ("arm64: untag
user address in __do_user_fault") in this series is not actually
needed and can be dropped (need to test that)):

276e9327 ("arm64: entry: improve data abort handling of tagged pointers"),
81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on
a tagged pointer")
7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged pointers")

Now, I also see two cases when kernel behavior changes depending on
whether a pointer is tagged:

1. Kernel code checks that a pointer belongs to userspace by comparing
it with TASK_SIZE/addr_limit/user_addr_max()/USER_DS/... .
2. A pointer gets passed to find_vma() or similar functions.
(Is there something else?)

The initial thought that I had here is that the pointers that reach
find_vma() must be passed through memory syscalls and therefore
shouldn't be untagged and don't require any fixes. There are at least
two exceptions to this: 1. get_user_pages() (see patch #4 ("mm, arm64:
untag user addresses in mm/gup.c") in this patch series) and 2.
__do_page_fault() in arch/arm64/mm/fault.c. Are there any other
obvious exceptions? I've tried adding BUG_ON(has_tag(addr)) to
find_vma() and running a modified syzkaller version that passes tagged
pointers to the kernel and failed to find anything else.

As for case 1, the places where pointers are compared with TASK_SIZE
and others can be found with grep. Maybe it makes sense to introduce
some kind of routine like is_user_pointer() that handles tagged
pointers and refactor the existing code to use it? And maybe add a
rule to checkpatch.pl that forbids the direct usage of TASK_SIZE and
others.

So I think detecting direct comparisons with TASK_SIZE and others
would more useful than finding __user pointer casts (it seems that the
latter requires a lot of annotations to be fixed/added), and I should
just drop this patch with annotations.

WDYT?
