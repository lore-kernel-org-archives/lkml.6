Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CEA2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfqFwfkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CEA2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeGJFd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:33:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45805 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeGJFdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:33:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id a17-v6so1260976plm.12;
        Mon, 09 Jul 2018 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmPCm/FjMdA9Xru7/A4CAE8Aons1lApQRQi3bEo2MaI=;
        b=WfqFwfkWlUI5dlVVHNTn2UZgIeWestNvpvv2MhLvcUt/4oYQksygWRf+guF80s48w0
         du/IrKvXO7m+ydDgTN+B04f/XBvOXJD6x0XCnzrfAVUnHzorePBOfLFjgPanwUIxFpq0
         8+KsFcWB1pdkeqZAtJRftlh2AAEEd1yOH/izJBQDNB3Bh6YgLZ/ybQQheMpB5ioPBtMl
         9EUuiDZkQXgQRlsXCNJh4FJK0ZZ1++9fsnOjKfLyvh9HZtDXRzP75sr7w8txayG4orvw
         y0KYAEvfyfqlVw88WVNZghBeISvUw8hEbZPGOXVe7eXZh3d+I9nEu+tbze0vcF0XHgzz
         iEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmPCm/FjMdA9Xru7/A4CAE8Aons1lApQRQi3bEo2MaI=;
        b=pg8aT49sPK591wIkVXPMqX11JAaL31vOuiO5BP5IS2CzYb4owUX0YdhMF0eYiljm2D
         dUGlRp9cw0bp6BJPQROcYBl6AdfRzAbejOjb9hV0isNMZTW25XBbiWPQefTJKMyFyHFz
         CepS+PigrZZ7otLI8Ql2CNgOVn+7BqDXjXCIBFxApjHg5lN8ej7vaFyWOKKT4KEXyWci
         9ZGtshDQwyPlBmzHXWw7n3ThBxGwxs2EXbFVmxEwzxHxl90UMBAZ3zAS49PS68HhOeAf
         RcKdRmy96oyXHF44EJIwOrPkOnKMosIstxs2+E6v9jAFVUMW0C8V1L+OOvO610KG5FNY
         4kRw==
X-Gm-Message-State: APt69E1PfbPfBoWZpVwzSCob68UCT4ll1UfEWvxg7193FBLGWbbBKMxc
        KkoceESRTHrwOtMuYJnJJuxfjw==
X-Google-Smtp-Source: AAOMgpepBo1eW6FiIFB3+xa+4N+j1+mI900P0zmuxPgOvC3RgRR4sluEgpRiD3fszTcpM0qCGWJ4pA==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6-v6mr23406478plb.120.1531199057750;
        Mon, 09 Jul 2018 22:04:17 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id w16-v6sm40615851pfi.101.2018.07.09.22.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 22:04:17 -0700 (PDT)
Date:   Tue, 10 Jul 2018 15:04:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel-team <kernel-team@fb.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: mm,tlb: revert 4647706ebeee?
Message-ID: <20180710150410.4207bbfa@roar.ozlabs.ibm.com>
In-Reply-To: <20180709171356.87d834e125f06e0cdaa72f85@linux-foundation.org>
References: <1530896635.5350.25.camel@surriel.com>
        <20180708012538.51b2c672@roar.ozlabs.ibm.com>
        <20180709171356.87d834e125f06e0cdaa72f85@linux-foundation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 17:13:56 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 8 Jul 2018 01:25:38 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > On Fri, 06 Jul 2018 13:03:55 -0400
> > Rik van Riel <riel@surriel.com> wrote:
> >   
> > > Hello,
> > > 
> > > It looks like last summer, there were 2 sets of patches
> > > in flight to fix the issue of simultaneous mprotect/madvise
> > > calls unmapping PTEs, and some pages not being flushed from
> > > the TLB before returning to userspace.
> > > 
> > > Minchan posted these patches:
> > > 56236a59556c ("mm: refactor TLB gathering API")
> > > 99baac21e458 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
> > > 
> > > Around the same time, Mel posted:
> > > 4647706ebeee ("mm: always flush VMA ranges affected by zap_page_range")
> > > 
> > > They both appear to solve the same bug.
> > > 
> > > Only one of the two solutions is needed.
> > > 
> > > However, 4647706ebeee appears to introduce extra TLB
> > > flushes - one per VMA, instead of one over the entire
> > > range unmapped, and also extra flushes when there are
> > > no simultaneous unmappers of the same mm.
> > > 
> > > For that reason, it seems like we should revert
> > > 4647706ebeee and keep only Minchan's solution in
> > > the kernel.
> > > 
> > > Am I overlooking any reason why we should not revert
> > > 4647706ebeee?  
> > 
> > Yes I think so. Discussed here recently:
> > 
> > https://marc.info/?l=linux-mm&m=152878780528037&w=2  
> 
> Unclear if that was an ack ;)
>

Sure, I'm thinking Rik's mail is a ack for my patch :)

No actually I think it's okay, but was in the middle of testing
my series when Aneesh pointed out a bit was missing from powerpc,
so I had to go off and fix that, I think that's upstream now. So
need to go back and re-test this revert.

Wouldn't hurt for other arch maintainers to have a look I guess
(cc linux-arch):

The problem powerpc had is that mmu_gather flushing will flush a
single page size based on the ptes it encounters when we zap. If
we hit a different page size, it flushes and switches to the new
size. If we have concurrent zaps on the same range, the other
thread may have cleared a large page pte so we won't see that and
will only do a small page flush for that range. Which means we can
return before the other thread invalidated our TLB for the large
pages in the range we wanted to flush.

I suspect most arches are probably okay, but if you make any TLB
flush choices based on the pte contents, then you could be exposed.
Except in the case of archs like sparc and powerpc/hash which do
the flushing in arch_leave_lazy_mmu_mode(), because that is called
under the same page table lock, so there can't be concurrent zap.

A quick look through the archs doesn't show anything obvious, but
please take a look at your arch.

And I'll try to do a bit more testing.

Thanks,
Nick
