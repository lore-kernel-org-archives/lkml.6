Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034EBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4301208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUHM9SiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4301208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeGaIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:19:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43233 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeGaIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:19:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so12699048ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6umieckSO3i/YyFtvNueYsBxg0MSGldzvv285NdRGg=;
        b=NUHM9SiCdZcjFwPnvElrJwMsS1ZCslctCkvPHIAkYcVKdNS+jUmlKcGhPGshpIExoY
         H5KsErDknQt46kkY39b1ag0VhypJ/FBFVXbmHA9eyQKAJLSfbbT/sq0RbkEJVpL4ich3
         2mmcNZ0YOSAmO5U26czJ93ha9vJjBOVZA0Los=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6umieckSO3i/YyFtvNueYsBxg0MSGldzvv285NdRGg=;
        b=F7/11Dsgf9J+CGgabbKUwlYpSmw4Wft+zLVGd7P/RfaU7aOl5q6ry/wB0IOHxgeGKq
         9A6rD2UC+DItnStKhVBxV/MA4p1kMsukENQOrO4KADmEwNhSSnHu/otlA9ZuyQzrNq1d
         sAKejv50gTb70ux+Ko5DcV/bkZ5PgBcxYqFcgW4wd9F6+rhIvHvBtlD2JzXwwI4X/6Pg
         ZaXd3dIttFtRMDdRsxt92QB+O/vepgXUm7Kwmx0Zt85d89WNTNQ7RCwX4O5kYtvSXM9f
         L9XYqtzn9SmYE1I0NNhnMlL2+q4mjSAcJX5AJYocWu+40MpZ0hP83BEQwI6K1D2FRzmy
         gG9g==
X-Gm-Message-State: AOUpUlGoBpH0/Out2f/Mdcw88Q1lFctGT/dVkV/HmS6QufUHSGqYkglI
        GrlBqBSl7oGVbSVTLi699LyDoMsR+nBZ/SX+cGHxtQ==
X-Google-Smtp-Source: AAOMgpdF5TfQk3YC6JOUaYyU9hNmjgR/KfAYksdkpyKWvpsJtMEw/r/NjPzAq1iRKTlitKNiMRwmZXCUj+e3fgIQGUg=
X-Received: by 2002:a2e:91d6:: with SMTP id u22-v6mr14505475ljg.64.1533019242495;
 Mon, 30 Jul 2018 23:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
In-Reply-To: <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 31 Jul 2018 12:10:06 +0530
Message-ID: <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     John Stultz <john.stultz@linaro.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kirill@shutemov.name, willy@infradead.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>, aarcange@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>, ccross@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 at 09:55, John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Jul 30, 2018 at 8:26 PM, Hugh Dickins <hughd@google.com> wrote:
> > On Mon, 30 Jul 2018, Linus Torvalds wrote:
> >> On Mon, Jul 30, 2018 at 2:53 PM Hugh Dickins <hughd@google.com> wrote:
> >> >
> >> > I have no problem with reverting -rc7's vma_is_anonymous() series.
> >>
> >> I don't think we need to revert the whole series: I think the rest are
> >> all fairly obvious cleanups, and shouldn't really have any semantic
> >> changes.
> >
> > Okay.
> >
> >>
> >> It's literally only that last patch in the series that then changes
> >> that meaning of "vm_ops". And I don't really _mind_ that last step
> >> either, but since we don't know exactly what it was that it broke, and
> >> we're past rc7, I don't think we really have any option but the revert
> >> it.
> >
> > It took me a long time to grasp what was happening, that that last
> > patch bfd40eaff5ab was fixing. Not quite explained in the commit.
> >
> > I think it was that by mistakenly passing the vma_is_anonymous() test,
> > create_huge_pmd() gave the MAP_PRIVATE kcov mapping a THP (instead of
> > COWing pages from kcov); which the truncate then had to split, and in
> > going to do so, again hit the mistaken vma_is_anonymous() test, BUG.
> >
> >>
> >> And if we revert it, I think we need to just remove the
> >> VM_BUG_ON_VMA() that it was supposed to fix. Because I do think that
> >> it is quite likely that the real bug is that overzealous BUG_ON(),
> >> since I can't see any reason why anonymous mappings should be special
> >> there.
> >
> > Yes, that probably has to go: but it's not clear what state it leaves
> > us in, with an anon THP being split by a truncate, without the expected
> > locking; I don't remember offhand, probably a subtler bug than that BUG,
> > which you may or may not consider an improvement.
> >
> > I fear that Kirill has not missed inserting a vma_set_anonymous() from
> > somewhere that it should be, but rather that zygote is working with some
> > special mapping which used to satisfy vma_is_anonymous(), faults supplying
> > backing pages, but now comes out as !vma_is_anonymous(), so do_fault()
> > finds !dummy_vm_ops.fault hence SIGBUS.
>
> I've been only casually following this thread (mostly just glad Amit
> caught it and I could avoid having to bisect the issue in my own
> Android testing), but this bit starting to shake a few old cobwebs
> loose in my brain.
>
> I'm wondering if Zygote is utilizing ashmem here, and we're somehow
> traversing ashmem purged memory, or due to some setup issue the
> initial traverse isn't being zero-filled as expected?
>
> ashmem ranges are created using: shmem_file_setup() and shmem_zero_setup()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/android/ashmem.c#n377
>
>
> If we purge pages, it punches it out with:
> vfs_fallocate(range->asma->file,
>      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>      start, end - start);
> here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/android/ashmem.c#n447
>
> But in ashmem_pin(), we don't do anything other then returning if we
> purged any page in the range.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/android/ashmem.c#n577
>
> And I believe the future assumption is the if we traverse those pages
> they will be zero filled (if purged or even during the initial
> traversal after mmap)
>
> Its been a long time, and I've not looked at the code in question but
> it sounds from Hugh's comments above that we might instead get a
> SIGBUS here.
>
> Looking more at the problematic patch..
> Amit: Does adding something like (whitespace damaged, apologies):
>
> index a1a0025..1af6915 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -402,7 +402,8 @@ static int ashmem_mmap(struct file *file, struct
> vm_area_struct *vma)
>                         fput(asma->file);
>                         goto out;
>                 }
> -       }
> +       } else
> +               vma_set_anonymous(vma);
>
>         if (vma->vm_file)
>                 fput(vma->vm_file);
>

This ashmem change ^^ worked too.

Regards,
Amit Pundir

>
> Seem to resolve it? (Sorry, I'd test it myself, but I'm away from my
> desk for the night).
> thanks
> -john
