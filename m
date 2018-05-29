Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965531AbeE2Rkn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:40:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:64872 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965284AbeE2Rkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:40:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="51544987"
Date: Tue, 29 May 2018 10:40:48 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180529174047.GC212416@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <f43f6139-7303-b469-a8b9-fe65e1cd9aed@intel.com>
 <20180529172511.GA212416@romley-ivt3.sc.intel.com>
 <43c11ed3-c0a6-03cb-51b5-075595f9be12@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c11ed3-c0a6-03cb-51b5-075595f9be12@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:28:11AM -0700, Dave Hansen wrote:
> On 05/29/2018 10:25 AM, Fenghua Yu wrote:
> > (By the way, ISE and SDM don't mention other important details, e.g. 
> > the fact that operand is fetched to cache before split lock is
> > checked. Without the fact, it's hard to explain that only split lock
> > generates bus lock in chapter 8.1.4 in SDM vol3.)
> 
> That's a bummer.  You're working with the folks that own those documents
> to get that fixed up, right?

Yes, I already asked them to add some missing parts in future ISE and SDM.

> 
> > Maybe I can add "Current TEST_CTL implementation is per-core. The patches
> > are supposed to work even when TEST_CTL is per-thread (or even per-
> > socket) in future as well."?
> 
> Yes, that would be a very important part of the software implementation
> to mention.

I'll do that in the next version.

Thanks.

-Fenghua
