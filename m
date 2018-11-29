Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C29C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03D820989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CgoFbD9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03D820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeK3Egk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:36:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37529 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeK3Egk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:36:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so2514936oth.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l06D3vkTAHbgGe4bhATuW0RHmioaENRzMGToVeO3Zsc=;
        b=CgoFbD9PtO6OqFOE1rOty4ny4muumLTSAf0KhyYYahS00gqIGT2qFdkHL+R/KKK10h
         T/3LWCNoFdzhdCAChf67TUrn3/4xDq/v8hZUvTNAzLKiRPbz1AyhUSYDMNkAqyrTh5gC
         1So1Cp8dqfs8/GiGg/lnWNkzPGj9+zquaXs0SRVKsxWb8WIRbSSCDng/jeme21XJdEFN
         sRn88ua9paLLkm/WfuRuCkyJ7LiH1vtpiEjFFhd8Xofjq/DA+r9IQPBZgh5jY6ynZqZr
         ygMjR+EuHa6B36/Z/3CGoIq0pwfb+RZVqzuwmNKUH96gyYzz2BQH+qsthwDe+igaMRLx
         bFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l06D3vkTAHbgGe4bhATuW0RHmioaENRzMGToVeO3Zsc=;
        b=HD9/5q6Qf5p+npJXO34yhECiQCrj3hYdhf0btIQBNJZ3cYnrG1lPvwOAeu98CBQblG
         fPDC9ZZUu0YdLnumVWAnOQeTqNR50tqjUvk2OX54ZRc1pwxKQPzatV19+wrVCZ9dPzBB
         sngBhkAhIG4Irl+xZLo6prJuQ619arkmvcBKFz6tT6+4qH6goXsEvcSm+qJsaas36Mpl
         4J7X7jZo/Dc0dDv+Xzk74ebBqGkc/4do/9z8a/iNzg8D+z7lOTLp3QDBhFbjC2EkQw/I
         Ccorn2bBJkfK2tJnxxyUF6YLHTr2axIjUsQszdzQ4sfz2VBS9ehKD0I4qmxvfSgeo8az
         4rbA==
X-Gm-Message-State: AA+aEWbg5LC2EYlum+TuUwIAX1slCvV9MOMbuM/SesGb2BKw1X5VmmV/
        RS8MvjFZbHgt0NI1mLPbKuewR6cuG+lKsvs8Vuh7sg==
X-Google-Smtp-Source: AFSGD/X0heWiCxlHk1RKT+muKPs6wmY//zu2YWJegWWKAq488U+8B6cikAwWNcIjIgS0q/eKkwcKMiC2zhyzAapQU5o=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr1467612oti.367.1543512632718;
 Thu, 29 Nov 2018 09:30:32 -0800 (PST)
MIME-Version: 1.0
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
 <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com> <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
 <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com>
In-Reply-To: <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Nov 2018 09:30:20 -0800
Message-ID: <CAPcyv4gZisOAE8VJPJChNXrWv0NhUevWuutsPdvNORBTOBXJfA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:07 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-28 8:10 p.m., Dan Williams wrote:
> > Yes, please send a proper patch.
>
> Ok, I'll send one shortly.
>
> > Although, I'm still not sure I see
> > the problem with the order of the percpu-ref kill. It's likely more
> > efficient to put the kill after the put_page() loop because the
> > percpu-ref will still be in "fast" per-cpu mode, but the kernel panic
> > should not be possible as long as their is a wait_for_completion()
> > before the exit, unless something else is wrong.
>
> The series of events looks something like this:
>
> 1) Some p2pdma user calls pci_alloc_p2pmem() to get some memory to DMA
> to taking a reference to the pgmap.
> 2) Another process unbinds the underlying p2pdma driver and the devm
> chain starts to unwind.
> 3) devm_memremap_pages_release() is called and it kills the reference
> and drop's it's last reference.

Oh! Yes, nice find. We need to wait for the percpu-ref to be dead and
all outstanding references dropped before we can proceed to
arch_remove_memory(), and I think this problem has been there since
day one because the final exit was always after devm_memremap_pages()
release which means arch_remove_memory() was always racing any final
put_page(). I'll take a look, it seems the arch_remove_pages() call
needs to be moved out-of-line to its own context and wait for the
final exit of the percpu-ref.

> 4) arch_remove_memory() is called which will remove all the struct pages.
> 5) We eventually get to pci_p2pdma_release() where we wait for the
> completion indicating all the pages have been freed.
> 6) The user in (1) tries to use the page that has been removed,
> typically by calling pci_p2pdma_map_sg(), but the page doesn't exist so
> the kernel panics.
>
> So we really need the wait in (5) to occur before (4) but after (3) so
> that the pages continue to exist until the last reference is dropped.
>
> > Certainly you can't move the wait_for_completion() into your ->kill()
> > callback without switching the ordering, but I'm not on board with
> > that change until I understand a bit more about why you think
> > device-dax might be broken?
> >
> > I took a look at the p2pdma shutdown path and the:
> >
> >         if (percpu_ref_is_dying(ref))
> >                 return;
> > ...looks fishy. If multiple agents can overlap their requests for the
> > same range why not track that simply as additional refs? Could it be
> > the crash that you are seeing is a result of mis-accounting when it is
> > safe to assume the page allocation can be freed?
>
> Yeah, someone else mentioned the same thing during review but if I
> remove it, there can be a double kill() on a hypothetical driver that
> might call pci_p2pdma_add_resource() twice. The issue is we only have
> one percpu_ref per device not one per range/BAR.
>
> Though, now that I look at it, the current change in question will be
> wrong if there are two devm_memremap_pages_release()s to call. Both need
> to drop their references before we can wait_for_completion() ;(. I guess
> I need multiple percpu_refs or more complex changes to
> devm_memremap_pages_release().

Can you just have a normal device-level kref for this case? On final
device-level kref_put then kill the percpu_ref? I guess the problem is
devm semantics where p2pdma only gets one callback on a driver
->remove() event. I'm not sure how to support multiple references of
the same pages without creating a non-devm version of
devm_memremap_pages(). I'm not opposed to that, but afaiu I don't
think p2pdma is compatible with devm as long as it supports N>1:1
mappings of the same range.
