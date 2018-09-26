Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3B020652
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ymQnl0bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3B020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeI0Cvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:51:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48056 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0Cvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:51:39 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QKakEZ036111;
        Wed, 26 Sep 2018 15:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537994207;
        bh=lAaai5OCflM6FuWAR75yj1kzhch0ZdC7CxUxBLYh9dQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ymQnl0bNOvGxGImQVB7XjDxmTb/lnXZZXn0I4bA6rJiqcFefg1QS8p91Ptn6RLpYC
         WnIkuyfJsvoBN1Lkj7awnzFO5qGgWvqaeMbUMcqgGcYwZoMY4Bkxldg8P/P3ozn/BR
         fPL5JjJSyW8rGNjunUbH1VSEp34W2h/q2Wj4dED4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QKakxr004442;
        Wed, 26 Sep 2018 15:36:46 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 15:36:46 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 15:36:47 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QKakBs024121;
        Wed, 26 Sep 2018 15:36:46 -0500
Subject: Re: [PATCH net-next] net: ti: fix return type of ndo_start_xmit
 function
To:     David Miller <davem@davemloft.net>, <yuehaibing@huawei.com>
CC:     <f.fainelli@gmail.com>, <w-kwok2@ti.com>, <m-karicheri2@ti.com>,
        <lukas@wunner.de>, <bgolaszewski@baylibre.com>,
        <ivan.khoronzhuk@linaro.org>, <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20180926090951.25544-1-yuehaibing@huawei.com>
 <20180926.101733.2070254569725987062.davem@davemloft.net>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b24fa149-40b3-57fd-ccb0-78a10c97b825@ti.com>
Date:   Wed, 26 Sep 2018 15:36:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926.101733.2070254569725987062.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 09/26/2018 12:17 PM, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Wed, 26 Sep 2018 17:09:51 +0800
> 
>> @@ -1290,7 +1291,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   			dev_warn(netcp->ndev_dev, "padding failed (%d), packet dropped\n",
>>   				 ret);
>>   			tx_stats->tx_dropped++;
>> -			return ret;
>> +			return NETDEV_TX_BUSY;
>>   		}
>>   		skb->len = NETCP_MIN_PACKET_SIZE;
>>   	}
>> @@ -1298,7 +1299,6 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	desc = netcp_tx_map_skb(skb, netcp);
>>   	if (unlikely(!desc)) {
>>   		netif_stop_subqueue(ndev, subqueue);
>> -		ret = -ENOBUFS;
>>   		goto drop;
>>   	}
>>   
>> @@ -1319,7 +1319,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	if (desc)
>>   		netcp_free_tx_desc_chain(netcp, desc, sizeof(*desc));
>>   	dev_kfree_skb(skb);
>> -	return ret;
>> +	return NETDEV_TX_BUSY;
>>   }
> 
> These conversions are not correct.
> 
> If the driver frees the SKB you must not return NETDEV_TX_BUSY.
> 
> NETDEV_TX_BUSY tells the caller that the driver could not process the
> packet and that it should reqeueu up the SKB and try again later when
> there is more TX queue room.
> 

Sry, but I still do not understand the reason for these changes (as I asked already [1])
May be there are some patches on the fly or long term decisions were made in this area.

According to the code include/linux/netdevice.h the .ndo_start_xmit() can return 3 type of values
1) enum netdev_tx, expected to be used by regular netdev drivers, but
2) "error while transmitting (rc < 0)" is also acceptable values
3) NET_XMIT_SUCCESS/DROP/CN (qdisc ->enqueue() return codes) for Virtual network devices 

So, are there plans to move NET_XMIT_XXX in enum? 
or any patches to change include/linux/netdevice.h "Transmit return codes:" section?

Not sure, that blindly following coccinelle recommendations is a good
choice in this particular case.

[1] https://lkml.org/lkml/2018/9/20/881

-- 
regards,
-grygorii
