Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410802080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfBDTJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:09:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:50620 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfBDTJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:09:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 11:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="316261243"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2019 11:09:55 -0800
Date:   Mon, 4 Feb 2019 11:03:44 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 09/10] x86/split_lock: Define #AC for split lock
 feature
Message-ID: <20190204190344.GA69898@romley-ivt3.sc.intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-10-git-send-email-fenghua.yu@intel.com>
 <2d1c4c93-6ea9-5a0d-9a36-641fc01b14f5@intel.com>
 <20190204184549.GA69755@romley-ivt3.sc.intel.com>
 <efd79b59-c3b5-a635-534a-b49596174969@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd79b59-c3b5-a635-534a-b49596174969@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:00:03AM -0800, Dave Hansen wrote:
> On 2/4/19 10:45 AM, Fenghua Yu wrote:
> > On Mon, Feb 04, 2019 at 10:41:40AM -0800, Dave Hansen wrote:
> >> On 2/1/19 9:14 PM, Fenghua Yu wrote:
> >>> --- a/arch/x86/include/asm/cpufeatures.h
> >>> +++ b/arch/x86/include/asm/cpufeatures.h
> >>> @@ -221,6 +221,7 @@
> >>>  #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
> >>>  #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
> >>>  #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
> >>> +#define X86_FEATURE_AC_SPLIT_LOCK	( 7*32+31) /* #AC for split lock */
> >>
> >> The last time this was posted, we (Intel) promised to go get the proper
> >> (CPUID or MSR-based) enumeration of this feature documented.  Did we do
> >> that?  If so, where is that documentation?
> > 
> > As said in the cover patch:
> > "Please note: The feature could be enumerated through
> > MSR IA32_CORE_CAPABILITY (0xCF). But the enumeration is not completely
> > published yet. So this patch set doesn't include the method."
> 
> FWIW, I think we (Intel) promised to get this documented _before_ we
> came back asking our intrepid x86 maintainers to accept something like
> setcpuid=.  While I generally applaud the post-early-post-often
> attitude, we might have been a bit trigger-happy on this one.
> 
> This is awfully crucial information to bury in a massive cover letter,
> especially when the patch description is a rather anemic two lines.
> 
Hi, Dave,

I do have two pathes available to enumerate IA32_CORE_CAPABILITY itself
and to enumerate #AC for split lock by bit 5 in the MSR. But because the
enumeration for the MSR is not published, I cannot release the two
patches in this patch set.

Hopefully this patch set without the two enumeration patches is
a meaningful set.

Thanks.

-Fenghua
