Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeCUJl4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:41:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19123 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751728AbeCUJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:41:53 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38036313"
Subject: Re: [PATCH 1/5] x86/smpboot: Add the missing description of
 possible_cpus
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <hpa@zytor.com>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
 <20180320123712.GR4043@hirez.programming.kicks-ass.net>
 <f64cb207-3851-9a26-2001-653fc0068540@cn.fujitsu.com>
 <20180321090826.GW4043@hirez.programming.kicks-ass.net>
 <076196e1-c181-ba44-f912-61bd279b345b@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <1dfcdb3d-6a92-8654-7cc4-ef262ddb0915@cn.fujitsu.com>
Date: Wed, 21 Mar 2018 17:41:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <076196e1-c181-ba44-f912-61bd279b345b@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 5D67F4D0EFC9.AE15B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 03/21/2018 05:34 PM, Dou Liyang wrote:
> Hi Peter,
> 
> At 03/21/2018 05:08 PM, Peter Zijlstra wrote:
>> On Wed, Mar 21, 2018 at 01:33:24PM +0800, Dou Liyang wrote:
>>> How about:
>>>
>>> possible_cpus=    [s390,x86_64] Set the number of possible CPUs which
>>>         are determined by the ACPI tables MADT or mptables by
>>>         default. possible_cpus=n : n >= 1 enforces the possible
>>>         number to be 'n'.
>>>         While nr_cpus is also be set: nr_cpus=m, choice the
>>>         minimum one for the number of possible CPUs.
>>
>> So what is the exact difference between possible_cpus and nr_cpus ? I
> 
> the possible_cpus= can reset the number of possible CPUs, even bigger
> than 'num_processors + disabled_cpus', But nr_cpus= can't.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       the maximum number kernel gets from ACPI/mptables, no matter what
number nr_cpus= is, the number of possible CPUs will not bigger than it.

>
>> konw maxcpus= limits the number of CPUs we bring up, and possible_cpus
>> limits the possible_map, but I'm not entirely sure what nr_cpus does
>> here.
>>
> 
> nr_cpus can limited the maximum CPUs that the kernel could support.
> 
> Here is a double check in case of using them at the same time, even if I
> think just using possible_cpus= is enough. :-)
> 
> Thanks,
>      dou.
>>
>>
