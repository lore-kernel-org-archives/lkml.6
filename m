Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933587AbeCMQbY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:31:24 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.95]:25669 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933305AbeCMQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:31:21 -0400
Subject: Re: [PATCH] iio: potentiometer: ds1803: remove VLA usage
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313152343.GA31789@embeddedgus>
 <20180313162454.GA8769@himanshu-Vostro-3559>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <be9b8f8d-929f-1c0b-334f-583d1c57460c@embeddedor.com>
Date: Tue, 13 Mar 2018 11:31:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313162454.GA8769@himanshu-Vostro-3559>
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
X-Exim-ID: 1evmpc-002tm3-Ic
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:52046
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/13/2018 11:24 AM, Himanshu Jha wrote:
> Hi Gustavo,
> 
> On Tue, Mar 13, 2018 at 10:23:43AM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA. In this particular
>> case use macro ARRAY_SIZE so the length of array _result_ can be
>> computed at preprocessing time.
>>
>> The use of stack Variable Length Arrays needs to be avoided, as they
>> can be a vector for stack exhaustion, which can be both a runtime bug
>> or a security flaw. Also, in general, as code evolves it is easy to
>> lose track of how big a VLA can get. Thus, we can end up having runtime
>> failures that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
> 
> It is already applied as I had sent the patch few days ago.
> https://lkml.org/lkml/2018/3/10/164
> 
> I specifically CC'ed you and Kees to avoid the patch collisions.
> 

I see. Can you please update this spreadsheet:

https://docs.google.com/spreadsheets/d/1OcfyKK8pJ24esYhSEsW4Q2boZE7UTGbYsSEEtFXf7U0/edit

Thanks
--
Gustavo
