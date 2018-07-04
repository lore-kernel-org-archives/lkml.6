Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A014C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53707208B7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53707208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGDSHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:07:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:13155 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752251AbeGDSHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:07:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 11:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,308,1526367600"; 
   d="scan'208";a="68699823"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2018 11:07:03 -0700
Date:   Wed, 4 Jul 2018 21:07:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/13] x86/sgx: architectural structures
Message-ID: <20180704180702.GM6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032056460.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807032056460.1816@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:04:01PM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> > This commit adds arch/x86/include/asm/sgx_arch.h that contains definitions
> 
> This is not a commit. Simply: Add .....
> 
> > for data structures used by the SGX.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Co-developed-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> Documentaiton:
> 
>   A Co-Developed-by: states that the patch was also created by another developer
>   along with the original author.  This is useful at times when multiple people
>   work on a single patch.  Note, this person also needs to have a Signed-off-by:
>   line in the patch as well.
> 
> Please fix all over the place.

I used this tag for the first time and thought that it was undocumented
because checkpatch.pl complained about it. I will fix this.

> > +#define SGX_MISC_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
> 
> L ? ULL I'd say...

Yes, should be ULL.

> > +#define SGX_ATTR_RESERVED_MASK 0xFFFFFFFFFFFFFFC9L
> 
> Ditto
> 
> > +#define SGX_SECS_RESERVED1_SIZE 24
> > +#define SGX_SECS_RESERVED2_SIZE 32
> > +#define SGX_SECS_RESERVED3_SIZE 96
> > +#define SGX_SECS_RESERVED4_SIZE 3836
> > +
> > +struct sgx_secs {
> > +	uint64_t size;
> > +	uint64_t base;
> > +	uint32_t ssaframesize;
> > +	uint32_t miscselect;
> > +	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
> > +	uint64_t attributes;
> 
> Please make these tabular aligned for readility sake

Ok, so it is now +2 for this. I can do that if you really want that.

> > +	uint32_t	miscselect;
> > +	uint8_t		reserved1[SGX_SECS_RESERVED1_SIZE];
> > +	uint64_t	attributes;
> 
> Hmm? All over the place...
> 
> > +enum sgx_tcs_flags {
> > +	SGX_TCS_DBGOPTIN	= 0x01, /* cleared on EADD */
> 
> Please do not use tail comments. Either put the comment above the define or
> use kernel doc.
> 
> > +};
> > +
> > +#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
> 
> See above.
> 
> > +#define SGX_SECINFO_PERMISSION_MASK	0x0000000000000007L
> > +#define SGX_SECINFO_PAGE_TYPE_MASK	0x000000000000FF00L
> > +#define SGX_SECINFO_RESERVED_MASK	0xFFFFFFFFFFFF00F8L
> 
> Ditto
> 
> Thanks,
> 
> 	tglx

Thank you.

/Jarkko
