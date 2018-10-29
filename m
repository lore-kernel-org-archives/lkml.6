Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F7DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C522080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C522080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeJ2QN6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:13:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:36886 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbeJ2QN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:13:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 00:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,439,1534834800"; 
   d="scan'208";a="269612290"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2018 00:26:32 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.81]) with mapi id 14.03.0415.000;
 Mon, 29 Oct 2018 00:26:31 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Bhupesh Sharma" <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Topic: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Index: AQHUbXSDlG5yxQFZuUKIGr9tlrL5CKU2Na4A//+f6EA=
Date:   Mon, 29 Oct 2018 07:26:30 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485E101E@ORSMSX114.amr.corp.intel.com>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
 <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
 <20181029060708.GB128403@gmail.com>
In-Reply-To: <20181029060708.GB128403@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWY1MzhiZmUtYTNhZS00NTlkLThlYWMtYzM1ZDljZjI5NGUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic0R3NGFPRW5ZZUNKTDFBcGhaQlk3MWw2UW5BQ09GS1E4K2lOSFpuck9yU0dvekhIYnNFYTBUTHRNdm5PQVp6TSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
> > +			      unsigned long numpages)
> > +{
> > +	int retval;
> > +
> > +	/*
> > +	 * The typical sequence for unmapping is to find a pte through
> > +	 * lookup_address_in_pgd() (ideally, it should never return NULL
> because
> > +	 * the address is already mapped) and change it's protections.
> > +	 * As pfn is the *target* of a mapping, it's not useful while unmapping.
> > +	 */
> > +	struct cpa_data cpa = {
> > +		.vaddr		= &address,
> > +		.pgd		= pgd,
> > +		.numpages	= numpages,
> > +		.mask_set	= __pgprot(0),
> > +		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
> > +		.flags		= 0,
> > +	};
> > +
> > +	retval = __change_page_attr_set_clr(&cpa, 0);
> > +	__flush_tlb_all();
> 
> So, just to clarify, 'pfn' is kept at 0 here? Might make sense to write it out
> explicitly like 'flags', even if it's not used by __change_page_attr_set_clr().

Sure! Makes sense. I will add it.

Regards,
Sai
