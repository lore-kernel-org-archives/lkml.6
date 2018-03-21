Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeCUKBa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:01:30 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:45021 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751459AbeCUKB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:01:27 -0400
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To: John Fastabend <john.fastabend@gmail.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
Message-ID: <00cc2d41-6861-9a9c-603f-ba8013b2e2ce@theobroma-systems.com>
Date: Wed, 21 Mar 2018 11:01:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.18 11:26, Jakob Unterwurzacher wrote:
> On 15.03.18 23:30, John Fastabend wrote:
>>> I have reproduced it using two USB network cards connected to each 
>>> other. The test tool sends UDP packets containing a counter and 
>>> listens on the other interface, it is available at
>>> https://github.com/jakob-tsd/pfifo_stress/blob/master/pfifo_stress.py
>>
>> Great thanks, can you also run this with taskset to bind to
>> a single CPU,
>>
>>   # taskset 0x1 ./pifof_stress.py
>>
>> And let me know if you still see the OOO.
> 
> Interesting. Looks like it depends on which core it runs on. CPU0 is 
> clean, CPU1 is not.

So we are at v4.16-rc6 now - have you managed to reproduce this is or 
should I try to get the revert correct?

Best regards,
Jakob
