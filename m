Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAC421848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Tl4TF8Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeLQQcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:32:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45376 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeLQQcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:32:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so10630736oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=946sLcjpQsp/968YiE5rGuiVT+iM4l7kZ4rJlWpVa50=;
        b=Tl4TF8HrpvrWtE6PZAeBIWjuXiyiPh+DpimAYFQ3skF4W4ghFENrvPts/LgGG/99F/
         wEs23pft98j1Jq5ZJjSQ42a9UuzvlLZG9xVuNjkQcDPdaVF8DU+GY53zXt7mzLpF8f0Q
         /ltrCZbBQ/hxAQFE5jzUFuRxAkLsdTiciCQ0mKwLU8yW+aofJ1XQQhB8k8UnHCncefQf
         iF6zQmlkeUaVlZgTJ/Q2qdI8l/EHEnKhYp0js//WYoUNwAS00bwez4MlLeGIbBnuWkrN
         QzumE189uiwfLJ6UQeDu2MjvYqLbGBVSIdiECSKXvtLNHLm38/CcNFFRlMS9oqGSATpb
         CenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=946sLcjpQsp/968YiE5rGuiVT+iM4l7kZ4rJlWpVa50=;
        b=PtElCqvOfRuhbCHgh1ot7M9OlYM4hq9HIcwNA8zefP7l2dZggUmRKxyvBOqda65AP4
         n+JE6PekJoWonulwHSNc8XdasuWJoNL9tHl35SoGRBtMqY7CVICTQqJKEY+Ea/9PimN2
         PO/twzVcqJDRKt0LINvQID4tXWjl7IA7j2rO90PieAlCJGybqjFPGK3cCPAJRvQWixzy
         NuqTPws8FJiTiYHpzG/nOBs7RS/pCgxa+WZPeNnk+fG11MAbgAA1SHTOJ6yrYisUQFVw
         Gozq/XXjh1s/fwKfRpNdgqBQlVJZIrwu4YY165RUd/Txr4gTPI9yOFOXCqDnJME9IHHH
         IAtA==
X-Gm-Message-State: AA+aEWb71HFBD2gK1VDqvNLNrma2Empjtz8gKalVGRkMv6DL117hSVXC
        o3rNq6+TneMbVwz3RzyOwtlSfbLaQADhsIqMIiTeG1gO
X-Google-Smtp-Source: AFSGD/XhhmDTC0uJQCfUYCgb22bQlbVyjKY1KaW9SrbEM9qOh5wiu5TAfhQ+VZ5NFGt6DWM8HTQ/uKeB/xcbgBsQErg=
X-Received: by 2002:aca:b804:: with SMTP id i4mr5562201oif.280.1545064343022;
 Mon, 17 Dec 2018 08:32:23 -0800 (PST)
MIME-Version: 1.0
References: <154483851047.1672629.15001135860756738866.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2153922.MoOcIFpNeT@aspire.rjw.lan>
In-Reply-To: <2153922.MoOcIFpNeT@aspire.rjw.lan>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Dec 2018 08:32:10 -0800
Message-ID: <CAPcyv4iW1812gtiuKz8UTPJPhT0_fg+jgo6Z_6Kt9CR2N0Z4Jg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mm: Randomize free memory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 2:12 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Saturday, December 15, 2018 2:48:30 AM CET Dan Williams wrote:
> > Changes since v4: [1]
> > * Default the randomization to off and enable it dynamically based on
> >   the detection of a memory side cache advertised by platform firmware.
> >   In the case of x86 this enumeration comes from the ACPI HMAT. (Michal
> >   and Mel)
> > * Improve the changelog of the patch that introduces the shuffling to
> >   clarify the motivation and better explain the tradeoffs. (Michal and
> >   Mel)
> > * Include the required HMAT enabling in the series.
> >
> > [1]: https://lkml.kernel.org/r/153922180166.838512.8260339805733812034.stgit@dwillia2-desk3.amr.corp.intel.com
> >
> > ---
> >
> > Quote patch 3:
> >
> > Randomization of the page allocator improves the average utilization of
> > a direct-mapped memory-side-cache. Memory side caching is a platform
> > capability that Linux has been previously exposed to in HPC
> > (high-performance computing) environments on specialty platforms. In
> > that instance it was a smaller pool of high-bandwidth-memory relative to
> > higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> > be found on general purpose server platforms where DRAM is a cache in
> > front of higher latency persistent memory [2].
> >
> > Robert offered an explanation of the state of the art of Linux
> > interactions with memory-side-caches [3], and I copy it here:
> >
> >     It's been a problem in the HPC space:
> >     http://www.nersc.gov/research-and-development/knl-cache-mode-performance-coe/
> >
> >     A kernel module called zonesort is available to try to help:
> >     https://software.intel.com/en-us/articles/xeon-phi-software
> >
> >     and this abandoned patch series proposed that for the kernel:
> >     https://lkml.org/lkml/2017/8/23/195
> >
> >     Dan's patch series doesn't attempt to ensure buffers won't conflict, but
> >     also reduces the chance that the buffers will. This will make performance
> >     more consistent, albeit slower than "optimal" (which is near impossible
> >     to attain in a general-purpose kernel).  That's better than forcing
> >     users to deploy remedies like:
> >         "To eliminate this gradual degradation, we have added a Stream
> >          measurement to the Node Health Check that follows each job;
> >          nodes are rebooted whenever their measured memory bandwidth
> >          falls below 300 GB/s."
> >
> > A replacement for zonesort was merged upstream in commit cc9aec03e58f
> > "x86/numa_emulation: Introduce uniform split capability". With this
> > numa_emulation capability, memory can be split into cache sized
> > ("near-memory" sized) numa nodes. A bind operation to such a node, and
> > disabling workloads on other nodes, enables full cache performance.
> > However, once the workload exceeds the cache size then cache conflicts
> > are unavoidable. While HPC environments might be able to tolerate
> > time-scheduling of cache sized workloads, for general purpose server
> > platforms, the oversubscribed cache case will be the common case.
> >
> > The worst case scenario is that a server system owner benchmarks a
> > workload at boot with an un-contended cache only to see that performance
> > degrade over time, even below the average cache performance due to
> > excessive conflicts. Randomization clips the peaks and fills in the
> > valleys of cache utilization to yield steady average performance.
> >
> > See patch 3 for more details.
> >
> > [2]: https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
> > [3]: https://lkml.org/lkml/2018/9/22/54
>
> Has this hibernation been tested with this series applied?

It has not. Is QEMU sufficient? What's your concern?
