Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D3AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F7C21756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F7C21756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeHMPo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:44:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbeHMPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:44:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4310ABED2407;
        Mon, 13 Aug 2018 21:02:11 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 21:02:04 +0800
Subject: Re: [PATCH 6/8] staging: erofs: fix vle_decompressed_index_clusterofs
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <chao@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-7-chao@kernel.org>
 <20180813120324.ibzrmftxji62ji6r@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <2b2e7678-b4c5-1b7a-0491-6bed02bfe119@huawei.com>
Date:   Mon, 13 Aug 2018 21:01:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180813120324.ibzrmftxji62ji6r@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/13 20:03, Dan Carpenter wrote:
>> -static inline unsigned
>> -vle_compressed_index_clusterofs(unsigned clustersize,
>> -	struct z_erofs_vle_decompressed_index *di)
>> +static inline int
>> +vle_decompressed_index_clusterofs(unsigned int *clusterofs,
> 
> Not related to your patch, but don't make functions inline.  Leave it to
> the compiler to decide.

OK, thanks for your suggestion.

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
> 
