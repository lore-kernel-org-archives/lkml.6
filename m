Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932986AbeCMNa4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:30:56 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.221]:29746 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752779AbeCMNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:30:54 -0400
Subject: Re: [PATCH v2] EDAC, sb_edac: Remove VLA usage
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313112034.GA28234@embeddedgus>
 <20180313102133.7e505e2b@vento.lan>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4a71e9da-61a1-ca9b-9d60-89f3c63619b9@embeddedor.com>
Date: Tue, 13 Mar 2018 08:30:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313102133.7e505e2b@vento.lan>
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
X-Exim-ID: 1evk0z-0041dt-8i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:48884
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/13/2018 08:21 AM, Mauro Carvalho Chehab wrote:
> Em Tue, 13 Mar 2018 06:20:34 -0500
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> escreveu:
> 
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with a fixed-length array instead.
>>
>> Fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>   - Use macro max_t to compute the max of all three array sizes.
>>     This change is based on Borislav's feedback.
>>
>>   drivers/edac/sb_edac.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
>> index 8721002..196b012 100644
>> --- a/drivers/edac/sb_edac.c
>> +++ b/drivers/edac/sb_edac.c
>> @@ -110,6 +110,10 @@ static const u32 knl_interleave_list[] = {
>>   	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
>>   	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
>>   };
>> +#define MAX_INTERLEAVE (max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),\
>> +			max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),\
>> +					    ARRAY_SIZE(knl_interleave_list))))
>> +
> 
> In order to avoid too long lines, it would be better to do it as:
> 
> #define MAX_INTERLEAVE						        \
> 	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),       \
> 	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list), \
> 		     ARRAY_SIZE(knl_interleave_list))))
> 

Yep. I agree.

> 
> With that:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 

I'll send v3 and add your Reviewed-by.

Thanks, Mauro.
--
Gustavo
