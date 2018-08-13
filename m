Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA74C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51245208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51245208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeHMQYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:24:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbeHMQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:24:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6580DA5261F7A;
        Mon, 13 Aug 2018 21:42:10 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 21:42:03 +0800
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <chao@kernel.org>, <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, Chao Yu <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
 <20180813114725.kgoupvppcwsw2vyj@mwanda>
 <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
 <20180813122553.jlavb6inwz3qad6x@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <dbb44f60-1d1c-81fd-845c-5d38f1d16ea3@huawei.com>
Date:   Mon, 13 Aug 2018 21:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180813122553.jlavb6inwz3qad6x@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/13 20:25, Dan Carpenter wrote:
> On Mon, Aug 13, 2018 at 08:17:27PM +0800, Gao Xiang wrote:
>>> 	/* we assume that ofs is aligned with 4 bytes */
>>> 	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
>>> 	return err;
>>>
> This might be cleaner if we wrote:
> 
> 	return (err < 0) ? error : 0;
> 
> The callers all treate zero and one the same so there isn't any reason
> to propogate the 1 back.
> 

Thanks, I will recheck all callers and fix as you suggested.
But it is better to fix them in an independent patch. :) I will send a new patch later.

Thanks,
Gao Xiang

> regards,
> dan carpenter
> 
