Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeCMLI5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:08:57 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.108]:11307 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932713AbeCMLIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:08:55 -0400
Subject: Re: [PATCH] EDAC, sb_edac: Remove VLA usage
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180309235654.GA9887@embeddedor.com>
 <20180310140434.GC8261@pd.tnic>
 <f875ba4f-65d0-0f13-850d-f323306b8e13@embeddedor.com>
 <20180313104811.GA23568@pd.tnic>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <99aa9024-ea78-70a0-bb22-222f53b00029@embeddedor.com>
Date: Tue, 13 Mar 2018 06:08:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313104811.GA23568@pd.tnic>
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
X-Exim-ID: 1evhnZ-001S8p-Sz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:46432
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/13/2018 05:48 AM, Borislav Petkov wrote:
> On Mon, Mar 12, 2018 at 05:52:13PM -0500, Gustavo A. R. Silva wrote:
>> Do you mean just adding a code comment?
> 
> No, I mean
> 
> #define MAX_INTERLEAVE (max_t(unsigned int, ARRAY_SIZE(knl_interleave_list), ...
> 
> which computes the max of all three array sizes.
> 
> Thx.
> 

I got it.

Exactly this:

#define MAX_INTERLEAVE (max_t(unsigned int, 
ARRAY_SIZE(knl_interleave_list),\
                         max_t(unsigned int, 
ARRAY_SIZE(ibridge_interleave_list),\
 
ARRAY_SIZE(sbridge_interleave_list))))


I'll send v2 shortly.

Thanks!
--
Gustavo
