Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B44C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC38E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC38E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756582AbeFOUzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:55:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:27375 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756499AbeFOUzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:55:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 13:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="63591427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2018 13:55:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 37DDB166; Fri, 15 Jun 2018 23:55:36 +0300 (EEST)
Date:   Fri, 15 Jun 2018 23:55:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 07/17] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
Message-ID: <20180615205535.32nhgqelbyjihzts@black.fi.intel.com>
References: <20180612143915.68065-8-kirill.shutemov@linux.intel.com>
 <8c31f6d2-6512-2726-763e-6dd1cbb0350a@intel.com>
 <20180615125720.r755xaegvfcqfr6x@black.fi.intel.com>
 <645a4ca8-ae77-dcdd-0cbc-0da467fc210d@intel.com>
 <20180615152731.3y6rre7g66rmncxr@black.fi.intel.com>
 <cbca7e78-d70b-3eae-1c73-6ad859661b8a@intel.com>
 <20180615160613.arntdivl5gdpfwfw@black.fi.intel.com>
 <445af5b3-eaca-0589-8899-88a3b26fb509@intel.com>
 <20180615204512.axt2avr4ysc2iyrp@black.fi.intel.com>
 <c9645eb2-2223-b374-1e30-2c5566ff73c6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9645eb2-2223-b374-1e30-2c5566ff73c6@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 08:45:21PM +0000, Dave Hansen wrote:
> On 06/15/2018 01:45 PM, Kirill A. Shutemov wrote:
> > On Fri, Jun 15, 2018 at 04:58:24PM +0000, Dave Hansen wrote:
> >> On 06/15/2018 09:06 AM, Kirill A. Shutemov wrote:
> >>> I have no idea what such concept should be called. I cannot come with
> >>> anything better than PTE_PFN_MASK_MAX. Do you?
> >> PTE_PRESERVE_MASK
> >>
> >> Or maybe:
> >>
> >> PTE_MODIFY_PRESERVE_MASK
> > It just replacing one confusion with another. Preserve what?
> 
> "Preserve this mask when modifying pte permission bits"

We preserve more than these bits. See _PAGE_CHG_MASK.

-- 
 Kirill A. Shutemov
