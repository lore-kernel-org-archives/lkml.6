Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEDF2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEDF2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHaPRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:17:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:16718 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeHaPRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:17:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 04:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="84964149"
Received: from ssirohi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.112])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2018 04:10:39 -0700
Date:   Fri, 31 Aug 2018 14:10:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Serge Ayoun <serge.ayoun@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
Message-ID: <20180831111038.GA16827@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
 <4666cae8-c711-8dd5-cbce-3d97cc19a9e5@intel.com>
 <20180828103040.GA21326@linux.intel.com>
 <68d730bc-898c-973f-9506-648fd8a7c610@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d730bc-898c-973f-9506-648fd8a7c610@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:53:11AM -0700, Dave Hansen wrote:
> >>>  extern bool sgx_enabled;
> >>>  extern bool sgx_lc_enabled;
> >>> +extern struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> >>> +
> >>> +/*
> >>> + * enum sgx_epc_page_desc - defines bits and masks for an EPC page's desc
> >>
> >> Why are you bothering packing these bits?  This seems a rather
> >> convoluted way to store two integers.
> > 
> > To keep struct sgx_epc_page 64 bytes.
> 
> It's a list_head and a ulong now.  That doesn't add up to 64.

Ah, there used to be one more variable in it.

> If you properly describe the bounds and limits of banks we can possibly
> help you find a nice solution.  As it stands, they are totally opaque
> and we have no idea what is going on.

Great, I see what I can do. I understand now better what you are looking
for. Thanks Dave.

/Jarkko
