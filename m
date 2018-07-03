Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC814C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD03521CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD03521CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753748AbeGCBsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:48:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43151 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753259AbeGCBsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:48:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98412AE05EC0D;
        Tue,  3 Jul 2018 09:48:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Tue, 3 Jul 2018
 09:48:39 +0800
Subject: Re: [PATCH v2] atmel: using strlcpy() to avoid possible buffer
 overflows
To:     Kalle Valo <kvalo@codeaurora.org>
References: <20180630063341.9900-1-yuehaibing@huawei.com>
 <8736x1snu9.fsf@kamboji.qca.qualcomm.com>
CC:     <simon@thekelleys.org.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, <andy.shevchenko@gmail.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <258d1cb3-b876-d7d5-48f8-13bf221c6b3d@huawei.com>
Date:   Tue, 3 Jul 2018 09:48:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <8736x1snu9.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/2 22:40, Kalle Valo wrote:
> YueHaibing <yuehaibing@huawei.com> writes:
> 
>> 'firmware' is a module param which may been longer than firmware_id,
>> so using strlcpy() to guard against overflows. Also priv is allocated
>> with zeroed memory,no need to set firmware_id[0] to '\0'.
>>
>> v1 -> v2: remove priv->firmware_id[0] = '\0';
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/wireless/atmel/atmel.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> The changelog should be after "---" line. I can fix it this time, but in
> the future please use the correct location.

Thank you,will notice it.

> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing
> 

