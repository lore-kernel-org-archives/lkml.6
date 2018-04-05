Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDEI1F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:27:05 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.119]:43136 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751418AbeDEI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:27:03 -0400
Subject: Re: [RESEND] SHASH_DESC_ON_STACK macro
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f662fa16-2cbb-a484-4efb-68bb3b39a792@embeddedor.com>
 <bda66faa-f52d-215d-f21b-763593b30f91@embeddedor.com>
 <20180327100709.GA12961@gondor.apana.org.au>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <296706fc-9578-1ca5-ac7f-9b0a5e863114@embeddedor.com>
Date: Thu, 5 Apr 2018 03:26:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327100709.GA12961@gondor.apana.org.au>
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
X-Exim-ID: 1f40EX-002Aa3-A9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:53384
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 03/27/2018 05:07 AM, Herbert Xu wrote:
> On Fri, Mar 23, 2018 at 02:09:46PM -0500, Gustavo A. R. Silva wrote:
>>
>> Hi Herbert,
>>
>> There is an ongoing effort to remove all VLAs from the code base [1] and
>> while working on that I came across the following macro at
>> include/crypto/hash.h:154:
>>
>> #define SHASH_DESC_ON_STACK(shash, ctx)                           \
>>          char __##shash##_desc[sizeof(struct shash_desc) +         \
>>                  crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
>>          struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
>>
>>
>> Currently, this macro is being used in 46 different places.
>>
>> I wonder how big can tfm->descsize can get?
> 
> descsize is capped at PAGE_SIZE / 8.
> 

Sorry for the late response. It seems I lost track of this email somehow.

OK. So based on your response I will propose a patch for this.

Thanks!
--
Gustavo
