Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7438C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7DA2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYwZA+72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7DA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeGaFE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:04:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39050 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGaFE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:04:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id a11-v6so8331899pgw.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7DlskNuV/GxLl2ckCmTVU201fSQXEI/X6Fn3BDP3xHU=;
        b=fYwZA+72xw8IuVSyecLrukjL6xA/31Ata9Wgl8abe5AeEOCovmeaazE/cxfNE61fsh
         3Oe15vXsivV+aWc8m0opnk+Y+Ysyw2hafX9SPnRtbkulU0XupOmNzjDzotctLJVyFB4S
         fnoSEbTcx1G8hTm+yUfJhMnZqu7hOrA52un9+1mtY9rnjyur5iaxAS08ZAkVPa/DuuCP
         e9nPw8Koz97kH4Jea9jhLyP4adk1rWDnQihU6ghmlZfXed9arq4/uu29WuY8sg03v7z9
         T9U75btcAkdeo8pmeeq5gOGQgz2bx4w7Q6jm/0/OitEvQCW8hnl2gKG83BttZXLH1lYE
         JveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7DlskNuV/GxLl2ckCmTVU201fSQXEI/X6Fn3BDP3xHU=;
        b=a+eATJI4epezMBHiUYUaXoXjos4YPMWCJf1WtyB7bHzjMFDhC4hSybfF/aSEucwFH/
         qFfBkBFZ0TkFDwVvZSyBWpM52PNZ4JAKcGdE4e53HY+d961SiOeMAxPWzcvZlUZ+lKFD
         7CDXp43zrlpIv8CgS1a9PykluuCsjWEzhO9gYpVXw/0NBS8BbgiE4/dMjpeYeWpaqpxv
         Oh0y6F3ga569XvQ+xFb7rcJkLAeYWf2XtUgnqiXk8rt4mt6rOv4C624TsqwBM7YnoBX+
         Ikf/mwSBSeFi2LVzThfuk951fxQcz/mtx+UxSPaHvgJTu4n+eh4EVsqV+UrXBsP9GFcb
         YCmA==
X-Gm-Message-State: AOUpUlGAwNrqqhqQ5vysMeYT+RKfWOEgtdF9+cpnSkaGDj+YAo85Yz0l
        kKaJxPUsVgkq+hFxUJpt33NT4Q==
X-Google-Smtp-Source: AAOMgpeGoL5y9iCmIyzTq6Xw7q+nCP10FG6RcTqQ6//m1n6ekiorW3nlsvCWRkbDdzMFMBj7xpEyVw==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr18556054pgb.136.1533007580116;
        Mon, 30 Jul 2018 20:26:20 -0700 (PDT)
Received: from [100.112.64.65] ([104.133.8.97])
        by smtp.gmail.com with ESMTPSA id a25-v6sm14515812pgv.51.2018.07.30.20.26.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 20:26:18 -0700 (PDT)
Date:   Mon, 30 Jul 2018 20:26:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Subject: Re: Linux 4.18-rc7
In-Reply-To: <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1807301940460.5904@eggly.anvils>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com> <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com> <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 2:53 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I have no problem with reverting -rc7's vma_is_anonymous() series.
> 
> I don't think we need to revert the whole series: I think the rest are
> all fairly obvious cleanups, and shouldn't really have any semantic
> changes.

Okay.

> 
> It's literally only that last patch in the series that then changes
> that meaning of "vm_ops". And I don't really _mind_ that last step
> either, but since we don't know exactly what it was that it broke, and
> we're past rc7, I don't think we really have any option but the revert
> it.

It took me a long time to grasp what was happening, that that last
patch bfd40eaff5ab was fixing. Not quite explained in the commit.

I think it was that by mistakenly passing the vma_is_anonymous() test,
create_huge_pmd() gave the MAP_PRIVATE kcov mapping a THP (instead of
COWing pages from kcov); which the truncate then had to split, and in
going to do so, again hit the mistaken vma_is_anonymous() test, BUG.

> 
> And if we revert it, I think we need to just remove the
> VM_BUG_ON_VMA() that it was supposed to fix. Because I do think that
> it is quite likely that the real bug is that overzealous BUG_ON(),
> since I can't see any reason why anonymous mappings should be special
> there.

Yes, that probably has to go: but it's not clear what state it leaves
us in, with an anon THP being split by a truncate, without the expected
locking; I don't remember offhand, probably a subtler bug than that BUG,
which you may or may not consider an improvement.

I fear that Kirill has not missed inserting a vma_set_anonymous() from
somewhere that it should be, but rather that zygote is working with some
special mapping which used to satisfy vma_is_anonymous(), faults supplying
backing pages, but now comes out as !vma_is_anonymous(), so do_fault()
finds !dummy_vm_ops.fault hence SIGBUS.

If that's so, perhaps dummy_vm_ops needs to be given a back-compatible
fault handler; or the driver(?) in question given vm_ops and that fault
handler. But when I say "back-compatible", I don't think it should ever
go so far as to supply a THP.

> 
> But I'm certainly also ok with re-visiting that commit later.  I just
> think that right _now_ the above is my preferred plan.
> 
> Kirill?
> 
> > I'm all for deleting that VM_BUG_ON_VMA() in zap_pmd_range(), it was
> > just a compromise with those who wanted to keep something there;
> > I don't think we even need a WARN_ON_ONCE() now.
> 
> So to me it looks like a historical check that simply doesn't
> "normally" trigger, but there's no reason I can see why we should care
> about the case it tests against.
> 
> > (It remains quite interesting how exit_mmap() does not come that way,
> > and most syscalls split the vma beforehand in vma_adjust(): it's mostly
> > about madvise(,,MADV_DONTNEED), perhaps others now, which zap ptes
> > without prior splitting.)
> 
> Well, in this case it's the ftruncate() path, which fundamentally
> doesn't split the vma at all (prior *or* later). But yes, madvise() is
> in the same boat - it doesn't change the vma at all, it just changes
> the contents of the vma.
> 
> And exit_mmap() is special because it just tears down everything.
> 
> So we do have three very distinct cases:
> 
>  (a) changing and thus splitting the vma itself (mprotect, munmap/mmap, mlock),

Yes.

> 
>  (b) not changing the vma, but changing the underlying mapping
> (truncate and madvise(MADV_DONTNEED)

Yes, though I think I would distinguish the truncate & hole-punch case
from the madvise zap case, they have different characteristics in other
ways (or did, before that awkward case of truncating an anon THP surfaced).

> 
>  (c) tearing down everything, and no locking needed because it's the
> last user (exit_mmap).

Yes; and it goes linearly from start to finish, never jumping into
the middle of a vma, so never needing to split a THP.

> 
> that are different for what I think are good reasons.
> 
>                    Linus
