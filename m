Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeDKKSw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:18:52 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35599 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeDKKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:18:50 -0400
X-Google-Smtp-Source: AIpwx4899GL+qgvFXtqnCdL9iLZ44hHYW5u/sX6txnKPBJ+j/Irpi+ZuutSHOtWnvGmM4xahKbueHw==
Subject: Re: [PATCH v2] net: tipc: Replace GFP_ATOMIC with GFP_KERNEL in
 tipc_mon_create
To: Ying Xue <ying.xue@windriver.com>, jon.maloy@ericsson.com,
        davem@davemloft.net
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1523323053-28127-1-git-send-email-baijiaju1990@gmail.com>
 <73c0b7cb-5148-9c38-d45b-750f711b5570@windriver.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <83b941ad-979c-9d15-9e94-c3b249f19409@gmail.com>
Date: Wed, 11 Apr 2018 18:18:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <73c0b7cb-5148-9c38-d45b-750f711b5570@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/11 18:11, Ying Xue wrote:
> On 04/10/2018 09:17 AM, Jia-Ju Bai wrote:
>> tipc_mon_create() is never called in atomic context.
>>
>> The call chain ending up at dn_route_init() is:
> Sorry, I don't think there is any relationship between the following
> call chain with dn_route_init().
>
>> [1] tipc_mon_create() <- tipc_enable_bearer() <- tipc_nl_bearer_enable()
>> tipc_nl_bearer_enable() calls rtnl_lock(), which indicates this function
>> is not called in atomic context.
>>
>> Despite never getting called from atomic context,
>> tipc_mon_create() calls kzalloc() with GFP_ATOMIC,
>> which does not sleep for allocation.
>> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
>> which can sleep and improve the possibility of sucessful allocation.
> s/sucessful/successful

Thanks for your reply.
I am sorry for my mistakes.
I will revised the text and send a V3.


Jia-Ju Bai
