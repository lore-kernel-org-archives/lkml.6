Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509AD20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfARHyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:54:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbfARHyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:54:51 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B421AA94EEA23E961D84;
        Fri, 18 Jan 2019 15:54:48 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 15:54:38 +0800
Subject: Re: [PATCH 3/4] crypto: hisilicon: Add HiSilicon ZIP accelerator
 support
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1545465105-133138-1-git-send-email-wangzhou1@hisilicon.com>
 <1545465105-133138-4-git-send-email-wangzhou1@hisilicon.com>
 <20190111060859.k647ltxukywjmi3l@gondor.apana.org.au>
 <5C383908.4090107@hisilicon.com> <5C3F3BDF.6070409@hisilicon.com>
 <20190118045546.hs37a2isfnvxgm7j@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-crypto@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5C418659.30904@hisilicon.com>
Date:   Fri, 18 Jan 2019 15:55:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190118045546.hs37a2isfnvxgm7j@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/18 12:55, Herbert Xu wrote:
> On Wed, Jan 16, 2019 at 10:12:47PM +0800, Zhou Wang wrote:
>>
>> A stupid question: how do we test scomp alg?
>>
>> It seems we can not use general comp API, e.g. crypto_alloc_comp
>> to do this.
>>
>> Could you give me any clue about this?
> 
> scomp algorithms are allocated through crypto_alloc_acomp.

A little strange, but let me try firstly.

However, another question is that seems other subsystems in kernel,
e.g. zswap still use crypto_alloc_comp. So we'd better register this
ZIP engine using both cryto_alloc_comp and scomp/acomp interface to
make it compatible with other subsystems?

Best,
Zhou

> 
> Thanks,
> 

