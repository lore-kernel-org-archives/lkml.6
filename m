Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDCSwj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:52:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:14523 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbeDCSwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:52:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000";
   d="scan'208";a="29263946"
Date: Tue, 3 Apr 2018 11:49:38 -0700 (PDT)
From: Shivappa Vikas <vikas.shivappa@intel.com>
X-X-Sender: vikas@vshiva-Udesk
To: Thomas Gleixner <tglx@linutronix.de>
cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/6] x86/intel_rdt/mba_sc: Add documentation for MBA
 software controller
In-Reply-To: <alpine.DEB.2.21.1804031625150.2511@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.10.1804031146530.27913@vshiva-Udesk>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-2-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1803302153280.1479@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1804031625150.2511@nanos.tec.linutronix.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Apr 2018, Thomas Gleixner wrote:

> On Tue, 3 Apr 2018, Thomas Gleixner wrote:
>> On Thu, 29 Mar 2018, Vikas Shivappa wrote:
>> You said above:
>>
>>> This may lead to confusion in scenarios below:
>>
>> Reading the blurb after that creates even more confusion than being
>> helpful.
>>
>> First of all this information should not be under the section 'Memory
>> bandwidth in MB/s'.
>>
>> Also please write bandwidth. The weird acronym b/w (band per width???) is
>> really not increasing legibility.
>>
>> What you really want is a general section about memory bandwidth allocation
>> where you explain the technical background in purely technical terms w/o
>> fairy tale mode. Technical descriptions have to be factual and not
>> 'could/may/would'.
>>
>> If I decode the above correctly then the current percentage based
>> implementation was buggy from the very beginning in several ways.
>>
>> Now the obvious question which is in no way answered by the cover letter is
>> why the current percentage based implementation cannot be fixed and we need
>> some feedback driven magic to achieve that. I assume you spent some brain
>> cycles on that question, so it would be really helpful if you shared that.
>>
>> If I understand it correctly then the problem is that the throttling
>> mechanism is per core and affects the L2 external bandwidth.
>>
>>   Is this really per core? What about hyper threads. Both threads have that
>>   MSR. How is that working?
>>
>> The L2 external bandwidth is higher than the L3 external bandwidth.
>>
>>   Is there any information available from CPUID or whatever source which
>>   allows us to retrieve the bandwidth ratio or the absolute maximum
>>   bandwidth per level?
>>
>> What's also missing from your explanation is how that feedback loop behaves
>> under different workloads.
>>
>>   Is this assuming that the involved threads/cpus actually try to utilize
>>   the bandwidth completely?
>>
>>   What happens if the threads/cpus are only using a small set because they
>>   are idle or their computations are mostly cache local and do not need
>>   external bandwidth? Looking at the implementation I don't see how that is
>>   taken into account.
>
> Forgot to mention the following:
>
>  The proposed new interface has no upper limit. The existing percentage
>  based implementation has at least some notion of limit and scale; not
>  really helpful either because of the hardware implementation. but I
>
>  How is the poor admin supposed to configure that new thing without
>  knowing what the actual hardware limits are in the first place?

That is true. The default values only put it to a very high bandwidth which 
means user gets to use everything. There seems no other way other than 
caliberating to know the actual max bandwidth in bytes. That could be a better 
value to have as default so admin knows the limit. I will explore if there is 
a way to calculate the same without caliberating.

Thanks,
Vikas

>
> Thanks,
>
> 	tglx
>
>
>
