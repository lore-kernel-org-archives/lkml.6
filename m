Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeECAbL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 20:31:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34737 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeECAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 20:31:08 -0400
X-Google-Smtp-Source: AB8JxZpzTULAiWMgry2Wk2tFmBmdmM/6cqAVQtohRsmjXKEifYTPLtbdfqMyqM0IG8I6xdJ8tTxsBg==
Subject: Re: [v2 PATCH 1/1] tg3: fix meaningless hw_stats reading after
 tg3_halt memset 0 hw_stats
To: Michael Chan <michael.chan@broadcom.com>
References: <20180502004234.230662-1-zumeng.chen@gmail.com>
 <CACKFLikg+p_1iDQtd0XN8tJaKtAgX0jfxGXuoqxhDJZ922UkUg@mail.gmail.com>
 <5af186f8-9718-c295-4e34-e84dd78ea157@gmail.com>
 <CACKFLinOzi+F9j+gbBHjkGdMdXTqpfMRLUwqx=zUpVg76zGxNA@mail.gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>,
        Zumeng Chen <zumeng.chen@windriver.com>
From: Zumeng Chen <zumeng.chen@gmail.com>
Message-ID: <8f73e98f-0c55-2d96-a1b7-0890bf90bf41@gmail.com>
Date: Thu, 3 May 2018 08:30:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <CACKFLinOzi+F9j+gbBHjkGdMdXTqpfMRLUwqx=zUpVg76zGxNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018年05月03日 01:32, Michael Chan wrote:
> On Wed, May 2, 2018 at 3:27 AM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>> On 2018年05月02日 13:12, Michael Chan wrote:
>>> On Tue, May 1, 2018 at 5:42 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>>>
>>>> diff --git a/drivers/net/ethernet/broadcom/tg3.h
>>>> b/drivers/net/ethernet/broadcom/tg3.h
>>>> index 3b5e98e..c61d83c 100644
>>>> --- a/drivers/net/ethernet/broadcom/tg3.h
>>>> +++ b/drivers/net/ethernet/broadcom/tg3.h
>>>> @@ -3102,6 +3102,7 @@ enum TG3_FLAGS {
>>>>           TG3_FLAG_ROBOSWITCH,
>>>>           TG3_FLAG_ONE_DMA_AT_ONCE,
>>>>           TG3_FLAG_RGMII_MODE,
>>>> +       TG3_FLAG_HALT,
>>> I think you should be able to use the existing INIT_COMPLETE flag
>>
>> No,  it will bring the uncertain factors into the existed complicate logic
>> of INIT_COMPLETE.
>> And I think it's very simple logic here to fix the meaningless hw_stats
>> reading and the problem
>> of commit f5992b72. I even suspect if you have read INIT_COMPLETE related
>> codes carefully.
>>
> We should use an existing flag whenever appropriate

I disagree. This is sort of blahblah...
> , instead of adding
> yet another flag to do similar things. I've looked at the code briefly
> and believe that INIT_COMPLETE will work.

When we fix a problem, we'd better think if we introduce a new one.

>    If you think it won't work,
> please be specific and point out why it won't work.  Thanks.

I don't care if it work or not, I directly feel it's a bad idea.
INIT_COMPLETE include a lot of network stuffs, it's not simple hardware 
reset related.

Here again,

My fix logic is very simple to fix the problem I met, I think this is 
how Linux works together
with such a lot of thing, which means clear,  simple, and robust for 
every unit, we re-unite
them eco-systematically.

Finally, it's yours, so be it.

Cheers,
Zumeng
