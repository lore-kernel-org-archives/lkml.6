Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F004C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12347214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="T8AAiho0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12347214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeIUDE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:04:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43908 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeIUDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:04:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id u20-v6so10902598otk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lMYQS/qi+HHShmzABXTpmfRGQIwmCaseRFkqZ9D2xQk=;
        b=T8AAiho0sAqdOg755anuBXiepu2QJgTdktY+O3wx5dMCJQFqC0kGpoRWIf06sc+Aet
         3V3LNWJMolZTB0nZNPRz6sw2Q0gRx77bVchDq/Qzc5/Xie2Y2Kf/tw8d2P3/Bg4xxxoS
         qhuX/ZEoErMg42LJ2q4S9zM1y+1Yk3Xx9pICIFLqjCxiqQtCEZcI6JJxnIQWud6AbW+k
         ImKGmgWD2s+GsjmH2Sxec/VP6Nq8x/Ktse6Dxrr/krmOHqixX40VG8lt0TTSh+d2vYxL
         Vv14lJy5QjZzSoog0wjOtRdLlOjIYhm3kINMMthS6JEM56IezFNa449L8cBQy9++qB7M
         aIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lMYQS/qi+HHShmzABXTpmfRGQIwmCaseRFkqZ9D2xQk=;
        b=ELfJAboz6HoKAn2L92so5Qxzubr5B9xah+5de7pI1EexL5ErcYPrdWRX75EbT6wyzF
         gbzXtTiR+X2Zn4QKFtDACajEa8vWWOKrZxycreWCn06aBUJfBPZwaXxAU+CM15jJ97iQ
         Vi67TxeKTuRMQxoc0oGqFJuCMs3SA9ZjN1UHVFprSuHBEzOmNiKuaV/UB6fV3/fUg9hz
         MvXRklyRQMkSs4lCLxYGeMZqRRkliEFBkCFTs0r7U3Ky/PtXve4o0+xl7NBm+mLet+re
         MU5Q2jEXQU6CMIgWwSxwOAdJAzD/8AifaY3Tc5a0WqPEWvEy3wPV4A0AfkSV07FpjdME
         TVow==
X-Gm-Message-State: APzg51AIdhSTMxtQDkDsJwSX+t2TE+wU1vWRYz4OJlLRfFJqKubEYdns
        WXU8WwaPD/91KJ21O78WIyhsrtGFBeWEPpaQ2k9qCQ==
X-Google-Smtp-Source: ANB0VdZf9gigw6s7PrJcTLeuBPbT+A5vvNC+u50fw0tTSRGuekp3fAyAHrc05UpBXBlZE8O2L3MkNHLTt8tqv3PbFwQ=
X-Received: by 2002:a9d:50ac:: with SMTP id b44-v6mr24291921oth.267.1537478368117;
 Thu, 20 Sep 2018 14:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
 <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
 <CAPcyv4ifg2BZMTNfu6mg0xxtPWs3BVgkfEj51v1CQ6jp2S70fw@mail.gmail.com>
 <fefbd66e-623d-b6a5-7202-5309dd4f5b32@redhat.com> <20180920224953.GA53363@tiger-server>
In-Reply-To: <20180920224953.GA53363@tiger-server>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Sep 2018 14:19:17 -0700
Message-ID: <CAPcyv4g6OS=_uSjJenn5WVmpx7zCRCbzJaBr_m0Bq=qyEyVagg@mail.gmail.com>
Subject: Re: [PATCH V5 4/4] kvm: add a check if pfn is from NVDIMM pmem.
To:     David Hildenbrand <david@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 7:11 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
>
> On 2018-09-19 at 09:20:25 +0200, David Hildenbrand wrote:
> > Am 19.09.18 um 04:53 schrieb Dan Williams:
> > >
> > > Should we consider just not setting PageReserved for
> > > devm_memremap_pages()? Perhaps kvm is not be the only component making
> > > these assumptions about this flag?
> >
> > I was asking the exact same question in v3 or so.
> >
> > I was recently going through all PageReserved users, trying to clean up
> > and document how it is used.
> >
> > PG_reserved used to be a marker "not available for the page allocator".
> > This is only partially true and not really helpful I think. My current
> > understanding:
> >
> > "
> > PG_reserved is set for special pages, struct pages of such pages should
> > in general not be touched except by their owner. Pages marked as
> > reserved include:
> > - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
> > - Pages allocated early during boot (bootmem, memblock)
> > - Zero pages
> > - Pages that have been associated with a zone but were not onlined
> >   (e.g. NVDIMM/pmem, online_page_callback used by XEN)
> > - Pages to exclude from the hibernation image (e.g. loaded kexec images)
> > - MCA (memory error) pages on ia64
> > - Offline pages
> > Some architectures don't allow to ioremap RAM pages that are not marked
> > as reserved. Allocated pages might have to be set reserved to allow for
> > that - if there is a good reason to enforce this. Consequently,
> > PG_reserved part of a user space table might be the indicator for the
> > zero page, pmem or MMIO pages.
> > "
> >
> > Swapping code does not care about PageReserved at all as far as I
> > remember. This seems to be fine as it only looks at the way pages have
> > been mapped into user space.
> >
> > I don't really see a good reason to set pmem pages as reserved. One
> > question would be, how/if to exclude them from the hibernation image.
> > But that could also be solved differently (we would have to double check
> > how they are handled in hibernation code).
> >
> >
> > A similar user of PageReserved to look at is:
> >
> > drivers/vfio/vfio_iommu_type1.c:is_invalid_reserved_pfn()
> >
> > It will not mark pages dirty if they are reserved. Similar to KVM code.
> Yes, kvm is not the only one user of the dax reserved page.
> >
> > >
> > > Why is MEMORY_DEVICE_PUBLIC memory specifically excluded?
> > >
> > > This has less to do with "dax" pages and more to do with
> > > devm_memremap_pages() established ranges. P2PDMA is another producer
> > > of these pages. If either MEMORY_DEVICE_PUBLIC or P2PDMA pages can be
> > > used in these kvm paths then I think this points to consider clearing
> > > the Reserved flag.
>
> Thanks Dan/David's comments.
> for MEMORY_DEVICE_PUBLIC memory, since host driver could manager the
> memory resource to share to guest, Jerome says we could ignore it at
> this time.
>
> And p2pmem, it seems mapped in a PCI bar space which should most likely
> a mmio. I think kvm should treated as a reserved page.

Ok, but the question you left unanswered is whether it would be better
for devm_memremap_pages() to clear the PageReserved flag for
MEMORY_DEVICE_{FS,DEV}_DAX rather than introduce a local kvm-only hack
for what looks like a global problem.
