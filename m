Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9718C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67064216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67064216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeI1NAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:00:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbeI1NAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:00:12 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F0F7883A31E3;
        Fri, 28 Sep 2018 14:37:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 28 Sep 2018
 14:37:54 +0800
Message-ID: <5BADCC41.60702@huawei.com>
Date:   Fri, 28 Sep 2018 14:37:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Stefan Schmidt <stefan@datenfreihafen.org>
CC:     <davem@davemloft.net>, <alex.aring@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ieee802154: remove a redundant local variable 'i'
References: <1537368097-60101-1-git-send-email-zhongjiang@huawei.com> <42999ee5-20c2-5d2c-4ca3-e5bb8f5a3864@datenfreihafen.org>
In-Reply-To: <42999ee5-20c2-5d2c-4ca3-e5bb8f5a3864@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/27 22:47, Stefan Schmidt wrote:
> Hello.
>
> On 19/09/2018 16:41, zhong jiang wrote:
>> The local variable 'i' is never used after being assigned.
>> hence it should be redundant adn can be removed.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  net/ieee802154/nl802154.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
>> index 99f6c25..5b90151 100644
>> --- a/net/ieee802154/nl802154.c
>> +++ b/net/ieee802154/nl802154.c
>> @@ -445,7 +445,6 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>>  {
>>  	struct nlattr *nl_cmds;
>>  	void *hdr;
>> -	int i;
>>  
>>  	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
>>  	if (!hdr)
>> @@ -508,7 +507,6 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>>  	if (!nl_cmds)
>>  		goto nla_put_failure;
>>  
>> -	i = 0;
>>  #define CMD(op, n)							\
>>  	do {								\
>>  		if (rdev->ops->op) {					\
>>
> Sorry, but this patch is wrong. The variable i is used in line 513
> inside the CMD() macro. The compiler clearly tells this when running
> with your patch:
>
> net/ieee802154/nl802154.c: In function ‘nl802154_send_wpan_phy’:
> net/ieee802154/nl802154.c:513:4: error: ‘i’ undeclared (first use in
> this function)
>
> I would appreciate if patches sent out would at least be compile tested.
Sorry, I really double check and compile test.

Thanks,
zhong jiang
> regards
> Stefan Schmidt
>
> .
>


