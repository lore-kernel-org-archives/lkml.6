Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1AFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5787B20846
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5787B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeH1L6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:58:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:32849 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbeH1L6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:58:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 01:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="85537435"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.39])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2018 01:08:15 -0700
Date:   Tue, 28 Aug 2018 11:08:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 04/13] x86/sgx: Architectural structures
Message-ID: <20180828080814.GE15508@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-5-jarkko.sakkinen@linux.intel.com>
 <3e8cf7d4-0d84-9526-816a-a2da30d81de7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8cf7d4-0d84-9526-816a-a2da30d81de7@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:41:29PM -0700, Dave Hansen wrote:
> > +/**
> > + * enum sgx_encls_leaves - return codes for ENCLS, ENCLU and ENCLV
> > + * %SGX_SUCCESS:		No error.
> > + * %SGX_INVALID_SIG_STRUCT:	SIGSTRUCT contains an invalid value.
> > + * %SGX_INVALID_ATTRIBUTE:	Enclave is not attempting to access a resource
> > + *				for which it is not authorized.
> > + * %SGX_BLKSTATE:		EPC page is already blocked.
> > + * %SGX_INVALID_MEASUREMENT:	SIGSTRUCT or EINITTOKEN contains an incorrect
> > + *				measurement.
> ...
> > +enum sgx_return_codes {
> > +	SGX_SUCCESS			= 0,
> > +	SGX_INVALID_SIG_STRUCT		= 1,
> > +	SGX_INVALID_ATTRIBUTE		= 2,
> > +	SGX_BLKSTATE			= 3,
> > +	SGX_INVALID_MEASUREMENT		= 4,
> ...
> 
> I don't think I've ever seen this particular method of commenting
> before.  It's rather verbose and duplicates the names twice, which seems
> a bit silly.
> 
> Can you talk a bit about why you chose to do it this way?  I'd
> personally much rather see at least some brief comments inline with the
> definitions.

The reason that I chose this was

  https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

It is recommended in the "kernel-doc for structs, unions, enums, and
typedefs" section.

/Jarkko
