Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeEROJ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:09:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbeEROJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:09:25 -0400
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
To: Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
 <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain>
 <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net>
 <1526575358.11765.14.camel@linux.intel.com>
 <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
 <20180517182803.GY12217@hirez.programming.kicks-ass.net>
 <20180518105742.GN30654@e110439-lin>
 <20180518112919.GI12217@hirez.programming.kicks-ass.net>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <efcccd63-d952-db31-29e7-1566e2b5089f@arm.com>
Date: Fri, 18 May 2018 15:09:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518112919.GI12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/05/18 12:29, Peter Zijlstra wrote:
> On Fri, May 18, 2018 at 11:57:42AM +0100, Patrick Bellasi wrote:
>> Thus, my simple (maybe dumb) questions are:
>> - why can't we just fold turbo boost frequency into the existing concepts?
>> - what are the limitations of such a "simple" approach?
> 
> Perhaps... but does this not further complicate the whole capacity vs
> util thing we already have in say the misfit patches?

What do you mean by that ? Bear in mind, I'm a complete stranger to turbo
boost so I fail to see why, as Patrick puts it, it can't fit within the
existing concepts (i.e. max util is 1024 but is only reachable when turbo
boosted).
