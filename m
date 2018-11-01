Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37468C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA2205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HzadiFe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEA2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKAUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:31:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40469 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKAUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:31:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id m15so17417722otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6PF0RiTcJwkIcly71gREdGcceqUcI7V7FLfCAd/vnk=;
        b=HzadiFe8GF1u9jwmpnGnmyHhyB6lXlryobbYWLasu/qlWD5Lr5KKRzC3Z/HzcXInCR
         27kMxLDhrlnM0U0Vjek5jkoiBt49TIqvG0OYqYFWqxjYd3hToupHSAe0GTStTt4oXYY1
         hp4X2FAQs7hm+XsNA59KGaSzxJVse7i8KWp+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6PF0RiTcJwkIcly71gREdGcceqUcI7V7FLfCAd/vnk=;
        b=Z155A7qE59DS5oGl5Rs3nBylEx//xeM7Yl2h2I6CZLADB6EXVu8grkDKd2Yx608V2B
         d9oaXM8sVD/4NB9bcxw+Eh4zp45+3DPm+YFUVLoCyGU89165LIIiND7eeLE5k/9Zt/cV
         bbmEqNzKbwoQ1Wjy7xmA5rviUM6P/ACO2k0jQCpEqmwmUfIr0+Ol/t7dq482uEI5mEY9
         WJaTdwqCUibSOuk6a9cZXXvKD9iAABbas2KN3psI9pYqKJXaozRE5hhaMurbYi9P2Al4
         w0Ig12xaQ9ZWIhVn4icq8gfh5r9bTnvNPpEpjUijCZrN3GQSAux8e+woloctAGbpSA2k
         c2mw==
X-Gm-Message-State: AGRZ1gKo4YzE+Fb3Qw1qIcCTwBHlrzy7PB7q8tnf3oqyl38ts+sS/MrC
        NrKpjYVQEDik7NltBOL4LQUUJhtnqphqk/u2qjS8
X-Google-Smtp-Source: AJdET5cehRw6kq4kEpFBE56j0n3kK52rgi/F0yGKwPyNBM9lS2JA7Np1ZWSl++D/+l3bUhPNL2fLUf8YujjG56YPYMw=
X-Received: by 2002:a9d:738a:: with SMTP id j10mr4455367otk.188.1541071737898;
 Thu, 01 Nov 2018 04:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081945.207709-1-vovoy@chromium.org> <20181031142458.GP32673@dhcp22.suse.cz>
 <cc44aa53-8705-02ea-6c59-f311427d93af@intel.com> <20181031164231.GQ32673@dhcp22.suse.cz>
In-Reply-To: <20181031164231.GQ32673@dhcp22.suse.cz>
From:   Vovo Yang <vovoy@chromium.org>
Date:   Thu, 1 Nov 2018 19:28:46 +0800
Message-ID: <CAEHM+4pSkv_fD3Yb2KX1xFrOmRHU1e=+wCBrCyLAAMBG3zP75w@mail.gmail.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     mhocko@kernel.org
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        peterz@infradead.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 12:42 AM Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 31-10-18 07:40:14, Dave Hansen wrote:
> > Didn't we create the unevictable lists in the first place because
> > scanning alone was observed to be so expensive in some scenarios?
>
> Yes, that is the case. I might just misunderstood the code I thought
> those pages were already on the LRU when unevictable flag was set and
> we would only move these pages to the unevictable list lazy during the
> reclaim. If the flag is set at the time when the page is added to the
> LRU then it should get to the proper LRU list right away. But then I do
> not understand the test results from previous run at all.

"gem_syslatency -t 120 -b -m" allocates a lot of anon pages, it consists of
these looping threads:
  * ncpu threads to alloc i915 shmem buffers, these buffers are freed by i915
shrinker.
  * ncpu threads to mmap, write, munmap an 2 MiB mapping.
  * 1 thread to cat all files to /dev/null

Without the unevictable patch, after rebooting and running
"gem_syslatency -t 120 -b -m", I got these custom vmstat:
  pgsteal_kswapd_anon 29261
  pgsteal_kswapd_file 1153696
  pgsteal_direct_anon 255
  pgsteal_direct_file 13050
  pgscan_kswapd_anon 14524536
  pgscan_kswapd_file 1488683
  pgscan_direct_anon 1702448
  pgscan_direct_file 25849

And meminfo shows large anon lru size during test.
  # cat /proc/meminfo | grep -i "active("
  Active(anon):     377760 kB
  Inactive(anon):  3195392 kB
  Active(file):      19216 kB
  Inactive(file):    16044 kB

With this patch, the custom vmstat after test:
  pgsteal_kswapd_anon 74962
  pgsteal_kswapd_file 903588
  pgsteal_direct_anon 4434
  pgsteal_direct_file 14969
  pgscan_kswapd_anon 2814791
  pgscan_kswapd_file 1113676
  pgscan_direct_anon 526766
  pgscan_direct_file 32432

The anon pgscan count is reduced.
