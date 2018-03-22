Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCVXzx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:55:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:53519 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbeCVXzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:55:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="scan'208";a="41411726"
Subject: Re: [PATCH v2] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>
References: <20180322204922.GA2337@alison-desk.jf.intel.com>
 <20180322232030.GA4043@hirez.programming.kicks-ass.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Luck@alison-desk.jf.intel.com, Tony <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <84b2c73d-e388-36dd-729e-a5baa4b29d07@linux.intel.com>
Date: Thu, 22 Mar 2018 16:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322232030.GA4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 04:20 PM, Peter Zijlstra wrote:
>> +		/*
>> +		 * Return value doesn't actually matter because we
>> +		 * are throwing away coregroups for scheduling anyway.
>> +		 * Return false to bypass topology broken bug messages
>> +		 * and fixups in sched_domain().
>> +		 */
>> +		return false;
> IIRC that return value _does_ matter because the resulting mask still
> ends up user visible in sysfs.
> 
> IIRC I went over with this dhansen a week or so ago, but I cannot now
> recall what we settled on as being the right return value and for what
> reason.

IIRC, a 'return true' true keeps the topology information and a 'return
false' throws it away.  We chose 'false' here because without it some
other warnings showed up in another part of the code:

BUG: arch topology borken the MC domain not a subset of the NODE domain

I think the right thing to do is just remove the first sentence of the
comment.
