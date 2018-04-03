Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDCNvJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:51:09 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:57884 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeDCNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:51:08 -0400
Subject: Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
To: Palmer Dabbelt <palmer@sifive.com>
CC: <antonynpavlov@gmail.com>, <jhogan@kernel.org>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
References: <mhng-e7e3dffe-bc80-4bea-8cf5-4d8afb76565a@palmer-si-x1c4>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <4ba976ed-7294-18ec-187f-7105a9782283@mips.com>
Date: Tue, 3 Apr 2018 14:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <mhng-e7e3dffe-bc80-4bea-8cf5-4d8afb76565a@palmer-si-x1c4>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1522763428-298553-26930-64224-2
X-BESS-VER: 2018.4-r1803302247
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191654
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 29/03/18 22:59, Palmer Dabbelt wrote:
> On Thu, 29 Mar 2018 03:41:21 PDT (-0700), matt.redfearn@mips.com wrote:
>> From: Palmer Dabbelt <palmer@sifive.com>
>>
>> As part of the MIPS conversion to use the generic GCC library routines,
>> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
>> patch rectifies the problem.
>>
>> CC: Matt Redfearn <matt.redfearn@mips.com>
>> CC: Antony Pavlov <antonynpavlov@gmail.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> ---
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2:
>>   add notrace to lib/ucmpdi2.c
>>
>>  lib/ucmpdi2.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
>> index 25ca2d4c1e19..597998169a96 100644
>> --- a/lib/ucmpdi2.c
>> +++ b/lib/ucmpdi2.c
>> @@ -17,7 +17,7 @@
>>  #include <linux/module.h>
>>  #include <linux/libgcc.h>
>>
>> -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
>> +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>>  {
>>      const DWunion au = {.ll = a};
>>      const DWunion bu = {.ll = b};
> 
> Ah, thanks, I think I must have forgotten about this.  I assume these 
> three are going through your tree?

Yeah I think that's the plan - James will need your ack to patch 2 if 
that's ok.

Thanks,
Matt
