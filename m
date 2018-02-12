Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeBLR5b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:57:31 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.119]:38094 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753081AbeBLR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:57:30 -0500
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
To: Eric Anholt <eric@anholt.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180207160002.GA9292@embeddedgus> <87inb7c2ld.fsf@anholt.net>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <c3e615e4-5c2d-4c3c-0417-5c04230bd5e5@embeddedor.com>
Date: Mon, 12 Feb 2018 11:57:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87inb7c2ld.fsf@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1elIM5-002wp9-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:46064
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 02/08/2018 02:22 AM, Eric Anholt wrote:
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
> 
>> Add suffix ULL to constant 9 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice that this
>> constant is used in a context that expects an expression of type
>> unsigned long long (64 bits, unsigned).
>>
>> The expression tfr->len * 9 * 1000000 is currently being evaluated
>> using 32-bit arithmetic.
>>
>> Addresses-Coverity-ID: 1339619
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> The effect looks like it would be that we would have chosen polling mode
> instead of waiting for interrupts for some transfers >477 seconds.
> Seems like a good fix for an unlikely bug.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> 

Thank you for your review.

--
Gustavo
