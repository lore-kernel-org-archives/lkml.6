Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8201DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A52620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MBcCzeuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A52620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeILGBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:01:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34288 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILGBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:01:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so435761ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V/CZuoxDlWV2LXi8Q0HeRK4VPjrLxaFxj16KV7q2mfc=;
        b=MBcCzeujulwuGlxNu4JBuEDSoBypjxqmREf9m6ObE18T7GMb5KVAIeCKGStddZhG6o
         lRdbWQE5CwJgu2O77VO2kXCxQVMh5Eyto1+85u86Bje0z2hvrasV2DCVY3vriVugJqGY
         iD5D+wo25rXVDvRdVEapSlHLkDvBsIemas/odHSYzJWlLraaN7oWUPPI99kfSsD5ZDV5
         Q7z7hWIrKPAWt6BJ3f0p/qvNwQ6wdvjxwREWzihkt1+HAMjH3q5ZIxNX12SBRqGcAIkD
         LFAGoBtlXExwhWj+9Tz2cEKXU7XJmp4yaqVaXF0VpdPbMNbORdOQVc3TfLZAN6q+A43H
         Qs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V/CZuoxDlWV2LXi8Q0HeRK4VPjrLxaFxj16KV7q2mfc=;
        b=hD7QCa1ceN9WKBV8LFOo1VjCKYf1k9a0FPizhdLdHX4TCdTr90dxELxh4lEC2R7mj6
         DlDykB5eanhA9tcN5IqA9Lsd57pxQYbdxTfjEwJubMu/sY+sjQ9DzXzbe/uAahJZ4wTI
         p+88K2YOnWPsPosQ4wBnRTdRU+wIwt7xqUeW64bqHBuNlafMmBbSOHihcwXt4N/D7ufe
         4KG6TaSDB4GKhDqVbPwXBMB8D97OqMklXyXG+7UIwHvQtcQKw9MhUHT7+5IUMyjduPVa
         eFc6505CsveEU4ufD3NWuiH7E7bg8L4hW03yADPj5yZDIQKYx/T/EevkVHeclTBm3A3n
         2gKg==
X-Gm-Message-State: APzg51DLlY0449DzgHiMwsSfhJ/isJ8iYrRUHbmLuv/ArikJivKEnTJX
        wWmWXo/W14bxKtD2G+xvcXWcTEJ3ySCTBhQQRdoXqA==
X-Google-Smtp-Source: ANB0VdavZkw5iRJWHX5K/bI1/B9vgxh8uJZvvciAH2g5ZSd76x19B0dnquWgjkS0rl4gFlghTfFzM8JWtqwwvs6Vf4g=
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr28083977oia.167.1536713966397;
 Tue, 11 Sep 2018 17:59:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 17:59:25
 -0700 (PDT)
In-Reply-To: <CAKgT0UdmkAXLdR6cfgmu-LcJUOO8a4qAS8zO3Bn+LwjJ9rT3pg@mail.gmail.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234354.4068.65260.stgit@localhost.localdomain> <CAPcyv4ja7=eUbwwJZhreexa9_7JyJotQwObrQm=nCEcgcfbWyw@mail.gmail.com>
 <CAKgT0UdmkAXLdR6cfgmu-LcJUOO8a4qAS8zO3Bn+LwjJ9rT3pg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 17:59:25 -0700
Message-ID: <CAPcyv4iiR3JgHg+Xyw-zON4+66stf917kUqNBxMFFLwT=H14qg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 5:51 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Tue, Sep 11, 2018 at 3:35 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Mon, Sep 10, 2018 at 4:43 PM, Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>> >
>> > From: Alexander Duyck <alexander.h.duyck@intel.com>
>> >
>> > The ZONE_DEVICE pages were being initialized in two locations. One was with
>> > the memory_hotplug lock held and another was outside of that lock. The
>> > problem with this is that it was nearly doubling the memory initialization
>> > time. Instead of doing this twice, once while holding a global lock and
>> > once without, I am opting to defer the initialization to the one outside of
>> > the lock. This allows us to avoid serializing the overhead for memory init
>> > and we can instead focus on per-node init times.
>> >
>> > One issue I encountered is that devm_memremap_pages and
>> > hmm_devmmem_pages_create were initializing only the pgmap field the same
>> > way. One wasn't initializing hmm_data, and the other was initializing it to
>> > a poison value. Since this is something that is exposed to the driver in
>> > the case of hmm I am opting for a third option and just initializing
>> > hmm_data to 0 since this is going to be exposed to unknown third party
>> > drivers.
>> >
>> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> > ---
>> >  include/linux/mm.h |    2 +
>> >  kernel/memremap.c  |   24 +++++---------
>> >  mm/hmm.c           |   12 ++++---
>> >  mm/page_alloc.c    |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>
>> Hmm, why mm/page_alloc.c and not kernel/memremap.c for this new
>> helper? I think that would address the kbuild reports and keeps all
>> the devm_memremap_pages / ZONE_DEVICE special casing centralized. I
>> also think it makes sense to move memremap.c to mm/ rather than
>> kernel/ especially since commit 5981690ddb8f "memremap: split
>> devm_memremap_pages() and memremap() infrastructure". Arguably, that
>> commit should have went ahead with the directory move.
>
> The issue ends up being the fact that I would then have to start
> exporting infrastructure such as __init_single_page from page_alloc. I
> have some follow-up patches I am working on that will generate some
> other shared functions that can be used by both memmap_init_zone and
> memmap_init_zone_device, as well as pulling in some of the code from
> the deferred memory init.

You wouldn't need to export it, just make it public to mm/ in
mm/internal.h, or a similar local header. With kernel/memremap.c moved
to mm/memremap.c this becomes even easier and better scoped for the
shared symbols.
