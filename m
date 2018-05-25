Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935875AbeEYNme (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:42:34 -0400
Received: from foss.arm.com ([217.140.101.70]:33892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933210AbeEYNmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:42:33 -0400
Subject: Re: [PATCH v4 00/26] arm64: provide pseudo NMI with GICv3
From: Julien Thierry <julien.thierry@arm.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <20180525101632.cfcfnmnt2u7rz3lt@holly.lan>
 <02afa8bb-5d27-f229-6085-8f61a626bc63@arm.com>
Message-ID: <8703b3e0-b5f8-e607-2d8f-3d0b71a5ec3c@arm.com>
Date: Fri, 25 May 2018 14:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <02afa8bb-5d27-f229-6085-8f61a626bc63@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/18 11:40, Julien Thierry wrote:
> 
> 
> On 25/05/18 11:16, Daniel Thompson wrote:
>> On Fri, May 25, 2018 at 10:49:06AM +0100, Julien Thierry wrote:
>>> This series is a continuation of the work started by Daniel [1]. The 
>>> goal
>>> is to use GICv3 interrupt priorities to simulate an NMI.
>>>
>>> To achieve this, set two priorities, one for standard interrupts and
>>> another, higher priority, for NMIs. Whenever we want to disable 
>>> interrupts,
>>> we mask the standard priority instead so NMIs can still be raised. Some
>>> corner cases though still require to actually mask all interrupts
>>> effectively disabling the NMI.
>>>
>>> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
>>> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as 
>>> NMI
>>> for now. I don't think there is any reason LPIs should be allowed to 
>>> be set
>>> as NMI as they do not have an active state.
>>> When an NMI is active on a CPU, no other NMI can be triggered on the 
>>> CPU.
>>>
>>> After the big refactoring I get performances similar to the ones I had
>>> in v3[2], reposting old results here:
>>>
>>> - "hackbench 200 process 1000" (average over 20 runs)
>>> +-----------+----------+------------+------------------+
>>> |           | native   | PMR guest  | v4.17-rc6 guest  |
>>> +-----------+----------+------------+------------------+
>>> | PMR host  | 40.0336s |   39.3039s |         39.2044s |
>>> | v4.17-rc6 | 40.4040s |   39.6011s |         39.1147s |
>>> +-----------+----------+------------+------------------+
>>>
>>> - Kernel build from defconfig:
>>> PMR host:  13m45.743s
>>> v4.17-rc6: 13m40.400s
>>>
>>> I'll try to post more detailed benchmarks later if I find notable
>>> differences with the previous version.
>>
>> Do you have a public git tree anywhere... I *can* apply 26 patches from
>> e-mail but I'd rather pull them!
>>
> 
> Yes that makes sense, I'll try to get one set up.
> 
> I'll let you know once I have done so.

My public git is up. You can pull the patches from:

git://linux-arm.org/linux-jt.git v4.17-pseudo-nmi

Cheers,

-- 
Julien Thierry
