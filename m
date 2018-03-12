Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCLWwS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:52:18 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.87]:38409 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751312AbeCLWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:52:17 -0400
Subject: Re: [PATCH] EDAC, sb_edac: Remove VLA usage
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180309235654.GA9887@embeddedor.com>
 <20180310140434.GC8261@pd.tnic>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <f875ba4f-65d0-0f13-850d-f323306b8e13@embeddedor.com>
Date: Mon, 12 Mar 2018 17:52:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310140434.GC8261@pd.tnic>
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
X-Exim-ID: 1evWIi-003gZn-0z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:39198
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 03/10/2018 08:04 AM, Borislav Petkov wrote:
> On Fri, Mar 09, 2018 at 09:02:18PM -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with a fixed-length array instead.
>>
>> Fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>
>> Notice that due to this change, the field max_interleave is no longer
>> used after it has been initialized. Maybe it should be removed?
> 
> Yes.
> 

I'll remove it then.

>> @@ -110,6 +110,7 @@ static const u32 knl_interleave_list[] = {
>>   	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
>>   	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
>>   };
>> +#define MAX_INTERLEAVE	ARRAY_SIZE(knl_interleave_list)
> 
> define that as the max of all interleave lists array sizes so that
> people can update it properly when new interleave lists get added.
> 

Do you mean just adding a code comment?

Thanks for the feedback.
--
Gustavo
