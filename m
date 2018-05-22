Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeEVRL5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:11:57 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:39881 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbeEVRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:11:56 -0400
X-Authority-Reason: nr=8
Subject: Re: [media] duplicate code in media drivers
To: Devin Heitmueller <dheitmueller@kernellabs.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Devin Heitmueller <dheitmueller@linuxtv.org>
References: <20180521193951.GA16659@embeddedor.com>
 <20180521171415.00c56487@vento.lan>
 <CAGoCfiwHPPJZABCtMgPzqvHNprnLn8qG9R0aT0b3Y8VfR_ta+g@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <eda3980d-0464-b030-448a-bc60fab75f97@embeddedor.com>
Date: Tue, 22 May 2018 12:11:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGoCfiwHPPJZABCtMgPzqvHNprnLn8qG9R0aT0b3Y8VfR_ta+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fLApH-003LKK-5y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:55344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2018 03:44 PM, Devin Heitmueller wrote:
>>> diff -u -p drivers/media/dvb-frontends/au8522_decoder.c /tmp/nothing/media/dvb-frontends/au8522_decoder.c
>>> --- drivers/media/dvb-frontends/au8522_decoder.c
>>> +++ /tmp/nothing/media/dvb-frontends/au8522_decoder.c
>>> @@ -280,14 +280,9 @@ static void setup_decoder_defaults(struc
>>>                          AU8522_TOREGAAGC_REG0E5H_CVBS);
>>>          au8522_writereg(state, AU8522_REG016H, AU8522_REG016H_CVBS);
>>>
>>> -       if (is_svideo) {
>>>                  /* Despite what the table says, for the HVR-950q we still need
>>>                     to be in CVBS mode for the S-Video input (reason unknown). */
>>>                  /* filter_coef_type = 3; */
>>> -               filter_coef_type = 5;
>>> -       } else {
>>> -               filter_coef_type = 5;
>>> -       }
>>
>> Better ask Devin about this (c/c).
> 
> This was a case where the implementation didn't match the datasheet,
> and it wasn't clear why the filter coefficients weren't working
> properly.  Essentially I should have labeled that as a TODO or FIXME
> when I disabled the "right" value and forced it to always be five.  It
> was also likely that the filter coefficients would need to differ if
> taking video over the IF interface as opposed to CVBS/S-video, which
> is why I didn't want to get rid of the logic entirely.  That said, the
> only product I've ever seen with the tda18271 mated to the au8522 will
> likely never be supported for analog video under Linux for unrelated
> reasons.
> 
> That said, it's worked "good enough" since I wrote the code nine years
> ago, so if somebody wants to submit a patch to either get rid of the
> if() statement or mark it as a FIXME that will likely never actually
> get fixed, I wouldn't have an objection to either.
> 

Devin,

I've sent a patch based on your feedback.

Thanks!
--
Gustavo
