Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D4BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2774821534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2774821534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeHTOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:08:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49955 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeHTOIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:08:31 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 887E0AD582DC0;
        Mon, 20 Aug 2018 18:53:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 20 Aug 2018
 18:53:19 +0800
Message-ID: <5B7A9D9E.3090901@huawei.com>
Date:   Mon, 20 Aug 2018 18:53:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] wireless: Use dma_zalloc_coherent instead of dma_alloc_coherent
 + memset
References: <1534604707-10874-1-git-send-email-zhongjiang@huawei.com> <87pnyfttop.fsf@kamboji.qca.qualcomm.com> <87lg93ttkv.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87lg93ttkv.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/19 2:31, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> zhong jiang <zhongjiang@huawei.com> writes:
>>
>>> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset (),
>>> We prefer to dma_zalloc_coherent instead of open-codeing.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> The correct prefix is "wcn36xx: ", not "wireless:". I can fix it this
>> time.
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_title_is_wrong
> Actually please resend this patch and CC linux-wireless so that
> patchwork sees this.
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#who_to_address
>
 Thanks. I will resend it in v2.

Best wishes,
zhong jiang

