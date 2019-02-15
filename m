Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14390C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD15D21917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393328AbfBOJcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:32:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392921AbfBOJcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:32:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14957FCCEA54204A65D3;
        Fri, 15 Feb 2019 17:32:43 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Feb 2019
 17:32:34 +0800
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Gao Xiang <gaoxiang25@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
 <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
 <20190215075757.GG2326@kadam>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fb99bac2-2587-04fa-6ac2-f2e5f83af7c9@huawei.com>
Date:   Fri, 15 Feb 2019 17:32:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190215075757.GG2326@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/15 15:57, Dan Carpenter wrote:
> On Fri, Feb 15, 2019 at 03:02:25PM +0800, Chao Yu wrote:
>> On 2019/2/1 20:16, Gao Xiang wrote:
>>> +	/*
>>> +	 * on-disk error, let's only BUG_ON in the debugging mode.
>>> +	 * otherwise, it will return 1 to just skip the invalid name
>>> +	 * and go on (in consideration of the lookup performance).
>>> +	 */
>>> +	DBG_BUGON(qd->name > qd->end);
>>
>> qd->name == qd->end is not allowed as well?
>>
>> So will it be better to return directly here?
>>
>> 	if (unlikely(qd->name >= qd->end)) {
>> 		DBG_BUGON(1);
>> 		return 1;
>> 	}
> 
> Please don't add likely/unlikely() annotations unless you have
> benchmarked it and it makes a difference.

Well, it only occur for corrupted image, since the image is readonly, so it
is really rare.

Thanks,

> 
> regards,
> dan carpenter
> 
> 
> 
> .
> 

