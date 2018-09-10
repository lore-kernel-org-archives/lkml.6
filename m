Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB315C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6085420855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6085420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeIJSs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:48:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728291AbeIJSs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:48:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34E19BCA589EB;
        Mon, 10 Sep 2018 21:54:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Mon, 10 Sep 2018
 21:54:37 +0800
Message-ID: <5B96779C.5060306@huawei.com>
Date:   Mon, 10 Sep 2018 21:54:36 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <davem@davemloft.net>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wireless: remove unnecessary condition check before kfree
References: <1536415955-33776-1-git-send-email-zhongjiang@huawei.com> <1536563406.3224.2.camel@sipsolutions.net>
In-Reply-To: <1536563406.3224.2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 15:10, Johannes Berg wrote:
> On Sat, 2018-09-08 at 22:12 +0800, zhong jiang wrote:
>> kfree has taken the null pointer into account. Just remove the
>> redundant condition check before kfree.
> I'm all for doing that if it actually removes conditionals, but
>
>> -	if (!IS_ERR_OR_NULL(regdb))
>> +	if (!IS_ERR(regdb))
>>  		kfree(regdb);
> this seems rather pointless since there's still a condition. In that
> case, I feel it's easier to understand the original code.
 Fine, make sense you have said. I just consider the duplication of function.
 
 Thanks,
 zhong jiang
> johannes
>
> .
>


