Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEDJyj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:54:39 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:47872 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbeEDJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:54:38 -0400
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
To: Robert Richter <robert.richter@cavium.com>
CC: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, <oprofile-list@lists.sf.net>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
Date: Fri, 4 May 2018 10:54:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180504093002.GC4493@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1525427651-321459-17908-26004-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192686
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 04/05/18 10:30, Robert Richter wrote:
> On 24.04.18 14:15:58, Matt Redfearn wrote:
>> On 24/04/18 14:05, James Hogan wrote:
>>> On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
>>>> Since it appears that MIPS oprofile support is currently broken, core
>>>> oprofile is not getting many updates and not as many architectures
>>>> implement support for it compared to perf, remove the MIPS support.
>>>
>>> That sounds reasonable to me. Any idea how long its been broken?
>>
>> Sorry, not yet. I haven't yet looked into where/how it's broken that would
>> narrow that down...
> 
> oprofile moved to perf syscall as kernel i/f with version 1.0.0. The

OK interesting. I guess this was the point at which MIPS' current 
Kconfig rule which only allows building oprofile or perf into a kernel 
broke oprofile userspace.


> opcontrol script that was using the oprofile kernel i/f was removed:
> 
>   https://sourceforge.net/p/oprofile/oprofile/ci/0c142c3a096d3e9ec42cc9b0ddad994fea60d135/
> 
> Thus, cpus that do not support the perf syscall are no longer
> supported by 1.x releases.
> 
>   https://sourceforge.net/p/oprofile/oprofile/ci/797d01dea0b82dbbdb0c21112a3de75990e011d2/
> 
> For those remainings there is still version 0.9.x available (tagged
> PRE_RELEASE_1_0).
> 
> I am undecided whether removing oprofile kernel i/f falls under the
> rule of "never break user space" here. Strictly seen, yes it breaks
> those remainings. So if the perf syscall is not available as an
> alternative, the oprofile kernel support shouldn't be removed.

perf is available for MIPS and supports many more CPU types than 
oprofile. oprofile userspace seemingly has been broken since 1.0.0 - 
removing oprofile support from the MIPS kernel would not break it more 
thatn it already is, but of course it would be better to fix it - if it 
is still useful and people still use it. That is the question that I was 
looking for answers for with this RFC - whether to spend the time & 
effort to fix oprofile, or if it can be removed since everyone uses perf.

Thanks,
Matt

> 
> -Robert
> 
