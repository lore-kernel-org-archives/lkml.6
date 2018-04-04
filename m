Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeDDRih (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:38:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:49745 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDRig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:38:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="31020675"
Date: Wed, 4 Apr 2018 10:38:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180404173848.GA10518@alison-desk.jf.intel.com>
References: <20180403211230.GA12842@alison-desk.jf.intel.com>
 <2d00edef-c8bf-2fc6-c342-274a0681e225@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d00edef-c8bf-2fc6-c342-274a0681e225@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:24:49AM -0700, Tim Chen wrote:
> On 04/03/2018 02:12 PM, Alison Schofield wrote:
> 
> > +
> > +	/*
> > +	 * topology_sane() considers LLCs that span NUMA nodes to be
> > +	 * insane and will display a warning message. Bypass the call
> > +	 * to topology_sane() for snc_cpu's to avoid that warning.
> > +	 */
> > +
> > +	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu)) {
> > +		/* Indicate that package has NUMA nodes inside: */
> > +		x86_has_numa_in_package = true;
> 
> Why does the x86_has_numa_in_package has to be set here when it would have
> been done later in set_cpu_sibling_map?

Tim,
I had that same thought when you commented on it previously. After 
discussing w DaveH, decided that match_llc() and match_die(c,0)
could be different and chose to be (cautiously) redundant.
alisons



> 
> > +
> > +		/*
> > +		 * false means 'c' does not share the LLC of 'o'.
> > +		 * Note: this decision gets reflected all the way
> > +		 * out to userspace.
> > +		 */
> > +
> > +		return false;
> 
> Thanks.
> 
> Tim
