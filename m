Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919A7C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfAQCvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:51:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727449AbfAQCvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:51:15 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A3598E4A3C1B1A8C8134;
        Thu, 17 Jan 2019 10:51:11 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 10:51:01 +0800
Subject: Re: [PATCH 0/5] Crypto Cleanup
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>, <ard.biesheuvel@linaro.org>,
        <jonathan.cameron@huawei.com>
References: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190116174949.GA152952@gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <62435a58-91fb-c48d-73f8-0b7634721924@huawei.com>
Date:   Thu, 17 Jan 2019 10:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190116174949.GA152952@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/17 1:49, Eric Biggers wrote:
> On Wed, Jan 16, 2019 at 10:50:29AM +0800, Xiongfeng Wang wrote:
>> The patchset introduce a helper to (un)register a array of crypto templates.
>> The following patches use this helper to simplify the code. This is also
>> a preparation for a coming patchset, which will register several crypto
>> templates.
>>
>> Xiongfeng Wang (5):
>>   crypto: api - add a helper to (un)register a array of templates
>>   crypto: ccm - use template array registering API to simplify the code
>>   crypto: gcm - use template array registering API to simplify the code
>>   crypto: ctr - use template array registering API to simplify the code
>>   crypto: chacha20poly1305 - use template array registering API to
>>     simplify the code
>>
>>  crypto/algapi.c           | 27 ++++++++++++++++
>>  crypto/ccm.c              | 81 +++++++++++++++--------------------------------
>>  crypto/chacha20poly1305.c | 38 +++++++++-------------
>>  crypto/ctr.c              | 46 ++++++++++-----------------
>>  crypto/gcm.c              | 76 +++++++++++++++-----------------------------
>>  include/crypto/algapi.h   |  2 ++
>>  6 files changed, 113 insertions(+), 157 deletions(-)
>>
>> -- 
>> 1.7.12.4
>>
> 
> Hi Xiongfeng, I think this a useful cleanup but can you please rebase this onto
> cryptodev?  There is a conflict in crypto/ctr.c.

Hi Eric, thanks for your reply. I will change it in the next version.

Thanks,
Xiongfeng
> 
> - Eric
> 
> .
> 

