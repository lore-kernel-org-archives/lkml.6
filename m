Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCZWTL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:19:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:31002 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeCZWTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:19:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="38328288"
Date: Mon, 26 Mar 2018 15:19:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Luck@alison-desk.jf.intel.com, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180326221948.GA17814@alison-desk.jf.intel.com>
References: <20180322204922.GA2337@alison-desk.jf.intel.com>
 <20180322233027.bh6dp5vdcb4rdvqe@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322233027.bh6dp5vdcb4rdvqe@agluck-desk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 04:30:29PM -0700, Luck, Tony wrote:
> On Thu, Mar 22, 2018 at 01:49:22PM -0700, Alison Schofield wrote:
> > +	if (!topology_same_node(c, o) &&
> > +	    (c->x86_vendor == X86_VENDOR_INTEL &&
> > +	     c->x86_model == INTEL_FAM6_SKYLAKE_X)) {
> 
> Maybe make life easier in the future to add more models
> to the list by using x86_match_cpu() here?
> 
> -Tony

Tony - 
 Am I on the right track below?

Define like this:
static const __initconst struct x86_cpu_id snc_cpu[] = {
	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X },
	{}
};

Use like this:
if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu)) {

Thanks,
alisons
