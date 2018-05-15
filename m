Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeEOPlb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:41:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:31951 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753122AbeEOPla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:41:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41990593"
Date: Tue, 15 May 2018 08:41:57 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Alan Cox <alan@linux.intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] x86/split_lock: Add CONFIG and enumerate #AC
 exception for split locked access feature
Message-ID: <20180515154156.GA244301@romley-ivt3.sc.intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
 <1526323945-211107-2-git-send-email-fenghua.yu@intel.com>
 <3194fef3-68a7-327b-395b-a98bbb12e40a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3194fef3-68a7-327b-395b-a98bbb12e40a@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:36:35AM -0700, Dave Hansen wrote:
> On 05/14/2018 11:52 AM, Fenghua Yu wrote:
> > +#include <linux/printk.h>
> > +#include <asm/msr.h>
> > +
> > +static bool split_lock_ac_supported;
> 
> Was there a reason not to use an X86_FEATURE* bit for this?

The feature is not enumerated in cpuid. It's detected by writing 1
to bit 29 in MSR 0x33.

So it can't fit in X86_FEATURE, right?

Thanks.

-Fenghua
