Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935511AbeBMOwA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:52:00 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51042 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935258AbeBMOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:51:59 -0500
X-Google-Smtp-Source: AH8x226VbOWDbQsg7mhmoyemM3i8u3w+D/ONTyq4Wz1OkZ/TSUfRa5AqTJvUp+/ibWSx76WXn87fqA==
Subject: Re: smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1696e2c6-8d0a-e954-1205-439d70a81f77@ursulin.net>
 <f4069994-6065-af69-0ab5-0587efe26636@ursulin.net>
 <alpine.DEB.2.21.1802131533160.1130@nanos.tec.linutronix.de>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <fb486edb-2da9-6ef3-8eb4-59c725995689@ursulin.net>
Date: Tue, 13 Feb 2018 14:51:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802131533160.1130@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 13/02/18 14:39, Thomas Gleixner wrote:
> On Tue, 13 Feb 2018, Tvrtko Ursulin wrote:
>> On 07/02/18 12:48, Tvrtko Ursulin wrote:
>>> We are seeing failures to online the CPU0 on Apollo Lake in the form of:
>>>
>>>    <6>[  126.508783] smpboot: CPU 0 is now offline
>>>    <6>[  127.520746] smpboot: Booting Node 0 Processor 0 APIC 0x0
>>>    <3>[  137.521036] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
>>>
>>> I unfortunately cannot say with which kernel version this started since
>>> we added a test which does this only recently. I also have no local
>>> access to this machine. (It is part of a test farm for i915 driver
>>> development testing.) But we recently added a test which off-lines, and
>>> on-lines back, CPUs and started seeing this. Small reproducer looks like
>>> this (without boilerplate):
>>
>> Any hints on how to debug this? Could it be firwmare? Try some boot options or
>> something?
> 
> There are issues with CPU0 hotplug on commodity hardware. I have systems
> where it does not work, but TBH I never bothered to investigate it. Some
> years ago we had issues with suspend/resume when it was not running on
> CPU0.  These were related to firmware assumptions about CPU0. So I wouldn't
> be too surprised if there are general issues with unplugging CPU0.
> 
> CPU0 unplug is really only relevant for systems which support physical
> hotplug, so testing it on commodity hardware does not have much
> value. Testing in VMs for increasing the test coverage works well enough.

Thanks, that explains it.

We actually use CPU hotplug just to test if the PMU event migration and 
accounting works as expected in i915 PMU. And since, luckily, the issue 
with CPU0 hotplug manifests only on one of the test systems, I think we 
will just skip this test on that machine.

Thanks again!

Tvrtko
