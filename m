Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeCGRar (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:30:47 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.96]:34331 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbeCGRam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:30:42 -0500
Subject: Re: [PATCH] cxgb3: remove VLA
To: David Miller <davem@davemloft.net>, gustavo@embeddedor.com
Cc: santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180306053934.GA17162@embeddedgus>
 <20180307.122541.1396477885969641264.davem@davemloft.net>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <2dbb7aba-4e12-c4df-363e-b65fcbb16d0e@embeddedor.com>
Date: Wed, 7 Mar 2018 11:30:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307.122541.1396477885969641264.davem@davemloft.net>
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
X-Exim-ID: 1etctk-00023E-3v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:38700
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2018 11:25 AM, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Date: Mon, 5 Mar 2018 23:39:34 -0600
> 
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with dynamic memory allocation.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> All of these lengths are limited by the encoding of the field in the
> VPD, which is a u8, and thus 255 bytes.
> 
> Please just change the 'len' argument to these functions to a u8 and
> use a 256 byte buffer on the stack.
> 
> Thanks.
> 


OK. I got it.

Thanks for the feedback.
--
Gustavo
