Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE947C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8F02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="RA7naYm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8F02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeILDgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:36:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42706 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeILDgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:36:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id v198-v6so32735162oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kv3XhMMmx7rFVxnOKJEZ8pDEIg1ExIxoLsHSho0w5mk=;
        b=RA7naYm8BAzyDE+u5GEw46OtrvTW4luklLqwyUJpv6/S6+rcy4LQkPgyvh71tyXoQX
         QoPXtablKOVeov9qvnvUILX5Fyz320xdTg0mc9wvy0qU037H73YEV/QHD9jrE+4G9Mtb
         7RuBlsQLhHohDVe97pWMpPdrPr6t2zXsyTmh61Q7ZI9tfhX/RlJfgzUvQOMxnA/fmYYP
         1X1PdpHn133WnDavT9PsMJdXj1hsMVp0k+zIjxrY+Nh/36ybrCOMRXAQbjOS07oF2SPz
         ZTh/m6SYK31kc1d2uo55DFNvxXpHuLDpjqL6TzF1YmT3ocvtC9WCfLMTflH7XQDi/rhS
         TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kv3XhMMmx7rFVxnOKJEZ8pDEIg1ExIxoLsHSho0w5mk=;
        b=Jma4Kf+boEynSIK0CURozFTZGjbxeqr3mERx3qoBNwf1PRhktJ38w3spGZ9aETZMNI
         MGEJFP2X3/mMa2VT+lXzvbS7hLsU2MDcIw2tblf+QXV5hXA+pvFlR9YfTHhxuU1AykxE
         d0Vz2QWPEGhACxmqU+3+GYKY+b8HozW+jRW3To5mej08lAbWxctQFsdXQHiIWxQeRHPK
         Gz3/RqX3TwKpT2gLrw/6fSPy1z8HX/fQd2PTpDqYV7Fjz5an1OsHAuSAi/ZVl9h6Y7vx
         bGGIvrOZcc+gbVEu3ZDhtdOwPlAlScW7GQ6owH7zl6AnaRZCZxxQWJK90T47u2NOOyi6
         P4Ag==
X-Gm-Message-State: APzg51AmVDsrJ4Gt8WoDvqRkeBSL2SNmL4OnYb5O03koJDygkdgk4Pto
        vRDumhlCT2XbhA3owiDWXachy72d3pj2NVKJz2xWHB4QekA=
X-Google-Smtp-Source: ANB0VdZaUHqJ4lA+9ml9Oy8g8UGn+GqDGF8vF8c7Iv/dgjDXDlWtkwPODQQC20UbB3q7yZHlLliMpifcFHbFkMRQdcU=
X-Received: by 2002:aca:5905:: with SMTP id n5-v6mr32431005oib.232.1536705304781;
 Tue, 11 Sep 2018 15:35:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 15:35:04
 -0700 (PDT)
In-Reply-To: <20180910234354.4068.65260.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain> <20180910234354.4068.65260.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Sep 2018 15:35:04 -0700
Message-ID: <CAPcyv4ja7=eUbwwJZhreexa9_7JyJotQwObrQm=nCEcgcfbWyw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Sep 10, 2018 at 4:43 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> The ZONE_DEVICE pages were being initialized in two locations. One was with
> the memory_hotplug lock held and another was outside of that lock. The
> problem with this is that it was nearly doubling the memory initialization
> time. Instead of doing this twice, once while holding a global lock and
> once without, I am opting to defer the initialization to the one outside of
> the lock. This allows us to avoid serializing the overhead for memory init
> and we can instead focus on per-node init times.
>
> One issue I encountered is that devm_memremap_pages and
> hmm_devmmem_pages_create were initializing only the pgmap field the same
> way. One wasn't initializing hmm_data, and the other was initializing it to
> a poison value. Since this is something that is exposed to the driver in
> the case of hmm I am opting for a third option and just initializing
> hmm_data to 0 since this is going to be exposed to unknown third party
> drivers.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  include/linux/mm.h |    2 +
>  kernel/memremap.c  |   24 +++++---------
>  mm/hmm.c           |   12 ++++---
>  mm/page_alloc.c    |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++-

Hmm, why mm/page_alloc.c and not kernel/memremap.c for this new
helper? I think that would address the kbuild reports and keeps all
the devm_memremap_pages / ZONE_DEVICE special casing centralized. I
also think it makes sense to move memremap.c to mm/ rather than
kernel/ especially since commit 5981690ddb8f "memremap: split
devm_memremap_pages() and memremap() infrastructure". Arguably, that
commit should have went ahead with the directory move.
