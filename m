Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF3C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586E221C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586E221C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHIFxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:53:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbeHIFxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:53:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6583D699AF1FE;
        Thu,  9 Aug 2018 11:31:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Thu, 9 Aug 2018
 11:30:59 +0800
Message-ID: <5B6BB573.3080707@huawei.com>
Date:   Thu, 9 Aug 2018 11:30:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net/usb/r8152: remove the unneeded variable "ret"
 in rtl8152_system_suspend
References: <1533778753-38089-1-git-send-email-zhongjiang@huawei.com> <7544eca5-bbca-06eb-462e-fca036fe1beb@embeddedor.com>
In-Reply-To: <7544eca5-bbca-06eb-462e-fca036fe1beb@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/9 10:28, Gustavo A. R. Silva wrote:
> Hi Zhong,
>
> On 8/8/18 8:39 PM, zhong jiang wrote:
>> rtl8152_system_suspend defines the variable "ret", but it is not modified
>> after initialization. So just remove it.
>>
> Thanks for working on this.
>
> I wonder if you are using any tool like Coccinelle to spot these sort
> of issues. If so, it'd be nice to mention that in the changelog.
 Yes, I use the returnval.cocci to spot it.  I will remember for next time.

 Thanks,
 zhong jiang
> The above is important for two reasons, one is to give credit to the people
> behind such tools, and the second one is to add support for metrics collection.
>
> Thanks
> --
> Gustavo
>
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/net/usb/r8152.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 124211a..9774270 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -4415,7 +4415,6 @@ static int rtl8152_runtime_suspend(struct r8152 *tp)
>>  static int rtl8152_system_suspend(struct r8152 *tp)
>>  {
>>  	struct net_device *netdev = tp->netdev;
>> -	int ret = 0;
>>  
>>  	netif_device_detach(netdev);
>>  
>> @@ -4430,7 +4429,7 @@ static int rtl8152_system_suspend(struct r8152 *tp)
>>  		napi_enable(napi);
>>  	}
>>  
>> -	return ret;
>> +	return 0;
>>  }
>>  
>>  static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
>>
>


