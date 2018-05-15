Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeEOQfW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:35:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:47973 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeEOQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:35:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="224446122"
Date: Tue, 15 May 2018 09:35:20 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Alan Cox <alan@linux.intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/15] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
Message-ID: <20180515163519.GA24474@agluck-desk>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
 <1526323945-211107-4-git-send-email-fenghua.yu@intel.com>
 <03909bf6-2dc5-f5e4-d6bc-a4ebaf20709d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03909bf6-2dc5-f5e4-d6bc-a4ebaf20709d@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:51:24AM -0700, Dave Hansen wrote:
> > +	pr_info_ratelimited("Alignment check for split lock at %lx\n", address);
> 
> This is a potential KASLR bypass, I believe.  We shouldn't be printing
> raw kernel addresses.
> 
> We have some nice printk's for page faults that give you kernel symbols.
>  Could you copy one of those?

It's not really all that useful to print the address of the split lock
itself. It's probably in something that was kmalloc()'d. Users will
probably want to see the address of the instruction so they know which
function to go and debug.  Print that with %pF

-Tony
