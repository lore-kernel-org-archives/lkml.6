Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCCBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A1D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JKpyZVHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfA3Sa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:30:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45897 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbfA3Sa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:30:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so433324ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9j79+mJlVivCZg8r9eXgCwMYenun/QvjMBX1vH8qwVk=;
        b=JKpyZVHwBzbZoi3xFBOJzn2IbpF802PLabqHWw8ZD026IfIn5OszULaE+vwKkiPb3S
         o/QUb9/hfz1n2Y6gak73YSduWwoX9jik/GbhVfYtK/DSG7mHLVLqgU5vhonAtUF2jow+
         L/38FpMlBqKHRgq6Hjwk5QvfkmtLNTw8xGz2Vpt5n/zOeBgZhvmBRLGfqr4WkF6KlIaZ
         hnQABc+30eTr722VZw3wwe+YZYrwRrWZc/rtNP/K5itYlVAQIxPwxbER+yLhyf6viRHS
         rcnIOmtzVlVFjfhdTF0es0jpUzl2S7LVV+g4hHtsF2yIqjKyHavd7Bmbyp+TBQhRpdsF
         45HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9j79+mJlVivCZg8r9eXgCwMYenun/QvjMBX1vH8qwVk=;
        b=ZW+w4wPZDRjqYwgPZ6Gj2etN8trywVns0U4yMLnyXOk/0BaLmQ9txitN2NyWnx5nWU
         45QdvkhRXpwz8ebHIbdY9Qcv4MvA06PB1nFDTraIGhblHy5HLRxdYnVY5uiUQGnbXC6t
         BNvlBtptGkq5Ymak6y54jugXvYsceURhy66asjUfQ/Qza0nYML7fR+2uorZMBw7NBIB8
         H/ECAokT9dpyfMpnN1m3ut/R0b0KOSFh1MEeyXn3bdkqn6GXSWwX/FBYRPLWdKhFY9VA
         HAL7yIMs4cdc75z8m8m6qtD4FNibqEqH/sICG9PvXNdG8UGQpdf/5XQ/CuwbGDQVZaof
         4poQ==
X-Gm-Message-State: AJcUukefUqQeFO0v9OTz7ltx9KWaa4uuqoMCwQKlmj/jXP7dXR914BHG
        mABpDmYrsszHAeEG/S5KSs37keCyswgjAqAwSss55Q==
X-Google-Smtp-Source: ALg8bN50PZrZSvg9p519hj+hk5qFch5Xc+sgKgpSmNfdxTt09IU1nK4fd3JVClOirb4JtDKnB6nQh9pcLz+sNphIw58=
X-Received: by 2002:a9d:394:: with SMTP id f20mr22353389otf.98.1548873027799;
 Wed, 30 Jan 2019 10:30:27 -0800 (PST)
MIME-Version: 1.0
References: <154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154882453604.1338686.15108059741397800728.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190130064856.GB17937@rapoport-lnx>
In-Reply-To: <20190130064856.GB17937@rapoport-lnx>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Jan 2019 10:30:16 -0800
Message-ID: <CAPcyv4jLFQ_ZGqBJK_xaVctMopdhdXEi7BzD=MA_VRucoNhKXQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:49 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Jan 29, 2019 at 09:02:16PM -0800, Dan Williams wrote:
> > Randomization of the page allocator improves the average utilization of
> > a direct-mapped memory-side-cache. Memory side caching is a platform
> > capability that Linux has been previously exposed to in HPC
> > (high-performance computing) environments on specialty platforms. In
> > that instance it was a smaller pool of high-bandwidth-memory relative to
> > higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> > be found on general purpose server platforms where DRAM is a cache in
> > front of higher latency persistent memory [1].
>
> [ ... ]
>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/list.h    |   17 ++++
> >  include/linux/mmzone.h  |    4 +
> >  include/linux/shuffle.h |   45 +++++++++++
> >  init/Kconfig            |   23 ++++++
> >  mm/Makefile             |    7 ++
> >  mm/memblock.c           |    1
> >  mm/memory_hotplug.c     |    3 +
> >  mm/page_alloc.c         |    6 +-
> >  mm/shuffle.c            |  188 +++++++++++++++++++++++++++++++++++++++++++++++
> >  9 files changed, 292 insertions(+), 2 deletions(-)
> >  create mode 100644 include/linux/shuffle.h
> >  create mode 100644 mm/shuffle.c
>
> ...
>
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 022d4cbb3618..c0cfbfae4a03 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/poison.h>
> >  #include <linux/pfn.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/shuffle.h>
>
> Nit: does not seem to be required
>
> >  #include <linux/kmemleak.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>

Good catch. Notch one more line saved in the incremental diffstat from
v8. I'll wait for Michal's thumbs up on the rest before re-spinning,
or perhaps Andrew can drop this line on applying?
