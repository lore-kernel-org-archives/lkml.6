Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeCMLCP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:02:15 -0400
Received: from ozlabs.org ([103.22.144.67]:38211 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932577AbeCMLCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:02:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
        akshay.adiga@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
        "linux\@roeck-us.net \>\> Guenter Roeck" <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH] powerpc/powernv : Add support to enable sensor groups
In-Reply-To: <7b64ac19-5463-5f30-83bb-d5ff0611dc94@linux.vnet.ibm.com>
References: <1511760988-10377-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <87bmjmzla7.fsf@concordia.ellerman.id.au> <06a771ec-fc79-0515-9166-f2a105eb33d0@linux.vnet.ibm.com> <87609nxfym.fsf@linux.vnet.ibm.com> <7b64ac19-5463-5f30-83bb-d5ff0611dc94@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 22:02:09 +1100
Message-ID: <87a7vcgrwu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> On 12/04/2017 10:11 AM, Stewart Smith wrote:
>> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>>> On 11/28/2017 05:07 PM, Michael Ellerman wrote:
>>>> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>>>>
>>>>> Adds support to enable/disable a sensor group. This can be used to
>>>>> select the sensor groups that needs to be copied to main memory by
>>>>> OCC. Sensor groups like power, temperature, current, voltage,
>>>>> frequency, utilization can be enabled/disabled at runtime.
>>>>>
>>>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>>>> ---
>>>>> The skiboot patch for the opal call is posted below:
>>>>> https://lists.ozlabs.org/pipermail/skiboot/2017-November/009713.html
>>>>
>>>> Can you remind me why we're doing this with a completely bespoke sysfs
>>>> API, rather than using some generic sensors API?
>>>
>>> Disabling/Enabling sensor groups is not supported in the current generic sensors
>>> API. And also we dont export all type of sensors in HWMON as not all of them are
>>> environment sensors (like performance).
>> 
>> Are there barriers to adding such concepts to the generic sensors API?
>
> Yes.
>
> HWMON does not support attributes for a sensor-group. If we are to extend HWMON
> to add new per-sensor attributes to disable/enable, then we need to do either of
> the below:
>
> 1) If any one of the sensor is disabled then all the sensors belonging to that
> group will be disabled. OR
>
> 2) To disable a sensor group we need to disable all the sensors belonging to
> that group.

Either of those sound doable, the first is probably simpler, as long as
there's some way for userspace to understand that it is modifying the
state of the whole group.

> Another problem is hwmon categorizes the sensor-groups based on the type of
> sensors like power, temp. If OCC allows multiple groups of the same type then
> this approach adds some more complexity to the user to identify the sensors
> belonging to correct group.

I don't really understand this one, what do you mean by "If OCC allows"?

Also do we really expect users to be using this API? Or rather tools?

> And lastly HWMON does not allow platform specific non-standard sensor groups
> like CSM, job-scheduler, profiler.

Have we actually made specific proposals to the hwmon maintainers on
adding/changing any of the above? Have they rejected those proposals and
told us to go away?

cheers
