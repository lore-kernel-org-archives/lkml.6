Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeDCVwm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:52:42 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.122]:26448 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753340AbeDCVwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:52:40 -0400
Subject: Re: [PATCH] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereference
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rric@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180403212925.GA31093@embeddedor.com>
 <f0deebb5-06e8-d788-0e68-0c15c979028c@gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <15d8d776-3768-b93e-8e38-0f2387668477@embeddedor.com>
Date: Tue, 3 Apr 2018 16:52:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f0deebb5-06e8-d788-0e68-0c15c979028c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3Tr5-00125G-US
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:42648
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 37
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 04:47 PM, Eric Dumazet wrote:
> 
> 
> On 04/03/2018 02:29 PM, Gustavo A. R. Silva wrote:
>> Add null check on kmalloc() return value in order to prevent
>> a null pointer dereference.
>>
>> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
>> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> index 1e9a31f..468321a 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> @@ -1999,6 +1999,8 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>>   				struct xcast_addr *xaddr;
>>   
>>   				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
>> +				if (unlikely(!mc_list))
>> +					return;
>>   				INIT_LIST_HEAD(&mc_list->list);
>>   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>>   					xaddr = kmalloc(sizeof(*xaddr),
>>
> 
> What about the second kmalloc() right there ?
> 

Oops. I thought I had it covered.

I'll send v2 with that change shortly.

Thanks for the feedback, Eric.
--
Gustavo
