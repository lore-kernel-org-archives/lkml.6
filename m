Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A137C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62389205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404353AbfAPOM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:12:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733044AbfAPOM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:12:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3FA214C5ADC8C58E29E1;
        Wed, 16 Jan 2019 22:12:56 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 22:12:48 +0800
Subject: Re: [PATCH 3/4] crypto: hisilicon: Add HiSilicon ZIP accelerator
 support
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1545465105-133138-1-git-send-email-wangzhou1@hisilicon.com>
 <1545465105-133138-4-git-send-email-wangzhou1@hisilicon.com>
 <20190111060859.k647ltxukywjmi3l@gondor.apana.org.au>
 <5C383908.4090107@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-crypto@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5C3F3BDF.6070409@hisilicon.com>
Date:   Wed, 16 Jan 2019 22:12:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5C383908.4090107@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/11 14:34, Zhou Wang wrote:
> On 2019/1/11 14:08, Herbert Xu wrote:
>> On Sat, Dec 22, 2018 at 03:51:44PM +0800, Zhou Wang wrote:
>>>
>>> +static struct crypto_alg hisi_zip_zlib = {
>>> +	.cra_name		= "zlib-deflate",
>>> +	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
>>> +	.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
>>> +	.cra_priority           = 300,
>>> +	.cra_module		= THIS_MODULE,
>>> +	.cra_init		= hisi_zip_alloc_comp_ctx,
>>> +	.cra_exit		= hisi_zip_free_comp_ctx,
>>> +	.cra_u			= {
>>> +		.compress = {
>>> +			.coa_compress	= hisi_zip_compress,
>>> +			.coa_decompress	= hisi_zip_decompress
>>> +		}
>>> +	}
>>> +};
>>
>> Please do not add any new implementations using the compress
>> interface.  You should either use scomp or acomp depending on
>> whether your driver is synchronous or async.

Hi Herbert,

A stupid question: how do we test scomp alg?

It seems we can not use general comp API, e.g. crypto_alloc_comp
to do this.

Could you give me any clue about this?

Best,
Zhou

> 
> OK, current this driver only supports synchronous interface.
> Will fix it in v2.
> 
> Thanks,
> Zhou
> 
>>
>> Thanks,
>>
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
> 
> .
> 

