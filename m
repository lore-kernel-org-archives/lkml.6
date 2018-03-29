Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeC2QJi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:09:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeC2QJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:09:36 -0400
Date: Thu, 29 Mar 2018 18:09:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180329160914.GR4082@hirez.programming.kicks-ass.net>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <20180329134723.GA4043@hirez.programming.kicks-ass.net>
 <8a24d82e-a8dd-2f35-4764-a58fd6c64ae8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a24d82e-a8dd-2f35-4764-a58fd6c64ae8@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 07:34:58AM -0700, Dave Hansen wrote:
> What should we say, though?
> 
>              /*
> 	      * false means 'c' does not share the LLC of 'o'.
> 	      * Note: this decision gets reflected all the way
> 	      * out to userspace
> 	      */
>              return false;

That works, I suppose. You might want to put in a refernce to wherever
it is you shrink llc-size such that cache-per-cpu remains invariant.
