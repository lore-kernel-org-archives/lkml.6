Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933061AbeCMLq3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:46:29 -0400
Received: from gateway20.websitewelcome.com ([192.185.50.28]:45560 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932922AbeCMLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:46:27 -0400
Subject: Re: linux-next: build warning after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180313171153.1614c11e@canb.auug.org.au>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <67db5ac6-9816-4bf1-c594-72697c426466@embeddedor.com>
Date: Tue, 13 Mar 2018 06:46:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313171153.1614c11e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
X-Exim-ID: 1eviNu-00264u-Qn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:46846
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 03/13/2018 01:11 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (sparc
> defconfig) produced this warning:
> 
> net/core/pktgen.c: In function 'pktgen_if_write':
> net/core/pktgen.c:1710:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>   }
>   ^
> 
> Introduced by commit
> 
>    35951393bbff ("pktgen: Remove VLA usage")
> 

Thanks for the report.

David:

If this code is not going to be executed very often [1], then I think it 
is safe to use dynamic memory allocation instead, as this is not going 
to impact the performance.

What do you think?

[1] https://lkml.org/lkml/2018/3/9/630

Thanks
--
Gustavo
