Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B000ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D8A20878
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JIuVOYgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D8A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbeGWLF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:05:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34593 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeGWLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:05:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so30810plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zk9Pme2iV/NriyqwcPPpH9br25cbVvY0c5t6UwQGT9M=;
        b=JIuVOYgSrYSNTq/tlMyHCavAAsOCtofyXSnvmkGvrwr+lGRD/zWxJqQigOy5uBGl5U
         XrDEA4M6kqQmJL/hyfFgMvcO3pt8e0t1K4/8klNJqF6zgwnW3aPiGNkm4c+6RpOjK+Z6
         7zOf/DcLBvbUoY5gu9p0xF5EvzO5XQbuU5ccBxAFC+PWz1Rf64Wd65PXO8wMPJS3nI2n
         KLvL3ZJ7rNG/fF2F6qdYiBhhkDJF1aSeyW2EyzjwUpyNMuFJGIk6Lvyk/xpCKDOu+r26
         pFraK58UlY9Zx5g2WIJJPmzcFYXzqcARYVwkY1c3gqbVRHX0QmrmAI8FHHociCPDStAe
         VgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zk9Pme2iV/NriyqwcPPpH9br25cbVvY0c5t6UwQGT9M=;
        b=gaKxRsD2KZHmAOUUZoM5jrq83UlgpoNEtlwxdO1IUQnfvF0jQcDU4NubmPuGy6Y0pk
         AVWJ1wVm+pcRQkKwJ57yDF5sr5VhlCvE0rX5Objl/slDRyfOKmWVi1K5hbmw86VVPXvP
         xmm/nKJckCZdyjmY5yg+EfyzYP13TxmsgxoHRQdlDpsii/SvZF7IHZNQwc+5Z5udxcyj
         6uCfZzs8nvhfSrsoAdlCf0IERoT/QDpOZeeezkjnS3WGezlkPS6cDUOpjht3hLTOz4kD
         O6njYSct5MXWDPAgbMOUnlSKVdZohNrSySysShv4pEK03CUGKWwkQ6qOx6aHNpGjx7Gf
         MnNQ==
X-Gm-Message-State: AOUpUlFS6i1n8N0cHAoNfXOzqtRmfnNjcmqk2id88pbpkSkOABrUv9TL
        O/GTCGEIfO1esZ1x2z7K/HtcSA==
X-Google-Smtp-Source: AAOMgpcO+BD6ln6QuDha+IVzOc0HQ2t7KK1C5Bw4g90hJl8M32Ekkzw8GJVQcJeV7Wb/PotSk0JXYg==
X-Received: by 2002:a17:902:59da:: with SMTP id d26-v6mr12253978plj.42.1532340303107;
        Mon, 23 Jul 2018 03:05:03 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id z8-v6sm12356273pfe.163.2018.07.23.03.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 03:05:02 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A44A7303A0F; Mon, 23 Jul 2018 13:04:58 +0300 (+03)
Date:   Mon, 23 Jul 2018 13:04:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 17/19] x86/mm: Implement sync_direct_mapping()
Message-ID: <20180723100458.3oifgqyfavb6c45j@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-18-kirill.shutemov@linux.intel.com>
 <4a99e079-7bd0-a611-571a-d730815b4b2a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a99e079-7bd0-a611-571a-d730815b4b2a@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:01:37PM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> >  arch/x86/include/asm/mktme.h |   8 +
> >  arch/x86/mm/init_64.c        |  10 +
> >  arch/x86/mm/mktme.c          | 437 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 455 insertions(+)
> 
> I'm not the maintainer.  But, NAK from me on this on the diffstat alone.
> 
> There is simply too much technical debt here.  There is no way this code
> is not riddled with bugs and I would bet lots of beer on the fact that
> this has received little to know testing with all the combinations that
> matter, like memory hotplug.  I'd love to be proven wrong, so I eagerly
> await to be dazzled with the test results that have so far escaped
> mention in the changelog.
> 
> Please make an effort to refactor this to reuse the code that we already
> have to manage the direct mapping.  We can't afford 455 new lines of
> page table manipulation that nobody tests or runs.

I'll look in this once again. But I'm not sure that there's any better
solution.

The problem boils down to page allocation issue. We are not be able to
allocate enough page tables in early boot for all direct mappings. At that
stage we have very limited pool of pages that can be used for page tables.
The pool is allocated at compile-time and it's not enough to handle MKTME.

Syncing approach appeared to be the simplest to me.

Other possibility I see is to write down a journal of operations on direct
mappings to be replayed once we have proper page allocator around.

> How _was_ this tested?

Besides normal boot with MTKME enabled and access pages via new direct
mappings, I also test memory hotplug and hotremove with QEMU.

Ideally we wound need some self-test for this. But I don't see a way to
simulate hotplug and hotremove. Soft offlining doesn't cut it. We
actually need to see the ACPI event to trigger the code.

-- 
 Kirill A. Shutemov
