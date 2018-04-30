Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeD3JxV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:53:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57112 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbeD3JxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:53:20 -0400
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
To: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        daniel.thompson@linaro.org, Joel Fernandes <joelaf@google.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
 <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <07a0b8c1-3d87-0cae-61df-dbff782be301@arm.com>
Date: Mon, 30 Apr 2018 10:53:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/04/18 07:37, Joel Fernandes wrote:
> On Wed, Jan 17, 2018 at 4:10 AM, Julien Thierry <julien.thierry@arm.com> wrote:
>> Hi,
>>
>> On 17/01/18 11:54, Julien Thierry wrote:
>>>
>>> This series is a continuation of the work started by Daniel [1]. The goal
>>> is to use GICv3 interrupt priorities to simulate an NMI.
>>>
>>
>>
>> I have submitted a separate series making use of this feature for the ARM
>> PMUv3 interrupt [1].
> 
> I guess the hard lockup detector using NMI could be a nice next step
> to see how well it works with lock up detection. That's the main
> usecase for my interest. However, perf profiling is also a strong one.
> 

 From my understanding, Linux's hardlockup detector already uses the ARM 
PMU interrupt to check whether some task is stuck. I haven't looked at 
the details of the implementation yet, but in theory having the PMU 
interrupt as NMI should make the hard lockup detector use the NMI.

When I do the v3, I'll have a look at this to check whether the 
hardlockup detector works fine when using NMI.

Cheers,

-- 
Julien Thierry
