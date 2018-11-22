Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8499BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C00D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405240AbeKVVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:14:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15573 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388243AbeKVVOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:14:01 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0CE1CCEBE85C5;
        Thu, 22 Nov 2018 18:35:08 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 18:35:00 +0800
Subject: Re: [PATCH 08/10] staging: erofs: locked before registering for all
 new workgroups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-9-gaoxiang25@huawei.com>
 <20181122102431.GH3189@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e0b4773c-36a1-cb02-e87f-a164cfbf3633@huawei.com>
Date:   Thu, 22 Nov 2018 18:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122102431.GH3189@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 18:24, Greg Kroah-Hartman wrote:
>> +	/* lock all primary followed works before visible to others */
>> +	if (unlikely(!mutex_trylock(&work->lock)))
>> +		/* for a new workgroup, try_lock *never* fails */
>> +		DBG_BUGON(1);
> Again, drop this, if it never fails, then there's no need for this.  If
> it can fail, then properly handle it.
> 
> And trylock can fail, so this needs to be fixed.

OK, I will drop this.

Thanks,
Gao Xiang

> 
> thanks,
