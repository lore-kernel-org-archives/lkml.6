Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCVShe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:37:34 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.124]:41437 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751686AbeCVShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:37:33 -0400
Subject: Re: [PATCH] net/mlx5/core/fpga/ipsec: Fix use-after-free
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Ilan Tayari <ilant@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322180342.GA18505@embeddedgus>
 <20180322183225.GA24009@yuvallap>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b19ec4fc-03fa-385f-a9d6-40b9d7b42830@embeddedor.com>
Date: Thu, 22 Mar 2018 13:37:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322183225.GA24009@yuvallap>
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
X-Exim-ID: 1ez55g-004L6E-5R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:55004
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuval,

On 03/22/2018 01:32 PM, Yuval Shaia wrote:
> On Thu, Mar 22, 2018 at 01:03:42PM -0500, Gustavo A. R. Silva wrote:
>> _rule_ is being freed and then dereferenced by accessing rule->ctx
>>
>> Fix this by copying the value returned by PTR_ERR(rule->ctx) into a local
>> variable for its safe use after freeing _rule_
>>
>> Addresses-Coverity-ID: 1466041 ("Read from pointer after free")
>> Fixes: 05564d0ae075 ("net/mlx5: Add flow-steering commands for FPGA IPSec implementation")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Prefix should not be that long, a short one as this is enough.
> 

Yeah. Actually, I was suspicious about it.

> net/mlx5: Fix use-after-free
> 
> Besides that - lgtm.
> 
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> 

I'll send v2 with a short prefix and add your Reviewed-by.

Thanks for the feedback.
--
Gustavo
