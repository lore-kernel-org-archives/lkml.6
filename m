Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D0C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E2F204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E2F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeJ3CvK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:51:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:28052 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeJ3CvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:51:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 11:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="99735193"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2018 11:01:28 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0415.000;
 Mon, 29 Oct 2018 11:01:28 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Topic: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Index: AQHUbXSDlG5yxQFZuUKIGr9tlrL5CKU27+KAgAACRID//5GH4A==
Date:   Mon, 29 Oct 2018 18:01:27 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485E5549@ORSMSX114.amr.corp.intel.com>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
 <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1810291809490.5984@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810291820250.5984@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810291820250.5984@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzU5ZWQ3ZWMtODczMC00YWRiLWE0ZjYtM2JmODU0NGY0ZGY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaG1DRW9NRDRNQzQ3UnhyY2gyYk1uTmh6QU9SZUY3dXNIeFJrbTFHOFwvWXdHU2FpbmZ3RjViNXZGQjVXWFRGUTEifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Peter,

[off the mailing list because I wasn't sure if it's a good idea to spam others with my questions]

> > > +	/*
> > > +	 * The typical sequence for unmapping is to find a pte through
> > > +	 * lookup_address_in_pgd() (ideally, it should never return NULL
> because
> > > +	 * the address is already mapped) and change it's protections.
> > > +	 * As pfn is the *target* of a mapping, it's not useful while unmapping.
> > > +	 */
> > > +	struct cpa_data cpa = {
> > > +		.vaddr		= &address,
> > > +		.pgd		= pgd,
> > > +		.numpages	= numpages,
> > > +		.mask_set	= __pgprot(0),
> > > +		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
> > > +		.flags		= 0,
> > > +	};
> > > +
> > > +	retval = __change_page_attr_set_clr(&cpa, 0);
> > > +	__flush_tlb_all();
> >
> > So this looks like you copied it from kernel_map_pages_in_pgd() which
> > has been discussed before to be not sufficient, but it can't be
> > changed right now due to locking issues.
>
> Managed to confuse myself. The place which cannot be changed is a different
> one, but still for your call site __flush_tlb_all() might not be sufficient.

Since the mappings are changed, I thought a flush_tlb() might be needed.
But, (to be honest), I don't completely understand the x86/mm code. So, could you 
please elaborate the issue more for my better understanding?

So some questions I have are,
1. What did Peter Z mean here? "How is that not a TLB invalidation bug ?"
2. I assumed kernel_map_pages_in_pgd() to be a good code but you said that 
it has some locking issues. So, could you please elaborate more on that.

Or, could you please provide me some pointers in the source code that I can take a look at so that I could understand the issue much better.

Regards,
Sai
