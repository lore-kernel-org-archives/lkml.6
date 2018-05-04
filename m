Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEDLDY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:03:24 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:46354 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeEDLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:03:22 -0400
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
To: Robert Richter <rric@kernel.org>
CC: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, <oprofile-list@lists.sf.net>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
 <20180504102600.GD4493@rric.localdomain>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
Date: Fri, 4 May 2018 12:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180504102600.GD4493@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1525431771-637139-31429-47751-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192687
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

On 04/05/18 11:26, Robert Richter wrote:
> On 04.05.18 10:54:32, Matt Redfearn wrote:
>> perf is available for MIPS and supports many more CPU types than oprofile.
>> oprofile userspace seemingly has been broken since 1.0.0 - removing oprofile
>> support from the MIPS kernel would not break it more thatn it already is,
> 
> What do you mean with "oprofile is broken"? It looks like you modified
> Kconfig to enable oprofile and perf in parallel, which is not intended
> to work. Have you tried a kernel with oprofile disabled and perf
> enabled?

Oh I see what you mean - previously I was trying v1.1.0 of the userspace 
with a kernel that has perf disabled - and that did not work (I assumed, 
naively, that the kernel oprofile code was required to run the oprofile 
userspace).

Thanks for the pointer - I confirmed that oprofile 1.1.0 userspace tools 
work with a kernel with "CONFIG_OPROFILE is not set", and 
"CONFIG_HW_PERF_EVENTS=y".

> 
> As said, oprofile version 0.9.x is still available for cpus that do
> not support perf. What is the breakage?

The breakage I originally set out to fix was the MT support in perf. 
https://www.linux-mips.org/archives/linux-mips/2018-04/msg00259.html

Since the perf code shares so much copied code from oprofile, those same 
issues exist in oprofile and ought to be addressed. But as newer 
oprofile userspace does not use the (MIPS) kernel oprofile code, then we 
could, perhaps, just remove it (as per the RFC). That would break legacy 
tools (0.9.x) though...

Thanks,
Matt

> 
> Thanks,
> 
> -Robert
> 
