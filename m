Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F77C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92D7206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92D7206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeI3IYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 04:24:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeI3IYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 04:24:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90B708C20C092;
        Sun, 30 Sep 2018 09:53:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Sun, 30 Sep 2018
 09:53:07 +0800
Subject: Re: [PATCH net-next] net: caif: fix return type of ndo_start_xmit
 function
To:     David Miller <davem@davemloft.net>
References: <20180926092705.28880-1-yuehaibing@huawei.com>
 <20180929.113802.1016843680571572182.davem@davemloft.net>
CC:     <dmitry.tarnyagin@lockless.no>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <be1fc45d-3dca-3c41-a68a-e8d614bc4e6f@huawei.com>
Date:   Sun, 30 Sep 2018 09:52:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180929.113802.1016843680571572182.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/9/30 2:38, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Wed, 26 Sep 2018 17:27:05 +0800
> 
>> @@ -1014,7 +1014,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	int prio;
>>  
>>  	if (!dev)
>> -		return -EINVAL;
>> +		return NETDEV_TX_BUSY;
>>  
>>  	cfhsi = netdev_priv(dev);
>>  
> 
> Even though the return type of ndo_start_xmit is netdev_tx_t, negative error codes are
> still allowed I believe.

I missed this and do the wrong thing.

> 
> Look, reviewing these are pretty stressful for me, because you aren't documenting your
> changes and in many cases the transformations look incorrect.
> 

I'm really sorry for this.

> I'm tossing the rest of your changes in this area for now, sorry.
> 
> Please double check your work and resubmit this at some time in the not-too-near
> future.
> 
> Thank you.
> 
> .
> 

