Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0985FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E1B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfgKBVwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E1B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbeIUWJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:09:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34952 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:09:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id x20-v6so11954618lfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fN2MyFbI6pwyHbFgq1mWh1sheEyEx/X06GhcwDaS3tY=;
        b=DfgKBVwbtkBqYDc9RHOXR/uRcb4rY7dgwel0sK0DLY+Q4HlMqHFdZkoBqevyaiXgp6
         2q5nFC0/6dhZ7hOjwjMqoQKOX0+gXSFORtQvvXIJf85u7CqViZ1etD/79m2n9bcOOCEU
         gfglQw4f94wvxT3naXYvxVz7+HrMmwlcFya26hXAl3CK1VCD3PAdXpmK1uH2kzo+MAaO
         Ew/Q+CJq08LJktMu5eqmL9b23x1iLMbbR1/kOTCIVG1b4CpkTeq1s8uAw0JMFzKqvd50
         nM2zYWFDGpTe9+W0aUNfzSx0PJrCDxhPzT719m2tRyBmegjoZvXYIo9jaVhnPVcfVaAW
         bolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fN2MyFbI6pwyHbFgq1mWh1sheEyEx/X06GhcwDaS3tY=;
        b=tXe7cDbZAvjdUcfr1UJC+TdTsGeRGKeswmCj25ZNnIiSNTNQ9qaharSjiYHdgEyrW5
         QMQlejn7XQrUwgWK9hBuUle3eOYHGMxCh5+AtdCPdSsmLqz127pXtSjKytxzhLf3sVCW
         fq6lw6K8MyXXvKN8JDD4RofahmkOFWTZrOe3OB/EPu56t05+BOydpArNHG7txNNzQfjK
         ptZj53bq7UGw0HpJE1TM5ZSsjlMwm/dOsjU8styelN+p04VqPgej97gsjEriAtQQyNjT
         uH3ktLTz3j1u1gIrmUR05IEIiYIDt95vVV+JYTqw3PT69mBF9/l30jc7tvTW4OP5MV7B
         qFDw==
X-Gm-Message-State: APzg51Dq6X3L8IX3Ild4zAQUBUBMEvzQlUZVWEnoRAAwXH6S0+jiTwv5
        oeRuM30zvluN99oSV6yiUZgvLG9XII0YfgFoTf4=
X-Google-Smtp-Source: ANB0Vdb+b+ooholNc2yR8buXuBglYz5faRgV1CVPOJoHaaMEhcM5D3Lhys+5Fq6O3phQtVtAEx9AAhr6LRdL1SPQa4E=
X-Received: by 2002:a19:6719:: with SMTP id b25-v6mr6587546lfc.54.1537546813432;
 Fri, 21 Sep 2018 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
 <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com> <CAFqt6zbp8wynKqFRyp3Q55Scoi9ojfdCVkMrxC4w9qxPxWMXGQ@mail.gmail.com>
 <68b8cbf3-1b5a-2311-ac09-a8676280e85e@virtuozzo.com> <CAFqt6za6VJ7vmWEqg4JGWqRiqbfc6GYDnpUeBQ+03xdY51-GQA@mail.gmail.com>
 <0c3d2ba2-29dc-ed02-0919-54d1d76a1eb1@virtuozzo.com>
In-Reply-To: <0c3d2ba2-29dc-ed02-0919-54d1d76a1eb1@virtuozzo.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 21 Sep 2018 21:50:00 +0530
Message-ID: <CAFqt6zbzikDrj5+o=YpbQF3OQtSUiXL=7WTq1KF8GE5WVvz-8w@mail.gmail.com>
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

On Fri, Sep 21, 2018 at 8:14 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 09/21/2018 04:25 PM, Souptick Joarder wrote:
> > On Fri, Sep 21, 2018 at 5:22 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> >> On 09/21/2018 01:03 PM, Souptick Joarder wrote:
> >>> On Fri, Sep 21, 2018 at 3:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> >>>>
> >>>> On 09/20/2018 10:12 PM, Souptick Joarder wrote:
> >>>>> @@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> >>>>>               spin_unlock(&kcov->lock);
> >>>>>               for (off = 0; off < size; off += PAGE_SIZE) {
> >>>>>                       page = vmalloc_to_page(kcov->area + off);
> >>>>> -                     if (vm_insert_page(vma, vma->vm_start + off, page))
> >>>>> -                             WARN_ONCE(1, "vm_insert_page() failed");
> >>>>> +                     if (vmf_insert_page(vma, vma->vm_start + off, page)
> >>>>> +                                     != VM_FAULT_NOPAGE)
> >>>>> +                             WARN_ONCE(1, "vmf_insert_page() failed");
> >>>>
> >>>> Nack, don't see the reason for such change, it only makes code worse.
> >>>
> >>> Yes, it needed.
> >>
> >> No, it's not needed. vm_insert_page() works perfectly fine here.
> >>
> >>> Going forward vm_insert_page will be converted to
> >>> vmf_insert_page. As part of it, this code has to be converted to use
> >>> vmf_insert_page().
> >>
> >> This doesn't explain why such conversion would make sense for kcov_mmap().
> >
> > vm_insert_page used to return errno which individual drivers have to
> > map to VM_FAULT_CODE.
> > There were also places where return value of vm_insert_page was
> > ignored and return a
> > TRUE value.
> >
> > As part of vm_fault_t migration patches, we have identified and clean
> > up all these.
> > The plan was to introduce inline wrapper vmf_insert_page(), convert all
> > the page fault handlers to use it and then convert vm_insert_page to
> > vmf_insert_page. By now we have converted all the page fault handlers
> > to use this API.
> >
> > Still their are few places where vm_insert_page is called outside fault handlers
> > context to map kernel page to user vma and kernel/kcov.c is one of them.
> >
> > Now removing vm_insert_page from those few places one by one.
> >
> > Going forward vm_insert_page will be removed from kernel permanently,
> > so that new drivers can't use this API and create new errno to VM_FAULT_CODE
> > mapping code.
> >
>
> So, to avoid addition of new code that converts errno->VM_FAULT_* you propose to add
> new code that does the opposite - converts VM_FAULT_* to errno? How is that better?

I didn't propose that. It's not a better idea.
And from fault handlers prospective, with these changes, fault handlers code
will only return VM_FAULT_CODE not errno.

>
> And what function is going to be next? pte_none()? It is also used in fault handlers.
> Are there going to be vmf_pte_none() and complete removal of pte_none() "so that new drivers
> can't use pte_none() and create new pte_none() to VM_FAULT_CODE mapping code"?

vmf_insert_{pfn, page, mixed} are the functions which are planned to change.
vmf_insert_{pfn,mixed} are merged into linux-next.
There is no plan for any other functions.

>

> Don't you see that how that doesn't make any sense?
> Want vmf_insert_page() for easier error handling in fault handlers? - fine, use it in fault handlers.
> But leave the vm_insert_page() for the code that has nothing to do with fault handling.

If we leave vm_insert_page() for the code other than fault handling,
then drivers writer will
have choice to use this API in fault handlers context in future which
need to be blocked.

How can we block driver writer not to use vm_insert_page in fault
handlers context ??
