Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FCCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353A32183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfAKGfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:35:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728958AbfAKGfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:35:06 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 249FB88744D01FBA21DA;
        Fri, 11 Jan 2019 14:35:03 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 11 Jan 2019
 14:34:53 +0800
Subject: Re: [PATCH 3/4] crypto: hisilicon: Add HiSilicon ZIP accelerator
 support
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1545465105-133138-1-git-send-email-wangzhou1@hisilicon.com>
 <1545465105-133138-4-git-send-email-wangzhou1@hisilicon.com>
 <20190111060859.k647ltxukywjmi3l@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5C383908.4090107@hisilicon.com>
Date:   Fri, 11 Jan 2019 14:34:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190111060859.k647ltxukywjmi3l@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/11 14:08, Herbert Xu wrote:
> On Sat, Dec 22, 2018 at 03:51:44PM +0800, Zhou Wang wrote:
>>
>> +static struct crypto_alg hisi_zip_zlib = {
>> +	.cra_name		= "zlib-deflate",
>> +	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
>> +	.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
>> +	.cra_priority           = 300,
>> +	.cra_module		= THIS_MODULE,
>> +	.cra_init		= hisi_zip_alloc_comp_ctx,
>> +	.cra_exit		= hisi_zip_free_comp_ctx,
>> +	.cra_u			= {
>> +		.compress = {
>> +			.coa_compress	= hisi_zip_compress,
>> +			.coa_decompress	= hisi_zip_decompress
>> +		}
>> +	}
>> +};
> 
> Please do not add any new implementations using the compress
> interface.  You should either use scomp or acomp depending on
> whether your driver is synchronous or async.

OK, current this driver only supports synchronous interface.
Will fix it in v2.

Thanks,
Zhou

> 
> Thanks,
> 

