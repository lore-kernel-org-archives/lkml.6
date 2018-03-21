Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCUNt4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:49:56 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.85]:30532 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751992AbeCUNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:49:55 -0400
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180321010527.GA16616@embeddedor.com>
 <8448C1B0-A2A9-4376-9CC3-7643F0FFC0FB@holtmann.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <7a8174a6-4f36-abf8-b15b-44c1f65b15f1@embeddedor.com>
Date: Wed, 21 Mar 2018 08:49:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8448C1B0-A2A9-4376-9CC3-7643F0FFC0FB@holtmann.org>
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
X-Exim-ID: 1eye7k-000P6i-Oy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:45306
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2018 08:45 AM, Marcel Holtmann wrote:
> Hi Gustavo,
> 
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with dynamic memory allocation instead.
>>
>> The use of stack Variable Length Arrays needs to be avoided, as they
>> can be a vector for stack exhaustion, which can be both a runtime bug
>> or a security flaw. Also, in general, as code evolves it is easy to
>> lose track of how big a VLA can get. Thus, we can end up having runtime
>> failures that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> Changes in v2:
>> - Fix memory leak in previous patch.
>>
>> net/bluetooth/smp.c | 17 ++++++++++++-----
>> 1 file changed, 12 insertions(+), 5 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 

Awesome.

Thanks, Marcel.
--
Gustavo
