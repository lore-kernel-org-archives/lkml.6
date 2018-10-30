Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F042084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJSjuAR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F042084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeJ3JUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:20:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44090 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3JUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:20:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so1361381pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aIduXejlUYEZ6jIq7652t/NWw9YOqzgn0icORillYY=;
        b=CJSjuAR9PTUDpqyKlilERVn7m9eYzeGNMnvB8Drq7lNEzOGsM0f3FCu2FCvNy+dt3f
         9SQPA2sVP4jCSp2OyUn85wWGhBMk1NXbyhlrWfl5C15Pw9RFUYP/1msykwHba7uISkaO
         oJH6jau73oxRDRTKu+gwYeDvDP4HmVgH8KscSUyPCpLC+x7x2y9h/ifvFzmPmKIoLur3
         +b8d2hk5dxrKthrNQSnJf7AeIuGRVt1WtzO5YW4VONsO1ioGV+9DsfVrvOfEy09g+sIQ
         DBJdCP4tmfjVI0ShSQbRWxvm9wxvo+9RC6T5iZBn3Gi3h5hD69gJLgbetbkNyNpiQsFL
         rv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aIduXejlUYEZ6jIq7652t/NWw9YOqzgn0icORillYY=;
        b=kX13OuKxu4yR2HvlBNGrO5oQHrl+Y2/RJpc7ug9IXFdbSaRBN1np6H8VAb9+sgkXYW
         qWfNAXZ1kfMpcravppRWALFlUsX2ym0OGSPdK6Ge0FUyHdXBq8oSdt9Bd3OICOkoFGap
         d7Vj+6QZDhWpdyZsCoo6H+Xxt8sHrQ2CMLvMiypnuAX345ekam2/9mYY4LhUpEzt+sHP
         WxurIfECRfgllUPvHJZd94W8l4ECdb4lgGNxsUa3vz5/x/fACR5jboWdPS4Os1bonN8a
         FoG6dImJvKDIEZaDeDq6K1JyzhEDc2kD7fcJ/1ClNH/G9JLSzFkhvCIJBt+SVwsSY1Hu
         ODcw==
X-Gm-Message-State: AGRZ1gKKNO3wHxaBkOeW0BnZI4gj5cBWxVyUZQGo3hI7c0eXxAJ3XvgJ
        njH35kQCBiduBoP2R429R1TcSQ==
X-Google-Smtp-Source: AJdET5duuPlGFy0u8kIgYLr70uDafeebKJKhA+lrO08QEFbYRu+gfrOdZuAgNbNXLDkcAc3czGjwuA==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr13586518pgf.240.1540859339827;
        Mon, 29 Oct 2018 17:28:59 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id l2-v6sm21751439pgp.20.2018.10.29.17.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 17:28:59 -0700 (PDT)
Date:   Mon, 29 Oct 2018 20:28:54 -0400
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
Message-ID: <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
In-Reply-To: <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
References: <20181029210716.212159-1-brho@google.com>
        <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-29 at 15:25 Dan Williams <dan.j.williams@intel.com> wrote:
> > +       /*
> > +        * Our caller grabbed the KVM mmu_lock with a successful
> > +        * mmu_notifier_retry, so we're safe to walk the page table.
> > +        */
> > +       map_sz = pgd_mapping_size(current->mm, hva);
> > +       switch (map_sz) {
> > +       case PMD_SIZE:
> > +               return true;
> > +       case P4D_SIZE:
> > +       case PUD_SIZE:
> > +               printk_once(KERN_INFO "KVM THP promo found a very large page");  
> 
> Why not allow PUD_SIZE? The device-dax interface supports PUD mappings.

The place where I use that helper seemed to care about PMDs (compared
to huge pages larger than PUDs), I think due to THP.  Though it also
checks "level == PT_PAGE_TABLE_LEVEL", so it's probably a moot point.

I can change it from pfn_is_pmd_mapped -> pfn_is_huge_mapped and allow
any huge mapping that is appropriate: so PUD or PMD for DAX, PMD for
non-DAX, IIUC.

> 
> > +               return false;
> > +       }
> > +       return false;
> > +}  
> 
> The above 2 functions are  similar to what we need to do for
> determining the blast radius of a memory error, see
> dev_pagemap_mapping_shift() and its usage in add_to_kill().

Great.  I don't know if I have access in the KVM code to the VMA to use
those functions directly, but I can extract the guts of
dev_pagemap_mapping_shift() or something and put it in mm/util.c.

> >  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> >                                         gfn_t *gfnp, kvm_pfn_t *pfnp,
> >                                         int *levelp)
> > @@ -3168,7 +3237,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> >          */
> >         if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> >             level == PT_PAGE_TABLE_LEVEL &&
> > -           PageTransCompoundMap(pfn_to_page(pfn)) &&
> > +           pfn_is_pmd_mapped(vcpu->kvm, gfn, pfn) &&  
> 
> I'm wondering if we're adding an explicit is_zone_device_page() check
> in this path to determine the page mapping size if that can be a
> replacement for the kvm_is_reserved_pfn() check. In other words, the
> goal of fixing up PageReserved() was to preclude the need for DAX-page
> special casing in KVM, but if we already need add some special casing
> for page size determination, might as well bypass the
> kvm_is_reserved_pfn() dependency as well.

kvm_is_reserved_pfn() is used in some other places, like
kvm_set_pfn_dirty()and kvm_set_pfn_accessed().  Maybe the way those
treat DAX pages matters on a case-by-case basis?  

There are other callers of kvm_is_reserved_pfn() such as
kvm_pfn_to_page() and gfn_to_page().  I'm not familiar (yet) with how
struct pages and DAX work together, and whether or not the callers of
those pfn_to_page() functions have expectations about the 'type' of
struct page they get back.

It looks like another time that this popped up was kvm_is_mmio_pfn(),
though that wasn't exactly checking kvm_is_reserved_pfn(), and it
special cased based on the memory type / PAT business.

Thanks,

Barret

