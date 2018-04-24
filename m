Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbeDXLsO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:48:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54721 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeDXLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:48:12 -0400
X-Google-Smtp-Source: AB8JxZred3sBIXOAYVB/zkBzeUsoSZQV5DqIzH/yVG9bx67l0fHKAy0VUZTRByb2b8BtRgpKdHBowdrpy8J3lolX8Yk=
MIME-Version: 1.0
In-Reply-To: <67a158d9-cd33-8c28-39c3-9cead4107205@gmail.com>
References: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
 <20180423.115821.640630949143585629.davem@davemloft.net> <788ce3f1-6534-5c2e-1870-5ebd8ea4ae7f@gmail.com>
 <CALOAHbDpgOckQhW7_Ysi-F2HCoZW4RKSdUuvTquELJZsaMj6Lg@mail.gmail.com> <67a158d9-cd33-8c28-39c3-9cead4107205@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 24 Apr 2018 19:47:31 +0800
Message-ID: <CALOAHbDajHPN9Z3TTWFBwpd1H16RVRRYYiUMrUELE3JxeZo+qw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: init sk_cookie for inet socket
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 7:41 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 04/23/2018 09:39 PM, Yafang Shao wrote:
>> On Tue, Apr 24, 2018 at 12:09 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>
>>>
>>> On 04/23/2018 08:58 AM, David Miller wrote:
>>>> From: Yafang Shao <laoar.shao@gmail.com>
>>>> Date: Sun, 22 Apr 2018 21:50:04 +0800
>>>>
>>>>> With sk_cookie we can identify a socket, that is very helpful for
>>>>> traceing and statistic, i.e. tcp tracepiont and ebpf.
>>>>> So we'd better init it by default for inet socket.
>>>>> When using it, we just need call atomic64_read(&sk->sk_cookie).
>>>>>
>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>
>>>> Applied, thank you.
>>>>
>>>
>>> This is adding yet another atomic_inc on a global cache line.
>>>
>>
>> That's a trade-off.
>>
>>> Most applications do not need the cookie being ever set.
>>>
>>> The existing mechanism was fine. Set it on demand.
>>
>> There are some drawback in the existing mechanism.
>> - we have to set the net->cookie_gen and then sk->sk_cookie when we
>> want to get the sk_cookie, that's a little expensive as well.
>
> Same cost.
>
>>   After that change, sock_gen_cookie() could be replaced by
>> atomic64_read(&sk->sk_cookie) in most places.
>
> Same cost than the helper.
>
>>
>> - If the application want to get the sk_cookie, it must set it first.
>>    What if the application don't have the permision to write?
>>    Furthermore, maybe it is a security concern ?
>
>
> Maybe ? Please elaborate.
>
> Your patch destroys SYNFLOOD behavior.
>
> I have spent months of work solving the SYNFLOOD behavior, your patch crushes it.
>

Could you pls. explain the issue to me ?

> I am not that happy.
>
> Please revert this patch.
>

OK. I will revert it.

> Thank you.
