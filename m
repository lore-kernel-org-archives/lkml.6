Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C004BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F5F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTBxXjW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfAJXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:07:57 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44959 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJXH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:07:57 -0500
Received: by mail-vs1-f67.google.com with SMTP id z23so8088829vsj.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAeQrrPFogb4V7tIaqn4XMzaKAPTBWnl2HVENewfKEs=;
        b=NTBxXjW1RJPgt4TrOmul7wCHLaypyr7ulxqdiFmQaTUJ5hUVrp98CVTeGdLkx6Mg6M
         lc286CNT8YqdEEVNztxsP4gTzdUOR4w0by2jt3MUSe7Z8SIRS2AIW5NAiLpN+/Iz7oAm
         tdzFq9f+69udFotzVtHFN1iG1hUJDBuKF1Lrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAeQrrPFogb4V7tIaqn4XMzaKAPTBWnl2HVENewfKEs=;
        b=VSOfXgsAAUJPTRNf3rpLuZlqR8Nq6PVdlrERA+FiI63aBipCASaVuPcExokOcSQPN5
         EYE07ZK8m4M3wkTidDPFuYHeayV85f0E6ivipsL9rwbsGDhLh9qulPFskUOVC6ycbAR6
         2R/y/iU+3RWnuV0KeydMKJvoWL2ALxgrlSC+xzdGEnDEA7OrnF3v8jDNM+p3Ud0gqYnQ
         ULXWuZHB8qj3rO5z9Ba7T0TSGaS9ETdgd7TbQ9SM63W5Q2nP28px4b5DK8hmvUPx50oN
         oBaaBSAe4qb3M8MCoz6Bvfc3V4bdqRYbEqh98sXUIxGuowABig5e7cBRmLzgIstxDP3J
         AMiQ==
X-Gm-Message-State: AJcUukcsCuGPWp2pwncbLDCC1rxZjbUAYtalhi927feC7jKxm1PKYNZa
        wBjoCpTBK1bagK1kpvZGiZ4bZpMowm4=
X-Google-Smtp-Source: ALg8bN5OpJ0kGSnWoYS5TV/G0bdl1Pn63a1KYNuhuTTzsBQr13RktKr3n8ZKOhLawkKkd5fuY3BHqA==
X-Received: by 2002:a67:e89a:: with SMTP id x26mr5032714vsn.80.1547161674858;
        Thu, 10 Jan 2019 15:07:54 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id l13sm62170951vka.16.2019.01.10.15.07.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:07:54 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id n13so8115484vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:07:52 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr5244437vsl.66.1547161670283;
 Thu, 10 Jan 2019 15:07:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Jan 2019 15:07:38 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKS8XSw7nByaeXqgPbmRRw01E_zUYxLCk7zFepAVSw_aQ@mail.gmail.com>
Message-ID: <CAGXu5jKS8XSw7nByaeXqgPbmRRw01E_zUYxLCk7zFepAVSw_aQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/16] Add support for eXclusive Page Frame Ownership
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liran.alon@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        kanth.ghatraju@oracle.com, joao.m.martins@oracle.com,
        Jim Mattson <jmattson@google.com>, pradeep.vincent@oracle.com,
        John Haxby <john.haxby@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, steven.sistare@oracle.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:10 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
> I implemented a solution to reduce performance penalty and
> that has had large impact. When XPFO code flushes stale TLB entries,
> it does so for all CPUs on the system which may include CPUs that
> may not have any matching TLB entries or may never be scheduled to
> run the userspace task causing TLB flush. Problem is made worse by
> the fact that if number of entries being flushed exceeds
> tlb_single_page_flush_ceiling, it results in a full TLB flush on
> every CPU. A rogue process can launch a ret2dir attack only from a
> CPU that has dual mapping for its pages in physmap in its TLB. We
> can hence defer TLB flush on a CPU until a process that would have
> caused a TLB flush is scheduled on that CPU. I have added a cpumask
> to task_struct which is then used to post pending TLB flush on CPUs
> other than the one a process is running on. This cpumask is checked
> when a process migrates to a new CPU and TLB is flushed at that
> time. I measured system time for parallel make with unmodified 4.20
> kernel, 4.20 with XPFO patches before this optimization and then
> again after applying this optimization. Here are the results:
>
> Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
> make -j60 all
>
> 4.20                            915.183s
> 4.20+XPFO                       24129.354s      26.366x
> 4.20+XPFO+Deferred flush        1216.987s        1.330xx
>
>
> Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
> make -j4 all
>
> 4.20                            607.671s
> 4.20+XPFO                       1588.646s       2.614x
> 4.20+XPFO+Deferred flush        794.473s        1.307xx

Well that's an impressive improvement! Nice work. :)

(Are the cpumask improvements possible to be extended to other TLB
flushing needs? i.e. could there be other performance gains with that
code even for a non-XPFO system?)

> 30+% overhead is still very high and there is room for improvement.
> Dave Hansen had suggested batch updating TLB entries and Tycho had
> created an initial implementation but I have not been able to get
> that to work correctly. I am still working on it and I suspect we
> will see a noticeable improvement in performance with that. In the
> code I added, I post a pending full TLB flush to all other CPUs even
> when number of TLB entries being flushed on current CPU does not
> exceed tlb_single_page_flush_ceiling. There has to be a better way
> to do this. I just haven't found an efficient way to implemented
> delayed limited TLB flush on other CPUs.
>
> I am not entirely sure if switch_mm_irqs_off() is indeed the right
> place to perform the pending TLB flush for a CPU. Any feedback on
> that will be very helpful. Delaying full TLB flushes on other CPUs
> seems to help tremendously, so if there is a better way to implement
> the same thing than what I have done in patch 16, I am open to
> ideas.

Dave, Andy, Ingo, Thomas, does anyone have time to look this over?

> Performance with this patch set is good enough to use these as
> starting point for further refinement before we merge it into main
> kernel, hence RFC.
>
> Since not flushing stale TLB entries creates a false sense of
> security, I would recommend making TLB flush mandatory and eliminate
> the "xpfotlbflush" kernel parameter (patch "mm, x86: omit TLB
> flushing by default for XPFO page table modifications").

At this point, yes, that does seem to make sense.

> What remains to be done beyond this patch series:
>
> 1. Performance improvements
> 2. Remove xpfotlbflush parameter
> 3. Re-evaluate the patch "arm64/mm: Add support for XPFO to swiotlb"
>    from Juerg. I dropped it for now since swiotlb code for ARM has
>    changed a lot in 4.20.
> 4. Extend the patch "xpfo, mm: Defer TLB flushes for non-current
>    CPUs" to other architectures besides x86.

This seems like a good plan.

I've put this series in one of my tree so that 0day will find it and
grind tests...
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/xpfo/v7

Thanks!

-- 
Kees Cook
