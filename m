Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719F9C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216E2219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216E2219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHFEWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:22:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbeHFEWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:22:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C1D05B3F1F409;
        Mon,  6 Aug 2018 10:15:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 10:15:27 +0800
Message-ID: <5B67AF40.70504@huawei.com>
Date:   Mon, 6 Aug 2018 10:15:28 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/bridge/br_multicast: remove redundant variable "err"
References: <1533478723-18361-1-git-send-email-zhongjiang@huawei.com> <20180805.173336.2098484669514510834.davem@davemloft.net>
In-Reply-To: <20180805.173336.2098484669514510834.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/6 8:33, David Miller wrote:
> From: zhong jiang <zhongjiang@huawei.com>
> Date: Sun, 5 Aug 2018 22:18:43 +0800
>
>> @@ -1797,7 +1795,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
>>  	struct sk_buff *skb_trimmed = NULL;
>>  	const unsigned char *src;
>>  	struct igmphdr *ih;
>> -	int err;
>> +	int err = 0;
>>  
>>  	err = ip_mc_check_igmp(skb, &skb_trimmed);
> The initialization of err to '0' is unnecessary, it gets assigned on
> the very next line.
>
> .
>
 That's right.  I will drop that change and repost.

Thanks,
zhong jiang

