Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeEOR2n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:28:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:62839 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeEOR2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:28:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="42021055"
Date: Tue, 15 May 2018 10:29:09 -0700
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
Subject: Re: [PATCH 09/15] x86/split_lock: Explicitly enable or disable #AC
 for split locked accesses
Message-ID: <20180515172908.GC244301@romley-ivt3.sc.intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
 <1526323945-211107-10-git-send-email-fenghua.yu@intel.com>
 <f462c3eb-88e4-829c-132a-e55eb6ef6f19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f462c3eb-88e4-829c-132a-e55eb6ef6f19@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:15:16AM -0700, Dave Hansen wrote:
> On 05/14/2018 11:52 AM, Fenghua Yu wrote:
> > By default, we don't set or clear the bit 29 in TEST_CTL MSR 0x33 and
> > the bit is inherited from BIOS/hardware setting.
> > 
> > The kernel parameter "split_lock_ac=on/off" explicitly sets or clears
> > the bit during boot time.
> 
> The more I think about this...  Why do we need this at boot anyway?
> Surely boot-time kernel code can't cause performance issues in the same
> way that untrusted repeated userspace can.  Why don't we just let
> userspace turn this on?

Turning split lock earlier can captuer split lock performance issue
in the boot path. Actually we did find two split lock issues during
boot time by turning on the feature earlier (see patch 4 and 5).

I guess how to improve boot time is still a concern for client and VM.
If split lock issue can be identified and fixed in boot time, it just
helps and dosn't hurt anything.

Turning on the feature during boot time makes user easier to identify
any split lock issue not just during boot time and also run time.

Having said that, there is a sysfs interface in patch #10 that allows
user to turn on/off the feature during boot time.

Does that sound better?

Thanks.

-Fenghua
