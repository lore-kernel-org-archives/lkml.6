Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4FE23E37
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="m8bwzpGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4FE23E37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFVHaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:30:02 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33587 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFVHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:30:01 -0400
Received: by mail-ot0-f193.google.com with SMTP id h6-v6so6496866otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J5Rf4GLMDYQIfR6cleT8OnPu9ho1bvz2aHxfVIWYtv8=;
        b=m8bwzpGRFqvTzlrgJBQDkemHgBIllA3c0tvW7PZdLsSLNn3S7XqGW+4JjBOj+deSqC
         KlMASOs8Trsfge+E5ZIjI7G37sjV0CTWEqVkaR3TNqHCTQ2GqYS9EpxDVP8OFqWbPZss
         5sGrHlHMn4957e6VDmmHoS2TCAnm5z4g6CrPKwT/u7pv9E+RcIrQ4K67sXpB2aeVpoGC
         kk+tsY6HQrPmtfccGAGzmlnkMty2WT0QRdnzHmvQOa+I3Hu7TyVVfWiNifRjI/7dKndN
         nXz0jcxaMVbHleDCQhist7m1AIeoGZYkZdhJWgT1nffgWutgQEZRyp+OgZpzSGNcqiyB
         k7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J5Rf4GLMDYQIfR6cleT8OnPu9ho1bvz2aHxfVIWYtv8=;
        b=nLiM8wiwwnmibZOZQK0dzDr8CzM37aA5lEykHILSADhJAwWesYosGOlueifHc6XL8O
         14LAi/0Lp1iat0N4NiCLCXzGHjsBsj/+CQqLqrRZ5eQdyIZ0ipoIerNAvU8tNUk8tarl
         TBAyjeaxl4tJ9CMfpC8IJ3DC34gPFQPft2olNeg1Q6DhHOkHlCysTzMPaGMGY6H/LU0Q
         z5cApjNjW5r6BRwOV12UEMICOn84m32P8m7D5U+G2PGEiV/m07bE1PIkh6TthDzxIPaf
         IaLeOqNYnfoCOxRHnrmp8yShbd/qiLQxhN3ulH84RQ6EdspI36c9JZfVCBw0B4x9w7Tr
         X0/Q==
X-Gm-Message-State: APt69E0K3ky1TUobyriD+u0zUc2LbignRloO6Ff1aW/+/Ylrk3XxiMn2
        gazv/272S9WyDNTCZMPqv4oNqE/laOuxHSa6w8JJaQ==
X-Google-Smtp-Source: ADUXVKKSiNhSYR/lm+ypvpR+mEoHo+Y2pel+eYZYpDb1a4H8UX2iIMM6FdzfGqBGN0jupMhMvZcKFvck14bfcLwBIM0=
X-Received: by 2002:a9d:64c3:: with SMTP id n3-v6mr293176otl.210.1529652600952;
 Fri, 22 Jun 2018 00:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:30:00
 -0700 (PDT)
In-Reply-To: <20180622065510.GA13556@hori1.linux.bs1.fc.nec.co.jp>
References: <1529647683-14531-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <CAPcyv4hpdvGRi+=psT47ePB6QigJW2JEq-zhbVXsTHb14pWfUQ@mail.gmail.com> <20180622065510.GA13556@hori1.linux.bs1.fc.nec.co.jp>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Jun 2018 00:30:00 -0700
Message-ID: <CAPcyv4iQMUOz0euRB3-rEYJyEzt9-Dt3Y0B=0A0nFAYNk0FTfA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: initialize struct page for reserved pages in ZONE_DEVICE
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:55 PM, Naoya Horiguchi
<n-horiguchi@ah.jp.nec.com> wrote:
> On Thu, Jun 21, 2018 at 11:12:01PM -0700, Dan Williams wrote:
>> On Thu, Jun 21, 2018 at 11:08 PM, Naoya Horiguchi
>> <n-horiguchi@ah.jp.nec.com> wrote:
>> > Reading /proc/kpageflags for pfns allocated by pmem namespace triggers
>> > kernel panic with a message like "BUG: unable to handle kernel paging
>> > request at fffffffffffffffe".
>> >
>> > The first few pages (controlled by altmap passed to memmap_init_zone())
>> > in the ZONE_DEVICE can skip struct page initialization, which causes
>> > the reported issue.
>> >
>> > This patch simply adds some initialization code for them.
>> >
>> > Fixes: 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment vmemmap_populate()")
>> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> > ---
>> >  mm/page_alloc.c | 10 +++++++++-
>> >  1 file changed, 9 insertions(+), 1 deletion(-)
>> >
>> > diff --git v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
>> > index 1772513..0b36afe 100644
>> > --- v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c
>> > +++ v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
>> > @@ -5574,8 +5574,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>> >          * Honor reservation requested by the driver for this ZONE_DEVICE
>> >          * memory
>> >          */
>> > -       if (altmap && start_pfn == altmap->base_pfn)
>> > +       if (altmap && start_pfn == altmap->base_pfn) {
>> > +               unsigned long i;
>> > +
>> > +               for (i = 0; i < altmap->reserve; i++) {
>> > +                       page = pfn_to_page(start_pfn + i);
>> > +                       __init_single_page(page, start_pfn + i, zone, nid);
>> > +                       SetPageReserved(page);
>> > +               }
>> >                 start_pfn += altmap->reserve;
>> > +       }
>>
>> No, unfortunately this will clobber metadata that lives in that
>> reserved area, see __nvdimm_setup_pfn().
>
> Hi Dan,
>
> This patch doesn't touch the reserved region itself, but only
> struct pages on the region. I'm still not sure why it's necessary
> to leave these struct pages uninitialized for pmem operation?
>
> My another related concern is about memory_failure_dev_pagemap().
> If a memory error happens on the reserved pfn range, this function
> seems to try to access to the uninitialized struct page and maybe
> trigger oops. So do we need something to prevent this?

Those pages are never mapped to userspace, so there is no opportunity
to consume the media error in that space. I'm still not sure it is
safe to initialize the pfns in the reserved range, I'll take a closer
look tomorrow. Otherwise, why not just delete the entire check and let
the main loop initialize the pages?
