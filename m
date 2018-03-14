Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeCNIRK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:17:10 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.12]:43087 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753622AbeCNIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:17:06 -0400
Subject: Re: [PATCH] pktgen: use dynamic allocation for debug print buffer
To: Wang Jian <jianjian.wang1@gmail.com>,
        David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, dima@arista.com, johannes.berg@intel.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313205856.3309750-1-arnd@arndb.de>
 <20180313.202552.1990425972566331246.davem@davemloft.net>
 <CAP4sYWURRroc0H7vDcMdmi2cyuKxHfcj12X0zqWjw1vcoru06A@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <dda53231-656f-463b-21a6-7477a61f055a@embeddedor.com>
Date: Wed, 14 Mar 2018 03:16:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP4sYWURRroc0H7vDcMdmi2cyuKxHfcj12X0zqWjw1vcoru06A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1ew1ar-0006Hh-84
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:34678
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd:

Thanks for the fix.

On 03/13/2018 10:02 PM, Wang Jian wrote:
>>> +  kfree(buf);
> free tb? buf is an array.
> 

Wang:

Thanks for the report. I already sent a patch to fix this: 
https://patchwork.kernel.org/patch/10281587/

--
Gustavo

> On Wed, Mar 14, 2018 at 8:25 AM, David Miller <davem@davemloft.net> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Tue, 13 Mar 2018 21:58:39 +0100
>>
>>> After the removal of the VLA, we get a harmless warning about a large
>>> stack frame:
>>>
>>> net/core/pktgen.c: In function 'pktgen_if_write':
>>> net/core/pktgen.c:1710:1: error: the frame size of 1076 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>>>
>>> The function was previously shown to be safe despite hitting
>>> the 1024 bye warning level. To get rid of the annoyging warning,
>>> while keeping it readable, this changes it to use strndup_user().
>>>
>>> Obviously this is not a fast path, so the kmalloc() overhead
>>> can be disregarded.
>>>
>>> Fixes: 35951393bbff ("pktgen: Remove VLA usage")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Applied, thanks.
