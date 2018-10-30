Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB609C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A46320657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgiR0zJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A46320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJaEk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:40:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeJaEkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:40:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so6373895pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPEIClmnutTl/pMLwT6QeVpbYCMVxqZfdu/z0155upY=;
        b=KgiR0zJI7kX5kXWMKVhAFGv5+TMTppld+AYFmmYfMFcyGymZk+SEelroZK+LCKgFI2
         0FvtrNw5Y9yoyP3O3+J0RSwA85PRv/JxNMdHXNtUBmtPhy5sgVjx/FJP8li2khHPvIyj
         TzvscdIiWlTVzAXnWPGuNu4DR56Sl2nXqAqmtUCsk4GQX3F8xeV1Wo1PTr607lPaHzpV
         QS4Hs9Ye/37ynEEid7ZNYc6QpEpHM18yKJiMs4DjXkg1R4jpZd5TpITi4S0lH7O9aTmi
         kxttiqgr6Jiy3Pfv6bPFz5a/8FzfmgwQZ0RN7qVp4wzXGoFHDTuc1gqdLdD1Ty7YtK+7
         ZTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPEIClmnutTl/pMLwT6QeVpbYCMVxqZfdu/z0155upY=;
        b=pWWr/ejIHEf9LU4fkvVYq/hU82HhHT/OOp2R8spUkN/XtjSyqSd5jDmA6F+bH/Aily
         mAxgRUpSmYRwYksHIbsBBwPu0qavOEFEqwaPB/urvuVkjC37GRdNMkj+Lfqyl+TStIFY
         0ZZ6vPapRWtVXwOHYzEZTNjqFhL8FDR3x+XCsXdkvdrz7BSDRew73iIVN4ppdfvAqoy0
         HevLFOoJHHr6XHDTuM1z8LXhPr0bE+R+NRwYt0fhm0d5s++wTHSCPaa0I0oiVOAzbYnE
         2SHIHccfLLPlpQb5BPJKmbm7ZVw/kx5bL1KXoMrU+vNUdOJchH4MPtQJ3+diHzqMEMV5
         lOnw==
X-Gm-Message-State: AGRZ1gL8l82XRvu6yF186axEUb1t0TvjPBxemyGWSS+EQ/q9AYwcmrZx
        3/NlcYyGMTXdlNO5xTArRpGZRg==
X-Google-Smtp-Source: AJdET5f+tFUT1UhiDEuZsywM/vh/+K2zTLA7YeZHBY/hnfxPo8tNsRXe3KT9zkzuxnZezCQOfkYAGQ==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr46024pgb.357.1540928733910;
        Tue, 30 Oct 2018 12:45:33 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id p62-v6sm40548573pfp.111.2018.10.30.12.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:45:33 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:45:24 -0400
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>
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
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
Message-ID: <20181030154524.181b8236@gnomeregan.cam.corp.google.com>
In-Reply-To: <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
References: <20181029210716.212159-1-brho@google.com>
        <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
        <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
        <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-29 at 20:10 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> > > >                                         gfn_t *gfnp, kvm_pfn_t *pfnp,
> > > >                                         int *levelp)
> > > > @@ -3168,7 +3237,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> > > >          */
> > > >         if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> > > >             level == PT_PAGE_TABLE_LEVEL &&
> > > > -           PageTransCompoundMap(pfn_to_page(pfn)) &&
> > > > +           pfn_is_pmd_mapped(vcpu->kvm, gfn, pfn) &&  
> > >
> > > I'm wondering if we're adding an explicit is_zone_device_page() check
> > > in this path to determine the page mapping size if that can be a
> > > replacement for the kvm_is_reserved_pfn() check. In other words, the
> > > goal of fixing up PageReserved() was to preclude the need for DAX-page
> > > special casing in KVM, but if we already need add some special casing
> > > for page size determination, might as well bypass the
> > > kvm_is_reserved_pfn() dependency as well.  
> >
> > kvm_is_reserved_pfn() is used in some other places, like
> > kvm_set_pfn_dirty()and kvm_set_pfn_accessed().  Maybe the way those
> > treat DAX pages matters on a case-by-case basis?
> >
> > There are other callers of kvm_is_reserved_pfn() such as
> > kvm_pfn_to_page() and gfn_to_page().  I'm not familiar (yet) with how
> > struct pages and DAX work together, and whether or not the callers of
> > those pfn_to_page() functions have expectations about the 'type' of
> > struct page they get back.
> >  
> 
> The property of DAX pages that requires special coordination is the
> fact that the device hosting the pages can be disabled at will. The
> get_dev_pagemap() api is the interface to pin a device-pfn so that you
> can safely perform a pfn_to_page() operation.
> 
> Have the pages that kvm uses in this path already been pinned by vfio?

I'm not aware of any explicit pinning, but it might be happening under
the hood.  These pages are just generic guest RAM, but they are present
in a host-side mapping.  I ran into this when looking at EPT fault
handling.  In the code I changed, a physical page was faulted in to the
task's page table, then while the kvm->mmu_lock is held, KVM makes an
EPT mapping to the same physical page.  That mmu_lock seems to prevent
any concurrent host-side unmappings; though I'm not familiar with the mm
notifier stuff.

One usage of kvm_is_reserved_pfn() in KVM code is like this:

static struct page *kvm_pfn_to_page(kvm_pfn_t pfn)
{  
        if (is_error_noslot_pfn(pfn))
                return KVM_ERR_PTR_BAD_PAGE; 
    
        if (kvm_is_reserved_pfn(pfn)) {                      
                WARN_ON(1);
                return KVM_ERR_PTR_BAD_PAGE;                         
        }

        return pfn_to_page(pfn);                                                  
}

I think there's no guarantee the kvm->mmu_lock is held in the generic
case.  Here's one case where it wasn't (from walking through the code):

handle_exception
-handle_ud
--kvm_emulate_instruction
---x86_emulate_instruction
----x86_emulate_insn
-----writeback
------segmented_cmpxchg
-------emulator_cmpxchg_emulated
--------kvm_vcpu_gfn_to_page
---------kvm_pfn_to_page

There are probably other rules related to gfn_to_page that keep the
page alive, maybe just during interrupt/vmexit context?  Whatever keeps
those pages alive for normal memory might grab that devmap reference
under the hood for DAX mappings.

Thanks,
Barret

