Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B68FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B220853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1B220853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeINKZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:25:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50439 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbeINKZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:25:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 93B10B178EF93;
        Fri, 14 Sep 2018 13:13:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Fri, 14 Sep 2018
 13:13:01 +0800
Message-ID: <5B9B435C.4020300@huawei.com>
Date:   Fri, 14 Sep 2018 13:13:00 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     <edumazet@google.com>, <kuznet@ms2.inr.ac.ru>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
References: <1536671593-14746-1-git-send-email-zhongjiang@huawei.com> <20180913.104254.1048729520825977993.davem@davemloft.net>
In-Reply-To: <20180913.104254.1048729520825977993.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/14 1:42, David Miller wrote:
> From: zhong jiang <zhongjiang@huawei.com>
> Date: Tue, 11 Sep 2018 21:13:13 +0800
>
>> The if condition can be removed if we use BUG_ON directly.
>> The issule is detected with the help of Coccinelle.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Taking Simon's feedback into consideration...
>
> I very often see changes like this and have to check the implementation
> of BUG_ON() et al. to make sure it evaluates it's arguments even when
> debugging is disabled.
>
> Even if it is always guaranteed to do so, like me people will be unsure
> forever and have to check.
>
> That makes auditing code and validating things more time consuming and
> hard.
>
> I also think the code as written now looks a lot nicer.
>
> So I'm not applying this, sorry.
>
> .
>
Get it.  Thank you for your explanation.

Sincerely,
zhong jiang

