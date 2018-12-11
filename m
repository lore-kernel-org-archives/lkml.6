Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A3BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772232084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772232084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeLKBvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:51:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727633AbeLKBvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:51:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A63F68756F05;
        Tue, 11 Dec 2018 09:51:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 11 Dec 2018
 09:51:31 +0800
Subject: Re: [PATCH net-next] ieee802154: ca8210: remove a dead branch
To:     David Miller <davem@davemloft.net>
References: <20181210113443.22796-1-yuehaibing@huawei.com>
 <20181210.120402.2087888281534527051.davem@davemloft.net>
CC:     <h.morris@cascoda.com>, <alex.aring@gmail.com>,
        <stefan@datenfreihafen.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wpan@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <906cefad-8f4d-9f50-4011-4b6de78ca592@huawei.com>
Date:   Tue, 11 Dec 2018 09:51:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181210.120402.2087888281534527051.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/11 4:04, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Mon, 10 Dec 2018 19:34:43 +0800
> 
>> Fix follwing gcc warning:
>>
>> drivers/net/ieee802154/ca8210.c:730:10: warning:
>>  comparison is always false due to limited range of data type [-Wtype-limits]
>>
>> the variable 'len' is of type u8 and cannot greater than
>> CA8210_SPI_BUF_SIZE , which is 256.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Then bug is the variable type here.
> 
> We are reading a u8 from buf[], then adding 2, which can overflow.
> 
> 'len' should be an unsigned int or similar.

Oh, Yes, will do it in v2.

> 
> .
> 

