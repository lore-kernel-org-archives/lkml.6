Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D9C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FFD25885
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FFD25885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966238AbeF0V5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:57:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:22697 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965460AbeF0V5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:57:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 14:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,280,1526367600"; 
   d="scan'208";a="51053395"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2018 14:57:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 535DBCB; Thu, 28 Jun 2018 00:57:26 +0300 (EEST)
Date:   Thu, 28 Jun 2018 00:57:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 18/18] x86: Introduce CONFIG_X86_INTEL_MKTME
Message-ID: <20180627215726.l5syzdcc26hgihtt@black.fi.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-19-kirill.shutemov@linux.intel.com>
 <ecf92475-93b4-295c-f1fc-7efba4843d98@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf92475-93b4-295c-f1fc-7efba4843d98@infradead.org>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:30:12PM +0000, Randy Dunlap wrote:
> On 06/26/2018 07:22 AM, Kirill A. Shutemov wrote:
> > Add new config option to enabled/disable Multi-Key Total Memory
> > Encryption support.
> > 
> > MKTME uses MEMORY_PHYSICAL_PADDING to reserve enough space in per-KeyID
> > direct mappings for memory hotplug.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/Kconfig | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index fa5e1ec09247..9a843bd63108 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1523,6 +1523,23 @@ config ARCH_USE_MEMREMAP_PROT
> >  	def_bool y
> >  	depends on AMD_MEM_ENCRYPT
> >  
> > +config X86_INTEL_MKTME
> > +	bool "Intel Multi-Key Total Memory Encryption"
> > +	select DYNAMIC_PHYSICAL_MASK
> > +	select PAGE_EXTENSION
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	---help---
> > +	  Say yes to enable support for Multi-Key Total Memory Encryption.
> > +	  This requires an Intel processor that has support of the feature.
> > +
> > +	  Multikey Total Memory Encryption (MKTME) is a technology that allows
> > +	  transparent memory encryption in and upcoming Intel platforms.
> 
> huh?  Maybe drop the "and"?

Ugh.. It has to be "an".

-- 
 Kirill A. Shutemov
