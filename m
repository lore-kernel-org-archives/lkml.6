Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeC2QZY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:25:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:7968 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbeC2QZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:25:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37919771"
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Peter Zijlstra <peterz@infradead.org>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <20180329134723.GA4043@hirez.programming.kicks-ass.net>
 <8a24d82e-a8dd-2f35-4764-a58fd6c64ae8@linux.intel.com>
 <20180329160914.GR4082@hirez.programming.kicks-ass.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <224bbc83-125d-0507-92af-5b6b4af62834@linux.intel.com>
Date: Thu, 29 Mar 2018 09:25:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329160914.GR4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 09:09 AM, Peter Zijlstra wrote:
> On Thu, Mar 29, 2018 at 07:34:58AM -0700, Dave Hansen wrote:
>> What should we say, though?
>>
>>              /*
>> 	      * false means 'c' does not share the LLC of 'o'.
>> 	      * Note: this decision gets reflected all the way
>> 	      * out to userspace
>> 	      */
>>              return false;
> That works, I suppose. You might want to put in a refernce to wherever
> it is you shrink llc-size such that cache-per-cpu remains invariant.

Hmm, if we shrink llc-size by splitting it, do we also need to create a
unique "id" for each slice?
