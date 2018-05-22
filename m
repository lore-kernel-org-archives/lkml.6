Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeEVOou (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:44:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36258 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeEVOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:44:46 -0400
X-Google-Smtp-Source: AB8JxZooF0/M7fExxVXxdAdvwWzNiloErm/OBt6ZQCat/gu6mBltrhSdjdW28YF66+pREdAlfDSVYA==
Subject: Re: [PATCH 1/4] arcnet: com20020: Add com20020 io mapped version
To: David Miller <davem@davemloft.net>
Cc: tobin@apporbit.com, a.greco@4sigma.it, m.grzeschik@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
 <20180517.163113.2110198960037727630.davem@davemloft.net>
 <CAPoXtQJJ-Fv6dBWxFs+r+B-+jhQAF+AxdqDg9g55AwSyBJ0U6g@mail.gmail.com>
 <20180518.135152.51730771671749217.davem@davemloft.net>
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Message-ID: <767e8133-d6d0-e8da-d893-e64ed9c5a280@gmail.com>
Date: Tue, 22 May 2018 16:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518.135152.51730771671749217.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 07:51 PM, David Miller wrote:
> From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
> Date: Fri, 18 May 2018 14:18:41 +0200
> 
>> In com20020.c found this:
>> /* FIXME: do this some other way! */
>> if (!dev->dev_addr[0])
>> dev->dev_addr[0] = arcnet_inb(ioaddr, 8);
>>
>> NODE-ID, must be univoque, for all arcnet network.
>> My previews idea was take random value but, this could create a
>> collision over network.
>>
>> A possible solution is:
>> In case of collision com20020 set a bit in status register.
>> Then peak a new NODE-ID and repeat this while correct NODE-ID is found.
>>
>> Other ideas is pass it via DTS.
>> But suppose have 2 same product in same network, same address same problem.
>> For this reason i prefer left standard driver behavior.
>>
>> Other ideas for solve this ?
> 
> Is there no way to obtain a unique value from the device?
> 
> If having a unique ID to talk on the ARCNET is so critical, there must
> be some way to properly allocation and use a unique ID.

Device can rise interrupt in case of Duplicate ID over the network.

> I guess this must be a general problem with this driver already.
I think arcnet network and relative NODE-ID designed during project 
phase, and address is always fixed.

In fact:
Other version of this dirver: PCI, ISA friends.
Simple work as module, and Node-ID is param of modules.

My opinion is that:
Before run `ifconfig arc0 up`, user has to setup hardware address with 
`ip link set dev arc0 address D2`.

All this is like a IP network with static address. If your IP address is 
duplicated, is not IP problem.

> You still need to address the issue of 'dev' being leaked on probe
> error paths.
For solve this,i think all considered a random address could be a good 
solution.

Regards, Andrea
