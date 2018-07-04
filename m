Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D41C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691D6242EB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691D6242EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDSJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:09:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:20993 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbeGDSJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:09:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 11:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,308,1526367600"; 
   d="scan'208";a="68700229"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2018 11:09:15 -0700
Date:   Wed, 4 Jul 2018 21:09:13 +0300
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
Subject: Re: [PATCH v12 05/13] x86/sgx: architectural structures
Message-ID: <20180704180913.GN6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com>
 <5790d6a4-7d30-1ed8-0214-f68f1cb72294@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5790d6a4-7d30-1ed8-0214-f68f1cb72294@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:22:52PM -0700, Dave Hansen wrote:
> On 07/03/2018 11:19 AM, Jarkko Sakkinen wrote:
> > +enum sgx_cpuid {
> > +	SGX_CPUID_CAPABILITIES	= 0,
> > +	SGX_CPUID_ATTRIBUTES	= 1,
> > +	SGX_CPUID_EPC_BANKS	= 2,
> > +};
> 
> I made a review comment about these last time.  I don't remember
> receiving any kind of response from you on it, or seeing it addressed in
> these patches in any kind of way.
> 
> I've also seen comments from Thomas that sound really familiar such as
> the lack of comments on the paging code or the use of a semaphore to
> protect things that don't sleep.  I made very, very similar comments on
> the last posting.
> 
> Is there a reason that those comments were not addressed?

My sloppiness is the reason.

The feedback has been awesome from you and Thomas for this version,
which will help me to get these things right for the next version.

Thank you.

/Jarkko
