Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756730AbeDCWkH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:40:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38859 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbeDCWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:40:05 -0400
X-Google-Smtp-Source: AIpwx48Af7iM55TxdtnwAMjhDUhrjVe0cU70s23+lbcTBxD/S2IR1VI5UYhL7ekcKWWhy4uACVaZRg==
Date: Tue, 03 Apr 2018 15:40:04 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 15:40:02 PDT (-0700)
Subject: Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
In-Reply-To: <4ba976ed-7294-18ec-187f-7105a9782283@mips.com>
CC: antonynpavlov@gmail.com, jhogan@kernel.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: matt.redfearn@mips.com
Message-ID: <mhng-56a331c2-0719-4c87-b1c9-172b64b5c315@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018 06:51:06 PDT (-0700), matt.redfearn@mips.com wrote:
> Hi Palmer,
>
> On 29/03/18 22:59, Palmer Dabbelt wrote:
>> On Thu, 29 Mar 2018 03:41:21 PDT (-0700), matt.redfearn@mips.com wrote:
>>> From: Palmer Dabbelt <palmer@sifive.com>
>>>
>>> As part of the MIPS conversion to use the generic GCC library routines,
>>> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
>>> patch rectifies the problem.
>>>
>>> CC: Matt Redfearn <matt.redfearn@mips.com>
>>> CC: Antony Pavlov <antonynpavlov@gmail.com>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>> ---
>>>
>>> Changes in v4: None
>>> Changes in v3: None
>>> Changes in v2:
>>>   add notrace to lib/ucmpdi2.c
>>>
>>>  lib/ucmpdi2.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
>>> index 25ca2d4c1e19..597998169a96 100644
>>> --- a/lib/ucmpdi2.c
>>> +++ b/lib/ucmpdi2.c
>>> @@ -17,7 +17,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/libgcc.h>
>>>
>>> -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
>>> +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>>>  {
>>>      const DWunion au = {.ll = a};
>>>      const DWunion bu = {.ll = b};
>> 
>> Ah, thanks, I think I must have forgotten about this.  I assume these 
>> three are going through your tree?
>
> Yeah I think that's the plan - James will need your ack to patch 2 if 
> that's ok.

OK, I think I acked the right one... :)
