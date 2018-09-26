Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E22F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeIZUzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:55:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeIZUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:55:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 64A0D77B56CA4;
        Wed, 26 Sep 2018 22:42:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 22:42:24 +0800
Message-ID: <5BAB9ACF.6040102@huawei.com>
Date:   Wed, 26 Sep 2018 22:42:23 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
CC:     <paulus@samba.org>, <benh@kernel.crashing.org>,
        <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com> <20180926162232.250c0090@naga>
In-Reply-To: <20180926162232.250c0090@naga>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/26 22:22, Michal Suchánek wrote:
> On Wed, 26 Sep 2018 19:46:08 +0800
> zhong jiang <zhongjiang@huawei.com> wrote:
>
>> It is safe to move dereference below a NULL test.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/powerpc/kernel/cacheinfo.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cacheinfo.c
>> b/arch/powerpc/kernel/cacheinfo.c index a8f20e5..7f19714 100644
>> --- a/arch/powerpc/kernel/cacheinfo.c
>> +++ b/arch/powerpc/kernel/cacheinfo.c
>> @@ -401,14 +401,13 @@ static struct cache
>> *cache_lookup_or_instantiate(struct device_node *node, struct cache
>> *cache; 
>>  	cache = cache_lookup_by_node(node);
>> +	if (!cache)
>> +		cache = cache_do_one_devnode(node, level);
>>  
>>  	WARN_ONCE(cache && cache->level != level,
> This has also null test so cache should be dereferenced only when
> non-null here.
:-[ ,  you're right.  I forget WARN_ONCE.  please ignore the patch.

Sincerely,
zhong jiang
> Thanks
>
> Michal
>
> .
>


