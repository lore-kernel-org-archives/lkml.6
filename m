Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D725ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7152086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAG9okL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7152086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbeIUPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:51:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389486AbeIUPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:51:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id x16-v6so4667397ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUfk5JtVX3HySYiBPlCp61HOzSC4ye0WcozRk/1JMBw=;
        b=XAG9okL8Z+RmsXZQH6e1oOREqd2viEVY3qffP6QsObJ6z7w1pE4e+4C6AC+MZBDLPc
         Lc1YiIgut132rjiJMQ6kICWbc6bgUknySzPsHRnzUgymdOD65Jgy7kRtheEpA/aX21k3
         nphGs0Hqcy0pd1ANDolgRHErSZQZHTy0Tn5K0DUdKX5OyLEURGgXTJ3Y7T8wgu1TTBpP
         GSexFjXvdG6XDr7GL0XW0AK7CHBYB/cPx+5DTQkeeLMc2En3DnqS9s0anjOq3FnC4Rig
         PzKbPtpJzF2htWgJseGKpQt/NSRkxZfxdoe3P7a4bmrZ8alGJ57h/aNK0cmv4Oy1TXQM
         Uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUfk5JtVX3HySYiBPlCp61HOzSC4ye0WcozRk/1JMBw=;
        b=N9cmcdnuK1kfk6ZUX3QplZKgOqTRWMC7HEpO7pbgzJeZTXCUn1r52bP0BqSK7x3ZpU
         FQFmW+mOSTWK9SQdqIAFiudhu2Yws63JHX4qV4lE6/ioJbQYvDHy5c+QSWqM4k2fN5xs
         lG3XugBIyaGvC2SV1TI9MKfEk/wwFn4RJOwis8CP2YtMBIyDQCSNOhTUYIc6C6f0HNSf
         ageUZVn1a48LyyZuZLa7qdXPb3evmbLOdjcEx9T76FYmWEDacwQYibr/0YIFPAU6Zbs5
         r4Knpb/OhWhLwKXdiiGcOVPbJIceLikRY77BFgAY3cVe83k0WSRxeDpFpcNSJZb03+jG
         WVsg==
X-Gm-Message-State: ABuFfogdlHSUjPE8bMXnNfRljbjk0tcGR8DkCh9xx4EUFYo2sa7WfVml
        WuxxBXvXx+Jce8ENYf6KUfdMMgtnYIpLNPwF55k=
X-Google-Smtp-Source: ANB0VdaCk76f77WYxgEFYFQIp52qy+VQHnm1PezNKAJ2S1/H13BF/pQUEGHBRVkTU/qpMx17Jx8BNCCWN667P5sluRg=
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr1209877ljj.103.1537524219424;
 Fri, 21 Sep 2018 03:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC> <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com>
In-Reply-To: <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 21 Sep 2018 15:33:27 +0530
Message-ID: <CAFqt6zbp8wynKqFRyp3Q55Scoi9ojfdCVkMrxC4w9qxPxWMXGQ@mail.gmail.com>
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

On Fri, Sep 21, 2018 at 3:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
> On 09/20/2018 10:12 PM, Souptick Joarder wrote:
> > There is a plan to replace vm_insert_page with new API
> > vmf_insert_page. As part of it, converting vm_insert_page
> > to use vmf_insert_page.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  kernel/kcov.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 3ebd09e..8900d8e 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> >               spin_unlock(&kcov->lock);
> >               for (off = 0; off < size; off += PAGE_SIZE) {
> >                       page = vmalloc_to_page(kcov->area + off);
> > -                     if (vm_insert_page(vma, vma->vm_start + off, page))
> > -                             WARN_ONCE(1, "vm_insert_page() failed");
> > +                     if (vmf_insert_page(vma, vma->vm_start + off, page)
> > +                                     != VM_FAULT_NOPAGE)
> > +                             WARN_ONCE(1, "vmf_insert_page() failed");
>
> Nack, don't see the reason for such change, it only makes code worse.

Yes, it needed. Going forward vm_insert_page will be converted to
vmf_insert_page. As part of it, this code has to be converted to use
vmf_insert_page().
please refer below commit on linus tree -
1c8f422059ae5da07db74
