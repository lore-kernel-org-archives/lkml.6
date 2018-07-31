Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2287C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0AA208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VqU/yUzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0AA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeGaCjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:39:18 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:34003 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeGaCjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:39:17 -0400
Received: by mail-it0-f51.google.com with SMTP id d70-v6so10858988ith.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMIrY39jnvjuHnif9V0lvi1L35mBfXD8cG6ibX8alWc=;
        b=VqU/yUziouyLYU/Ug3f3jnPbOlUeY59d64t/5fdYgcOAamLciU1ekSul+E5B0NEj2f
         2cayBoQ6oX2Nbd5SqiDkZ4JIckfysHnCxIt7tir5EjrdrKrpxCVZGy3X9QlyIkWt9el9
         awnRE9iwG1GhcIJ3tkmGUUc5BASHzcG07CaNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMIrY39jnvjuHnif9V0lvi1L35mBfXD8cG6ibX8alWc=;
        b=cve++TbiaKSQihYLAUfnhDRJXmKIYHHnkYzMNS8Yb4pv3Y10MzZLUVjDg37IFzEmzN
         1P6NpJ4RTlb0UkBf4GOh8hz6M1ORBRHWdGYwn0BwrbIL4qkbKYdpdNtt651qi19nUiPd
         uTkOusOEEDS8JIld2H4wM6RMqpJrC/fHmiQ3s7d/qkoZXNkhLTmDt9AcOXizQ38MN/4q
         kleVXc+4h/6Bx3qur/TKBKVZoIC47n6xpHSEjo1Iqf0m4Xa88mqYGR0unQYQM8tftGTK
         VMrIZwqtQfNoroYUFNKteRcFJPGB5kgvRtMgNEqvoPZJBtO8TxwvtiUiNq7QKN/NnkfV
         R6oA==
X-Gm-Message-State: AOUpUlF9WTRniLRNl97pYRxTQKe05lUFV38mLri571HfszwW5edbSmJd
        GldKLSC/RpEgabcm7NM25SFmWxniesKGc/9RxY4=
X-Google-Smtp-Source: AAOMgpdnq1wg7xmYu3aOMF8tJMyrt1uwNx5UDN+YX/xuNGaVButvr7xG3L1l5/eh8P7hGCaxfMgO8STSXTxsScdNWt8=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr1267567itm.113.1532998898145;
 Mon, 30 Jul 2018 18:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jul 2018 18:01:26 -0700
Message-ID: <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 2:53 PM Hugh Dickins <hughd@google.com> wrote:
>
> I have no problem with reverting -rc7's vma_is_anonymous() series.

I don't think we need to revert the whole series: I think the rest are
all fairly obvious cleanups, and shouldn't really have any semantic
changes.

It's literally only that last patch in the series that then changes
that meaning of "vm_ops". And I don't really _mind_ that last step
either, but since we don't know exactly what it was that it broke, and
we're past rc7, I don't think we really have any option but the revert
it.

And if we revert it, I think we need to just remove the
VM_BUG_ON_VMA() that it was supposed to fix. Because I do think that
it is quite likely that the real bug is that overzealous BUG_ON(),
since I can't see any reason why anonymous mappings should be special
there.

But I'm certainly also ok with re-visiting that commit later.  I just
think that right _now_ the above is my preferred plan.

Kirill?

> I'm all for deleting that VM_BUG_ON_VMA() in zap_pmd_range(), it was
> just a compromise with those who wanted to keep something there;
> I don't think we even need a WARN_ON_ONCE() now.

So to me it looks like a historical check that simply doesn't
"normally" trigger, but there's no reason I can see why we should care
about the case it tests against.

> (It remains quite interesting how exit_mmap() does not come that way,
> and most syscalls split the vma beforehand in vma_adjust(): it's mostly
> about madvise(,,MADV_DONTNEED), perhaps others now, which zap ptes
> without prior splitting.)

Well, in this case it's the ftruncate() path, which fundamentally
doesn't split the vma at all (prior *or* later). But yes, madvise() is
in the same boat - it doesn't change the vma at all, it just changes
the contents of the vma.

And exit_mmap() is special because it just tears down everything.

So we do have three very distinct cases:

 (a) changing and thus splitting the vma itself (mprotect, munmap/mmap, mlock),

 (b) not changing the vma, but changing the underlying mapping
(truncate and madvise(MADV_DONTNEED)

 (c) tearing down everything, and no locking needed because it's the
last user (exit_mmap).

that are different for what I think are good reasons.

                   Linus
