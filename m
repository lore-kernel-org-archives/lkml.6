Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFBD20811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfBDVPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:15:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:63887 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfBDVPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:15:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 13:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="119945091"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2019 13:15:24 -0800
Date:   Mon, 4 Feb 2019 13:09:12 -0800
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
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190204210912.GA70429@romley-ivt3.sc.intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:05:52AM -0800, Dave Hansen wrote:
> On 2/4/19 9:49 AM, Thomas Gleixner wrote:
> > On Fri, 1 Feb 2019, Fenghua Yu wrote:
> >> This option behaves like existing kernel option clearcpuid.
> > 
> > No it does NOT. clearcpuid allows to disable things.
> > 
> > This allows to enable random CPUID bits without any sanity checking. Not
> > going to happen. We made it clear in the past that functionality needs to
> > be detectable by enumeration. We do quirks for broken crap, but this is
> > just not how it works.
> 
> Hi Thomas,
> 
> I think we are trying persuade you like mentioned here:
> 
> > http://lkml.kernel.org/r/alpine.DEB.2.21.1807122153170.1597@nanos.tec.linutronix.de
> 
> But, we're not being very persuasive because we kinda forgot about the
> "if and only if" condition that you mentioned.

Intel SDM published TODAY does have IA32_CORE_CAPABILITY MSR enumerateion
bit CPUID.0x7.0:EDX[30] now. Please check today's SDM for the bit:
https://software.intel.com/en-us/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

I will add the two patches that enumerate the MSR and #AC for split lock
in the next version.

Thanks.

-Fenghua
