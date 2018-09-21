Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8736C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D0F2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t16AGqWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D0F2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbeIUTOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:14:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39195 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:14:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so11639131lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJFvYvUXiSW5WCbOfxE2BKgCZxDE29u3shIdNmORS/w=;
        b=t16AGqWiLbSa1yDlxhU+OoXznKrk3wbrOOZPQR4XPdLL2fkZHhpUiMpw2099cjCANa
         TMA8uNIaPs4mb98A0D1k5YoOEyCC5cRXldSI+CAs6gQcFmmU8ihdMcSxULXPwIRQ/K4k
         HId0I2PZM/uu2VL3qNlS4x8d1NwxorXSOdq5hWJOhRiLxKZKFxMtrItNpOJ5raRqwvfm
         oDeQP2GSR0M/AfK2SHH7W1+Puh+NEEL1RTqJZ1LQUvergXhjG3aHOPfodkZ/AoNskXol
         EONGWyZYudRgPf5twdR2BWnNvMxwYlrzsZhRgvVR7XljypxQHpoE3uSFV9JVTHaK5BuQ
         C7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJFvYvUXiSW5WCbOfxE2BKgCZxDE29u3shIdNmORS/w=;
        b=bMImKU4W7HHydY9HcEvr5+F92VnSJIhmkul48Odljk6SlDPtJT47xmzi8nx7o/jmeL
         WAHYkmpENpk3dHh2YbiE3VQpn8XJgB3FfWuFUHSiV0DffWc56h8qtur9uRt0/6+OFtWb
         kxzvmdov25/WGX69A+HdG7o71HFdg+Hj8Jbs67T7Vak9RbPIVlsiMFsaC9QtT7y83ZJO
         Ot0ZFNphGxhLtvOgU0cj2PdwOVmOHMXpwNlhFoipD6xKhm83/C3CBQIzxnCVRjRrVaW/
         nwVBYyMCBGjDvQM/6JO3nADxaPzKyxSwsBaqIKyh4PHtFlDiFKlxdebNcIlLRsfzwNbk
         1iGw==
X-Gm-Message-State: ABuFfoj5iCuNk+OWeuR9IC++LOIn1Du9EKSp+51CJr0bpBsIHEwIxEbl
        6M4+lOj1EQEQ1YQaNVVuxQJtwVpcWf731mswvSA=
X-Google-Smtp-Source: ACcGV60Fcg01npQdYB6mZbES/EvGUm1AQCt6qbKLkzqUppyw1FnvlVwEaBzrj8RwsiCxkhqoiGspH8UBqtUD9bBOXwM=
X-Received: by 2002:a2e:8ed1:: with SMTP id e17-v6mr1849774ljl.86.1537536360141;
 Fri, 21 Sep 2018 06:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
 <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com> <CAFqt6zbp8wynKqFRyp3Q55Scoi9ojfdCVkMrxC4w9qxPxWMXGQ@mail.gmail.com>
 <68b8cbf3-1b5a-2311-ac09-a8676280e85e@virtuozzo.com>
In-Reply-To: <68b8cbf3-1b5a-2311-ac09-a8676280e85e@virtuozzo.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 21 Sep 2018 18:55:47 +0530
Message-ID: <CAFqt6za6VJ7vmWEqg4JGWqRiqbfc6GYDnpUeBQ+03xdY51-GQA@mail.gmail.com>
Subject: Re: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
To:     aryabinin@virtuozzo.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:22 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 09/21/2018 01:03 PM, Souptick Joarder wrote:
> > On Fri, Sep 21, 2018 at 3:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> >>
> >> On 09/20/2018 10:12 PM, Souptick Joarder wrote:
> >>> There is a plan to replace vm_insert_page with new API
> >>> vmf_insert_page. As part of it, converting vm_insert_page
> >>> to use vmf_insert_page.
> >>>
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> ---
> >>>  kernel/kcov.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/kcov.c b/kernel/kcov.c
> >>> index 3ebd09e..8900d8e 100644
> >>> --- a/kernel/kcov.c
> >>> +++ b/kernel/kcov.c
> >>> @@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> >>>               spin_unlock(&kcov->lock);
> >>>               for (off = 0; off < size; off += PAGE_SIZE) {
> >>>                       page = vmalloc_to_page(kcov->area + off);
> >>> -                     if (vm_insert_page(vma, vma->vm_start + off, page))
> >>> -                             WARN_ONCE(1, "vm_insert_page() failed");
> >>> +                     if (vmf_insert_page(vma, vma->vm_start + off, page)
> >>> +                                     != VM_FAULT_NOPAGE)
> >>> +                             WARN_ONCE(1, "vmf_insert_page() failed");
> >>
> >> Nack, don't see the reason for such change, it only makes code worse.
> >
> > Yes, it needed.
>
> No, it's not needed. vm_insert_page() works perfectly fine here.
>
> > Going forward vm_insert_page will be converted to
> > vmf_insert_page. As part of it, this code has to be converted to use
> > vmf_insert_page().
>
> This doesn't explain why such conversion would make sense for kcov_mmap().

vm_insert_page used to return errno which individual drivers have to
map to VM_FAULT_CODE.
There were also places where return value of vm_insert_page was
ignored and return a
TRUE value.

As part of vm_fault_t migration patches, we have identified and clean
up all these.
The plan was to introduce inline wrapper vmf_insert_page(), convert all
the page fault handlers to use it and then convert vm_insert_page to
vmf_insert_page. By now we have converted all the page fault handlers
to use this API.

Still their are few places where vm_insert_page is called outside fault handlers
context to map kernel page to user vma and kernel/kcov.c is one of them.

Now removing vm_insert_page from those few places one by one.

Going forward vm_insert_page will be removed from kernel permanently,
so that new drivers can't use this API and create new errno to VM_FAULT_CODE
mapping code.

>
> > please refer below commit on linus tree -
> > 1c8f422059ae5da07db74
>
> That the commit has nothing to deal with kcov, it doesn't explain why kcov_mmap()
> can't keep using vm_insert_page() and/or why we should prefer vmf_insert_page()
> over vm_insert_page() particularly in the case of kcov_mmap().
>
