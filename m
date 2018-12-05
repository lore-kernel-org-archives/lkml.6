Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6DC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0555020879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJsAb1tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0555020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeLEOfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:35:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SUQMdlnKRthCQ62qwHJk8Au9gymYOBsjGwwtw0vjVRU=; b=DJsAb1tT+GGnSKi4lr4stzTll
        YMfX5dARm9m9yhE99EbWBifMg0ZC5K639PtD3ZFdNP8J9/iTONHMcuTHHyTzF9gwjki30w51j+LQ0
        je6Bl6Vd+BMgxzenDq4ku2e1UumyLw5pCOjXmKb3EUYOFKidEpkW4htHkdYodq+n5kLb0FDgcDzyZ
        yrcOmaUlu0Mae3UBRiihJQCsd9Fo3YrOuth/bR+jZweoSDgc8kCBIObBuQ54Qeyiu0TpWN5Yr0Ktf
        YjyB2HDAYvg3pp+NHYydCwPQi7KZ1GhpiTTpklp0AQkI/YGFSFooqN07BRXTlHt/8VfClcnzaJwuj
        Ihjp8NmCw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUYGc-0003YG-8t; Wed, 05 Dec 2018 14:35:10 +0000
Date:   Wed, 5 Dec 2018 06:35:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Miles Chen <miles.chen@mediatek.com>,
        yi.z.zhang@linux.intel.com, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 7/7] mm: better document PG_reserved
Message-ID: <20181205143510.GA17232@bombadil.infradead.org>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205122851.5891-8-david@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:28:51PM +0100, David Hildenbrand wrote:
> I don't see a reason why we have to document "Some of them might not even
> exist". If there is a user, we should document it. E.g. for balloon
> drivers we now use PG_offline to indicate that a page might currently
> not be backed by memory in the hypervisor. And that is independent from
> PG_reserved.

I think you're confused by the meaning of "some of them might not even
exist".  What this means is that there might not be memory there; maybe
writes to that memory will be discarded, or maybe they'll cause a machine
check.  Maybe reads will return ~0, or 0, or cause a machine check.
We just don't know what's there, and we shouldn't try touching the memory.

> +++ b/include/linux/page-flags.h
> @@ -17,8 +17,22 @@
>  /*
>   * Various page->flags bits:
>   *
> - * PG_reserved is set for special pages, which can never be swapped out. Some
> - * of them might not even exist...
> + * PG_reserved is set for special pages. The "struct page" of such a page
> + * should in general not be touched (e.g. set dirty) except by their owner.
> + * Pages marked as PG_reserved include:
> + * - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
> + * - Pages allocated early during boot (bootmem, memblock)
> + * - Zero pages
> + * - Pages that have been associated with a zone but are not available for
> + *   the page allocator (e.g. excluded via online_page_callback())
> + * - Pages to exclude from the hibernation image (e.g. loaded kexec images)
> + * - MMIO pages (communicate with a device, special caching strategy needed)
> + * - MCA pages on ia64 (pages with memory errors)
> + * - Device memory (e.g. PMEM, DAX, HMM)
> + * Some architectures don't allow to ioremap pages that are not marked
> + * PG_reserved (as they might be in use by somebody else who does not respect
> + * the caching strategy). Consequently, PG_reserved for a page mapped into
> + * user space can indicate the zero page, the vDSO, MMIO pages or device memory.

So maybe just add one more option to the list.
