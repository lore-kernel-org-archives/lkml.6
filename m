Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A74C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B59820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B59820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeGYDdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:33:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55563 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727353AbeGYDdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:33:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCC61931CEFDA;
        Wed, 25 Jul 2018 10:24:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 10:24:09 +0800
Subject: Re: [PATCH] ARM: dma-mapping: always clear allocated buffers
To:     Christoph Hellwig <hch@infradead.org>
References: <20180724140435.17112-1-yuehaibing@huawei.com>
 <20180724180906.GA8240@infradead.org>
CC:     <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <vladimir.murzin@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <akpm@linux-foundation.org>, <iamjoonsoo.kim@lge.com>,
        <robin.murphy@arm.com>, <treding@nvidia.com>,
        <zhongjiang@huawei.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <0414bb3e-33a2-8f30-f765-ee10ecb44fad@huawei.com>
Date:   Wed, 25 Jul 2018 10:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180724180906.GA8240@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/25 2:09, Christoph Hellwig wrote:
> On Tue, Jul 24, 2018 at 10:04:35PM +0800, YueHaibing wrote:
>> Sean Wang report dma_zalloc_coherent doesn't work as expect on his
>> armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
>> doesn't honor __GFP_ZERO.
> 
> Please explain the "why" a little more.  All the explanations are in
> the referenced arm64 commit and should be mentioned here as well.

ok, will send v2.

> 
> .
> 

