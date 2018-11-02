Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E818C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B230520831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSxLy/jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B230520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbeKCFlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:41:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35833 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeKCFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:41:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id z2-v6so1535972pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uilUDw7zITC+QIAjPiZ00R/+2wRcQiP/3dTjKHWyZq8=;
        b=RSxLy/jN+rF0ZverNLQt5eBN27yJ11YRZkItJU6TLsrw3rhK5pmCmZvMNufDqNwO+h
         CTH4JyaHK3yXTPArl98WeL8Dx5jzn0VkapwMBXYurZucOLA0L5jE5ZD0wjOlER4wmVGX
         290gRWfi2HmHudKhAsDeOaS/pNXRR0/EE2ySK+TRDWZDVZLFYkq5xTSJBZM7zMI9Dtcs
         NwuJQbDzjgTDh1WP1ECO/xq81b+CREypTBsaFlMBe2Qg4M+e2FE2R5JW9Qua0B8MeUqS
         GbQ+yGraJ8vp8WA5QbJtjmcVKvZ9GnZ+rOhaHXW1idLnKN2zz2jT4X36iZKU/RNvN5cZ
         pyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uilUDw7zITC+QIAjPiZ00R/+2wRcQiP/3dTjKHWyZq8=;
        b=HwwjeiiPYiVFbC2qefoXNuFuHXqvxlKw6uRxOGWtmbOVyo/kOAj/JLp+apdIlP/ZXq
         OX02z1x+3kkxjl4pdmTxM3beELnKYADGeDBjy2s3PbJ5OaJ6FmP+hYtB2Ztg+SDINMLz
         /afrx9ZYlXQbM8h+kUi4XOYqMZavZoNScsPmqexeCQhmbGc9OO/wTEOUwod3zRRrfyPw
         vslvFOpt7xxW2SPFuPS6pTXP+e7cItOq4PcwDzXnbsb1zoAoNxK7H6sGeMM/T7tP8g5A
         9PC210OeP50IiK5hN3oSfcqJRzl2U6EoVBYvJNZmV5cSMpJtkXsBqwk4aRCwH9hnQ6p0
         tjKA==
X-Gm-Message-State: AGRZ1gKDN5qFur/6p9zepExZigxBzq7uBwjD0Qea7FasP6I5E+ohgssU
        udMRcU37OIPN1WCDt5eYWZIa+g==
X-Google-Smtp-Source: AJdET5fsFP/yiJrTf7ebPPgymJzVuMgbvz4nIsIundsCkcSMM0sLTYzEwCdBoBTGGY+/CI3PUWHjKg==
X-Received: by 2002:a63:955a:: with SMTP id t26mr12245285pgn.449.1541190788632;
        Fri, 02 Nov 2018 13:33:08 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id j187-v6sm45751187pfc.39.2018.11.02.13.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 13:33:08 -0700 (PDT)
Date:   Fri, 2 Nov 2018 16:32:54 -0400
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
Message-ID: <20181102163254.04be68b5@gnomeregan.cam.corp.google.com>
In-Reply-To: <71d52e0f-ec40-d423-4dd4-e3aeb3730166@redhat.com>
References: <20181029210716.212159-1-brho@google.com>
        <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
        <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
        <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
        <20181030154524.181b8236@gnomeregan.cam.corp.google.com>
        <71d52e0f-ec40-d423-4dd4-e3aeb3730166@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-31 at 09:49 Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 2018-10-29 at 20:10 Dan Williams <dan.j.williams@intel.com> wrote:  
> >> The property of DAX pages that requires special coordination is the
> >> fact that the device hosting the pages can be disabled at will. The
> >> get_dev_pagemap() api is the interface to pin a device-pfn so that you
> >> can safely perform a pfn_to_page() operation.
> >>
> >> Have the pages that kvm uses in this path already been pinned by vfio?  
> 
> No, VFIO is not involved here.
> 
> The pages that KVM uses are never pinned.  Soon after we grab them and
> we build KVM's page table, we do put_page in mmu_set_spte (via
> kvm_release_pfn_clean).  From that point on the MMU notifier will take
> care of invalidating SPT before the page disappears from the mm's page
> table.

I looked into this a little, and I think it's safe in terms of DAX's
get_dev_pagemap() refcounts to have kvm_is_reserved_pfn() treat
DAX pages as not reserved.  kvm_is_reserved_pfn() is used before a
pfn_to_page() call, so the concern was that the pages didn't have a DAX
refcount.

Many of the times that KVM looks at the PFN, it's holding the KVM
mmu_lock, which keeps the pages in the host-side VMA. (IIUC).
Functions like kvm_set_pfn_dirty() fall into this category.

The other times, such as the vmexit path I mentioned before, go through
a gfn_to_pfn call.  Under the hood, those call one of the
get_user_pages() functions during hva_to_pfn, and those do the
right thing w.r.t. get_dev_pagemap().

One of the other things I noticed was some places in KVM make a
distinction between kvm_is_reserved_pfn and PageReserved:

void kvm_set_pfn_dirty(kvm_pfn_t pfn)
{
        if (!kvm_is_reserved_pfn(pfn)) {
                struct page *page = pfn_to_page(pfn);

                if (!PageReserved(page))
                        SetPageDirty(page);
        }
}

I think we want to SetPageDirty for DAX, so making PageReserved be true
for DAX seems like the way to go, or we'll need more KVM-specific
changes.  Apologies is this was discussed in the previous thread on this
topic and is redundant.

Thanks,

Barret

