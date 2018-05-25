Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbeEYBwf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:52:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:54026 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeEYBw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:52:29 -0400
Date: Thu, 24 May 2018 21:52:25 -0400 (EDT)
Message-Id: <20180524.215225.1188038676378368123.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: ganeshgr@chelsio.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] cxgb4: Check for kvzalloc allocation failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <f26c9a69-2d48-ddc7-4f12-53d0cf65b4f1@huawei.com>
References: <20180522070718.12864-1-yuehaibing@huawei.com>
        <20180524.110743.522760687215216591.davem@davemloft.net>
        <f26c9a69-2d48-ddc7-4f12-53d0cf65b4f1@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 25 May 2018 09:39:20 +0800

> On 2018/5/24 23:07, David Miller wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>> Date: Tue, 22 May 2018 15:07:18 +0800
>> 
>>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>>> index 130d1ee..019cffe 100644
>>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>>> @@ -4135,6 +4135,10 @@ static int adap_init0(struct adapter *adap)
>>>  		 * card
>>>  		 */
>>>  		card_fw = kvzalloc(sizeof(*card_fw), GFP_KERNEL);
>>> +		if (!card_fw) {
>>> +			ret = -ENOMEM;
>>> +			goto bye;
>>> +		}
>>>  
>> 
>> On error, this leaks fw_info.
> 
> Hi David,
> 
> I checked fw_info is an element of fw_info_array，there all members of struct fw_info no need free.

Aha, I misread the code, sorry.

Applied, thanks.
