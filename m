Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A73DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE307223B6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE307223B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeGEQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:08:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:51997 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbeGEQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:08:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 09:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,313,1526367600"; 
   d="scan'208";a="70333197"
Received: from dmorlich-mobl.amr.corp.intel.com (HELO localhost) ([10.252.36.24])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2018 09:08:15 -0700
Date:   Thu, 5 Jul 2018 19:08:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 03/13] x86/sgx: add SGX definitions to msr-index.h
Message-ID: <20180705160814.GB12818@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-4-jarkko.sakkinen@linux.intel.com>
 <296d6c54-306d-ebec-0a7a-68e06d00e704@intel.com>
 <20180705160549.GA12818@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705160549.GA12818@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:05:49PM +0300, Jarkko Sakkinen wrote:
> On Tue, Jul 03, 2018 at 11:31:59AM -0700, Dave Hansen wrote:
> > On 07/03/2018 11:19 AM, Jarkko Sakkinen wrote:
> > > --- a/arch/x86/include/asm/msr-index.h
> > > +++ b/arch/x86/include/asm/msr-index.h
> > > @@ -479,6 +479,8 @@
> > >  #define FEATURE_CONTROL_LOCKED				(1<<0)
> > >  #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
> > >  #define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
> > > +#define FEATURE_CONTROL_SGX_ENABLE                      (1<<18)
> > > +#define FEATURE_CONTROL_SGX_LE_WR			(1<<17)
> > >  #define FEATURE_CONTROL_LMCE				(1<<20)
> > 
> > Have you run checkpatch.pl on these?  There's a tabs-vs-spaces issue here.
> 
> High portion of lines in this file are over 80 characters and have this
> same incosistent spacing. I'm not sure if this should be fixed bacause
> it would be consistent with the formatting that this file uses...

Ignore! I was looking at the cpufeature patch, this one really has a
formatting issue (apologies).

/Jarkko
