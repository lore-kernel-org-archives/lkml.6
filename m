Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965526AbeE2RiE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:38:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:48208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965284AbeE2RiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:38:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60080766"
Date: Tue, 29 May 2018 10:38:08 -0700
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
Message-ID: <20180529173808.GB212416@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <b4d3e2d0-dfb1-fa1d-8430-0bcb124063e5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d3e2d0-dfb1-fa1d-8430-0bcb124063e5@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:40:09AM -0700, Dave Hansen wrote:
> On 05/27/2018 08:45 AM, Fenghua Yu wrote:
> > A split lock is any atomic operation whose operand crosses two cache
> > lines. Since the operand spans two cache lines and the operation must
> > be atomic, the system locks the bus while the CPU accesses the two cache
> > lines.
> 
> Could you give us a bit of an idea why this is RFC?  What needs review?
> What needs commenting-on?  What is left before you think this can be
> merged?  Where would you like Thomas, Ingo, and other reviewers to focus
> their attention?
> 
> One thing we from Intel can be horrible about is launching in to the
> details of the hardware implementation instead of focusing on the
> software implications.  For instance, you launch into the details of bus
> locks without mentioning key things like:
> 
> Split-lock-detection is a new hardware feature that generates
> alignment-check (#AC) faults to help detect when badly-aligned atomic
> instructions might impact whole-system performance.  These patches are
> primarily targeted at application-level issues, but we can also detect
> the same issues in the kernel.  There is a significant interaction
> between this feature and firmware because firmware may or may not be
> prepared for this feature to be enabled.

Hi, Thomas, Ingo, and other reviewers,

Currently I only got feedback from Intel people (Dave, Alan, Tony, Ashok,
etc). So far I haven't seen any feedback from you.

Does the patch set handle the feature of #AC for split lock right e.g.
in areas like enumeration, interaciton with firmware, etc? Does it handle
usage case right e.g. the configuration, debugfs interface,etc? Need any
coding improvement?

Thank you very much!

-Fenghua
