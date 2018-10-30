Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E57C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1620824
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D1W9Nubz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A1620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJ3MCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:02:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35663 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJ3MCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:02:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id 14so9761800oth.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 20:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOXSHA8/PfVCGuU345coRR2PoLkyRREFhJjY3zVEPp8=;
        b=D1W9NubzjpWo4uA4CzR0yvTVSwgh9e3L5YfCJ2LWaZ94FLGTpWDMmmyQ+MM1gjtDpi
         vGFG82oE0vOGif5jycUsC9f4EefjgpMlUZL3Cu2OOdyqzbom/i9uWn3Tm0J8QjUbfRQJ
         7Xu4BX10C1uJMZ8vzTsaVYN+oT5IPdULdacXCc9T/9TNZwkuTbgq8EvxwLCtOBxXbdzC
         vQMMQ4xvYC8P0SVxNKhU0WF971JrlA8s/AGTB7827j2hIicPslWNno136uoU6WdW9qbi
         ThgNrfT3SWSX9JJIVV0iWZoLfW9ubF40NnvPDeq1l/WD4qFKiAbi/w+GUBTNvEF51t70
         SX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOXSHA8/PfVCGuU345coRR2PoLkyRREFhJjY3zVEPp8=;
        b=syiQBx4HYOXSQ7illHu/PT3thbI83+nTUCkaG07QFMiW1qySmR6BkiDyyfEn/+m/U9
         xbN5RFdiHSG1epSOb4Usj1kus/vMChfJz/5kkQbx0RJzxsvcrNLonb/9xN9Q3YtuwDoG
         hrWqxqWbrOko2aYItv5HmwDWBKBNORGeXbTL4JUlb8JBjTkDUudADJCd2uBpN/xeMn0l
         y/ZAX8Hjue5z8xQA2Yb8ZlGMSvhTULUAN4h26uvxWReqAfeLQJU9WYwTIauiSWMyffXt
         Kf7Ji3TEsYZH2D05UWL8fRVPbdSwbiNsZEm/sVRjTV5k+AK/8MtvvknC6N+5rcueNYuo
         USFw==
X-Gm-Message-State: AGRZ1gJlwknjmIePvFvJtfMe3MJLDYWGa20SZi77oJLSACqzJwH6seTZ
        cdY4kEuB95/AqW8OYLBY7mjqO8wQf57mDYW7XjMtCg==
X-Google-Smtp-Source: AJdET5fWpqEPJ4WSXTuWhgvNJypZXibqGvPqR1Y27nH1Al0hJcyiBIG3oOnSCH/OsaS88cEsssqaKilld5HQsqtRjKs=
X-Received: by 2002:a9d:9c4:: with SMTP id 4mr5093910otz.214.1540869063697;
 Mon, 29 Oct 2018 20:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181029210716.212159-1-brho@google.com> <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
 <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
In-Reply-To: <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Oct 2018 20:10:52 -0700
Message-ID: <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
To:     Barret Rhoden <brho@google.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 5:29 PM Barret Rhoden <brho@google.com> wrote:
>
> On 2018-10-29 at 15:25 Dan Williams <dan.j.williams@intel.com> wrote:
> > > +       /*
> > > +        * Our caller grabbed the KVM mmu_lock with a successful
> > > +        * mmu_notifier_retry, so we're safe to walk the page table.
> > > +        */
> > > +       map_sz = pgd_mapping_size(current->mm, hva);
> > > +       switch (map_sz) {
> > > +       case PMD_SIZE:
> > > +               return true;
> > > +       case P4D_SIZE:
> > > +       case PUD_SIZE:
> > > +               printk_once(KERN_INFO "KVM THP promo found a very large page");
> >
> > Why not allow PUD_SIZE? The device-dax interface supports PUD mappings.
>
> The place where I use that helper seemed to care about PMDs (compared
> to huge pages larger than PUDs), I think due to THP.  Though it also
> checks "level == PT_PAGE_TABLE_LEVEL", so it's probably a moot point.
>
> I can change it from pfn_is_pmd_mapped -> pfn_is_huge_mapped and allow
> any huge mapping that is appropriate: so PUD or PMD for DAX, PMD for
> non-DAX, IIUC.

Yes, THP stops at PMDs, but DAX and hugetlbfs support PUD level mappings.

> > > +               return false;
> > > +       }
> > > +       return false;
> > > +}
> >
> > The above 2 functions are  similar to what we need to do for
> > determining the blast radius of a memory error, see
> > dev_pagemap_mapping_shift() and its usage in add_to_kill().
>
> Great.  I don't know if I have access in the KVM code to the VMA to use
> those functions directly, but I can extract the guts of
> dev_pagemap_mapping_shift() or something and put it in mm/util.c.

Sounds good.

> > >  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> > >                                         gfn_t *gfnp, kvm_pfn_t *pfnp,
> > >                                         int *levelp)
> > > @@ -3168,7 +3237,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> > >          */
> > >         if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> > >             level == PT_PAGE_TABLE_LEVEL &&
> > > -           PageTransCompoundMap(pfn_to_page(pfn)) &&
> > > +           pfn_is_pmd_mapped(vcpu->kvm, gfn, pfn) &&
> >
> > I'm wondering if we're adding an explicit is_zone_device_page() check
> > in this path to determine the page mapping size if that can be a
> > replacement for the kvm_is_reserved_pfn() check. In other words, the
> > goal of fixing up PageReserved() was to preclude the need for DAX-page
> > special casing in KVM, but if we already need add some special casing
> > for page size determination, might as well bypass the
> > kvm_is_reserved_pfn() dependency as well.
>
> kvm_is_reserved_pfn() is used in some other places, like
> kvm_set_pfn_dirty()and kvm_set_pfn_accessed().  Maybe the way those
> treat DAX pages matters on a case-by-case basis?
>
> There are other callers of kvm_is_reserved_pfn() such as
> kvm_pfn_to_page() and gfn_to_page().  I'm not familiar (yet) with how
> struct pages and DAX work together, and whether or not the callers of
> those pfn_to_page() functions have expectations about the 'type' of
> struct page they get back.
>

The property of DAX pages that requires special coordination is the
fact that the device hosting the pages can be disabled at will. The
get_dev_pagemap() api is the interface to pin a device-pfn so that you
can safely perform a pfn_to_page() operation.

Have the pages that kvm uses in this path already been pinned by vfio?
