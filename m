Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A60C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CFE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVjZ0lDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfBSQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:23:37 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:53325 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbfBSQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:23:37 -0500
Received: by mail-it1-f174.google.com with SMTP id x131so7394337itc.3;
        Tue, 19 Feb 2019 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhMB84E+/47wn1sZt5liOW3BmGymNyzTutVeoGbw3Vo=;
        b=vVjZ0lDDJgqtzyfmVB7yib6R85CiAjYjRtnpCVCLdS7FOrHOITIlcn6hVMwjymsZ/K
         4NU4+i7z1jiZFwHYzV+RpTOpKnWOf9+IZkjDwYnSw1HOUwrwzdZtbzZRcHzmVt+KIJ9w
         vq+gI2bz/QST+mAkZPulDLeC7cD7xNedmHEwHnSSLRoFOW42Os8bwElDlLywStA4Amwz
         V6shdY3Jqf9HhrmY17Tmn+lSzKromGFM6+GkQ4DX4MUW76D4Z7FNeUnQCxdxf8875Iy+
         4mmJp+MntD0O9TRvBj+XKDsX1DqiPwJv7THkaCHz1NaxHVuYVN+eklcNLwTkE/n2O8f2
         l2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhMB84E+/47wn1sZt5liOW3BmGymNyzTutVeoGbw3Vo=;
        b=Rp5NPOlBatopoQGJ8ClT3ji+zXiJLKoGJAk9LLL5LkqxVZ7teTuSsA6Cf8Ce6eE1LJ
         R4eQK9r4hWo2TmdoNjnslYZ0El8Xf/zJtGZjsrwx4rcTa+pMp239Z4kkkhjXE8YzWLN0
         /TjPkEwF2w9UeWQyIhhQKmX9NDeWSPkwVbYUaAfdRzywxs8HakQzZvNKbkRGtFoaA1fm
         bGVwEgauo6TaQqKsM2HmpytvjoDtNAGKOf9hvzImymkdrczelqDeSltGBbNFeIyXmbj9
         YcKnjku5bWUcjoX5z8di65MHthskRH83puD5f1Z9pMGNaBnHRdiPcxtCcHJR0ZeoSQ0t
         PSGw==
X-Gm-Message-State: AHQUAubBeDKpS6yrQujHGvzRkmy0/0MF2cIgN5m3Sxs+ccjnf9ngRTxg
        XdzvulJfxEHHVSmn5/TEjpBWbNrDWH+Zez3il9E=
X-Google-Smtp-Source: AHgI3IblktggL12ItFdn5Ak8ePI0Z61Jgx9yLJp7Ywcmmh6JOO2gq8+GfIH2f8c3gS0ZViv9VTdUNS2ZoemULIM4U7E=
X-Received: by 2002:a6b:e219:: with SMTP id z25mr16246550ioc.116.1550593415664;
 Tue, 19 Feb 2019 08:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org> <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com> <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
 <20190219024611.GC24502@redhat.com>
In-Reply-To: <20190219024611.GC24502@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 19 Feb 2019 08:23:24 -0800
Message-ID: <CAKgT0UdjaPy9TSNVGxmkUoxEpbiB84=n+a4MwYGgi_Hps+wQ_w@mail.gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 6:46 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hello,
>
> On Mon, Feb 18, 2019 at 03:47:22PM -0800, Alexander Duyck wrote:
> > essentially fragmented them. I guess hugepaged went through and
> > started trying to reassemble the huge pages and as a result there have
> > been apps that ended up consuming more memory than they would have
> > otherwise since they were using fragments of THP pages after doing an
> > MADV_DONTNEED on sections of the page.
>
> With relatively recent kernels MADV_DONTNEED doesn't necessarily free
> anything when it's applied to a THP subpage, it only splits the
> pagetables and queues the THP for deferred splitting. If there's
> memory pressure a shrinker will be invoked and the queue is scanned
> and the THPs are physically splitted, but to be reassembled/collapsed
> after a physical split it requires at least one young pte.
>
> If this is particularly problematic for page hinting, this behavior
> where the MADV_DONTNEED can be undoed by khugepaged (if some subpage is
> being frequently accessed), can be turned off by setting
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none to
> 0. Then the THP will only be collapsed if all 512 subpages are mapped
> (i.e. they've all be re-allocated by the guest).
>
> Regardless of the max_ptes_none default, keeping the smaller guest
> buddy orders as the last target for page hinting should be good for
> performance.

Okay, this is good to know. Thanks.

> > Yeah, no problem. The only thing I don't like about MADV_FREE is that
> > you have to have memory pressure before the pages really start getting
> > scrubbed with is both a benefit and a drawback. Basically it defers
> > the freeing until you are under actual memory pressure so when you hit
> > that case things start feeling much slower, that and it limits your
> > allocations since the kernel doesn't recognize the pages as free until
> > it would have to start trying to push memory to swap.
>
> The guest allocation behavior should not be influenced by MADV_FREE vs
> MADV_DONTNEED, the guest can't see the difference anyway, so why
> should it limit the allocations?

Actually I was talking about the host. So if  have a guest that is
using MADV_FREE what I have to do is create an allocation that would
force us to have to access swap and that in turn ends up triggering
the freeing of the pages that were moved to the "Inactive(file)" list
by the MADV_FREE call.

The only reason it came up is that one of my test systems had a small
swap so I ended up having to do multiple allocations and frees in swap
sized increments to free up memory from a large guest that wasn't in
use.

> The benefit of MADV_FREE should be that when the same guest frees and
> reallocates an huge amount of RAM (i.e. guest app allocating and
> freeing lots of RAM in a loop, not so uncommon), there will be no KVM
> page fault during guest re-allocations. So in absence of memory
> pressure in the host it should be a major win. Overall it sounds like
> a good tradeoff compared to MADV_DONTNEED that forcefully invokes MMU
> notifiers and forces host allocations and KVM page faults in order to
> reallocate the same RAM in the same guest.

Right, and I do see that behavior.

> When there's memory pressure it's up to the host Linux VM to notice
> there's plenty of MADV_FREE material to free at zero I/O cost before
> starting swapping.

Right.
