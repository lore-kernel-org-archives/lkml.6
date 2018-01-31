Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeAaL7p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 06:59:45 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:32935 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbeAaL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 06:59:43 -0500
Subject: Re: [PATCH v2 1/2] Add notrace to lib/ucmpdi2.c
To: Antony Pavlov <antonynpavlov@gmail.com>, <linux-mips@linux-mips.org>
CC: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>
References: <20180130224202.7682-1-antonynpavlov@gmail.com>
 <20180130224202.7682-2-antonynpavlov@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <aeb636ad-571e-104d-e180-8f60877de571@mips.com>
Date: Wed, 31 Jan 2018 11:54:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180130224202.7682-2-antonynpavlov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1517399973-321457-24928-39230-12
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189548
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 30/01/18 22:42, Antony Pavlov wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
> 
> As part of the MIPS conversion to use the generic GCC library routines,
> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
> patch rectifies the problem.
> 
> CC: Matt Redfearn <matt.redfearn@mips.com>
> CC: Antony Pavlov <antonynpavlov@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>


Looks good to me :-)
Reviewed-by: Matt Redfearn <amtt.redfearn@mips.com>

> ---
>   lib/ucmpdi2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
> index 25ca2d4c1e19..597998169a96 100644
> --- a/lib/ucmpdi2.c
> +++ b/lib/ucmpdi2.c
> @@ -17,7 +17,7 @@
>   #include <linux/module.h>
>   #include <linux/libgcc.h>
>   
> -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
> +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>   {
>   	const DWunion au = {.ll = a};
>   	const DWunion bu = {.ll = b};
> 
