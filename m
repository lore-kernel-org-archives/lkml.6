Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A703FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170A2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2170A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHXKNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:13:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbeHXKNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:13:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF534B3FB09EC;
        Fri, 24 Aug 2018 14:39:52 +0800 (CST)
Received: from [127.0.0.1] (10.63.173.108) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Fri, 24 Aug 2018
 14:39:47 +0800
Subject: Re: [PATCH NET 3/3] net: hns: add configuration constraints for 1000M
 half
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>
References: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
 <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
 <20180824034119.GA29111@lunn.ch>
From:   "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <194ac663-94d8-55e2-0231-a6be53e35f04@huawei.com>
Date:   Fri, 24 Aug 2018 14:39:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180824034119.GA29111@lunn.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.63.173.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/24 11:41, Andrew Lunn wrote:
> On Fri, Aug 24, 2018 at 11:42:23AM +0800, Peng Li wrote:
>> Hisilicon hip05 and hip06 board network card do not support
>> 1000M half configuration. Driver can not config gmac as
>> 1000M half.
>>
>> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Hi Peng
>
> Does the driver remove SUPPORTED_1000baseT_Half from
> phydev->supported?  If you do that, the PHY should never negotiate
> this speed.
>
>     Andrew
Hi, Andrew,

The driver has removed SUPPORTED_1000baseT_Half from

phydev->supported.

the code is :
#define MAC_GMAC_SUPPORTED \
	(SUPPORTED_10baseT_Half \
	| SUPPORTED_10baseT_Full \
	| SUPPORTED_100baseT_Half \
	| SUPPORTED_100baseT_Full \
	| SUPPORTED_Autoneg)
  h->if_support = MAC_GMAC_SUPPORTED;
  h->if_support |= SUPPORTED_1000baseT_Full;
phydev->supported &= h->if_support;

As gmac do not support 1000M half, we add this patch to
make sure that no users can set 1000M half in any case.

Thanks

>
> .
>


